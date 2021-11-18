{
  Autor: Michael Springwald

  Datum: Samstag der 05.06.2021
}

unit uplEditor_02062021;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, Graphics, LCLType,
  uplEditor_Document
  ;

type
  { TPLEditor_02062021_V1 }
  TPLEditor_02062021_V1 = class(TCustomControl)
  private
    FOnMouseUp: TMouseEvent;

  protected
    procedure DoOnResize; override;
  public
    Document:TPLEditorDocument;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure paint; override;
    procedure BoundsChanged; override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure UTF8KeyPress(var UTF8Key: TUTF8Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
  published
  end; // TPLEditor_02062021_V1

implementation

procedure TPLEditor_02062021_V1.DoOnResize;
begin
  inherited DoOnResize;
//  writeln(Width, ' ', Height, ' ', HandleAllocated);
  if (Width > 0) and (Height > 0) then begin
    Document.Layout(ClientWidth, ClientHeight, Canvas);
    Invalidate;
  end;

end; // TPLEditor_02062021_V1.DoOnResize

{ TPLEditor_02062021_V1 }
constructor TPLEditor_02062021_V1.Create(AOwner: TComponent);
var
  TextStyle:TTextStyle;
begin
  inherited Create(AOwner);
  Document:=TPLEditorDocument.Create;
  Font.Name:='Ubuntu';
  Font.Size:=14;

  TextStyle:=Canvas.TextStyle;
  TextStyle.Opaque:=False;
  TextStyle.SystemFont:=False;

  Canvas.TextStyle:=TextStyle;
  FOnMouseUp:=nil;
end; // TPLEditor_02062021_V1.Create

destructor TPLEditor_02062021_V1.Destroy;
begin
  FreeAndNil(Document);
  inherited Destroy;
end; // TPLEditor_02062021_V1.Destroy

procedure TPLEditor_02062021_V1.paint;
begin
  RootBox.OutCanvas:=Canvas;
  Document.Render(Canvas);
end; // TPLEditor_02062021_V1.paint

procedure TPLEditor_02062021_V1.BoundsChanged;
begin
  inherited BoundsChanged;
end; // TPLEditor_02062021_V1.BoundsChanged

procedure TPLEditor_02062021_V1.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
end; // TPLEditor_02062021_V1.KeyDown

procedure TPLEditor_02062021_V1.KeyPress(var Key: char);
begin
  inherited KeyPress(Key);
end; // TPLEditor_02062021_V1.KeyPress

procedure TPLEditor_02062021_V1.UTF8KeyPress(var UTF8Key: TUTF8Char);
begin
  inherited UTF8KeyPress(UTF8Key);
end; // TPLEditor_02062021_V1.UTF8KeyPress

procedure TPLEditor_02062021_V1.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
end; // TPLEditor_02062021_V1.KeyUp

procedure TPLEditor_02062021_V1.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  Document.MouseDown(Button, Shift, X,Y);
end; // TPLEditor_02062021_V1.MouseDown

procedure TPLEditor_02062021_V1.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  Document.MouseMove(Shift, X,Y);
end; // TPLEditor_02062021_V1.MouseMove

procedure TPLEditor_02062021_V1.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);

  if mbLeft = button then begin
    Document.MouseUp(Button, Shift, X,Y);
  end;

  if Assigned(OnMouseUp) then
    OnMouseUp(self, Button,Shift, X, Y);
end; // TPLEditor_02062021_V1.MouseUp

end.

