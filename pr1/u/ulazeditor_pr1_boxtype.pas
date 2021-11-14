{
  Autor: Michael Springwald
  Datum: Sonntag der 07.11.2021
}

unit ulazeditor_pr1_boxtype;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
  { TLazEditorBox }
  TLazEditorBox = class
  private

  protected

  public

    constructor Create;
    destructor Destroy; override;
  published
  end; // TLazEditorBox

  { TLazEditorTextBox }
  TLazEditorTextBox = class(TLazEditorBox)
  private

  protected

  public
    Text:String;
    constructor Create(const aText:String);
    destructor Destroy; override;
  published
  end; // TLazEditorTextBox

  { TLazEditorStyleBox }
  TLazEditorStyleBox = class(TLazEditorBox)
  private
  protected

  public
    styleStr:String;

    constructor Create;
    destructor Destroy; override;
  published
  end; // TLazEditorStyleBox

  TLazEditorBoxArray = array of TLazEditorBox;

implementation

constructor TLazEditorStyleBox.Create;
begin
  inherited Create;
end; // TLazEditorStyleBox.Create

destructor TLazEditorStyleBox.Destroy;
begin
  inherited Destroy;
end; // TLazEditorStyleBox.Destroy

constructor TLazEditorTextBox.Create(const aText: String);
begin
  inherited Create;
  Text:=aText;
end; // TLazEditorTextBox.Create

destructor TLazEditorTextBox.Destroy;
begin
  inherited Destroy;
end; // TLazEditorTextBox.Destroy

{ TLazEditorBox }
constructor TLazEditorBox.Create;
begin
  inherited Create;
end; // TLazEditorBox.Create

destructor TLazEditorBox.Destroy;
begin
  inherited Destroy;
end; // TLazEditorBox.Destroy

end.

