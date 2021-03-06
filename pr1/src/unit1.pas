unit Unit1;

{$mode objfpc}
//{$MODE DELPHI}
{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, uLazEditor_pr1_Test, ulazeditor_pr1_BoxType, ulazeditor_pr1_styletypes;

type
  { TForm1 }
  TForm1 = class(TForm)
    BitBtn4: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
    LazEditor_pr1_Test:TLazEditor_pr1_Test;
    Liste_Kraut:TStringList;
    StyleList1, StyleList2, StyleList3, StyleList4:TLazEditorStyleList;
    function RandomBoxArray():TLazEditorBoxArray;
    procedure RandomParagraph(const aCount:Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);
var
  P1, P2, P3:TLazEditorBoxParagraph;
begin
  Randomize;
  Liste_Kraut:=TStringList.Create;
  Liste_Kraut.LoadFromFile('/home/pluto/entwicklung/Lazarus/github/LazEditor/pr1/Listen/Kräuter.txt');

  LazEditor_pr1_Test:=TLazEditor_pr1_Test.Create(Panel2);
  LazEditor_pr1_Test.Align:=alClient;
  LazEditor_pr1_Test.Parent:=Panel2;

  StyleList1:=TLazEditorStyleList.Create;
  StyleList1.Add(ESN_Color,'',clWindowText);
  StyleList1.Add(ESN_BackgroundColor,'',clWindow);
  StyleList1.Add(ESN_FontSize,'',12);
  StyleList1.Add(ESN_FontStyle,'',0).ValueFonts:=[];

  LazEditor_pr1_Test.DefaultStyleList:=StyleList1;

  StyleList2:=TLazEditorStyleList.Create;
  StyleList2.Add(ESN_Color,'',clYellow);
  StyleList2.Add(ESN_BackgroundColor,'',clBlack);
  StyleList2.Add(ESN_FontStyle,'',0).ValueFonts:=[];
  StyleList2.Add(ESN_FontSize,'',18);

  StyleList3:=TLazEditorStyleList.Create;
  StyleList3.Add(ESN_Color,'',clWhite);
  StyleList3.Add(ESN_BackgroundColor,'',clRed);
  StyleList3.Add(ESN_FontStyle,'',14).ValueFonts:=[fsBold];

  StyleList4:=TLazEditorStyleList.Create;
  StyleList4.Add(ESN_Color,'',clYellow);
  StyleList4.Add(ESN_BackgroundColor,'',clGreen);
  StyleList4.Add(ESN_FontStyle,'',0).ValueFonts:=[];
  StyleList4.Add(ESN_FontSize,'',12);

  P1:=TLazEditorBoxParagraph.Create(LazEditor_pr1_Test.LineList);
  P1.Name:='P1';
  P1.StyleList:=StyleList1;
  P1.SetText([StyleList1,TLazEditorTextBox.Create('Abelmoschus Ackerveilchen gehen Affodill Alberbaum Aloe'),
              StyleList2,TLazEditorTextBox.Create('Blutblume Gefahr Blutwürze Bockshornklee '),

              StyleList1,TLazEditorTextBox.Create('Bärenklau Bärlapp Bermet')
             ]);

  LazEditor_pr1_Test.RootBox.Items.Add(P1);

  P2:=TLazEditorBoxParagraph.Create(LazEditor_pr1_Test.LineList);
  P2.StyleList:=StyleList1;
  P2.Name:='P2';
  P2.SetText([StyleList1,TLazEditorTextBox.Create('Zypresse Zwiebeln Zwetschge Zupfblatteln '),
              StyleList2,TLazEditorTextBox.Create('Zosen Zizerlstrauch Zitwerwurzel Zitwer '),
              StyleList1,TLazEditorTextBox.Create('Weisskohl Weiderich Weberkarde Waldrebe ')
             ]);
  LazEditor_pr1_Test.RootBox.Items.Add(P2);

  P3:=TLazEditorBoxParagraph.Create(LazEditor_pr1_Test.LineList);
  P3.StyleList:=StyleList3;
  P3.Name:='P3';
  P3.SetText([TLazEditorTextBox.Create('Rotwurz Rosskastanie Sanddorn '),
              TLazEditorTextBox.Create('Sandsegge Saudistel Saukraut '),
              TLazEditorTextBox.Create('Schillerlilie Schlehdorn Schöllkraut '),
              TLazEditorTextBox.Create('Sinau Singrün Sonnenhut Spirulina')
             ]);
  LazEditor_pr1_Test.RootBox.Items.Add(P3);



// LazEditor_pr1_Test.ContentText:='Dies ist ein langer langer Text mit Umlauten(ÖÄÜ,öäü) ♠';
  //LazEditor_pr1_Test.ContentText:='Abelmoschus <b>Ackerveilchen</b> Affodill [b]Alberbaum[/b] Aloe Altee *Blutblume* **Blutwürze** Bockshornklee <fgColor="red">Bogenbaum Bohnenkraut Dittichrut Dragon Dreisdorn Einbeere';

{  LazEditor_pr1_Test.SetText([StyleList1, TLazEditorTextBox.Create('Abelmoschus Ackerveilchen gehen Affodill Alberbaum Aloe'),
                              StyleList2, TLazEditorTextBox.Create('Blutblume Gefahr Blutwürze Bockshornklee '),
                              StyleList1, TLazEditorTextBox.Create('Bärenklau Bärlapp Bermet'),
                              StyleList2, TLazEditorTextBox.Create('Bogenbaum Bohnenkraut Dittichrut '),
                              StyleList1, TLazEditorTextBox.Create('Dragon Dreisdorn Einbeere '),
                              StyleList1, TLazEditorTextBox.Create('Zypresse Zwiebeln Zwetschge Zupfblatteln '),
                              StyleList2, TLazEditorTextBox.Create('Zosen Zizerlstrauch Zitwerwurzel Zitwer '),
                              StyleList1, TLazEditorTextBox.Create('Weisskohl Weiderich Weberkarde Waldrebe '),
                              StyleList1, TLazEditorTextBox.Create('Tulpe Trollblume Tripmadam '),
                              StyleList1, TLazEditorTextBox.Create('Tremisse Traubenkraut Tragant Trabenkraut '),
                              StyleList1, TLazEditorTextBox.Create('Thymian Teeminze Tausendschön Tater')
                             ]
                            );
 }
//  LazEditor_pr1_Test.ContentText:='Abelmoschus Ackerveilchen Affodill Alberbaum Aloe Altee Blutblume Blutwürze Bockshornklee Bogenbaum Bohnenkraut Dittichrut Dragon Dreisdorn Einbeere';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LazEditor_pr1_Test);
  FreeAndNil(Liste_Kraut);
end;

function TForm1.RandomBoxArray(): TLazEditorBoxArray;
  procedure AddBoxArray(aBox:TLazEditorBox; var aBoxArray:TLazEditorBoxArray);
  var
    Len:Integer;
  begin
    Len:=Length(aBoxArray);
    SetLength(aBoxArray, Len+1);
    aBoxArray[Len]:=aBox;
  end;

  function GetRandomStyle():TLazEditorStyleList;
  var
    r:Integer;
  begin
    result:=StyleList1;
    r:=Random(4) + 1;
    case r of
      1: result:=StyleList1;
      2: result:=StyleList2;
      3: result:=StyleList3;
      4: result:=StyleList4;
    end;
  end; // GetRandomStyle

var
  i,WordCount, y, StartI, CountI:Integer;
  Str:String;

  TempStyleBox:TLazEditorStyleList;
begin
  Result:=[];
  str:='';

  WordCount:=Random(10)+1;
  y:=0;
  SetLength(Result, 0);
  TempStyleBox:=GetRandomStyle;
  CountI:=Random(25);
  StartI:=Random(Liste_Kraut.Count);
  if StartI + CountI >=Liste_Kraut.Count -1 then
    StartI:=StartI - CountI;

  for i:=StartI to StartI + CountI do begin
    Str+=Liste_Kraut[i] + ' ';
    if y + 1 <=WordCount then begin
      AddBoxArray(TempStyleBox, Result);
      AddBoxArray(TLazEditorTextBox.Create(Str), Result);
      y+=1;
      str:='';
    end
    else begin
      y:=0;
      TempStyleBox:=GetRandomStyle();
      WordCount:=Random(10)+1;
    end;
  end;

end; // TForm1.RandomBoxArray

procedure TForm1.RandomParagraph(const aCount: Integer);
var
  Temp:TLazEditorBoxParagraph;
  i:Integer;
begin
  LazEditor_pr1_Test.RootBox.clear();
  for i:=0 to aCount do begin
    Temp:=TLazEditorBoxParagraph.Create(LazEditor_pr1_Test.LineList);
    Temp.Name:='P_' + IntToStr(i);
    Temp.SetText(RandomBoxArray());
    Temp.StyleList:=StyleList1;
    LazEditor_pr1_Test.RootBox.Items.Add(Temp);
  end; // for i
  LazEditor_pr1_Test.Invalidate;
end; // TForm1.RandomParagraph

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  RandomParagraph(2);
end;

end.

