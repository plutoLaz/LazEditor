unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  uLazEditorPR3;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    procedure FormCreate(Sender: TObject);
  private

  public
    LazEditorPR3:TLazEditorPR3;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  P1, P2, P3:TLazEditorBox;

  SPAN1, SPAN2, SPAN3:TLazEditorBox;
  SPAN1_A, SPAN1_B, SPAN1_C:TLazEditorBox;
begin
  LazEditorPR3:=TLazEditorPR3.Create(Panel4);
  LazEditorPR3.Parent:=Panel4;
  LazEditorPR3.Align:=alClient;

  P1:=LazEditorPR3.RootBox.Add('',BD_BLOCK);
  P1.Name:='P1';
    SPAN1:=P1.Add('Tater Taubecherl Taubenkraut Teufelsbrot ', BD_INLINE);
      SPAN1_A:=SPAN1.Add('Ein Text ohne ein Kraut zu sein ', BD_INLINE);;
        SPAN1_B:=SPAN1_A.Add('Ein weitere Text ', BD_INLINE);;
          SPAN1_C:=SPAN1_B.Add('Mal sehen, wie weit ich es treiben kann ', BD_INLINE);;

    SPAN2:=P1.Add('Spinnenkraut Spissdorn Benedikte Stechapfel ', BD_INLINE);
    SPAN3:=P1.Add('Schmerwurz Schnittlauch Schlafmohn Sassafras ', BD_INLINE);

  P2:=LazEditorPR3.RootBox.Add('',BD_BLOCK);;
  P2.Name:='P2';
  SPAN1:=P2.Add('Rose Roseneibisch Rosmarin ', BD_INLINE);
  SPAN2:=P2.Add('Rosmarinheide Rossfenchel Rosshuf ', BD_INLINE);
  SPAN3:=P2.Add('Rossrippen Rotbuche Roteibe ', BD_INLINE);

  LazEditorPR3.Debug_PrintBox(LazEditorPR3.RootBox,'');
end;

end.

