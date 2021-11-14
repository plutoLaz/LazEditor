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
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
    LazEditor_pr1_Test:TLazEditor_pr1_Test;
    Liste_Kraut:TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.FormCreate(Sender: TObject);
var
  StyleRed, StyleLime, StyleDefault:TLazEditorStyleBox;
  StyleList1, StyleList2, StyleList3:TLazEditorStyleList;

begin
  Randomize;
  Liste_Kraut:=TStringList.Create;
  Liste_Kraut.LoadFromFile('/home/pluto/nextcloud_pluto/LazEditorComponent/tests/pr1/Listen/Kräuter.txt');

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

// LazEditor_pr1_Test.ContentText:='Dies ist ein langer langer Text mit Umlauten(ÖÄÜ,öäü) ♠';
  //LazEditor_pr1_Test.ContentText:='Abelmoschus <b>Ackerveilchen</b> Affodill [b]Alberbaum[/b] Aloe Altee *Blutblume* **Blutwürze** Bockshornklee <fgColor="red">Bogenbaum Bohnenkraut Dittichrut Dragon Dreisdorn Einbeere';

  LazEditor_pr1_Test.SetText([TLazEditorTextBox.Create('Abelmoschus Ackerveilchen Affodill Alberbaum Aloe'),
                              StyleList2, TLazEditorTextBox.Create('Blutblume Blutwürze Bockshornklee '),
                              StyleList1, TLazEditorTextBox.Create('Bärenklau Bärlapp Bermet'),
                              StyleList3, TLazEditorTextBox.Create('Bogenbaum Bohnenkraut Dittichrut '),
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

//  LazEditor_pr1_Test.ContentText:=str;
  LazEditor_pr1_Test.SetText([TLazEditorTextBox.Create(str)]);
  LazEditor_pr1_Test.Invalidate;
end;

end.

