unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  TStyleValue = record
    case integer of
      1: (Value:String[10]);
      2: (Value:Integer);
      3: (Value:TColor);
  end; // TStyleValue

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private

  public
    StyleValue:TStyleValue;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  StyleValue.
end;

end.

