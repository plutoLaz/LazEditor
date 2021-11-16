{
  Datum: Mittwoch der 03.04.2021

  Autor: Michael Springwald
}

unit ulazeditor_pr2_test;

{$mode ObjFPC}
{$H+}

interface

uses
  Classes, SysUtils, Controls, Graphics, LazUTF8, LCLType, LCLIntf,  Contnrs, Types,
  ulazeditor_pr2_boxtype, ulazeditor_pr2_styletypes;

type
  TLazEditorLine = class;

  { TLazEditorLineItem }
  TLazEditorLineItem = class
  private
    fAscent: Integer;
    fBox: TLazEditorBox;
    fDescent: Integer;
    fEndCharIndex: Integer;
    fHeight: Integer;
    fLeft: Integer;
    fLine: TLazEditorLine;
    fStartCharIndex: Integer;
    fWidth: Integer;

  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure ResetVar();

    property Box:TLazEditorBox read fBox write fBox;

    // Damit ist die Zeile gemeint.
    property Line:TLazEditorLine read fLine write fLine;

    // Ein Index als Integer, der sich auf die "Line" bezieht
    property StartCharIndex:Integer read fStartCharIndex write fStartCharIndex;

    // Ein Index als Integer, der sich auf die "Line" bezieht
    property EndCharIndex:Integer read fEndCharIndex write fEndCharIndex;

    property Ascent:Integer read fAscent write fAscent;
    property Descent:Integer read fDescent write fDescent;
    property Left:Integer read fLeft write fLeft;

    property Width:Integer read fWidth write fWidth;
    property Height:Integer read fHeight write fHeight;

  published
  end; // TLazEditorLineItem

  { TLazEditorLine }
  TLazEditorLine = class
  private
    fAscent: Integer;
    fDescent: Integer;
    fHeight: Integer;
    fTop: Integer;
    fWidth: Integer;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorLineItem;

  protected

  public
    Items:TObjectList;

    constructor Create;
    destructor Destroy; override;

    procedure ResetVar();
    function AddLineItem():TLazEditorLineItem;

    property Item[const aItemIndex:Integer]:TLazEditorLineItem read GetItem; default;
    property Count:Integer read GetCount;

    property Ascent:Integer read fAscent write fAscent;
    property Descent:Integer read fDescent write fDescent;
    property Top:Integer read fTop write fTop;
    property Width:Integer read fWidth write fWidth;
    property Height:Integer read fHeight write fHeight;
  published
  end; // TLazEditorLine

  { TLazEditorLineContainer }
  TLazEditorLineContainer = class
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorLine;

  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;
    function AddLine():TLazEditorLine;

    property Item[const aItemIndex:Integer]:TLazEditorLine read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TLazEditorLineContainer


  // Eine Test Komponente, Abgeleitet von "TCustomControl".
  // Alle selbst erstellen Komponenten, die NICHT vom Betriebsystem kommen, sind von TCustomControl abgeleitet.
  // Die Namen können wir gerne noch ändern
  { TLazEditor_pr2_Test }
  TLazEditor_pr2_Test = class(TCustomControl)
  private
    fContentText: String;
    procedure SetContentText(AValue: String);

    procedure ResetStyle();
  protected

  public
    // Speichert die einzelnen Elemente der langen Zeile
    DefaultStyleList:TLazEditorStyleList;

    // Ohne geht es EINFACH nicht !
    LineContainer:TLazEditorLineContainer;

    RootBox:TLazEditorBox;

    constructor Create({%H-}AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ToCanvas(aStyle:TLazEditorStyleList; aSaveList:TObjectList);
    procedure Layout(aBox:TLazEditorBox);
    procedure Render();

    procedure BoundsChanged; override;
    procedure Paint; override;

    procedure SetText(const {%H-}aBoxArray:TLazEditorBoxArray);

    // Der Text der "gerendert" wird
    property ContentText:String read fContentText write SetContentText;
  published
  end; // TLazEditor_pr2_Test

implementation

function TLazEditorLineContainer.GetCount: Integer;
begin
  result:=Items.Count;
end; // TLazEditorLineContainer.GetCount

function TLazEditorLineContainer.GetItem(const aItemIndex: Integer): TLazEditorLine;
begin
  result:=items[aItemIndex] as TLazEditorLine;
end; // TLazEditorLineContainer.GetItem

{ TLazEditorLineContainer }
constructor TLazEditorLineContainer.Create;
begin
  inherited Create;
  Items:=TObjectList.Create(False);
end; // TLazEditorLineContainer.Create

destructor TLazEditorLineContainer.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorLineContainer.Destroy

function TLazEditorLineContainer.AddLine(): TLazEditorLine;
begin
  result:=Item[Items.Add(TLazEditorLine.Create)];
end; // TLazEditorLineContainer.AddLine

function TLazEditorLine.GetCount: Integer;
begin
  result:=Items.Count;
end; // TLazEditorLine.GetCount

function TLazEditorLine.GetItem(const aItemIndex: Integer): TLazEditorLineItem;
begin
  result:=Items[aItemIndex] as TLazEditorLineItem;
end; // TLazEditorLine.GetItem

{ TLazEditorLine }
constructor TLazEditorLine.Create;
begin
  inherited Create;
  Items:=TObjectList.Create(False);
  ResetVar();
end; // TLazEditorLine.Create

destructor TLazEditorLine.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorLine.Destroy

procedure TLazEditorLine.ResetVar();
begin
  fAscent:=-1;
  fDescent:=-1;
  fTop:=-1;
  fWidth:=-1;
  fHeight:=-1;
end; // TLazEditorLine.ResetVar

function TLazEditorLine.AddLineItem(): TLazEditorLineItem;
begin
  result:=Item[items.Add(TLazEditorLineItem.Create)];
  result.Line:=self;
end; // TLazEditorLine.AddLineItem

{ TLazEditorLineItem }
constructor TLazEditorLineItem.Create;
begin
  inherited Create;
  ResetVar();
end; // TLazEditorLineItem.Create

destructor TLazEditorLineItem.Destroy;
begin
  inherited Destroy;
end; // TLazEditorLineItem.Destroy

procedure TLazEditorLineItem.ResetVar();
begin
  fBox:=nil;
  fLine:=nil;
  fStartCharIndex:=-1;
  fEndCharIndex:=-1;
  fAscent:=-1;
  fDescent:=-1;
  fLeft:=-1;
  fWidth:=-1;
  fHeight:=-1;
end; // TLazEditorLineItem.ResetVar

{
  Wenn jedes Element noch seine Formatierung speichert,
  kann das bei den Methoden Angewendet werden.
  Diese Elemente gehören ja auch zur "Langen" Zeile.
}

procedure TLazEditor_pr2_Test.SetContentText(AValue: String);
{const
  ItemLen = 10;
var
  Len, x, CountChar:Integer;
  Token:String;
  r:boolean;}
begin
  {
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
      LineList.InsertLast(TLazEditorLine.Create(Token,nil));
      if r then break;
      x += ItemLen + 1;
      if x >= Len then begin
        CountChar:=Len - x;
        r:=true;
      end;
    end;
  end;}
end; // TLazEditor_pr2_Test.SetContentText

procedure TLazEditor_pr2_Test.ResetStyle();
begin
  Canvas.Font.Name:='Ubuntu';
  Canvas.Font.Size:=12;
  Canvas.Font.Style:=[];
  Canvas.Font.Color:=clWindowText;
  Canvas.Brush.Color:=clWindow;
end; // TLazEditor_pr2_Test.ResetStyle

{ TLazEditor_pr2_Test }
constructor TLazEditor_pr2_Test.Create(AOwner: TComponent);
var
  TextStyle:TTextStyle;
begin
  inherited Create(Owner);
  RootBox:=TLazEditorBox.Create(nil,'RootBox',True);
  LineContainer:=TLazEditorLineContainer.Create;

  ResetStyle();

  TextStyle:=Canvas.TextStyle;
  TextStyle.Opaque:=True;
  Canvas.TextStyle:=TextStyle;

  DefaultStyleList:=TLazEditorStyleList.Create;
end; // TLazEditor_pr2_Test.Create

destructor TLazEditor_pr2_Test.Destroy;
begin
  FreeAndNil(LineContainer);
  inherited Destroy;
end; // TLazEditor_pr2_Test.Destroy

procedure TLazEditor_pr2_Test.ToCanvas(aStyle: TLazEditorStyleList; aSaveList: TObjectList);
var
  i:Integer;
  TempStyle, Style:TLazEditorStyle;
begin
  for i:=0 to aStyle.Count -1  do begin
    Style:=aStyle[i];
    case Style.Name of
      ESN_Color: begin
        TempStyle:=TLazEditorStyle.Create();
        TempStyle.Name:=ESN_Color;
        TempStyle.ValueInt:=Canvas.Font.Color;
        aSaveList.Add(TempStyle);
        Canvas.Font.Color:=style.ValueInt;
      end;

      ESN_BackgroundColor: begin
        Canvas.Brush.Color:=style.ValueInt;
      end;

      ESN_FontStyle: begin
        Canvas.Font.Style:=style.ValueFonts;
      end;

      ESN_FontSize: begin
        Canvas.Font.Size:=style.ValueInt;
      end

      else begin

      end;
    end;
  end;
end; // TLazEditor_pr2_Test.ToCanvas

procedure TLazEditor_pr2_Test.Layout(aBox: TLazEditorBox);
var
  SaveList:TObjectList;

  procedure _LayoutContentText(var Line:TLazEditorLine; var LineItem:TLazEditorLineItem; Box: TLazEditorBox; var px:Integer; var py:integer; const aLevelStr:String);
  var
    x, Len, pw:Integer;
    Size:TSize;
    ch, TempText:String;
  begin
    pw:=0; TempText:=''; ch:='';
    LineItem.Box:=Box;
    len:=UTF8Length(Box.ContentText);
    for x:=1 to Len do begin
      ch:=UTF8Copy(Box.ContentText, x, 1);
      Size:=Canvas.TextExtent(ch);
      if Size.cy >=Line.Height then Line.Height:=Size.cy;

      pw:=Size.cx;
      if px + pw <= ClientWidth then begin
        TempText+=ch;
        LineItem.Width:=LineItem.Width + pw;
        px+=pw;
      end
      else begin
        Line.Top:=py;
        LineItem.EndCharIndex:=x;
        py+=Line.Height;

        Line:=LineContainer.AddLine();
        Line.Top:=py;

        px:=5;
        LineItem:=Line.AddLineItem();
        LineItem.StartCharIndex:=x;
        LineItem.Left:=px;
        LineItem.Box:=Box;
      end;
    end; // for x
    LineItem.EndCharIndex:=x+1;

  end; // _LayoutContentText

  procedure _Layout(var Line:TLazEditorLine; var LineItem:TLazEditorLineItem; _aBox: TLazEditorBox; var px:Integer; var py:integer; aLevelStr:String);
  var
    Box:TLazEditorBox;
    i:Integer;
  begin
    for i:=0 to _aBox.Count -1 do begin
      Box:=_aBox[i];
      if Box.ContentText <> '' then begin
        // Jede Box wird eine eigene Spalte in der Zeilen/Spalten Struktur
        LineItem:=Line.AddLineItem();
        LineItem.StartCharIndex:=1;
        LineItem.Left:=px;
        _LayoutContentText(Line, LineItem, Box,px, py, aLevelStr);
      end;

      if Box.Count > 0 then
        _Layout(Line, LineItem, Box,px, py, aLevelStr + '  ');
    end; // for i
  end; // _Layout

var
  px, py:Integer;

  Line:TLazEditorLine;
  LineItem:TLazEditorLineItem;
begin
  SaveList:=TObjectList.Create();

  ToCanvas(DefaultStyleList, SaveList);
  LineContainer.Items.Clear; // Alles löschen.
  px:=5; py:=5;

  Line:=LineContainer.AddLine();
  Line.Top:=py;
  LineItem:=nil;

  _Layout(Line, LineItem, aBox,px, py, '');

  FreeAndNil(SaveList);
end; // TLazEditor_pr2_Test.Layout

{
  Das ist jetzt die zweite Variante der Render Methode.
  Ich fand die Idee mit der "Langen" Zeile nicht schlecht, mir ist aber nicht klar, wo man dort s speichern könnte über die Zeile bevor
  gerendert wird.
}

procedure TLazEditor_pr2_Test.Render();
var
  y,x:Integer;

  Line:TLazEditorLine;
  LineItem:TLazEditorLineItem;
  TempText:String;
  SaveList:TObjectList;
begin
  SaveList:=TObjectList.Create();
  ToCanvas(DefaultStyleList, SaveList);

  for y:=0 to LineContainer.Count -1 do begin
    Line:=LineContainer[y];
    for x:=0 to Line.Count -1 do begin
      LineItem:=Line[x];
      TempText:=UTF8Copy(LineItem.Box.ContentText,LineItem.StartCharIndex, LineItem.EndCharIndex - LineItem.StartCharIndex);
      if Assigned(LineItem.Box.StyleList) then
        ToCanvas(LineItem.Box.StyleList, SaveList);
      Canvas.TextOut(LineItem.Left, LineItem.Line.Top, TempText);
    end; // for
  end; // for y
  FreeAndNil(SaveList);
end; // TLazEditor_pr2_Test.Render

procedure TLazEditor_pr2_Test.BoundsChanged;
begin
  inherited BoundsChanged;
  Layout(RootBox);
  writeln('               ');
  Invalidate;
end; // TLazEditor_pr2_Test.BoundsChanged

procedure TLazEditor_pr2_Test.Paint;
begin
  inherited Paint;
  Canvas.Brush.Color:=clWindow;
  Canvas.FillRect(0, 0, ClientWidth, ClientHeight);
  Render();
end; // TLazEditor_pr2_Test.Paint

procedure TLazEditor_pr2_Test.SetText(const aBoxArray: TLazEditorBoxArray);
//var
//  box:TLazEditorBox;
//  StyleList:TLazEditorStyleList;
begin
//  LineList.Clear;
{  for box in aBoxArray do begin
    if box is TLazEditorTextBox then begin
      TextBox:=box as TLazEditorTextBox;
      LineList.InsertLast(TLazEditorLine.Create(TextBox.Text,nil));
    end

  end;}
end; // TLazEditor_pr2_Test.SetText

end.

