{
  Autor: Michael Springwald

  Datum: Sonntag der 06.06.2021
}

unit upleditor_styletype;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
  TPLEditor_StyleName = (
                          ST_None = 0,
                          ST_Color = 1,
                          ST_BackgroundColor = 2,

                          ST_FontSize = 3,
                          ST_FontName = 4,
                          ST_FontStyle = 5
                        ); // TPLEditor_StyleName

  { TPLEditor_Value }
  TPLEditor_Value = class
  private

  protected

  public
    constructor Create;
    destructor Destroy; override;

    function ToCanvas(aCanvas:TCanvas; aStyleName:TPLEditor_StyleName):boolean; virtual;
  published
  end; // TPLEditor_Value

    { TPLEditorColorValue }
    TPLEditorColorValue = class(TPLEditor_Value)
    private
      fValue: TColor;

    protected

    public
      constructor Create(const aValue:TColor);
      destructor Destroy; override;

      function ToCanvas(aCanvas:TCanvas;aStyleName:TPLEditor_StyleName):boolean; override;

      property Value:TColor read fValue write fValue;
    published
    end; // TPLEditorColorValue

    { TPLEditorStringValue }
    TPLEditorStringValue = class(TPLEditor_Value)
    private
      fValue: String;
    protected

    public
      constructor Create(const aValue:String);
      destructor Destroy; override;

      function ToCanvas(aCanvas:TCanvas;aStyleName:TPLEditor_StyleName):boolean; override;
      property Value:String read fValue write fValue;
    published
    end; // TPLEditorStringValue

    { TPLEditorIntegerValue }
    TPLEditorIntegerValue = class(TPLEditor_Value)
    private
      fValue: Integer;
    protected

    public
      constructor Create(const aValue:Integer);
      destructor Destroy; override;

      function ToCanvas(aCanvas:TCanvas;aStyleName:TPLEditor_StyleName):boolean; override;

      property Value:Integer read fValue write fValue;
    published
    end; // TPLEditorIntegerValue

    { TPLEditorFontStyleValue }
    TPLEditorFontStyleValue = class(TPLEditor_Value)
    private
      fValue: TFontStyles;

    protected

    public
      constructor Create(const aValue:TFontStyles);
      destructor Destroy; override;

      function ToCanvas(aCanvas:TCanvas; aStyleName:TPLEditor_StyleName):boolean; override;
      property Value:TFontStyles read fValue write fValue;
    published
    end; // TPLEditorFontStyleValue

    { TPLEditorPenStyleValue }
    TPLEditorPenStyleValue = class(TPLEditor_Value)
    private
      fValue: TPenStyle;

    protected

    public
      constructor Create(aValue:TPenStyle);
      destructor Destroy; override;

      function ToCanvas(aCanvas:TCanvas;aStyleName:TPLEditor_StyleName):boolean; override;
      property Value:TPenStyle read fValue write fValue;
    published
    end; // TPLEditorPenStyleValue

implementation

constructor TPLEditorPenStyleValue.Create(aValue: TPenStyle);
begin
  inherited Create;
  fValue:=aValue;
end; // TPLEditorPenStyleValue.Create

destructor TPLEditorPenStyleValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditorPenStyleValue.Destroy

function TPLEditorPenStyleValue.ToCanvas(aCanvas: TCanvas; aStyleName: TPLEditor_StyleName): boolean;
begin
  result:=False;
{  case aStyleName of
    ST_: begin
      aCanvas.Pen.Style:=Value;
      result:=True;
    end;
    else
      result:=False;
  end;}

end; // TPLEditorPenStyleValue.ToCanvas

constructor TPLEditorFontStyleValue.Create(const aValue: TFontStyles);
begin
  inherited Create;
  fValue:=aValue;
end; // TPLEditorFontStyleValue.Create

destructor TPLEditorFontStyleValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditorFontStyleValue.Destroy

function TPLEditorFontStyleValue.ToCanvas(aCanvas: TCanvas; aStyleName: TPLEditor_StyleName): boolean;
begin
  result:=False;
  case aStyleName of
    ST_FontStyle: begin
      aCanvas.Font.Style:=Value;
      result:=True;
    end;
    else
      result:=False;
  end;
end; // TPLEditorFontStyleValue.ToCanvas

{ TPLEditorIntegerValueStyle }
constructor TPLEditorIntegerValue.Create(const aValue: Integer);
begin
  inherited Create;
  fValue:=aValue;
end; // TPLEditorIntegerValue.Create

destructor TPLEditorIntegerValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditorIntegerValue.Destroy

function TPLEditorIntegerValue.ToCanvas(aCanvas: TCanvas; aStyleName: TPLEditor_StyleName): boolean;
begin
  result:=False;
  case aStyleName of
    ST_FontSize: begin
      aCanvas.Font.Size:=Value;
      result:=True;
    end
    else
      result:=False;
  end;

end; // TPLEditorIntegerValue.ToCanvas

{ TPLEditorColorValueStyle }

constructor TPLEditorColorValue.Create(const aValue: TColor);
begin
  inherited Create;
  fValue:=aValue;
end; // TPLEditorColorValue.Create

destructor TPLEditorColorValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditorColorValueStyle.Destroy

function TPLEditorColorValue.ToCanvas(aCanvas: TCanvas; aStyleName: TPLEditor_StyleName): boolean;
begin
  result:=False;
  case aStyleName of
    ST_Color: begin
      aCanvas.Font.Color:=Value;
      result:=True;
    end;

    ST_BackgroundColor: begin
      aCanvas.Brush.Color:=Value;
      result:=True;
    end
    else
      result:=False;
  end;
end; // TPLEditorColorValue.ToCanvas

constructor TPLEditorStringValue.Create(const aValue: String);
begin
  inherited Create;
  fValue:=aValue;
end; // TPLEditorStringValue.Create

destructor TPLEditorStringValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditorStringValue.Destroy

function TPLEditorStringValue.ToCanvas(aCanvas: TCanvas; aStyleName: TPLEditor_StyleName): boolean;
begin
  result:=False;
  case aStyleName of
    ST_FontName: begin
      aCanvas.Font.Name:=Value;
      result:=True;
    end
    else
      result:=False;
  end;
end; // TPLEditorStringValue.ToCanvas

{ TPLEditor_ValueStyle }
constructor TPLEditor_Value.Create;
begin
  inherited Create;
end; // TPLEditor_Value.Create

destructor TPLEditor_Value.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_Value.Destroy

function TPLEditor_Value.ToCanvas(aCanvas: TCanvas; aStyleName: TPLEditor_StyleName): boolean;
begin
  result:=False;
end; // TPLEditor_Value.ToCanvas

end.

