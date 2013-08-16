program ana42;

uses
  Forms,
  main in 'main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Анаграмма-42';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
