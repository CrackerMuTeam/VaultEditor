program Vault_Editor;

uses
  Forms,
  MainUnit in 'MainUnit.pas' {frmMain},
  showdata in 'showdata.pas' {frmSD},
  Dec in 'Dec.pas',
  FlashForm in 'FlashForm.pas' {MUFlash},
  Unit3 in 'Unit3.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMUFlash, MUFlash);
  Application.CreateForm(TForm3, Form3);
  Application.Title := 'CMT-VMAT Vault Editor';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSD, frmSD);

  Application.Run;
end.
