{
  Autor: Michael Springwald

  Datum: Samstag der 05.06.2021
}

unit uplEditor_Document;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Contnrs, Controls, Graphics, Types, LCLType, LCLProc, LCLIntf,
  upleditor_style, upleditor_styletype
  ;

type
  TPLEditor_RootBox = class;
  TPLEditor_Line = class;
  TPLEditor_LineList = class;

  TPLEditor_CustomContent = class;
  TPLEditor_ContainerBox = class;
  TPLEditor_Paragraph = class;

  TPLEditor_ContentList = class;

  TPLEditor_OnLog = procedure (const aMsg:String; const aGotoToLine:Boolean) of object;

  { TPLEditor_LineColumn }
  TPLEditor_LineColumn = class
  private
    fAscent: Integer;
    fDescent: Integer;
    fEndContent: Integer;
    fLeft: Integer;
    fParagraph: TPLEditor_Paragraph;
    fStartContent: Integer;
    fStyleClass: TPLEditorStyleClass;
    fWidth: Integer;

  protected

  public
    Line:TPLEditor_Line; // Eine Pointer Verbindung
    LineList:TPLEditor_LineList;
    constructor Create;
    destructor Destroy; override;

    procedure Clear();

    function FindContentByXY(const X,Y:Integer):Integer;

    property Left:Integer read fLeft write fLeft;
    property Width:Integer read fWidth write fWidth;

    property Ascent:Integer read fAscent write fAscent;
    property Descent:Integer read fDescent write fDescent;

    property StyleClass:TPLEditorStyleClass read fStyleClass write fStyleClass;

    property Paragraph:TPLEditor_Paragraph read fParagraph write fParagraph; // Eine Pointer Verbindung
    property StartContent:Integer read fStartContent write fStartContent; // Eine Pointer Verbindung
    property EndContent:Integer read fEndContent write fEndContent; // Eine Pointer Verbindung
  published
  end; // TPLEditor_LineColumn

  TPLEditor_Line = class
  private
    fAscent: Integer;
    fDescent: Integer;
    fHeight: Integer;
    fLeft: Integer;
    fTop: Integer;
    fWidth: Integer;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLEditor_LineColumn;

  protected

  public
    Items:TObjectList;
    LineList:TPLEditor_LineList; // Eine Pointer Verbindung
    constructor Create;
    destructor Destroy; override;

    function Add():TPLEditor_LineColumn;
    procedure Clear();

    function FindLineColumnByXY(const X, Y:Integer):Integer;


    property Item[const aItemIndex:Integer]:TPLEditor_LineColumn read GetItem; default;
    property Count:Integer read GetCount;

    property Left:Integer read fLeft write fLeft;
    property Top:Integer read fTop write fTop;
    property Width:Integer read fWidth write fWidth;
    property Height:Integer read fHeight write fHeight;

    property Ascent:Integer read fAscent write fAscent;
    property Descent:Integer read fDescent write fDescent;

  published
  end; // TPLEditor_Line

  { TPLEditor_LineList }
  TPLEditor_LineList = class
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLEditor_Line;

  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;

    function Add():TPLEditor_Line;
    procedure Clear();

    function FindLineByXY(const X, Y:Integer):Integer;

    property Item[const aItemIndex:Integer]:TPLEditor_Line read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TPLEditor_LineList

  { TPLEditor_CustomContent }
  TPLEditor_CustomContent = class
  private

  protected

  public
    StyleClass:TPLEditorStyleClass;
    constructor Create(aContentList:TPLEditor_ContentList); virtual;
    destructor Destroy; override;
  published
  end; // TPLEditor_CustomContent

  { TPLEditor_TextContent }
  TPLEditor_TextContent = class(TPLEditor_CustomContent)
  private

  protected

  public
    Text:String;
    constructor Create(aContentList:TPLEditor_ContentList); override;
    destructor Destroy; override;
  published
  end; // TPLEditor_TextContent

  { TPLEditor_ImageContent }
  TPLEditor_ImageContent = class(TPLEditor_CustomContent)
  private
    fPicture: TPicture;
  protected

  public
    constructor Create(aContentList:TPLEditor_ContentList); override;
    destructor Destroy; override;

    property Picture:TPicture read fPicture write fPicture;
  published
  end; // TPLEditor_ImageContent

  { TPLEditor_ContentList }
  TPLEditor_ContentList = class
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLEditor_CustomContent;

  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;

    property Item[const aItemIndex:Integer]:TPLEditor_CustomContent read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TPLEditor_ContentList

  { TPLEditor_CustomBox }
  TPLEditor_CustomBox = class
  private
    fHeight: Integer;
    fLeft: Integer;
    fTop: Integer;
    fWidth: Integer;

  protected

  public
    Name:String; // Nur zum testen am Anfang
    OwnerContainer:TPLEditor_ContainerBox;
    StyleClass:TPLEditorStyleClass;

    constructor Create(aOwnerContainer:TPLEditor_ContainerBox); virtual;
    destructor Destroy; override;

    procedure Layout(aCanvas:TCanvas); virtual;
    // Wird aufgerufen, wenn die RootBox, alle Zeilen Löscht.
    // Beim Absatzt wird hier z.b. StartLineIndex und EndLineIndex auf -1 gesetzt
    procedure DoClearLineList(); virtual;

    property Left:Integer read fLeft write fLeft;
    property Top:Integer read fTop write fTop;
    property Width:Integer read fWidth write fWidth;
    property Height:Integer read fHeight write fHeight;
  published
  end; // TPLEditor_CustomBox

  { TPLEditor_ContainerBox }
  TPLEditor_ContainerBox = class(TPLEditor_CustomBox)
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLEditor_CustomBox;

  protected

  public
    Items:TObjectList;
    constructor Create(aOwnerContainer:TPLEditor_ContainerBox); override;
    destructor Destroy; override;

    procedure Layout(aCanvas:TCanvas); override;

    property Item[const aItemIndex:Integer]:TPLEditor_CustomBox read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TPLEditor_ContainerBox

  // Sollte es nur einmal geben, pro Dokument.
  { TPLEditor_RootBox }
  TPLEditor_RootBox = class(TPLEditor_ContainerBox)
  private
    fOnLog: TPLEditor_OnLog;

  protected
  public
    LineList:TPLEditor_LineList; // Gibt es nur einmal in der RootBox. Jede ContainerBox erzeugt eine Zeile.
    StyleContainer:TPLEditorStyleContainer;
    OutCanvas:TCanvas;

    CurrLine:TPLEditor_Line;
    CurrLineColumn:TPLEditor_LineColumn;
    CurrCustomContent:TPLEditor_CustomContent;
    CurrCustomContentLeft:Integer;

    constructor Create(aOwnerContainer:TPLEditor_ContainerBox); override;
    destructor Destroy; override;

    procedure Layout(aCanvas:TCanvas); override;
    procedure Render(aCanvas:TCanvas; const aStartLineIndex:Integer = -1; const aEndLineIndex:Integer = -1);

    procedure Update();
    procedure AddOrEditSyleClass(const aStyleName: TPLEditor_StyleName; aValue: TPLEditor_Value);

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure DoOnLog(const aMsg:String; const aGotoToLine:Boolean);
    property OnLog:TPLEditor_OnLog read fOnLog write fOnLog;
  published
  end; // TPLEditor_RootBox

  { TPLEditor_Table }
  TPLEditor_Table = class(TPLEditor_ContainerBox)
  private

  protected

  public

    constructor Create(aOwnerContainer:TPLEditor_ContainerBox); override;
    destructor Destroy; override;
  published
  end; // TPLEditor_Table

  { TPLEditor_List }
  TPLEditor_List = class(TPLEditor_ContainerBox)
  private

  protected

  public

    constructor Create(aOwnerContainer:TPLEditor_ContainerBox); override;
    destructor Destroy; override;
  published
  end; // TPLEditor_List

  { TPLEditor_Paragraph }
  TPLEditor_Paragraph = class(TPLEditor_CustomBox)
  private

  protected

  public
    ContentList:TPLEditor_ContentList;
    StartLineIndex, EndLineIndex:Integer;

    constructor Create(aOwnerContainer:TPLEditor_ContainerBox); override;
    destructor Destroy; override;

    procedure DoClearLineList(); override;
    procedure Layout(aCanvas:TCanvas); override;

    procedure AddTextContent(const aValue:String; const aStyleClass:TPLEditorStyleClass);
    procedure AddImage(aPic:TPicture);
    procedure AddImage(const aFileName:String);
  published
  end; // TPLEditor_Paragraph

  { TPLEditorDocument }
  TPLEditorDocument = class
  private

  protected

  public
    constructor Create;
    destructor Destroy; override;

    procedure Layout(const aWidth, aHeight:Integer; aCanvas:TCanvas);
    procedure Render(aCanvas:TCanvas);

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  published
  end; // TPLEditorDocument

var
  RootBox:TPLEditor_RootBox;

implementation

function TPLEditor_LineList.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLEditor_LineList.GetCount

function TPLEditor_LineList.GetItem(const aItemIndex: Integer): TPLEditor_Line;
begin
  result:=Items[aItemIndex] as TPLEditor_Line;
end; // TPLEditor_LineList.GetItem

{ TPLEditor_LineList }
constructor TPLEditor_LineList.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
end; // TPLEditor_LineList.Create

destructor TPLEditor_LineList.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLEditor_LineList.Destroy

function TPLEditor_LineList.Add(): TPLEditor_Line;
begin
  result:=Item[ Items.Add(TPLEditor_Line.Create)];
  result.LineList:=self;
end; // TPLEditor_LineList.Add

procedure TPLEditor_LineList.Clear();
var
  i:Integer;
begin

  for i:=Count -1 downto 0 do begin
    Item[i].Clear();
  end; // for i
  Items.Clear;
end; // TPLEditor_LineList.Clear

function TPLEditor_LineList.FindLineByXY(const X, Y: Integer): Integer;
var
  i:Integer;
  TempLine:TPLEditor_Line;
  Rect:TRect;
  PT:TPoint;
begin
  result:=-1;

  PT:=Point(X,Y);
  for i:=0 to Count -1 do begin
    TempLine:=Item[i];

    Rect.Left:=TempLine.Left;
    Rect.Top:=TempLine.Top;
    Rect.Right:=Rect.Left + TempLine.Width;
    Rect.Bottom:=Rect.Top + TempLine.Height;

    if PtInRect(Rect, pt) then begin
      result:=i;
      break;
    end;
  end; // for i
end; // TPLEditor_LineList.FindLineByXY

function TPLEditor_Line.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLEditor_Line.GetCount

function TPLEditor_Line.GetItem(const aItemIndex: Integer): TPLEditor_LineColumn;
begin
  result:=items[aItemIndex] as TPLEditor_LineColumn;
end; // TPLEditor_Line.GetItem

{ TPLEditor_Line }
constructor TPLEditor_Line.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
  LineList:=nil;

  fLeft:=0;
  fTop:=0;
  fWidth:=0;
  fHeight:=0;
  fAscent:=0;
  fDescent:=0;
end; // TPLEditor_Line.Create

destructor TPLEditor_Line.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLEditor_Line.Destroy

function TPLEditor_Line.Add(): TPLEditor_LineColumn;
begin
  result:=Item[Items.Add(TPLEditor_LineColumn.Create)];
  result.Line:=self;
end; // TPLEditor_Line.Add

procedure TPLEditor_Line.Clear();
var
  i:Integer;
begin
  for i:=Count -1 downto 0 do begin
    Item[i].Clear();
  end; // for i
  Items.Clear;
end; // TPLEditor_Line.Clear

function TPLEditor_Line.FindLineColumnByXY(const X, Y: Integer): Integer;
var
  i:Integer;
  TempLineColumn:TPLEditor_LineColumn;
  Rect:TRect;
  PT:TPoint;
begin
  result:=-1;

  PT:=Point(X,Y);
  for i:=0 to Count -1 do begin
    TempLineColumn:=Item[i];

    Rect.Left:=TempLineColumn.Left;
    Rect.Top:=Top;
    Rect.Right:=Rect.Left + TempLineColumn.Width;
    Rect.Bottom:=Rect.Top + Height;

    if PtInRect(Rect, pt) then begin
      result:=i;
      break;
    end;
  end; // for i
end; // TPLEditor_Line.FindLineColumnByXY

{ TPLEditor_LineColumn }
constructor TPLEditor_LineColumn.Create;
begin
  inherited Create;
  Line:=nil;
  LineList:=nil;
  fLeft:=0;
  fWidth:=0;
  fAscent:=0;
  fDescent:=0;
  fParagraph:=nil;
  fStyleClass:=nil;
  fStartContent:=-1;
  fEndContent:=-1;
end; // TPLEditor_LineColumn.Create

destructor TPLEditor_LineColumn.Destroy;
begin
  fParagraph:=nil;
  fStartContent:=-1;
  fEndContent:=-1;
  inherited Destroy;
end; // TPLEditor_LineColumn.Destroy

procedure TPLEditor_LineColumn.Clear();
begin
   if Assigned(LineList) then LineList.Clear();
end; // TPLEditor_LineColumn.Clear()

function TPLEditor_LineColumn.FindContentByXY(const X, Y: Integer): Integer;
var
  i, px, pw:Integer;
  TextContent:TPLEditor_TextContent;
begin
  result:=-1;
  if Assigned(Paragraph.StyleClass) then Paragraph.StyleClass.ToCanvas(RootBox.OutCanvas);
  if Assigned(StyleClass) then StyleClass.ToCanvas(RootBox.OutCanvas);
  px:=Left;

  for i:=StartContent to EndContent do begin
    TextContent:=Paragraph.ContentList[i] as TPLEditor_TextContent;

    pw:=RootBox.OutCanvas.TextWidth(TextContent.Text);
    if px + pw <= X then
      px:=px + pw
    else begin
      result:=i;
      break;
    end;
  end;
end; // TPLEditor_LineColumn.FindContentByXY

function TPLEditor_ContentList.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLEditor_ContentList.GetCount

function TPLEditor_ContentList.GetItem(const aItemIndex: Integer): TPLEditor_CustomContent;
begin
  result:=Items[aItemIndex] as TPLEditor_CustomContent;
end; // TPLEditor_ContentList.GetItem

{ TPLEditor_ContentList }
constructor TPLEditor_ContentList.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
end; // TPLEditor_ContentList.Create

destructor TPLEditor_ContentList.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLEditor_ContentList.Destroy

{ TPLEditor_ImageContent }
constructor TPLEditor_ImageContent.Create(aContentList: TPLEditor_ContentList);
begin
  inherited Create(aContentList);
  fPicture:=TPicture.Create;
end; // TPLEditor_ImageContent.Create

destructor TPLEditor_ImageContent.Destroy;
begin
  FreeAndNil(fPicture);
  inherited Destroy;
end; // TPLEditor_ImageContent.Destroy

{ TPLEditor_TextContent }
constructor TPLEditor_TextContent.Create(aContentList: TPLEditor_ContentList);
begin
  inherited Create(aContentList);
  Text:='';
end; // TPLEditor_TextContent.Create

destructor TPLEditor_TextContent.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_TextContent.Destroy

{ TPLEditor_CustomContent }
constructor TPLEditor_CustomContent.Create(aContentList: TPLEditor_ContentList);
begin
  inherited Create;
  aContentList.Items.Add(self);
  StyleClass:=nil;
end; // TPLEditor_CustomContent.Create

destructor TPLEditor_CustomContent.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_CustomContent.Destroy

constructor TPLEditorDocument.Create;
begin
  inherited Create;
  RootBox:=TPLEditor_RootBox.Create(nil);
end; // TPLEditorDocument.Create

destructor TPLEditorDocument.Destroy;
begin
  FreeAndNil(RootBox);
  inherited Destroy;
end; // TPLEditorDocument.Destroy

procedure TPLEditorDocument.Layout(const aWidth, aHeight: Integer; aCanvas: TCanvas);
begin
  RootBox.Width:=aWidth;
  RootBox.Height:=aHeight;
  RootBox.Layout(aCanvas);
end; // TPLEditorDocument.Layout

procedure TPLEditorDocument.Render(aCanvas: TCanvas);
begin
  RootBox.Render(aCanvas);
end; // TPLEditorDocument.Render

procedure TPLEditorDocument.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RootBox.MouseDown(Button, Shift, X,Y);
end; // TPLEditorDocument.MouseDown

procedure TPLEditorDocument.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  RootBox.MouseMove(Shift, X,Y);
end; // TPLEditorDocument.MouseMove

procedure TPLEditorDocument.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RootBox.MouseUp(Button, Shift, X, Y);
end; // TPLEditorDocument.MouseUp

constructor TPLEditor_Paragraph.Create(aOwnerContainer: TPLEditor_ContainerBox);
begin
  inherited Create(aOwnerContainer);
  ContentList:=TPLEditor_ContentList.Create;

  StartLineIndex:=-1;
  EndLineIndex:=-1;
end; // TPLEditor_Paragraph.Create

destructor TPLEditor_Paragraph.Destroy;
begin
  FreeAndNil(ContentList);
  inherited Destroy;
end; // TPLEditor_Paragraph.Destroy

procedure TPLEditor_Paragraph.DoClearLineList();
begin
  inherited DoClearLineList();
  StartLineIndex:=-1;
  EndLineIndex:=-1;
end; // TPLEditor_Paragraph.DoClearLineList

procedure TPLEditor_Paragraph.Layout(aCanvas: TCanvas);
  function InitTextMetric():TTextMetric;
  begin
    result.tmHeight:=0;
    result.tmAscent:=0;
    result.tmDescent:=0;
    result.tmInternalLeading:=0;
    result.tmExternalLeading:=0;
    result.tmAveCharWidth:=0;
    result.tmMaxCharWidth:=0;
    result.tmWeight:=0;
    result.tmOverhang:=0;
    result.tmDigitizedAspectX:=0;
    result.tmDigitizedAspectY:=0;
    result.tmFirstChar:=#0 ;
    result.tmLastChar:=#0 ;
    result.tmDefaultChar:=#0;
    result.tmBreakChar:=#0;
    result.tmItalic:=0;
    result.tmUnderlined:=0;
    result.tmStruckOut:=0;
    result.tmPitchAndFamily:=0;
    result.tmCharSet:=0;
  end; // InitTextMetric
var
  i, x:Integer;

  px, py:Integer;

  Line:TPLEditor_Line;
  LineColumn:TPLEditor_LineColumn;
  TextContent:TPLEditor_TextContent;
  OldStyleClass:TPLEditorStyleClass;
  TextMetric:TTextMetric;
  Size:TSize;
begin
// An dieser stelle brauche ich eine vertektte Liste.
{  if (StartLineIndex > -1) and (EndLineIndex > -1) then begin
    for i:=EndLineIndex downto StartLineIndex do begin
      RootBox.LineList.Items.Delete(i);
    end; // for i
    StartLineIndex:=-1; EndLineIndex:=-1;
  end;}
//  StartLineIndex:=-1;
//  EndLineIndex:=-1;

  Width:=OwnerContainer.Width;

  Height:=0; px:=Left; py:=Top;

  OldStyleClass:=nil;
  TextMetric:=InitTextMetric();
  RootBox.DoOnLog(Name, False);
  RootBox.DoOnLog('----', False);

  RootBox.StyleClass.ToCanvas(aCanvas);
  if Assigned(StyleClass) then StyleClass.ToCanvas(aCanvas);

  Line:=RootBox.LineList.Add();
  Line.Left:=px;
  Line.Top:=py;
  RootBox.DoOnLog(IntToStr(StartLineIndex), True);
  StartLineIndex:=RootBox.LineList.Count -1;

  LineColumn:=Line.Add();
  LineColumn.Paragraph:=self;
  LineColumn.Left:=px;
  LineColumn.StartContent:=0;
  for i:=0 to ContentList.Count - 1 do begin
    TextContent:=ContentList[i] as TPLEditor_TextContent;

    if (TextContent.StyleClass <> OldStyleClass) then begin
      LineColumn.EndContent:=i - 1;
      RootBox.StyleClass.ToCanvas(aCanvas);
      if Assigned(StyleClass) then StyleClass.ToCanvas(aCanvas);
      if Assigned(TextContent.StyleClass) then TextContent.StyleClass.ToCanvas(aCanvas);

      Size:=aCanvas.TextExtent(TextContent.Text);
      GetTextMetrics(aCanvas.Handle,TextMetric);
      if (px + Size.cx+5 < Width) then begin
        LineColumn:=Line.Add();
        LineColumn.StyleClass:=TextContent.StyleClass;
        LineColumn.Paragraph:=self;
        LineColumn.Left:=px;
        LineColumn.StartContent:=i;
      end;
    end;
    OldStyleClass:=TextContent.StyleClass;
    Size:=aCanvas.TextExtent(TextContent.Text);

    GetTextMetrics(aCanvas.Handle,TextMetric);
    if RootBox.CurrCustomContent = TextContent then begin
      RootBox.CurrLine:=Line;
      RootBox.CurrLineColumn:=LineColumn;
    end;

    if Size.cy > Line.Height then Line.Height:=Size.cy;

    if (px + Size.cx+5 < Width) then begin
      px:=px+Size.cx;
      LineColumn.Width:=LineColumn.Width + Size.cx;
      Line.Width:=Line.Width + Size.cx;
      if TextMetric.tmAscent > LineColumn.Ascent then LineColumn.Ascent:=TextMetric.tmAscent;
      if TextMetric.tmDescent > LineColumn.Descent then LineColumn.Descent:=TextMetric.tmDescent;
    end
    else begin
      py:=py + Line.Height;
      px:=Left;
      LineColumn.EndContent:=i-1;
      Line.Width:=Line.Width + Size.cx;

      Line:=RootBox.LineList.Add();
      Line.Left:=px;
      Line.Top:=py;
      Line.Height:=size.cy;

      LineColumn:=Line.Add();
      LineColumn.Paragraph:=self;
      LineColumn.Left:=px;
      LineColumn.StartContent:=i;
      LineColumn.StyleClass:=TextContent.StyleClass;
      LineColumn.Width:=size.Width;
      LineColumn.Ascent:=TextMetric.tmAscent;
      LineColumn.Descent:=TextMetric.tmDescent;


      px:=px + Size.cx;
    end;
  end; // for i
  EndLineIndex:=RootBox.LineList.Count -1;

  for i:=StartLineIndex to EndLineIndex do begin
    Line:=RootBox.LineList[i];
    for x:=0 to Line.Count -1 do begin
      LineColumn:=Line[x];
      if LineColumn.Ascent > Line.Ascent then Line.Ascent:=LineColumn.Ascent;
      if LineColumn.Descent > Line.Descent then Line.Descent:=LineColumn.Descent;
    end;

    Height:=Height + Line.Height;
  end; // for i

  if LineColumn.EndContent = -1 then begin
    LineColumn.EndContent:=ContentList.Count - 1;
    Line.Width:=Line.Width + LineColumn.Width;
  end;
  Height:=Height + 5;

end; // TPLEditor_Paragraph.Layout

procedure TPLEditor_Paragraph.AddTextContent(const aValue: String; const aStyleClass: TPLEditorStyleClass);
var
  ch, Token:UTF8String;
  TextContent:TPLEditor_TextContent;
begin
  Token:='';

  for ch in aValue do begin
    if ch = ' ' then begin
      if Token <> '' then begin
        TextContent:=TPLEditor_TextContent.Create(ContentList);
        TextContent.Text:=Token + ch;
        TextContent.StyleClass:=aStyleClass;
      end;
      Token:='';
    end
    else
      Token+=ch;
  end;

  if Token <> '' then begin
    TextContent:=TPLEditor_TextContent.Create(ContentList);
    TextContent.Text:=Token;
    TextContent.StyleClass:=aStyleClass;
  end;
end; // TPLEditor_Paragraph.AddTextContent

procedure TPLEditor_Paragraph.AddImage(aPic: TPicture);
begin

end; // TPLEditor_Paragraph.AddImage

procedure TPLEditor_Paragraph.AddImage(const aFileName: String);
begin

end; // TPLEditor_Paragraph.AddImage

constructor TPLEditor_List.Create(aOwnerContainer: TPLEditor_ContainerBox);
begin
  inherited Create(aOwnerContainer);
end; // TPLEditor_List.Create

destructor TPLEditor_List.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_List.Destroy

constructor TPLEditor_Table.Create(aOwnerContainer: TPLEditor_ContainerBox);
begin
  inherited Create(aOwnerContainer);
end; // TPLEditor_Table.Create

destructor TPLEditor_Table.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_Table.Destroy

procedure TPLEditor_RootBox.DoOnLog(const aMsg: String; const aGotoToLine: Boolean);
begin
  if Assigned(OnLog) then OnLog(aMsg, aGotoToLine);
end; // TPLEditor_RootBox.DoOnLog

constructor TPLEditor_RootBox.Create(aOwnerContainer: TPLEditor_ContainerBox);
begin
  inherited Create(aOwnerContainer);
  CurrLine:=nil; CurrLineColumn:=nil; CurrCustomContent:=nil;

  StyleContainer:=TPLEditorStyleContainer.Create();
  StyleClass:=TPLEditorStyleClass.Create(StyleContainer);

  StyleClass.Add(ST_Color, TPLEditorColorValue.Create(clRed));
  StyleClass.Add(ST_BackgroundColor, TPLEditorColorValue.Create(clBlack));
  StyleClass.Add(ST_FontSize, TPLEditorIntegerValue.Create(14));
  StyleClass.Add(ST_FontStyle, TPLEditorFontStyleValue.Create([]));

  LineList:=TPLEditor_LineList.Create;
  fOnLog:=nil;
  CurrCustomContentLeft:=0;
end; // TPLEditor_RootBox.Create

destructor TPLEditor_RootBox.Destroy;
begin
  FreeAndNil(StyleContainer);
  FreeAndNil(LineList);
  inherited Destroy;
end; // TPLEditor_RootBox.Destroy

procedure TPLEditor_RootBox.Layout(aCanvas: TCanvas);
var
  i, px, py:Integer;
begin
  LineList.Clear();
  px:=5;
  py:=5;
  for i:=0 to Count - 1 do begin
    Item[i].Left:=px;
    Item[i].Top:=py;
    Item[i].DoClearLineList();
    Item[i].Layout(aCanvas);
    py:=py + Item[i].Height;
  end; // for i
end; // TPLEditor_RootBox.Layout

procedure TPLEditor_RootBox.Render(aCanvas: TCanvas; const aStartLineIndex: Integer; const aEndLineIndex: Integer);
var
  y,x,i, BaseY, TempPX, TempPW:Integer;
  TempLeft, TempTop, TempWidth, TempHeight:Integer;
  R1:TRect;
  Line:TPLEditor_Line;
  LineColumn:TPLEditor_LineColumn;
  TextContent:TPLEditor_TextContent;

  OldParagraph, TempParagraph:TPLEditor_Paragraph;
  ColumnText:String;
  TempStartLineIndex, TempEndLindex:Integer;
  SelectRect:TRect;
  FoundContentItem:Boolean;
begin
  StyleClass.ToCanvas(aCanvas);
  R1:=Rect(0,0, Width, Height);

  if aStartLineIndex > -1 then begin
    TempParagraph:=LineList[aStartLineIndex].Item[0].Paragraph;

    R1.Left:=TempParagraph.Left - 4;
    R1.Top:=TempParagraph.Top - 4;
    R1.Right:=R1.Left + TempParagraph.Width + 2;
    R1.Bottom:=R1.Top + TempParagraph.Height + 2;
  end;

  aCanvas.FillRect(R1);

  OldParagraph:=nil;
  BaseY:=0;
  TempPX:=0; TempPW:=0; FoundContentItem:=False;

  // Standard ist, alle Zeilen durchgehen
  TempStartLineIndex:=0;
  TempEndLindex:=LineList.Count -1;

  // Die Durch zu gehenen Zeilen können begrenzt werden(Test! )
  if aStartLineIndex > -1 then TempStartLineIndex:=aStartLineIndex;
  if aEndLineIndex > -1 then TempEndLindex:=aEndLineIndex;
  FoundContentItem:=False; SelectRect:=Rect(0,0,0,0);
  for y:=TempStartLineIndex to TempEndLindex do begin
    Line:=LineList[y];
    for x:=0 to Line.Count - 1 do begin
      LineColumn:=Line[x];
      if LineColumn.Paragraph <>  OldParagraph then begin
        RootBox.StyleClass.ToCanvas(aCanvas);
        if Assigned(LineColumn.Paragraph.StyleClass) then
          LineColumn.Paragraph.StyleClass.ToCanvas(aCanvas);

        TempLeft:=LineColumn.Paragraph.Left;
        TempTop:=LineColumn.Paragraph.Top;
        TempWidth:=LineColumn.Paragraph.Width - 10;
        TempHeight:=LineColumn.Paragraph.Height - 5;

        R1:=Rect(TempLeft, TempTop, TempLeft + TempWidth, TempTop + TempHeight);
        aCanvas.FillRect(R1);
      end;
      OldParagraph:=LineColumn.Paragraph;

      RootBox.StyleClass.ToCanvas(aCanvas);
      if Assigned(LineColumn.Paragraph.StyleClass) then LineColumn.Paragraph.StyleClass.ToCanvas(aCanvas);

      if Assigned(LineColumn.StyleClass) then begin
        LineColumn.StyleClass.ToCanvas(aCanvas);

        if LineColumn.StyleClass.FindName(ST_BackgroundColor) then begin
          TempLeft:=LineColumn.Left;
          TempTop:=Line.Top;
          TempWidth:=LineColumn.Width;
          TempHeight:=Line.Height;

          R1:=Rect(TempLeft, TempTop, TempLeft + TempWidth, TempTop + TempHeight);
          aCanvas.FillRect(R1);
        end;
      end;

      ColumnText:='';
      TempPX:=LineColumn.Left;

      for i:=LineColumn.StartContent to LineColumn.EndContent do begin
        TextContent:=LineColumn.Paragraph.ContentList[i] as TPLEditor_TextContent;
        ColumnText+=TextContent.Text;
        TempPW:=aCanvas.TextWidth(TextContent.Text);
        if (not FoundContentItem) and (CurrCustomContent = TextContent) then begin
          FoundContentItem:=true;
          SelectRect.Left:=TempPX - 2;
          SelectRect.Top:=Line.Top - 2;
          SelectRect.Right:=SelectRect.Left + TempPW + 4;
          SelectRect.Bottom:=SelectRect.Top + Line.Height + 6;
        end;

        if not FoundContentItem then begin
          TempPX:=TempPX + TempPW;
        end;
      end; // for i

      if Line.Ascent - Line.Descent = 0 then
        BaseY:=0
      else
        BaseY:=abs(Line.Ascent - LineColumn.Ascent);

      aCanvas.Brush.Style:=bsClear;
      aCanvas.TextOut(LineColumn.Left, Line.Top + BaseY, ColumnText);
      aCanvas.Brush.Style:=bsSolid;
    end; // for x
  end; // for y

  if FoundContentItem then begin
    aCanvas.Pen.Width:=2;
    aCanvas.Pen.Style:=psSolid;
    aCanvas.Pen.Color:=InvertColor(aCanvas.Brush.Color);
    aCanvas.Frame(SelectRect);
  end;

end; // TPLEditor_RootBox.Render

procedure TPLEditor_RootBox.Update();
var
   TempParagraph:TPLEditor_Paragraph;
begin
  if Assigned(CurrLineColumn) then begin
    TempParagraph:=RootBox.CurrLineColumn.Paragraph;
    Layout(RootBox.OutCanvas);
    RootBox.Render(RootBox.OutCanvas, TempParagraph.StartLineIndex, TempParagraph.EndLineIndex)
  end
  else begin
    RootBox.Layout(RootBox.OutCanvas);
    RootBox.Render(RootBox.OutCanvas);
  end;
end; // TPLEditor_RootBox.Update

procedure TPLEditor_RootBox.AddOrEditSyleClass(const aStyleName: TPLEditor_StyleName; aValue: TPLEditor_Value);
var
  TempStyleClass:TPLEditorStyleClass;
begin
  if Assigned(CurrCustomContent) then begin
    TempStyleClass:=CurrCustomContent.StyleClass;
    if not Assigned(TempStyleClass) then
      TempStyleClass:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
    TempStyleClass.AddOrEdit(aStyleName, aValue);
    CurrCustomContent.StyleClass:=TempStyleClass;
    Update();
  end;
end; // TPLEditor_RootBox.AddOrEditSyleClass

procedure TPLEditor_RootBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
end; // TPLEditor_RootBox.MouseDown

procedure TPLEditor_RootBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin

end; // TPLEditor_RootBox.MouseMove

procedure TPLEditor_RootBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  TempLineIndex, TempLineColumnIndex, TempContentIndex:Integer;
  TempLineColumn:TPLEditor_LineColumn;
begin
  TempLineColumn:=CurrLineColumn;
  CurrLine:=nil; CurrLineColumn:=nil; CurrCustomContent:=nil;

  if Assigned(TempLineColumn) then begin
    Render(OutCanvas,TempLineColumn.Paragraph.StartLineIndex, TempLineColumn.Paragraph.EndLineIndex);
  end;

  TempLineIndex:=LineList.FindLineByXY(X,Y);
  if TempLineIndex > -1 then begin // Aktuelle Zeile
    CurrLine:=LineList[TempLineIndex];
    TempLineColumnIndex:=CurrLine.FindLineColumnByXY(X,Y);
    if TempLineColumnIndex > -1 then begin // Aktuelle Spalte in der Aktuellen Zeile
      CurrLineColumn:=CurrLine[TempLineColumnIndex];
      TempContentIndex:=CurrLineColumn.FindContentByXY(X,Y);
      if TempContentIndex > -1 then begin // Aktueller Content
        CurrCustomContent:=CurrLineColumn.Paragraph.ContentList[TempContentIndex];
        Render(OutCanvas,CurrLineColumn.Paragraph.StartLineIndex, CurrLineColumn.Paragraph.EndLineIndex);
      end;
    end;
  end;
end; // TPLEditor_RootBox.MouseUp

function TPLEditor_ContainerBox.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLEditor_ContainerBox.GetCount

function TPLEditor_ContainerBox.GetItem(const aItemIndex: Integer): TPLEditor_CustomBox;
begin
  result:=Items[aItemIndex] as TPLEditor_CustomBox;
end; // TPLEditor_ContainerBox.GetItem

constructor TPLEditor_ContainerBox.Create(aOwnerContainer: TPLEditor_ContainerBox);
begin
  inherited Create(aOwnerContainer);
  Items:=TObjectList.Create();
end; // TPLEditor_ContainerBox.Create

destructor TPLEditor_ContainerBox.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLEditor_ContainerBox.Destroy

procedure TPLEditor_ContainerBox.Layout(aCanvas: TCanvas);
begin

end; // TPLEditor_ContainerBox.Layout

{ TPLEditor_CustomBox }
constructor TPLEditor_CustomBox.Create(aOwnerContainer: TPLEditor_ContainerBox);
begin
  inherited Create;
  StyleClass:=nil;
  fLeft:=0;
  fTop:=0;
  fWidth:=0;
  fHeight:=0;
  if Assigned(aOwnerContainer) then begin
    aOwnerContainer.Items.Add(self);
    OwnerContainer:=aOwnerContainer;
  end;
end; // TPLEditor_CustomBox.Create

destructor TPLEditor_CustomBox.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_CustomBox.Destroy

procedure TPLEditor_CustomBox.Layout(aCanvas: TCanvas);
begin

end; // TPLEditor_CustomBox.Layout

procedure TPLEditor_CustomBox.DoClearLineList();
begin

end; // TPLEditor_CustomBox.DoClearLineList

initialization
  RootBox:=TPLEditor_RootBox.Create(nil);
end.

