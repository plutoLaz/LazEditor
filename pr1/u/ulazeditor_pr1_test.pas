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
  TLazEditorLongLine = class;

  // Warum das Nötig ist, weiß ich im Moment nicht. Sonst geht die "For/In schleife" meine ich nicht.
  TLazEditorLineLL = specialize TLinkedList<TLazEditorLongLine>;

  { TLazEditorBoxExt }
  TLazEditorBoxExt = class
  private
    fHeight: Integer;
    fName: string;
    fWidth: Integer;

  protected

  public
    LineList:TLazEditorLineLL;
    StyleList:TLazEditorStyleList;
    constructor Create(aLineList:TLazEditorLineLL);
    destructor Destroy; override;

    procedure Render(var aLeft, aTop:Integer; aCanvas:TCanvas); virtual;

    property Name:string read fName write fName;

    property Width:Integer read fWidth write fWidth;
    property Height:Integer read fHeight write fHeight;
  published
  end; // TLazEditorBox

  { TLazEditorBoxContainer }
  TLazEditorBoxContainer = class(TLazEditorBoxExt)
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorBoxExt;

  protected

  public
    Items:TObjectList;

    constructor Create(aLineList:TLazEditorLineLL);
    destructor Destroy; override;

    procedure Render(var aLeft, aTop:Integer; aCanvas:TCanvas); override;

    property Count:Integer read GetCount;
    property Item[const aItemIndex:Integer]:TLazEditorBoxExt read GetItem; default;
  published
  end; // TLazEditorBoxContainer

  { TLazEditorBoxParagraph }
  TLazEditorBoxParagraph = class(TLazEditorBoxExt)
  private

  protected

  public
    StartLongLine:TLazEditorLongLine;
    EndLongLine:TLazEditorLongLine;
    StartItem, EndItem: TLazEditorLineLL.PItem;

    constructor Create(aLineList:TLazEditorLineLL);
    destructor Destroy; override;

    procedure SetText(const aBoxArray:TLazEditorBoxArray);

    procedure Render(var aLeft, aTop:Integer; aCanvas:TCanvas); override;
  published
  end; // TLazEditorBoxParagraph

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
    RootBox:TLazEditorBoxContainer;

    constructor Create({%H-}AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Render();
    procedure Render2();
    procedure Render3();

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

{ TLazEditorBoxParagraph }
constructor TLazEditorBoxParagraph.Create(aLineList: TLazEditorLineLL);
begin
  inherited Create(aLineList);
  StartLongLine:=nil;
  EndLongLine:=nil;
  StartItem:=nil;
  EndItem:=nil;
end; // TLazEditorBoxParagraph.Create

destructor TLazEditorBoxParagraph.Destroy;
begin
  inherited Destroy;
end; // TLazEditorBoxParagraph.Destroy

procedure TLazEditorBoxParagraph.SetText(const aBoxArray: TLazEditorBoxArray);
var
  box:TLazEditorBox;
  TempLongLine:TLazEditorLongLine;

  TextBox:TLazEditorTextBox;
  TempStyleList:TLazEditorStyleList;

  Item:TLazEditorLineLL.PItem;
begin
  StartLongLine:=nil;
  EndLongLine:=nil;
  for box in aBoxArray do begin
    if box is TLazEditorTextBox then begin
      TextBox:=box as TLazEditorTextBox;
      TempLongLine:=TLazEditorLongLine.Create(TextBox.Text,nil);
      Item:=LineList.InsertLast(TempLongLine);
    end
    else begin
      TempStyleList:=box as TLazEditorStyleList;
      TempLongLine:=TLazEditorLongLine.Create(#0,TempStyleList);
      Item:=LineList.InsertLast(TempLongLine);
    end;

    if not Assigned(StartItem) then StartItem:=Item;
  end;

 EndItem:=Item;
end; // TLazEditorBoxParagraph.SetText

procedure TLazEditorBoxParagraph.Render(var aLeft, aTop: Integer; aCanvas: TCanvas);
  procedure ToCanvas(aStyle:TLazEditorStyleList);
  var
    i:Integer;
    Style:TLazEditorStyle;
  begin
    for i:=0 to aStyle.Count -1  do begin
      Style:=aStyle[i];
      case Style.Name of
        ESN_Color: aCanvas.Font.Color:=style.ValueInt;
        ESN_BackgroundColor: aCanvas.Brush.Color:=style.ValueInt;
        ESN_FontStyle: aCanvas.Font.Style:=style.ValueFonts;
        ESN_FontSize: aCanvas.Font.Size:=style.ValueInt;

        else begin

        end;
      end;
    end;
  end; // ToCanvas

  procedure TextRender(const aPx, aPy:Integer; const aLineText:String; aDefaultTM, aTempTM:TEXTMETRIC; const aXHeight:Integer);
  var
    py:Integer;
    r:TRect;
    Size:TSize;
  begin
    py:=0;
    if aTempTM.tmHeight > aDefaultTM.tmHeight then begin
      py:=aTempTM.tmAscent;
    end
    else
      py:=+aTempTM.tmAscent;

    Size:=aCanvas.TextExtent(aLineText);

    r.Left:=aPx;
    r.Top:=aPy-aDefaultTM.tmAscent;
    r.Right:=r.left+Size.cx;
    r.Bottom:=r.top+aXHeight;
    // Hintergrund Zeichnen. Nun wird die ganze Höhe beachtet beim Hintergrund Zeichnen.
    aCanvas.FillRect(r);

    aCanvas.Brush.Style:=bsClear;
    aCanvas.TextOut(aPx,aPy-py,aLineText);
    aCanvas.Brush.Style:=bsSolid;

    if aCanvas.Brush.Color = clWindow then
      aCanvas.Pen.Color:=clBlack
    else
      aCanvas.Pen.Color:=InvertColor(aCanvas.Brush.Color);
    aCanvas.MoveTo(r.left, r.top+aDefaultTM.tmAscent);
    aCanvas.LineTo(r.left+Size.cx, r.top+aDefaultTM.tmAscent);
  end; // TextRender

  procedure _AutoLineBreak(const aLineText:String; var _aLeft, _aTop:Integer; aLineItem:TLazEditorLongLine);
//  var
  begin
  end;

var
  LineItem:TLazEditorLongLine;
  TempLineText:String;
  Item:TLazEditorLineLL.PItem;

  px, ph, x, len, pw:Integer;
  XHeight:Integer;
  ch:String;
  LineText:String;
  Size:TSize;
  DefaultTM, TempTM:TEXTMETRIC;

begin
  inherited Render(aLeft, aTop, aCanvas);
  LineText:='';
  writeln(Name, ' Width: ', Width, ' aTop: ', aTop);

  px:=aLeft;

  ToCanvas(StyleList);
  XHeight:=aCanvas.TextHeight('Ae');
  ph:=XHeight;

  LCLIntf.GetTextMetrics(aCanvas.Handle, DefaultTM{%H-});
  TempTM:=DefaultTM;

  Item:=StartItem;
  repeat
    LineItem:=(item^.Data as TLazEditorLongLine);
    TempLineText:=LineItem.GetLineText;
    len:=UTF8Length(TempLineText);

    x:=0;
    repeat
      x:=x + 1;
      ch:=UTF8Copy(TempLineText, x, 1);
      if ch = #0 then begin
        if LineText <> '' then
          TextRender(aLeft,aTop,TempLineText,DefaultTM, TempTM, ph);

        aLeft:=px;
        LineText:='';
        ToCanvas(StyleList);
        ToCanvas(LineItem.GetStyle);
        GetTextMetrics(aCanvas.Handle, TempTM{%H-});
        continue;
      end;

      Size:=aCanvas.TextExtent(ch);
      pw:=Size.cx;
      if px + pw <=Width- pw then begin
        LineText+=ch;
        px+=pw;
      end
      else begin
        if LineText <> '' then begin
          TextRender(aLeft,aTop,LineText,DefaultTM, TempTM, ph);
        end;
        LineText:=ch;
        aLeft:=5;
        px:=5 + pw;
        aTop+=ph;
      end;
    until x >= len;

    if Item = EndItem then break;
    item:=Item^.Next;
  until false;

  if LineText <> '' then begin
    TextRender(aLeft,aTop,LineText,DefaultTM, TempTM, ph);
    aTop+=ph;
    LineText:='';
  end;

  writeln('');

end; // TLazEditorBoxParagraph.Render

function TLazEditorBoxContainer.GetCount: Integer;
begin
  result:=Items.Count;
end; // TLazEditorBoxContainer.GetCount

function TLazEditorBoxContainer.GetItem(const aItemIndex: Integer): TLazEditorBoxExt;
begin
  result:=Items[aItemIndex] as TLazEditorBoxExt;
end; // TLazEditorBoxContainer.GetItem

{ TLazEditorBoxContainer }
constructor TLazEditorBoxContainer.Create(aLineList: TLazEditorLineLL);
begin
  inherited Create(aLineList);
  Items:=TObjectList.Create(False);
  Items.OwnsObjects:=False;
end; // TLazEditorBoxContainer.Create

destructor TLazEditorBoxContainer.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorBoxContainer.Destroy

procedure TLazEditorBoxContainer.Render(var aLeft, aTop: Integer; aCanvas: TCanvas);
var
  i:Integer;
begin
  inherited Render(aLeft,aTop, aCanvas);
  for i:=0 to Count -1 do begin
    Item[i].Width:=Width;
    Item[i].Render(aLeft, aTop, aCanvas);
  end;
end; // TLazEditorBoxContainer.Render

{ TLazEditorBoxExt }
constructor TLazEditorBoxExt.Create(aLineList: TLazEditorLineLL);
begin
  inherited Create;
  StyleList:=nil;
  fName:='';
  fWidth:=-1;
  fHeight:=-1;
  LineList:=aLineList;
end; // TLazEditorBoxExt.Create

destructor TLazEditorBoxExt.Destroy;
begin
  inherited Destroy;
end; // TLazEditorBoxExt.Destroy

procedure TLazEditorBoxExt.Render(var aLeft, aTop: Integer; aCanvas: TCanvas);
begin

end; // TLazEditorBoxExt.Render

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
  TextStyle.Opaque:=False;
  TextStyle.SystemFont:=False;
  Canvas.TextStyle:=TextStyle;
  DefaultStyleList:=nil;

  RootBox:=TLazEditorBoxContainer.Create(LineList);
end; // TLazEditor_pr1_Test.Create

destructor TLazEditor_pr1_Test.Destroy;
begin
  FreeAndNil(LineList); FreeAndNil(RootBox);
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

  procedure TextRender(const aPx, aPy:Integer; const aLineText:String; aDefaultTM, aTempTM:TEXTMETRIC; const aXHeight:Integer);
  var
    py:Integer;
    r:TRect;
    Size:TSize;
  begin
    py:=0;
    if aTempTM.tmHeight > aDefaultTM.tmHeight then begin
      py:=aTempTM.tmAscent;
    end
    else
      py:=+aTempTM.tmAscent;

    Size:=Canvas.TextExtent(aLineText);

    r.Left:=aPx;
    r.Top:=aPy-aDefaultTM.tmAscent;
    r.Right:=r.left+Size.cx;
    r.Bottom:=r.top+aXHeight;
    // Hintergrund Zeichnen. Nun wird die ganze Höhe beachtet beim Hintergrund Zeichnen.
    Canvas.FillRect(r);

    Canvas.Brush.Style:=bsClear;
    Canvas.TextOut(aPx,aPy-py,aLineText);
    Canvas.Brush.Style:=bsSolid;

    if Canvas.Brush.Color = clWindow then
      Canvas.Pen.Color:=clBlack
    else
      Canvas.Pen.Color:=InvertColor(Canvas.Brush.Color);
    Canvas.MoveTo(r.left, r.top+aDefaultTM.tmAscent);
    Canvas.LineTo(r.left+Size.cx, r.top+aDefaultTM.tmAscent);
  end; // TextRender

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
  DefaultTM, TempTM:TEXTMETRIC;
begin
  px:=5; py:=5; pw:=0; ph:=0; LineStart:=px; LineText:='';

  ResetStyle();
  XHeight:=Canvas.TextHeight('Ae');

  LCLIntf.GetTextMetrics(Canvas.Handle, DefaultTM{%H-});
  TempTM:=DefaultTM;
  py:=20;
  ph:=XHeight+5;

  for LineItem in LineList do begin
    TempLineText:=LineItem.GetLineText;
    x:=0;
    len:=UTF8Length(TempLineText);
    repeat
      x:=x + 1;
      ch:=UTF8Copy(TempLineText, x, 1);
      if ch = #0 then begin
        if LineText <> '' then TextRender(LineStart,py,LineText,DefaultTM, TempTM, ph);

        LineStart:=px;
        LineText:='';
        ToCanvas(DefaultStyleList);
        ToCanvas(LineItem.GetStyle);
        GetTextMetrics(Canvas.Handle, TempTM{%H-});
        continue;
      end;

      Size:=Canvas.TextExtent(ch);
      pw:=Size.cx;
      if px + pw <=ClientWidth - pw then begin
        LineText+=ch;
        px+=pw;
      end
      else begin
        if LineText <> '' then
          TextRender(LineStart,py,LineText,DefaultTM, TempTM, ph);
        LineText:=ch;
        LineStart:=5;
        px:=5 + pw;
        py+=ph;
      end;
    until x >= len;
  end; // for LineItem

  if LineText <> '' then begin
    TextRender(LineStart,py,LineText,DefaultTM, TempTM, ph);
  //  Canvas.TextOut(LineStart,py, LineText);
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

procedure TLazEditor_pr1_Test.Render3();
var
  px, py:Integer;
begin
  px:=5; py:=20;
  RootBox.Width:=ClientWidth;
  RootBox.Render(px, py, Canvas);
end; // TLazEditor_pr1_Test.Render3

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
  Render3();
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

