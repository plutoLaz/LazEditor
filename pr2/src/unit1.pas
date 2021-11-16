unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, Contnrs,
  ulazeditor_pr2_test, ulazeditor_pr2_boxtype, ulazeditor_pr2_styletypes;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn3: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public
    LazEditor_pr2_Test:TLazEditor_pr2_Test;
    Liste_Kraut:TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  RootBox:TLazEditorBox;
  StyleList1, StyleList2, StyleList3:TLazEditorStyleList;
  Box1, Box2, Box2_A_1, Box2_A_2, Box3:TLazEditorBox;
begin
  Liste_Kraut:=TStringList.Create;
  Liste_Kraut.LoadFromFile('/home/pluto/nextcloud_pluto/LazEditorComponent/tests/pr1/Listen/Kräuter.txt');

  StyleList1:=TLazEditorStyleList.Create;
  StyleList1.Add(ESN_Color, '',clRed);

  StyleList2:=TLazEditorStyleList.Create;
  StyleList2.Add(ESN_Color, '',clBlue);

  StyleList3:=TLazEditorStyleList.Create;
  StyleList3.Add(ESN_Color, '',clGreen);


  LazEditor_pr2_Test:=TLazEditor_pr2_Test.Create(Panel3);
  LazEditor_pr2_Test.DefaultStyleList.Add(ESN_FontName,'Ubuntu',0);
  LazEditor_pr2_Test.DefaultStyleList.Add(ESN_Color,'',clRed);
  LazEditor_pr2_Test.DefaultStyleList.Add(ESN_BackgroundColor,'',clWindow);
  LazEditor_pr2_Test.DefaultStyleList.Add(ESN_FontSize,'',14);
  LazEditor_pr2_Test.DefaultStyleList.Add(ESN_FontStyle,'',0).ValueFonts:=[];

  RootBox:=LazEditor_pr2_Test.RootBox;
    Box1:=TLazEditorBox.Create(RootBox,'Box1');
    Box1.ContentText:='Gricken Guarana Gurke Haarlinsen ';

    Box2:=TLazEditorBox.Create(RootBox, 'Box2');
    Box2.ContentText:='Hauhechel Hauswurz Heckenrübe ';
    Box2.StyleList:=StyleList2;
    Box2.Items:=TObjectList.Create(False);

      Box2_A_1:=TLazEditorBox.Create(Box2, 'Box2_A_1');
      Box2_A_1.ContentText:='Erst mal ein Test ';

      Box2_A_2:=TLazEditorBox.Create(Box2, 'Box2_A_2');
      Box2_A_2.ContentText:='Morgen ist nicht heute ';

    Box3:=TLazEditorBox.Create(RootBox, 'Box3');
    Box3.ContentText:='Ibenbaum Kamille Kanel';

  writeln(Box2_A_2.Parent.Parent.Name);

  LazEditor_pr2_Test.Parent:=Panel3;
  LazEditor_pr2_Test.Align:=alClient;
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
//  LazEditor_pr1_Test.SetText([TLazEditorTextBox.Create(str)]);
//  LazEditor_pr1_Test.Invalidate;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(LazEditor_pr2_Test);
  FreeAndNil(Liste_Kraut);
end;

end.

