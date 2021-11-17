{
  Autor: Michael Springwald

  Datum: Dienstag der 16.11.2021
}

unit uLazEditorPR3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, Graphics, Contnrs;

type
  {
    Später kommen noch inline-block, Tabelle, Tabelle-Row,
  }

  TLazEditorBox_Display = (
                            BD_INLINE = 0,
                            BD_BLOCK = 1
                          ); // TLazEditorBox_Display

  { TLazEditorBox }
  TLazEditorBox = class
  private
    fDisplay: TLazEditorBox_Display;
    fText: String;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorBox;
    procedure SetDisplay(AValue: TLazEditorBox_Display);

  protected

  public
    Items:TObjectList;
    Name:String; // Für das Debuggen
    constructor Create(const aDisplay:TLazEditorBox_Display);
    destructor Destroy; override;

    function Add(const aText:String; const aDisplay:TLazEditorBox_Display):TLazEditorBox;

    property Text:String read fText write fText;
    property Count:Integer read GetCount;
    property Item[const aItemIndex:Integer]:TLazEditorBox read GetItem; default;
    property Display:TLazEditorBox_Display read fDisplay write SetDisplay;
  published
  end; // TLazEditorBox

  { TLazEditorPR3 }
  TLazEditorPR3 = class(TCustomControl)
  private

  protected

  public
    RootBox:TLazEditorBox;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ResetStyle();

    procedure Paint; override;
    procedure Resize; override;

    procedure Render();

    procedure Debug_PrintBox(aBox:TLazEditorBox; const aLevel:String);
  published
  end; // TLazEditorPR3

implementation

function TLazEditorBox.GetCount: Integer;
begin
  if Assigned(Items) then
    result:=Items.Count
  else
    result:=0;
end; // TLazEditorBox.GetCount

function TLazEditorBox.GetItem(const aItemIndex: Integer): TLazEditorBox;
begin
  result:=Items[aItemIndex] as TLazEditorBox;
end; // TLazEditorBox.GetItem

procedure TLazEditorBox.SetDisplay(AValue: TLazEditorBox_Display);
begin
  if fDisplay <> AValue then
    fDisplay:=AValue;
end; // TLazEditorBox.SetDisplay

{ TLazEditorBox }
constructor TLazEditorBox.Create(const aDisplay: TLazEditorBox_Display);
begin
  inherited Create;
  Name:='';
  fText:='';
  Items:=nil;
  Display:=aDisplay;
end; // TLazEditorBox.Create

destructor TLazEditorBox.Destroy;
begin
  if Assigned(Items) then
    FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorBox.Destroy

function TLazEditorBox.Add(const aText: String; const aDisplay: TLazEditorBox_Display): TLazEditorBox;
begin
  if not Assigned(Items) then begin
    Items:=TObjectList.Create(False);
    Items.OwnsObjects:=False;
  end;
  result:=Item[Items.Add(TLazEditorBox.Create(aDisplay))];
  result.Text:=aText;
end; // TLazEditorBox.Add

{ TLazEditorPR3 }
constructor TLazEditorPR3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ResetStyle();
  RootBox:=TLazEditorBox.Create(BD_BLOCK);
  RootBox.Items:=TObjectList.Create(False);
  RootBox.Items.OwnsObjects:=False;;
end; // TLazEditorPR3.Create

destructor TLazEditorPR3.Destroy;
begin
  FreeAndNil(RootBox);
  inherited Destroy;
end; // TLazEditorPR3.Destroy

procedure TLazEditorPR3.ResetStyle();
begin
  Canvas.Font.Name:='Ubuntu';
  Canvas.Font.Size:=12;
  Canvas.Font.Style:=[];
  Canvas.Font.Color:=clWindowText;

  Canvas.Brush.Color:=clWindow;
  Canvas.Brush.Style:=bsSolid;
end; // TLazEditorPR3.ResetStyle

procedure TLazEditorPR3.Paint;
begin
  inherited Paint;
  ResetStyle();
  Canvas.FillRect(0,0, ClientWidth, ClientHeight);
end; // TLazEditorPR3.Paint

procedure TLazEditorPR3.Resize;
begin
  inherited Resize;
end;

procedure TLazEditorPR3.Render();
begin

end; // TLazEditorPR3.Render

procedure TLazEditorPR3.Debug_PrintBox(aBox: TLazEditorBox; const aLevel: String);
var
  i:Integer;
begin
  for i:=0 to aBox.Count -1 do begin
    if aBox[i].Text <> '' then
      writeln(aLevel, '"', aBox[i].Text, '"')
    else
      writeln('<', aBox[i].Name, '>');
    if Assigned(aBox.Items) then begin
      Debug_PrintBox(aBox.Item[i], aLevel + '  ');
    end;
  end;
end; // TLazEditorPR3.Debug_PrintBox

end.

