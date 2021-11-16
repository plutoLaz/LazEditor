{
  Autor: Michael Springwald
  Datum: Dienstag der 09.11.2021
}

unit ulazeditor_pr2_boxtype;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics, Contnrs, ulazeditor_pr2_styletypes;

type
  { TLazEditorBox }

  { Eine Box, die sich selbst aufnehmen kann.
    Daraus ergibt sich der Baum.
    Jedoch auch ein Problem, Items ist nicht immer Installisiert. D.H. bei jedem Zugriff
    sollte sichergestellt sein, dass Items auch Installisiert ist !

    Jede Box  kann Text speichern.
  }
  TLazEditorBox = class
  private
    fContentText: String;
    function GetCount: Integer;
    function GetItem(const aItemIndex: Integer): TLazEditorBox;
  protected

  public
    Items:TObjectList;
    StyleList:TLazEditorStyleList;
    Parent:TLazEditorBox;
    Name:String;

    constructor Create(const aOnwerItems:TLazEditorBox; const aName:String = ''; const aCreateItems:Boolean= false);
    destructor Destroy; override;

    property Item[const aItemIndex:Integer]:TLazEditorBox read GetItem; default;
    property Count:Integer read GetCount;

    property ContentText:String read fContentText write fContentText;
  published
  end; // TLazEditorBox

  TLazEditorBoxArray = array of TLazEditorBox;

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
  if Assigned(Items) then
    result:=Items[aItemIndex] as TLazEditorBox
  else
    result:=nil;
end; // TLazEditorBox.GetItem

{ TLazEditorBox }
constructor TLazEditorBox.Create(const aOnwerItems: TLazEditorBox; const aName: String; const aCreateItems: Boolean);
begin
  inherited Create;
  Name:=aName;

  if not aCreateItems then
    Items:=nil
  else begin
    Items:=TObjectList.Create(False);
  end;

  if Assigned(aOnwerItems) then
    aOnwerItems.Items.Add(self);

  Parent:=aOnwerItems;

  StyleList:=nil;
  fContentText:='';
end; // TLazEditorBox.Create

destructor TLazEditorBox.Destroy;
begin
  if Assigned(Items) then
    FreeAndNil(Items);
  inherited Destroy;
end; // TLazEditorBox.Destroy

end.

