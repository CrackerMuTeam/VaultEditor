unit FlashForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,mmsystem,inifiles,mainunit, BmsXPProgressBar, jpeg,  ComCtrls, dec,
  DB, ADODB;

type
  TMUFlash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    BmsXPProgressBar1: TBmsXPProgressBar;
    Timer1: TTimer;
    Image2: TImage;
    Image3: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MUFlash: TMUFlash;
   tempo:integer;
   x:byte;
   dsnini:tinifile;
   b:boolean;
implementation

{$R *.dfm}

procedure TMUFlash.Timer1Timer(Sender: TObject);

begin
tempo:=tempo+1;
bmsxpprogressbar1.Position:=bmsxpprogressbar1.Position+1;

 if (bmsxpprogressbar1.Position=100) and (b=false) then
   begin
   b:=true;
   frmmain.iniciar;
     frmmain.visible:=true;
     //frmmain.iniciar;
     MUFlash.visible:=false;
     bmsxpprogressbar1.Position:=0;
    
   end;
//if tempo=30 then MUFlash.CLOSE ;

if tempo=1+x then label2.caption:='Carregando.';
if tempo=5+x then label2.caption:='Carregando..';
if tempo=9+x then label2.caption:='Carregando...';
if tempo=13+x then
  begin
    label2.caption:='Carregando';
    x:=x+16;
  end;



end;
procedure TMUFlash.FormCreate(Sender: TObject);
var i:byte;
begin
 b:=false;
tempo:=0;
x:=0;
if fileexists('dsn.ini') then
      begin
        dsnini:=tinifile.Create(extractfilepath(application.ExeName)+'DSN.ini');
        mudsn:=dsnini.ReadString('MuOnline','DSN','');
        muid:=dsnini.ReadString('MuOnline','User','');
        mupwd:=dsnini.ReadString('MuOnline','Password','');
        catalog:=dsnini.ReadString('MuOnline','InitCatalog','');
        vs:=dsnini.ReadString('MuOnline','Versao','');
        dsnini.Free;
      end
        else
          begin
            tempo:=1000;
            application.MessageBox(pchar('Arquivo não encontrado'+#13+'           (dsn.ini)'),'Erro!',mb_ok+mb_iconerror);
            muflash.Close;
          end;

end;

end.
