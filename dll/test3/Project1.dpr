program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  NetInterfaceUnit in '..\NetInterfaceUnit.pas',
  superobject in '..\superobject.pas',
  superxmlparser in '..\superxmlparser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
