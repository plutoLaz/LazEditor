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
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
    LazEditor_pr1_Test:TLazEditor_pr1_Test;
    Liste_Kraut:TStringList;
    StyleList1, StyleList2, StyleList3, StyleList4:TLazEditorStyleList;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);
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
  StyleList2.Add(ESN_BackgroundColor,'',clBlue);
  StyleList2.Add(ESN_FontStyle,'',0).ValueFonts:=[];
  StyleList2.Add(ESN_FontSize,'',18);

  StyleList3:=TLazEditorStyleList.Create;
  StyleList3.Add(ESN_Color,'',clWhite);
  StyleList3.Add(ESN_BackgroundColor,'',clRed);
  StyleList3.Add(ESN_FontStyle,'',0).ValueFonts:=[fsBold];

  StyleList4:=TLazEditorStyleList.Create;
  StyleList4.Add(ESN_Color,'',clYellow);
  StyleList4.Add(ESN_BackgroundColor,'',clBlue);
  StyleList4.Add(ESN_FontStyle,'',0).ValueFonts:=[];
  StyleList4.Add(ESN_FontSize,'',12);


// LazEditor_pr1_Test.ContentText:='Dies ist ein langer langer Text mit Umlauten(ÖÄÜ,öäü) ♠';
  //LazEditor_pr1_Test.ContentText:='Abelmoschus <b>Ackerveilchen</b> Affodill [b]Alberbaum[/b] Aloe Altee *Blutblume* **Blutwürze** Bockshornklee <fgColor="red">Bogenbaum Bohnenkraut Dittichrut Dragon Dreisdorn Einbeere';

  LazEditor_pr1_Test.SetText([TLazEditorTextBox.Create('Abelmoschus Ackerveilchen gehen Affodill Alberbaum Aloe'),
                              StyleList2, TLazEditorTextBox.Create('Blutblume Gefahr Blutwürze Bockshornklee '),
                              StyleList1, TLazEditorTextBox.Create('Bärenklau Bärlapp Bermet'),
                              StyleList4, TLazEditorTextBox.Create('Bogenbaum Bohnenkraut Dittichrut '),
                              StyleList1, TLazEditorTextBox.Create('Dragon Dreisdorn Einbeere ')

                             ]
                            );

//  LazEditor_pr1_Test.ContentText:='Abelmoschus Ackerveilchen Affodill Alberbaum Aloe Altee Blutblume Blutwürze Bockshornklee Bogenbaum Bohnenkraut Dittichrut Dragon Dreisdorn Einbeere';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LazEditor_pr1_Test);
  FreeAndNil(Liste_Kraut);
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
//var
//  TempItem:TMyItem;
begin
//  writeln('--------------------------');
//  for TempItem in LinkedList do begin
//    writeln(TempItem.FName);
//  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  i:Integer;
  Str:String;
begin
  str:='';
  for i:=0 to 50 do begin
    Str+=Liste_Kraut[i] + ' ';
  end;

  LazEditor_pr1_Test.SetText([TLazEditorTextBox.Create(str)]);
  LazEditor_pr1_Test.Invalidate;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
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
  i,WordCount, y:Integer;
  Str:String;

  BoxArray:TLazEditorBoxArray;
  TempStyleBox:TLazEditorStyleList;
begin
  BoxArray:=[];
  str:='';

  WordCount:=Random(10)+1;
  y:=0;
  SetLength(BoxArray, 0);
  TempStyleBox:=GetRandomStyle;
  for i:=0 to 50 do begin
    Str+=Liste_Kraut[i] + ' ';
    if y + 1 <=WordCount then begin
      AddBoxArray(TempStyleBox, BoxArray);
      AddBoxArray(TLazEditorTextBox.Create(Str), BoxArray);
      y+=1;
      str:='';
    end
    else begin
      y:=0;
      TempStyleBox:=GetRandomStyle();
      WordCount:=Random(10)+1;
    end;
  end;

  LazEditor_pr1_Test.SetText(BoxArray);
  LazEditor_pr1_Test.Invalidate;
end;

end.

