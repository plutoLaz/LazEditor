unit uplEditor_ZeilenTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Contnrs;

type
  { TPLContentChar }
  TPLContentChar = class
  private

  protected

  public
    uChar:string;
    constructor Create;
    destructor Destroy; override;
  published
  end; // TPLContentChar

  { TPLContentList }
  TPLContentList = class
  private
    function GetItem(const aItemIndex: Integer): TPLContentChar;

  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;
    property Item[const aItemIndex:Integer]:TPLContentChar read GetItem;
  published
  end; // TPLContentList


  { TPLLineItem }
  TPLLineItem = class
  private
    fText: String;
    procedure SetText(AValue: String);

  protected

  public
    width, height:Integer;

    constructor Create;
    destructor Destroy; override;
    property Text:String read fText write SetText;
  published
  end; // TPLLineItem

  TPLLine = class
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLLineItem;

  protected

  public
    width, height:Integer;
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;

    property Item[const aItemIndex:Integer]:TPLLineItem read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TPLLine

  { TPLLines }
  TPLLines = class
  private
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TPLLine;
  protected

  public
    Items:TObjectList;
    constructor Create;
    destructor Destroy; override;

    property Item[const aItemIndex:Integer]:TPLLine read GetItem; default;
    property Count:Integer read GetCount;
  published
  end; // TPLLineItems

var
  ContentList:TPLContentList;

implementation

function TPLContentList.GetItem(const aItemIndex: Integer): TPLContentChar;
begin
  result:=Items[aItemIndex] as TPLContentChar;
end; // TPLContentList.GetItem

{ TPLContentList }
constructor TPLContentList.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
end; // TPLContentList.Create

destructor TPLContentList.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLContentList.Destroy

{ TPLContentChar }
constructor TPLContentChar.Create;
begin
  inherited Create;
end; // TPLContentChar.Create

destructor TPLContentChar.Destroy;
begin
  inherited Destroy;
end; // TPLContentChar.Destroy

function TPLLine.GetCount: Integer;
begin
  result:=items.Count;
end; // TPLLine.GetCount

function TPLLine.GetItem(const aItemIndex: Integer): TPLLineItem;
begin
  result:=Items[aItemIndex] as TPLLineItem
end; // TPLLine.GetItem

constructor TPLLine.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
  width:=0;
  height:=0;
end; // TPLLine.Create

destructor TPLLine.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLLine.Destroy

function TPLLines.GetCount: Integer;
begin
  result:=Items.Count;
end; // TPLLines.GetCount

function TPLLines.GetItem(const aItemIndex: Integer): TPLLine;
begin
  result:=Items[aItemIndex] as TPLLine;
end; // TPLLines.GetItem

constructor TPLLines.Create;
begin
  inherited Create;
  Items:=TObjectList.Create();
end; // TPLLines.Create

destructor TPLLines.Destroy;
begin
  FreeAndNil(Items);
  inherited Destroy;
end; // TPLLines.Destroy

procedure TPLLineItem.SetText(AValue: String);
var
  x, len:Integer;
  ch:String;
  ContentChar:TPLContentChar;
begin
  if fText <> AValue then begin
    fText:=AValue;

    for ch in AValue do begin
      ContentChar:=TPLContentChar.Create;
      ContentChar.uChar:=ch;

      ContentList.Items.Add(ContentChar);
    end; // for x
  end;
end;

{ TPLLineItem }
constructor TPLLineItem.Create;
begin
  inherited Create;
  Text:='';
  width:=0;
  height:=0;
end; // TPLLineItem.Create

destructor TPLLineItem.Destroy;
begin
  inherited Destroy;
end; // TPLLineItem.Destroy

end.

