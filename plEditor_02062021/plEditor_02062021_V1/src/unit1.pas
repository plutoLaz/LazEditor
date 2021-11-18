unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StrUtils, LazUTF8,
  StdCtrls, ComCtrls, FileUtil,
  uplEditor_02062021, uplEditor_Document, upleditor_style, upleditor_styletype, ucolorlist;

type

  { TPLStringListObject }
  TPLStringListObject = class
    used:boolean;
    constructor Create;
  end; // TPLStringListObject

  { TForm1 }
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    SP_Style_Bold: TSpeedButton;
    SP_Style_Italic: TSpeedButton;
    SP_Style_UnderLine: TSpeedButton;
    SP_Style_StrikeOut: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ColorButton1ColorChanged(Sender: TObject);
    procedure ColorButton2ColorChanged(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure ComboBox2Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure SP_Style_BoldClick(Sender: TObject);
  private

  public
    plEditor:TPLEditor_02062021_V1;
    FileList_Herbs:TStringList;
    ListenDir:String;
    NoChange:Boolean;
    procedure CreateDocument1();

    procedure Fill_ParagraphA(aParagraph:TPLEditor_Paragraph);
    procedure Fill_ParagraphB(aParagraph:TPLEditor_Paragraph);
    procedure Fill_ParagraphC(aParagraph:TPLEditor_Paragraph);

    procedure Fill_Paragraph_FromHerbs(aParagraph:TPLEditor_Paragraph; aContentCount:Integer);
    procedure LineList_debug();

    procedure PLEditor_OnLog(const aMsg: String; const aGotoToLine: Boolean);
    procedure PLEditor_OnClick(sender:TObject);
    procedure PLEditor_OnMouseUp(Sender:TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TPLStringListObject }

constructor TPLStringListObject.Create;
begin
  used:=False;
end; // TPLStringListObject.Create

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  ListenDir:='/home/pluto/entwicklung/Lazarus/plForum/plContentManagerV2/bin/Listen/';
  NoChange:=False;
  FileList_Herbs:=TStringList.Create;
  FileList_Herbs.LoadFromFile(ListenDir + 'Kräuter.txt');

  plEditor:=TPLEditor_02062021_V1.Create(Panel3);
  plEditor.Parent:=Panel3;
  plEditor.Align:=alClient;
  plEditor.OnClick:=@PLEditor_OnClick;

  plEditor.OnMouseUp:=@PLEditor_OnMouseUp;

  RootBox.OnLog:=@PLEditor_OnLog;
  CreateDocument1();
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  LineList_debug();
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i, x:Integer;
  Paragraph:TPLEditor_Paragraph;
  TextContent:TPLEditor_TextContent;
begin
  for i:=0 to RootBox.Count -1 do begin
    Paragraph:=RootBox.Item[i] as TPLEditor_Paragraph;
    Memo1.Lines.Add(Paragraph.Name);
    for x:=0 to Paragraph.ContentList.Count -1 do begin
      TextContent:=Paragraph.ContentList[x] as TPLEditor_TextContent;
      Memo1.Lines.Add('"' + TextContent.Text +'"');
    end; // for x
    Memo1.Lines.Add('');
  end; // for y
end;

// FindInMemo: Returns the position where the string to search was found
function FindInMemo(AMemo: TMemo; AString: String; StartPos: Integer): Integer;
begin
  Result := PosEx(AString, AMemo.Text, StartPos);
  if Result > 0 then
  begin
    AMemo.SelStart := UTF8Length(PChar(AMemo.Text), Result - 1);
    AMemo.SelLength := Length(AString);
    AMemo.SetFocus;
  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
const
  SearchStr: String = '';                     // The string to search for
  SearchStart: Integer = 0;                   // Last position of the string to search for
begin
  if SearchStr <> Edit1.Text then begin       // Falls sich der zu suchende String geändert hat
    SearchStart := 0;
    SearchStr := Edit1.Text;
  end;
  SearchStart := FindInMemo(Memo1, SearchStr, SearchStart + 1);
end;

procedure TForm1.ColorButton1ColorChanged(Sender: TObject);
begin
  if not NoChange then
    RootBox.AddOrEditSyleClass(ST_Color,TPLEditorColorValue.Create(ColorButton1.ButtonColor));
end;

procedure TForm1.ColorButton2ColorChanged(Sender: TObject);
begin
  if not NoChange then
    RootBox.AddOrEditSyleClass(ST_BackgroundColor,TPLEditorColorValue.Create(ColorButton2.ButtonColor));
end;

procedure TForm1.ComboBox2Click(Sender: TObject);
begin
end;

procedure TForm1.ComboBox2Select(Sender: TObject);
begin
  if not NoChange then begin
    RootBox.AddOrEditSyleClass(ST_FontSize,TPLEditorIntegerValue.Create(StrToInt(ComboBox2.Text)));
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(plEditor);
  FreeAndNil(FileList_Herbs);
end;

procedure TForm1.Memo2Change(Sender: TObject);
begin

end;

procedure TForm1.SP_Style_BoldClick(Sender: TObject);
var
  FontStyle:TFontStyles;
begin
  if not NoChange then begin
    FontStyle:=[];

    if SP_Style_Bold.Down then
      FontStyle:=FontStyle + [fsBold]
    else
      FontStyle:= FontStyle - [fsBold];

    if SP_Style_Italic.Down then
      FontStyle:=FontStyle + [fsItalic]
    else
      FontStyle:=FontStyle - [fsItalic];

    if SP_Style_UnderLine.Down then
      FontStyle:=FontStyle + [fsUnderline]
    else
      FontStyle:=FontStyle - [fsUnderline];

    if SP_Style_StrikeOut.Down then
      FontStyle:=FontStyle + [fsStrikeOut]
    else
      FontStyle:=FontStyle - [fsStrikeOut];

    RootBox.AddOrEditSyleClass(ST_FontStyle,TPLEditorFontStyleValue.Create(FontStyle));
  end;
end;

procedure TForm1.CreateDocument1();
var
  p, P1, P2, P3:TPLEditor_Paragraph;

  StyleClass1, StyleClass2, StyleClass3:TPLEditorStyleClass;
begin
  StyleClass1:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass1.Add(ST_Color, TPLEditorColorValue.Create(clRed));
  StyleClass1.Add(ST_BackgroundColor, TPLEditorColorValue.Create(clLime));

  StyleClass2:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass2.Add(ST_Color, TPLEditorColorValue.Create(clBlue));
  StyleClass2.Add(ST_BackgroundColor, TPLEditorColorValue.Create(clRed));

  StyleClass3:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass3.Add(ST_Color, TPLEditorColorValue.Create(clGreen));
  StyleClass3.Add(ST_BackgroundColor, TPLEditorColorValue.Create(clYellow));

  P1:=TPLEditor_Paragraph.Create(RootBox);
  P1.Name:='P1';
//  P1.StyleClass:=StyleClass1;
  Fill_ParagraphB(P1);
  //Fill_ParagraphA(P1);
//  Fill_Paragraph_FromHerbs(P1, 50);

{  P2:=TPLEditor_Paragraph.Create(RootBox);
  P2.Name:='P2';
//  P2.StyleClass:=StyleClass2;
  Fill_ParagraphB(P2);
//  Fill_Paragraph_FromHerbs(P2, 60);}

  P3:=TPLEditor_Paragraph.Create(RootBox);
  P3.Name:='P3';
  P3.StyleClass:=StyleClass3;
  Fill_ParagraphC(P3);
//  Fill_Paragraph_FromHerbs(P3, 40);


{  P1:=TPLEditor_Paragraph.Create(RootBox);
  P1.Name:='P1';
    P1.AddTextContent('Ich habe ');
    P1.AddTextContent('jetzt einige Erfahrung ');
    P1.AddTextContent('gemacht mit');

  P2:=TPLEditor_Paragraph.Create(RootBox);
  P2.Name:='P2';
    P2.AddTextContent('JavaScript Editoren,');
    P2.AddTextContent(' das ');
    P2.AddTextContent(' schreiben damit');}

{  writeln('Einträge: ', RootBox.Count);
  for i:=0 to RootBox.Count - 1 do begin
    p:=RootBox[i] as TPLEditor_Paragraph;
    writeln(p.ClassName, ' ', p.Name);
    for x:=0 to p.ContentList.Count -1 do begin
      TextContent:=p.ContentList[x] as TPLEditor_TextContent;
      writeln('"', TextContent.Text,'"');
    end; // for x
    writeln();
  end; // for i}
end; // TForm1.CreateDocument1

procedure TForm1.Fill_ParagraphA(aParagraph: TPLEditor_Paragraph);
begin
  aParagraph.AddTextContent('Krametbaum',nil);
end; // TForm1.Fill_ParagraphA

procedure TForm1.Fill_ParagraphB(aParagraph: TPLEditor_Paragraph);
var
  StyleClass1, StyleClass2, StyleClass3:TPLEditorStyleClass;
begin
  StyleClass1:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass1.Add(ST_Color, TPLEditorColorValue.Create(pl_orange1));
  StyleClass1.Add(ST_BackgroundColor, TPLEditorColorValue.Create(pl_orange4));

  StyleClass2:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass2.Add(ST_Color, TPLEditorColorValue.Create(pl_green1));
  StyleClass2.Add(ST_BackgroundColor, TPLEditorColorValue.Create(pl_green4));

  StyleClass3:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass3.Add(ST_Color, TPLEditorColorValue.Create(pl_white));
  StyleClass3.Add(ST_BackgroundColor, TPLEditorColorValue.Create(pl_blue4));

  aParagraph.AddTextContent('Ackerlauch Alberbaum Alhorn ',StyleClass2);
  aParagraph.AddTextContent('Aloe Augenblümchen ',nil);
  aParagraph.AddTextContent('Bärlauch Besenheide ',StyleClass1);
  aParagraph.AddTextContent('Belladonna Biertram ',nil);
  aParagraph.AddTextContent('Blutblume ',nil);
  aParagraph.AddTextContent('Bockbeere Chlorella Demut Elendsblum ',nil);
  aParagraph.AddTextContent('Erdmännchen Feuerbaum Fastenblume ',nil);
  aParagraph.AddTextContent('Flohkraut Galbanum Gartenmajoran ',StyleClass3);
  aParagraph.AddTextContent('Gelbsenf ',StyleClass3);

  aParagraph.AddTextContent('Gewürzsumach Goji Grosses Kreuzkraut Hasen-Klee',nil);
  aParagraph.AddTextContent('Hermel Herzblume ',nil);
  aParagraph.AddTextContent('Hohlzahn Hundsrose ',nil);
  aParagraph.AddTextContent('Jambu Kamille Karotte ',nil);
  aParagraph.AddTextContent('Knirk',nil);
end; // TForm1.Fill_ParagraphB

procedure TForm1.Fill_ParagraphC(aParagraph: TPLEditor_Paragraph);
var
  StyleClass1, StyleClass2, StyleClass3:TPLEditorStyleClass;
begin
  StyleClass1:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass1.Add(ST_Color, TPLEditorColorValue.Create(pl_red1));
  StyleClass1.Add(ST_BackgroundColor, TPLEditorColorValue.Create(pl_red4));

  StyleClass2:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass2.Add(ST_Color, TPLEditorColorValue.Create(pl_CadetBlue));
  StyleClass2.Add(ST_FontSize, TPLEditorIntegerValue.Create(9));

  StyleClass3:=TPLEditorStyleClass.Create(RootBox.StyleContainer);
  StyleClass3.Add(ST_Color, TPLEditorColorValue.Create(pl_brown1));
  StyleClass3.Add(ST_BackgroundColor, TPLEditorColorValue.Create(pl_YellowGreen));

  aParagraph.AddTextContent('Myrrhe Nachtkerze Natterholz ',nil);
  aParagraph.AddTextContent('Neem Oleander Papaya ',nil);
  aParagraph.AddTextContent('Pferdeminze Poleiminze ',StyleClass3);
  aParagraph.AddTextContent('Potschen ',StyleClass2);
  aParagraph.AddTextContent('Rispenhirse ',StyleClass3);
  aParagraph.AddTextContent('Rittersporn ',StyleClass2);

  aParagraph.AddTextContent('Rockenblume Römische Kamille Ronechrut Rosskastanie Russischer Klee ',nil);
  aParagraph.AddTextContent('Santakraut Scharleikraut Schlangenknoblauch ',nil);

  aParagraph.AddTextContent('Schneiderbeutel Schnittlauch Schwalbenkraut Schwarzerle ',nil);
  aParagraph.AddTextContent('Senega Senf Sennes Singrün ',nil);
  aParagraph.AddTextContent('Sommereiche Sommerklee Sommerlinde ',nil);
  aParagraph.AddTextContent('Sonnengold Spierstaude Spissdorn ',nil);

  aParagraph.AddTextContent('Spindelstrauch Spitzwegerich Springkraut ',nil);
  aParagraph.AddTextContent('Spritzgurke Stadt-Benedikte Stahlkraut ',nil);
  aParagraph.AddTextContent('Stechapfel Stechmyrte Stechpalme Steinklee ',nil);
  aParagraph.AddTextContent('Stephanskraut Sternanis Sternenkraut Stevia ',nil);
  aParagraph.AddTextContent('Stichkraut Stickwurz Stieleiche ',nil);
  aParagraph.AddTextContent('Stinkasant Stinkbaum Stinkerich ',StyleClass2);
  aParagraph.AddTextContent('Stockrose Styrax Süssdolde ',nil);
  aParagraph.AddTextContent('Sumpf-Blutauge Sumpfdotterblume Tabak',StyleClass1);
end; // TForm1.Fill_ParagraphC

procedure TForm1.Fill_Paragraph_FromHerbs(aParagraph: TPLEditor_Paragraph; aContentCount: Integer);
var
  i, R_Index:Integer;
  StringListObject:TPLStringListObject;
begin
  R_Index:=0;
  Randomize;
  for i:=0 to aContentCount do begin;
    while true do begin
      R_Index:=Random(FileList_Herbs.Count -1);
      if not Assigned(FileList_Herbs.Objects[R_Index]) then begin
        StringListObject:=TPLStringListObject.Create;
        StringListObject.used:=True;
        FileList_Herbs.Objects[R_Index]:=StringListObject;
        break;
      end;
    end;

    aParagraph.AddTextContent(FileList_Herbs[R_Index] + ' ',nil);
  end;
end; // TForm1.Fill_Paragraph_FromHerbs

procedure TForm1.LineList_debug();
var
  Line:TPLEditor_Line;
  LineColumn:TPLEditor_LineColumn;
  ContentText:TPLEditor_TextContent;
  i, x, ci:Integer;
begin
  writeln('----');
  writeln(RootBox.LineList.Count -1);
  for i:=0 to RootBox.LineList.Count -1 do begin
    Line:=RootBox.LineList[i];
    for x:=0 to Line.Count -1 do begin
      LineColumn:=Line[x];
      for ci:=LineColumn.StartContent to LineColumn.EndContent do begin
        ContentText:=LineColumn.Paragraph.ContentList[ci] as TPLEditor_TextContent;
        write(ContentText.Text);
      end; // for ci
      writeln();
    end; // for x
  end; // for i

end; // TForm1.LineList_debug

procedure TForm1.PLEditor_OnLog(const aMsg: String; const aGotoToLine: Boolean);
begin
  Memo1.Lines.Add(aMsg);

  if aGotoToLine then
    Memo1.CaretPos:=Point(0,Memo1.Lines.Count-1);

end; // TForm1.PLEditor_OnLog

procedure TForm1.PLEditor_OnClick(sender: TObject);
begin

end; // TForm1.PLEditor_OnClick

procedure TForm1.PLEditor_OnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FontStyle:TFontStyles;
  TempStyleClass:TPLEditorStyleClass;
  TempStyle:TPLEditorStyle;
  FontSize:Integer;
begin
  if mbLeft = Button then begin
    NoChange:=True;

    TempStyle:=RootBox.StyleClass.FindNameExt(ST_FontSize);
    if Assigned(TempStyle) then begin
      FontSize:=(TempStyle.Value as TPLEditorIntegerValue).Value;
      ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf( IntToStr(FontSize));
    end; // ST_FontSize

    TempStyle:=RootBox.StyleClass.FindNameExt(ST_FontStyle);
    if Assigned(TempStyle) then begin
      FontStyle:=(TempStyle.Value as TPLEditorFontStyleValue).Value;
      SP_Style_Bold.Down:=fsBold in FontStyle;
      SP_Style_Italic.Down:=fsItalic in FontStyle;
      SP_Style_UnderLine.Down:=fsUnderline in FontStyle;
      SP_Style_StrikeOut.Down:=fsStrikeOut in FontStyle;
    end; // ST_FontStyle

    TempStyle:=RootBox.StyleClass.FindNameExt(ST_Color);
    if Assigned(TempStyle) then
      ColorButton1.ButtonColor:=(TempStyle.Value as TPLEditorColorValue).Value;

    TempStyle:=RootBox.StyleClass.FindNameExt(ST_BackgroundColor);
    if Assigned(TempStyle) then
      ColorButton2.ButtonColor:=(TempStyle.Value as TPLEditorColorValue).Value;

    if Assigned(RootBox.CurrCustomContent) then begin
      TempStyleClass:=RootBox.CurrCustomContent.StyleClass;
      if Assigned(TempStyleClass) then begin

        TempStyle:=TempStyleClass.FindNameExt(ST_FontSize);
        if Assigned(TempStyle) then begin
          FontSize:=(TempStyle.Value as TPLEditorIntegerValue).Value;
          ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf( IntToStr(FontSize));
        end; // ST_FontSize

        TempStyle:=TempStyleClass.FindNameExt(ST_FontStyle);
        if Assigned(TempStyle) then begin
          FontStyle:=(TempStyle.Value as TPLEditorFontStyleValue).Value;

          SP_Style_Bold.Down:=fsBold in FontStyle;
          SP_Style_Italic.Down:=fsItalic in FontStyle;
          SP_Style_UnderLine.Down:=fsUnderline in FontStyle;
          SP_Style_StrikeOut.Down:=fsStrikeOut in FontStyle;
        end;

        TempStyle:=TempStyleClass.FindNameExt(ST_Color);
        if Assigned(TempStyle) then
          ColorButton1.ButtonColor:=(TempStyle.Value as TPLEditorColorValue).Value;

        TempStyle:=TempStyleClass.FindNameExt(ST_BackgroundColor);
        if Assigned(TempStyle) then
          ColorButton2.ButtonColor:=(TempStyle.Value as TPLEditorColorValue).Value;
      end;
    end;
    NoChange:=False;
  end;
end; // TForm1.PLEditor_OnMouseUp

end.

