program ana42;

uses
  Forms,
  main in 'main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���������-42';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
