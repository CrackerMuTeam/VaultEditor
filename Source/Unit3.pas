unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,comobj, ComCtrls, jpeg, ExtCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    StatusBar1: TStatusBar;
    Image1: TImage;
    Button2: TButton;
    Label4: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    procedure Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var IE: Variant;
begin
  IE := CreateOleObject('InternetExplorer.Application');
  IE.Visible := true;
  IE.Navigate('http://www.virtualmu.com.br/forum/');
end;

procedure TForm3.Button1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  statusbar1.Panels[0].Text:='http://www.virtualmu.com.br/forum/';
end;



procedure TForm3.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  statusbar1.Panels[0].Text:='Cr�ditos';
end;

procedure TForm3.Button2Click(Sender: TObject);
var IE: Variant;
begin
  IE := CreateOleObject('InternetExplorer.Application');
  IE.Visible := true;
  IE.Navigate('http://www.crackermuteam.com.br/');
end;

procedure TForm3.Button2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 statusbar1.Panels[0].Text:='http://www.crackermuteam.com.br/';
end;

end.
