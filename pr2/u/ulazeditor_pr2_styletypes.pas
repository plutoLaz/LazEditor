{
  Autor: Michael Springwald
  Erstellt am: Montag der 08.11.2021
}

unit ulazeditor_pr2_styletypes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Contnrs, Graphics;

type
  TLazEditorStyleName = (
                          ESN_None = 0,
                          ESN_Color = 1,
                          ESN_BackgroundColor = 2,
                          ESN_FontSize = 3,
                          ESN_FontStyle = 4,
                          ESN_FontName = 5
                        );
{
  als was soll die Value Eigenschaft gespeichert werde?

  1. Ein TVariant?
     Hier muss scheinbar auch immer wieder umgewandelt werden

  2. Einzelne Klassen? Eine Klasse für Integer, eine weitere für Flots, und soweiter?
     Hier muss auch immer wieder umgewandelt werden.

  3. Bei Pointern muss auch immer wieder umgewandelt werden und es muss auch der Typ erst mal ermittelt werden

  4. Es könnte auch jeweils ein ValueStr, ValueInt, ValueFloat geben und je nach Style Name wird das eine oder andere Verwendet.
     Bei dieser Lösung habe ich das Problem mit dem FontStyle, wie soll ich den am besten "Speichern" als Value.

}
  { TLazEditorStyle }
  TLazEditorStyle = class
  private
    fName: TLazEditorStyleName;
    fValueFonts: TFontStyles;
    fValueInt: Integer;
    fValueStr: String;

  protected

  public
    constructor Create();
    destructor Destroy; override;
    property Name:TLazEditorStyleName read fName write fName;

    property ValueStr:String read fValueStr write fValueStr;
    property ValueInt:Integer read fValueInt write fValueInt;
    property ValueFonts:TFontStyles read fValueFonts write fValueFonts;
  published
  end; // TLazEditorStyle

  { TLazEditorStyleList }
  TLazEditorStyleList = class
  private
    fName: String;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorStyle;

  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;
    function Add(const aStyleName:TLazEditorStyleName; const aValueStr:String; const aValueInt:Integer):TLazEditorStyle;

    property Count:Integer read GetCount;
    property Item[const aItemIndex:Integer]:TLazEditorStyle read GetItem; default;
    property Name:String read fName write fName;
  published
  end; // TLazEditorStyleList

  { TLazEditorStyleListContainer }

  TLazEditorStyleListContainer = class
  private
    fName: String;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorStyleList;

  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;

    property Count:Integer read GetCount;
    property Item[const aItemIndex:Integer]:TLazEditorStyleList read GetItem; default;
    property Name:String read fName write fName;
  published
  end; // TLazEditorStyleListContainer


implementation

function TLazEditorStyleListContainer.GetCount: Integer;
begin
  result:=Items.Count;
end; // TLazEditorStyleListContainer.GetCount

function TLazEditorStyleListContainer.GetItem(const aItemIndex: Integer): TLazEditorStyleList;
begin
  result:=Items[aItemIndex] as TLazEditorStyleList;
end; // TLazEditorStyleListContainer.GetItem

constructor TLazEditorStyleListContainer.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
  fName:='';
end; // TLazEditorStyleListContainer.Create

destructor TLazEditorStyleListContainer.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorStyleListContainer.Destroy

function TLazEditorStyleList.GetCount: Integer;
begin
  result:=items.Count;
end; // TLazEditorStyleList.GetCount

function TLazEditorStyleList.GetItem(const aItemIndex: Integer): TLazEditorStyle;
begin
  result:=items[aItemIndex] as TLazEditorStyle;
end; // TLazEditorStyleList.GetItem

constructor TLazEditorStyleList.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
  fName:='';
end; // TLazEditorStyleList.Create

destructor TLazEditorStyleList.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorStyleList.Destroy

function TLazEditorStyleList.Add(const aStyleName: TLazEditorStyleName; const aValueStr: String; const aValueInt: Integer): TLazEditorStyle;
begin
  result:=TLazEditorStyle.Create();
  result.Name:=aStyleName;
  result.ValueInt:=aValueInt;
  result.ValueStr:=aValueStr;
  Items.Add(result);
end; // TLazEditorStyleList.Add

{ TLazEditorStyle }
constructor TLazEditorStyle.Create();
begin
  inherited Create;
  fName:=ESN_None;
  fValueInt:=0;
  fValueStr:='';
  fValueFonts:=[];
end; // TLazEditorStyle.Create

destructor TLazEditorStyle.Destroy;
begin
  inherited Destroy;
end; // TLazEditorStyle.Destroy

end.

