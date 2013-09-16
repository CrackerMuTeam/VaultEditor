program Vault_Editor;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {frmMain},
  showdata in 'showdata.pas' {frmSD},
  FlashForm in 'FlashForm.pas' {MUFlash},
  ConfigForm in 'ConfigForm.pas' {CfgForm},
  Dec in 'Dec.pas',
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMUFlash, MUFlash);
  Application.CreateForm(TCfgForm, CfgForm);

  Application.Title := 'CMT Vault Editor';
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSD, frmSD);
   muflash.iniciar;
  Application.Run;
end.
