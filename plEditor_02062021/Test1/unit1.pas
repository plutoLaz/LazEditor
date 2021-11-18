unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  Buttons, StdCtrls, uplEditor_ZeilenTest;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    Lines:TPLLines;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  Line1, Line2, Line3:TPLLine;
  LineItem1, LineItem2, LineItem3:TPLLineItem;
begin
  ContentList:=TPLContentList.Create;
  Lines:=TPLLines.Create;

  Line1:=TPLLine.Create;

    LineItem1:=TPLLineItem.Create;
    LineItem1.Text:='Abraute Acai-Beere Ackersenf';
    Line1.Items.Add(LineItem1);

    LineItem2:=TPLLineItem.Create;
    LineItem2.Text:='Affodill Aloe Alpen-Milchlattich';
    Line1.Items.Add(LineItem2);

    LineItem3:=TPLLineItem.Create;
    LineItem3.Text:='Betonie Bettseicherle Birnäpsel';
    Line1.Items.Add(LineItem3);

  Lines.Items.Add(Line1);

  Line2:=TPLLine.Create;
  LineItem1:=TPLLineItem.Create;
  LineItem1.Text:='Boldo Brautkraut Buchsbaum';
  Line2.Items.Add(LineItem1);

  LineItem2:=TPLLineItem.Create;
  LineItem2.Text:='Demut Eberwurz Ellhorn';
  Line2.Items.Add(LineItem2);

  LineItem3:=TPLLineItem.Create;
  LineItem3.Text:='Erdmännchen Estragon Essigscharl';
  Line2.Items.Add(LineItem3);

  Lines.Items.Add(Line2);

  Line3:=TPLLine.Create;
  LineItem1:=TPLLineItem.Create;
  LineItem1.Text:='Feuerbaum Flachs Flohsamen';
  Line3.Items.Add(LineItem1);

  LineItem2:=TPLLineItem.Create;
  LineItem2.Text:='Fuchsauge Galleieli Gartenminze';
  Line3.Items.Add(LineItem2);

  LineItem3:=TPLLineItem.Create;
  LineItem3.Text:='Germer Ginseng Gräne';
  Line3.Items.Add(LineItem3);

  Lines.Items.Add(Line3);

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  X,Y,Z:Integer;
  px, py, pw, ph, PenWidth:integer;

  Line:TPLLine;
  LineItem:TPLLineItem;
begin
  px:=5; py:=5; ph:=20;
  Image1.Picture.Bitmap.Width:=Image1.Width;
  Image1.Picture.Bitmap.Height:=Image1.Height;
  Image1.Picture.Bitmap.Canvas.Brush.Color:=clWindow;
  Image1.Picture.Bitmap.Canvas.FillRect(0, 0, Image1.Width, Image1.Height);
  Image1.Picture.Bitmap.Canvas.Brush.Style:=bsClear;

  Image1.Picture.Bitmap.Canvas.Pen.EndCap:=pecSquare;
  Image1.Picture.Bitmap.Canvas.Pen.Cosmetic:=False;
  Image1.Picture.Bitmap.Canvas.Pen.JoinStyle:=pjsBevel;

  Image1.Picture.Bitmap.Canvas.Pen.Width:=2;
  PenWidth:=Image1.Picture.Bitmap.Canvas.Pen.Width;

  for z:=0 to Lines.Count -1 do begin
    Line:=Lines[z];
    Line.width:=Image1.Width - 10;
    for Y:=0 to Line.Count -1 do begin
      LineItem:=Line[Y];
      pw:=Image1.Picture.Bitmap.Canvas.TextWidth(LineItem.Text);
      ph:=Image1.Picture.Bitmap.Canvas.TextHeight(LineItem.Text);
      LineItem.width:=pw + (PenWidth*2);
      LineItem.height:=ph + (PenWidth*2);
      if ph > Line.height then Line.height:=ph+1;
    end; // for y
  end; // for z


  for z:=0 to Lines.Count -1 do begin
    Line:=Lines[z];
    Image1.Picture.Bitmap.Canvas.Pen.Color:=clRed;
    Image1.Picture.Bitmap.Canvas.Frame(px,py,px+Line.width, py+Line.height+2+(PenWidth*2));

    for Y:=0 to Line.Count -1 do begin
      LineItem:=Line[Y];
      Image1.Picture.Bitmap.Canvas.Pen.Color:=clLime;
      Image1.Picture.Bitmap.Canvas.Frame(px+PenWidth,py + PenWidth,px+LineItem.width+4, py+Line.height+(PenWidth*2));

      Image1.Picture.Bitmap.Canvas.TextOut(px + (PenWidth*2), py + (PenWidth*2)  , LineItem.Text);
      px:=px + LineItem.width + (PenWidth*2);
    end; // for y
    px:=5;
    py:=py + Line.height + 2 +(PenWidth*2) + 2;
  end; // for z

  Memo1.Lines.Clear;
  for y:=0 to ContentList.Items.Count -1 do begin
    Memo1.Lines.Add(ContentList.Item[y].uChar);
  end;
end;

end.

