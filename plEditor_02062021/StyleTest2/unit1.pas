unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  { TPLEditor_StyleValue }
  TPLEditor_StyleValue = class
  private
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure ToCanvas(aCanvas:TCanvas); virtual;
  published
  end; // TPLEditor_StyleValue

    { TPLEditor_StringValue }
    TPLEditor_StringValue = class(TPLEditor_StyleValue)
    private
      fValue: String;

    protected

    public
      constructor Create;
      destructor Destroy; override;

      procedure ToCanvas(aCanvas:TCanvas); override;
      property Value:String read fValue write fValue;
    published
    end; // TPLEditor_StringValue

    { TPLEditor_IntegerValue }
    TPLEditor_IntegerValue = class(TPLEditor_StyleValue)
    private
      fValue: Integer;

    protected

    public
      constructor Create;
      destructor Destroy; override;

      procedure ToCanvas(aCanvas:TCanvas); override;
      property Value:Integer read fValue write fValue;
    published
    end; // TPLEditor_IntegerValue

    { TPLEditor_ColorValue }
    TPLEditor_ColorValue = class(TPLEditor_StyleValue)
    private
      fValue: TColor;

    protected

    public
      constructor Create;
      destructor Destroy; override;
      procedure ToCanvas(aCanvas:TCanvas); override;
      property Value:TColor read fValue write fValue;

    published
    end; // TPLEditor_ColorValue


  { TForm1 }
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private

  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TPLEditor_ColorValue }
constructor TPLEditor_ColorValue.Create;
begin
  inherited Create;
end; // TPLEditor_ColorValue.Create

destructor TPLEditor_ColorValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_ColorValue.Destroy

procedure TPLEditor_ColorValue.ToCanvas(aCanvas: TCanvas);
begin

end; // TPLEditor_ColorValue.ToCanvas

{ TPLEditor_IntegerValue }
constructor TPLEditor_IntegerValue.Create;
begin
  inherited Create;
end; // TPLEditor_IntegerValue.Create

destructor TPLEditor_IntegerValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_IntegerValue.Destroy

procedure TPLEditor_IntegerValue.ToCanvas(aCanvas: TCanvas);
begin

end; // TPLEditor_IntegerValue.ToCanvas

{ TPLEditor_StringValue }
constructor TPLEditor_StringValue.Create;
begin
  inherited Create;
end; // TPLEditor_StringValue.Create

destructor TPLEditor_StringValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_StringValue.Destroy

procedure TPLEditor_StringValue.ToCanvas(aCanvas: TCanvas);
begin

end; // TPLEditor_StringValue.ToCanvas

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  ColorStyleValue1, ColorStyleValue2:TPLEditor_ColorValue;


begin
  ColorStyleValue1:=TPLEditor_ColorValue.Create;
  ColorStyleValue1.Value:=clRed;
  ColorStyleValue1.ToCanvas(Canvas);

  ColorStyleValue2:=TPLEditor_ColorValue.Create;
  ColorStyleValue2.Value:=clBlue;

end;

{ TPLEditor_StyleValue }
constructor TPLEditor_StyleValue.Create;
begin
  inherited Create;

end; // TPLEditor_StyleValue.Create

destructor TPLEditor_StyleValue.Destroy;
begin
  inherited Destroy;
end; // TPLEditor_StyleValue.Destroy

procedure TPLEditor_StyleValue.ToCanvas(aCanvas: TCanvas);
begin

end; // TPLEditor_StyleValue.ToCanvas

end.

