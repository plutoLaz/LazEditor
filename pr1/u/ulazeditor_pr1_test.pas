{
  Datum: Mittwoch der 03.04.2021

  Autor: Michael Springwald
}

unit uLazEditor_pr1_Test;

{$mode ObjFPC}
{$H+}

interface

uses
  Classes, SysUtils, Controls, Graphics, glinkedlist, LazUTF8, LCLType, LCLIntf, Types, Contnrs,
  ulazeditor_pr1_boxtype, ulazeditor_pr1_styletypes;

type
  ILazEditorLongLineIntf = interface
    function GetLineText: String;
    function GetStyle: TLazEditorStyleList;
    property LineText: String read GetLineText;
  end;

  // statt einen Record, gibt es eine "class" mit Interface(warum das Interface nötig ist, weiß ich noch nicht)
  { TLazEditorLine }
  TLazEditorLongLine = class(TInterfacedObject, ILazEditorLongLineIntf)
  protected
    fLineText: String;
    fStyleBox:TLazEditorStyleList;
  public
    constructor Create(const aLineText: String; const aStyle:TLazEditorStyleList);
    function GetLineText: String;
    function GetStyle: TLazEditorStyleList;
  end;

  // Warum das Nötig ist, weiß ich im Moment nicht. Sonst geht die "For/In schleife" meine ich nicht.
  TLazEditorLineLL = specialize TLinkedList<TLazEditorLongLine>;

  { TLazEditorLineItem }
  TLazEditorLineItem = class
  private

  protected

  public
    StartCharIndex, EndCharIndex:Integer;
    StartLongLineItem, EndLongLineItem:TLazEditorLongLine;
    LineText:String;
    constructor Create;
    destructor Destroy; override;
  published
  end; // TLazEditorLineItem


  // Eine Test Komponente, Abgeleitet von "TCustomControl".
  // Alle selbst erstellen Komponenten, die NICHT vom Betriebsystem kommen, sind von TCustomControl abgeleitet.
  // Die Namen können wir gerne noch ändern
  { TLazEditor_pr1_Test }
  TLazEditor_pr1_Test = class(TCustomControl)
  private
    fContentText: String;
    fDefaultStyleList: TLazEditorStyleList;
    procedure SetContentText(AValue: String);

    procedure ResetStyle();
    procedure SetDefaultStyleList(AValue: TLazEditorStyleList);
  protected

  public
    // Speichert die einzelnen Elemente der langen Zeile
    LineList:TLazEditorLineLL;

    constructor Create({%H-}AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Render();
    procedure Render2();

    procedure BoundsChanged; override;
    procedure Paint; override;

    procedure SetText(const aBoxArray:TLazEditorBoxArray);

    // Der Text der "gerendert" wird
    property ContentText:String read fContentText write SetContentText;
    property DefaultStyleList:TLazEditorStyleList read fDefaultStyleList write SetDefaultStyleList;

  published
  end; // TLazEditor_pr1_Test

implementation

operator :=(const AValue: String): TLazEditorLongLine;
begin
  Result := TLazEditorLongLine.Create(AValue,nil);
end;

{ TLazEditorLineItem }
constructor TLazEditorLineItem.Create;
begin
  inherited Create;
  LineText:='';
  StartCharIndex:=-1; EndCharIndex:=-1;
  StartLongLineItem:=nil; EndLongLineItem:=nil;
end; // TLazEditorLineItem.Create

destructor TLazEditorLineItem.Destroy;
begin
  inherited Destroy;
end; // TLazEditorLineItem.Destroy

{ TLazEditorLine }
constructor TLazEditorLongLine.Create(const aLineText: String; const aStyle: TLazEditorStyleList);
begin
  inherited Create;
  fLineText:= aLineText;
  fStyleBox:=aStyle;
end; // TLazEditorLongLine.Create

function TLazEditorLongLine.GetLineText: String;
begin
  result:=fLineText;
end; // TLazEditorLongLine.GetLineText

function TLazEditorLongLine.GetStyle: TLazEditorStyleList;
begin
  result:=fStyleBox;
end; // TLazEditorLongLine.GetStyle

{
  Wenn jedes Element noch seine Formatierung speichert,
  kann das bei den Methoden Angewendet werden.
  Diese Elemente gehören ja auch zur "Langen" Zeile.
}

procedure TLazEditor_pr1_Test.SetContentText(AValue: String);
const
  ItemLen = 10;
var
  Len, x, CountChar:Integer;
  Token:String;
  r:boolean;
begin
  fContentText:=AValue;

  Token:='';
  r:=False;
  if fContentText <> AValue then begin
    LineList.Clear;
    Len:=UTF8Length(AValue);
    x:=1;
    CountChar:=ItemLen;
    while (true) do begin
      Token:=UTF8Copy(AValue, x,CountChar +1);
      LineList.InsertLast(TLazEditorLongLine.Create(Token,nil));
      if r then break;
      x += ItemLen + 1;
      if x >= Len then begin
        CountChar:=Len - x;
        r:=true;
      end;
    end;
  end;

end; // TLazEditor_pr1_Test.SetContentText

procedure TLazEditor_pr1_Test.ResetStyle();
begin
  Canvas.Font.Name:='Ubuntu';
  Canvas.Font.Size:=12;
  Canvas.Font.Style:=[];
  Canvas.Font.Color:=clWindowText;
  Canvas.Brush.Color:=clWindow;
end; // TLazEditor_pr1_Test.ResetStyle

procedure TLazEditor_pr1_Test.SetDefaultStyleList(AValue: TLazEditorStyleList);
begin
  if fDefaultStyleList=AValue then Exit;
  fDefaultStyleList:=AValue;
end; // TLazEditor_pr1_Test.SetDefaultStyleList

{ TLazEditor_pr1_Test }
constructor TLazEditor_pr1_Test.Create(AOwner: TComponent);
var
  TextStyle:TTextStyle;
begin
  inherited Create(Owner);
  LineList:=TLazEditorLineLL.Create;
  ResetStyle();

  TextStyle:=Canvas.TextStyle;
  TextStyle.Opaque:=True;
  TextStyle.SystemFont:=False;
  Canvas.TextStyle:=TextStyle;
  DefaultStyleList:=nil;
end; // TLazEditor_pr1_Test.Create

destructor TLazEditor_pr1_Test.Destroy;
begin
  FreeAndNil(LineList);
  inherited Destroy;
end; // TLazEditor_pr1_Test.Destroy

{
  Hier kommen jetzt die ersten Steuerzeichen zum Einsatz.
  Der Zeilenumbruch. Hier wird gezeichnet auf ein "TCanvas".
  Entweder ein Automatischer Zeilenumbruch oder ein Manueller.

  TTextMetric;
  GetTextMetrics();

  An dieser stelle kommt nun die Spannende Frage:
  Wie werden Infos wie Ascent und Descent oder auch die Breite der jeweilige Zeile gespeichert?
  Ascent und Descent sollten Pro Formatierung / Element beachtet werden.
  Für die Ausrichtung an der "BaseLine".

  Für die Zeile ist es Sinnvoll die Maximale Ascent und Descent zu wissen um eine die Elemente einer "Zeile"
  auszurichten.

  Dann gibt es ja noch "align" Left, Center, Right und Blocksatz.

  Jedes Element sollte auch eine Hintergrund Farbe erhalten können.

  Diese Infos hatte ich bisher immer im 2D Raster(Kein 2D Array sondern, es gab immer eine Liste von Zeilen und die hatte jeweils eine Spalten Liste) gespeichert.

  Ich könnte mir auch eine Methode vorstellen, die eine Zeilenstruktur Zurück gibt.
  Gewisse Infos, muss ich vorberechnen.
  Zeigt einige gute Lösungen, für UTF8 Probleme
  https://www.lazarusforum.de/viewtopic.php?t=12779

  Nachtrag:
  Jede Zeile soll gleich hoch sein. Die Schrift Größe wird jetzt erst mal vernachlässigt.

  Das Problem ist jedoch, dass die Methode "TextExtent" von TCanvas die Text Höhe aber nicht die Buchstaben höhe zuürkc gibt.
  Jeder Buchstabe ist gleich Hoch aber unterschiedlich breit.
  Bin mir noch nicht 100% sicher ob das irgendwo einstellbar ist. Bisher habe ich noch keine Hinweise dazu gefunden.

  In einem Test konnte ich einfache Schrift Formatierungs Zeichen wie * und so auswerten. Problem ist dann die Schrift Farbe.
  D.H. wie Parameter übergeben werden.
}

procedure TLazEditor_pr1_Test.Render();
  procedure ToCanvas(aStyle:TLazEditorStyleList);
  var
    i:Integer;
    Style:TLazEditorStyle;
  begin
    for i:=0 to aStyle.Count -1  do begin
      Style:=aStyle[i];
      case Style.Name of
        ESN_Color: Canvas.Font.Color:=style.ValueInt;
        ESN_BackgroundColor: Canvas.Brush.Color:=style.ValueInt;
        ESN_FontStyle: Canvas.Font.Style:=style.ValueFonts;
        ESN_FontSize: Canvas.Font.Size:=style.ValueInt;

        else begin

        end;
      end;
    end;
  end; // ToCanvas

var
  LineItem:TLazEditorLongLine;
  TempLineText:String;

  LineText :String;
  ch:String;

  px, py, pw, ph, x:Integer;
  len:PtrInt;
  LineStart:Integer;
  Size:TSize;
  XHeight:Integer;
  DefaultTM:TEXTMETRIC;
begin
  px:=5; py:=5; pw:=0; ph:=0; LineStart:=px; LineText:='';

  ResetStyle();
  XHeight:=Canvas.TextHeight('x'); // Ist leider nur die Texthöhe aber nicht die Buchstaben Höhe
//  XLineHeight:=XHeight*3;

  LCLIntf.GetTextMetrics(Canvas.Handle, DefaultTM{%H-});
  py:=5;
  ph:=XHeight;

  for LineItem in LineList do begin
    TempLineText:=LineItem.GetLineText;
    x:=0;
    len:=UTF8Length(TempLineText);
    repeat
      x:=x + 1;
      ch:=UTF8Copy(TempLineText, x, 1);
      if ch = #0 then begin
        Canvas.TextOut(LineStart,py,LineText);
        LineStart:=px;
        LineText:='';
        ToCanvas(DefaultStyleList); // Im Moment gibt es noch keine "Vererbung" von Stylen.
        ToCanvas(LineItem.GetStyle);
//        GetTextMetrics(Canvas.Handle, TempTM{%H-});
        continue;
      end;

      Size:=Canvas.TextExtent(ch);
      pw:=Size.cx;
//      TempPH:=Size.cy;
//      if TempPH > ph then ph:=TempPH;

      if px + pw <=ClientWidth - pw then begin
        LineText+=ch;
        px+=pw;
      end
      else begin
        if LineText <> '' then
          Canvas.TextOut(LineStart,py,LineText);
        LineText:=ch;
        LineStart:=5;
        px:=5 + pw;
        py+=ph;
//        ph:=0;
      end;
    until x >= len;
  end; // for LineItem

  if LineText <> '' then begin
    Canvas.TextOut(LineStart,py,LineText);
    LineText:='';
  end;
end; // TLazEditor_pr1_Test.Render

procedure TLazEditor_pr1_Test.Render2();
  procedure CreateLineList(var aLineList:TObjectList);
  var
    LongLineItem:TLazEditorLongLine;
    TempLineText:String;
    LineText :String;
    ch:String;
    px, py, pw, ph, x:Integer;
    LineStart, len:Integer;
    Size:TSize;
    LineItem:TLazEditorLineItem;

  begin
    px:=5; py:=5; pw:=0; ph:=0; LineStart:=px; LineText:='';
    x:=1;
    ResetStyle();

    LineItem:=TLazEditorLineItem.Create;

    for LongLineItem in LineList do begin
      if not Assigned(LineItem.StartLongLineItem) then LineItem.StartLongLineItem:=LongLineItem;

      TempLineText:=LongLineItem.GetLineText;
      x:=0;
      len:=UTF8Length(TempLineText);
      repeat
        x:=x + 1;
        if LineItem.StartCharIndex = -1 then
          LineItem.StartCharIndex:=x;

        ch:=UTF8Copy(TempLineText, x, 1);
        if ch = #0 then begin
          Continue;
        end;

        Size:=Canvas.TextExtent(ch);
        pw:=Size.cx;

        if px + pw <=ClientWidth - pw then begin
          LineText+=ch;
          px+=pw;
        end
        else begin
          LineItem.EndLongLineItem:=LongLineItem;
          LineItem.EndCharIndex:=UTF8Length(TempLineText);
          LineItem.LineText:=LineText;
          aLineList.Add(LineItem);

          LineItem:=TLazEditorLineItem.Create;
          LineItem.StartCharIndex:=x+1;
          LineItem.StartLongLineItem:=LongLineItem;
//          if LineText <> '' then begin
//            Canvas.TextOut(LineStart,py,LineText);
//          end;
          LineText:=ch;
          LineStart:=5;
          px:=5 + pw;
          py+=ph;
        end;
      until x >= len;
    end; // for LineItem

    if LineText <> '' then begin
      LineItem.EndLongLineItem:=LongLineItem;
      LineItem.EndCharIndex:=UTF8Length(TempLineText);
      LineItem.LineText:=LineText;
      aLineList.Add(LineItem);
      LineText:='';
    end;
  end;
var
  aLineList:TObjectList;
  LineItem:TLazEditorLineItem;

  i:Integer;
begin
  aLineList:=TObjectList.Create();
  CreateLineList(aLineList);

  for i:=0 to aLineList.Count -1  do begin
    LineItem:=aLineList[i] as TLazEditorLineItem;

    writeln(LineItem.LineText);
  end; // for i

  FreeAndNil(aLineList);
end; // TLazEditor_pr1_Test.Render2

procedure TLazEditor_pr1_Test.BoundsChanged;
begin
  inherited BoundsChanged;
  Invalidate;
end; // TLazEditor_pr1_Test.BoundsChanged

procedure TLazEditor_pr1_Test.Paint;
begin
  inherited Paint;
  Canvas.Brush.Color:=clWindow;
  Canvas.FillRect(0, 0, ClientWidth, ClientHeight);
  Render();
end; // TLazEditor_pr1_Test.Paint

procedure TLazEditor_pr1_Test.SetText(const aBoxArray: TLazEditorBoxArray);
var
  box:TLazEditorBox;
  TextBox:TLazEditorTextBox;
  StyleList:TLazEditorStyleList;
begin
  LineList.Clear;
  for box in aBoxArray do begin
    if box is TLazEditorTextBox then begin
      TextBox:=box as TLazEditorTextBox;
      LineList.InsertLast(TLazEditorLongLine.Create(TextBox.Text,nil));
    end
    else begin
      StyleList:=box as TLazEditorStyleList;
      LineList.InsertLast(TLazEditorLongLine.Create(#0,StyleList));
    end;

  end;
end; // TLazEditor_pr1_Test.SetText

end.

