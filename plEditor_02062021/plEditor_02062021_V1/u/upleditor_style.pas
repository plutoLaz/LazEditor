{
  Autor: Michael Springwald

  Datum: Sonntag der 06.06.2021
}

unit upleditor_style;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Contnrs, upleditor_styletype;

type
  TPLEditorStyleContainer = class;

  { TPLEditorStyle }
  TPLEditorStyle = class
  private
    fName: TPLEditor_StyleName;
    fValue: TPLEditor_Value;

  protected

  public

    constructor Create;
    destructor Destroy; override;

    function ToCanvas(aCanvas:TCanvas):boolean;

    property Name:TPLEditor_StyleName read fName write fName;
    property Value:TPLEditor_Value read fValue write fValue;
  published
  end; // TPLEditorStyle

  { TPLEditorStyleClass }
  TPLEditorStyleClass = class
  private
    fName: String;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLEditorStyle;

  protected

  public
    Items:TObjectList;

    constructor Create(aStyleContainer:TPLEditorStyleContainer);
    destructor Destroy; override;

    procedure Assign(aFromStyleClass:TPLEditorStyleClass);
    function Compare(const aStyleClass:TPLEditorStyleClass):boolean;

    function FindName(const aStyleName:TPLEditor_StyleName):Boolean;
    function FindNameExt(const aStyleName:TPLEditor_StyleName):TPLEditorStyle;
    procedure AddOrEdit(const aStyleName:TPLEditor_StyleName; aValue:TPLEditor_Value);

    procedure Add(const aName:TPLEditor_StyleName; aValue:TPLEditor_Value);

    procedure ToCanvas(aCanvas:TCanvas);


    property Item[const aItemIndex:Integer]:TPLEditorStyle read GetItem; default;
    property Count:Integer read GetCount;

    property Name:String read fName write fName;
  published
  end; // TPLEditorStyleClass

  { TPLEditorStyleContainer }
  TPLEditorStyleContainer = class
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLEditorStyleClass;

  protected

  public
    Items:TObjectList;

    constructor Create();
    destructor Destroy; override;

    function FindStyleClassByName(const aStyleClassName:String):TPLEditorStyleClass;

    procedure Assign(aFromStyleContainer:TPLEditorStyleContainer);

    property Item[const aItemIndex:Integer]:TPLEditorStyleClass read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TPLEditorStyleContainer


implementation

function TPLEditorStyleContainer.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLEditorStyleContainer.GetCount

function TPLEditorStyleContainer.GetItem(const aItemIndex: Integer): TPLEditorStyleClass;
begin
  result:=Items[aItemIndex] as TPLEditorStyleClass
end; // TPLEditorStyleContainer.GetItem

constructor TPLEditorStyleContainer.Create();
begin
  inherited Create;
  Items:=TObjectList.Create();
end; // TPLEditorStyleContainer.Create

destructor TPLEditorStyleContainer.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLEditorStyleContainer.Destroy

function TPLEditorStyleContainer.FindStyleClassByName(const aStyleClassName: String): TPLEditorStyleClass;
var
  i:integer;
begin
  result:=nil;
  for i:=0 to Count -1 do begin
    if Item[i].Name = aStyleClassName then begin
      result:=Item[i];
      break;
    end;
  end; // for i
end; // TPLEditorStyleContainer.FindStyleClassByName

procedure TPLEditorStyleContainer.Assign(aFromStyleContainer: TPLEditorStyleContainer);
begin

end; // TPLEditorStyleContainer.Assign

function TPLEditorStyleClass.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLEditorStyleClass.GetCount

function TPLEditorStyleClass.GetItem(const aItemIndex: Integer): TPLEditorStyle;
begin
  result:=items[aItemIndex] as TPLEditorStyle
end; // TPLEditorStyleClass.GetItem

constructor TPLEditorStyleClass.Create(aStyleContainer: TPLEditorStyleContainer);
begin
  inherited Create;
  Items:=TObjectList.Create();
  fName:='';
  aStyleContainer.Items.Add(self);
end; // TPLEditorStyleClass.Create

destructor TPLEditorStyleClass.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLEditorStyleClass.Destroy

procedure TPLEditorStyleClass.Assign(aFromStyleClass: TPLEditorStyleClass);
var
  i:Integer;
begin
  Items.Clear;
  for i:=0 to aFromStyleClass.Count - 1 do begin
    Items.Add(aFromStyleClass[i]);
  end; // for i
end; // TPLEditorStyleClass.Assign

function TPLEditorStyleClass.Compare(const aStyleClass: TPLEditorStyleClass): boolean;
begin
  result:=False;
end; // TPLEditorStyleClass.Compare

function TPLEditorStyleClass.FindName(const aStyleName: TPLEditor_StyleName): Boolean;
var
  i:Integer;
begin
  result:=False;
  for i:=0 to Count -1 do begin
    if Item[i].Name = aStyleName then begin
      result:=True;
      break;
    end;
  end;
end; // TPLEditorStyleClass.FindName

function TPLEditorStyleClass.FindNameExt(const aStyleName: TPLEditor_StyleName): TPLEditorStyle;
var
  i:Integer;
begin
  result:=nil;
  for i:=0 to Count -1 do begin
    if Item[i].Name = aStyleName then begin
      result:=Item[i];
      break;
    end;
  end;
end; // TPLEditorStyleClass.FindNameExt

procedure TPLEditorStyleClass.AddOrEdit(const aStyleName: TPLEditor_StyleName; aValue: TPLEditor_Value);
var
  TempEditorStyle:TPLEditorStyle;
begin
  TempEditorStyle:=FindNameExt(aStyleName);
  if not Assigned(TempEditorStyle) then
    Add(aStyleName, aValue)
  else begin
    FreeAndNil(TempEditorStyle.fValue);
    TempEditorStyle.Value:=aValue;
  end;
end; // TPLEditorStyleClass.AddOrEdit

procedure TPLEditorStyleClass.Add(const aName: TPLEditor_StyleName; aValue: TPLEditor_Value);
var
  TempStyle:TPLEditorStyle;
begin
  TempStyle:=Item[Items.Add(TPLEditorStyle.Create)];
  TempStyle.Name:=aName;
  TempStyle.Value:=aValue;
end; // TPLEditorStyleClass.Add

procedure TPLEditorStyleClass.ToCanvas(aCanvas: TCanvas);
var
  i:Integer;
  Style:TPLEditorStyle;
begin
  for i:=0 to Count - 1 do begin
    Style:=Item[i];
    Style.ToCanvas(aCanvas);
  end; // for i
end; // TPLEditorStyleClass.ToCanvas

{ TPLEditorStyle }
constructor TPLEditorStyle.Create;
begin
  inherited Create;
  fName:=ST_None;
  fValue:=nil;
end; // TPLEditorStyle.Create

destructor TPLEditorStyle.Destroy;
begin
  if Assigned(fValue) then FreeAndNil(fValue);
  inherited Destroy;
end; // TPLEditorStyle.Destroy

function TPLEditorStyle.ToCanvas(aCanvas: TCanvas): boolean;
begin
  result:=False;
  if Assigned(Value) then result:=Value.ToCanvas(aCanvas, Name);
end; // TPLEditorStyle.ToCanvas

end.

