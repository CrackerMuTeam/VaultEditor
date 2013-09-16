unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls,strUtils, ValEdit, ExtCtrls, Buttons,dec,
  ComCtrls,showdata, Menus,  unit3,
  ToolWin;

type
  TfrmMain = class(TForm)
    muQuery: TADOQuery;
    itemQuery: TADOQuery;
    StatusBar1: TStatusBar;
    cmtDB: TADOCommand;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    popMenuitem: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label17: TLabel;
    Label14: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label13: TLabel;
    cboType: TComboBox;
    cboitem: TComboBox;
    TrackBar2: TTrackBar;
    edtdur: TEdit;
    jn: TCheckBox;
    xy: TCheckBox;
    CheckBox2: TCheckBox;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    GroupBox1: TGroupBox;
    zy1: TCheckBox;
    zy2: TCheckBox;
    zy3: TCheckBox;
    zy4: TCheckBox;
    zy5: TCheckBox;
    zy6: TCheckBox;
    TrackBar1: TTrackBar;
    GroupBox7: TGroupBox;
    Label16: TLabel;
    Label15: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    cboX: TComboBox;
    cboY: TComboBox;
    GroupBox6: TGroupBox;
    btnSave: TBitBtn;
    BitBtn1: TBitBtn;
    btnHelp: TBitBtn;
    btnExit: TBitBtn;
    cbSql: TCheckBox;
    BitBtn6: TBitBtn;
    btnIN: TBitBtn;
    lblspace: TLabel;
    edtShow: TEdit;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Labe1: TLabel;
    edtZen: TEdit;
    cboID: TComboBox;
    CheckBox3: TCheckBox;
    RichEdit1: TRichEdit;
    procedure CheckBox1Click(Sender: TObject);
    procedure edtZenKeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);
    procedure edtdurKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure cboIDChange(Sender: TObject);
    procedure iniciar;
    procedure Adicionaritem1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure zy1Click(Sender: TObject);

    procedure btnSaveClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure cboTypeChange(Sender: TObject);
    procedure btnINClick(Sender: TObject);
//    procedure BitBtn2Click(Sender: TObject);

    procedure cboIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboIDClick(Sender: TObject);
//    procedure BitBtn3Click(Sender: TObject);
    procedure itemadd;


  private
    { Private declarations }
  public
    { Public declarations }
    procedure lblClick(sender:tobject);
    procedure cellClick(sender:tobject);
    procedure cellDblClick(sender:tobject);
    procedure lblmousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  end;
type itemproperty=record
     Name:string;
     X:integer;
     Y:integer;
end;
type itemoption=record
     lvl:string;
     opt:string;
     dur:string;
     skill:string;
     lucky:string;
     ExOpt:string;
     anc:string;
     ser:string;
end;
var
  frmMain: TfrmMain;
  itemspc:array of string; {ÎïÆ·ËùÕ¼¿Õ¼äÊý×é}
  warehouse:array[0..14,0..7] of string; {ÎïÆ·16½øÖÆ´úÂëÊý×é£¬ÓëÐéÄâ²Ö¿âÍ¬²½}
  wscells:array[0..14,0..7] of tspeedbutton; {×é³ÉÐéÄâ²Ö¿âµÄspeedbuttonÊý×é}
  currentitem:string; {¸ú×Ùµ±Ç°Ñ¡ÔñµÄÎïÆ·}
  sexopt2,ancient2:string;
  level2,numordem:integer;
  colorred,additem2b:boolean;
  cbox2,cboy2:byte;

implementation

{$R *.dfm}


//×Ô¶¨Òå Procedure&Function ¿ªÊ¼ ===============================================
Function HexasToInt(const HexStr: string): longint;
var
iNdx: integer;
cTmp: Char;
begin
result := 0;
for iNdx := 1 to Length(HexStr) do
begin
cTmp := HexStr[iNdx];
case cTmp of
'0'..'9': Result := 16 * Result + (Ord(cTmp) - $30);
'A'..'F': Result := 16 * Result + (Ord(cTmp) - $37);
'a'..'f': Result := 16 * Result + (Ord(cTmp) - $57);
else
raise EConvertError.Create('Illegal character in hex string');
end;
end;
end;  


function HexToInt(Hex : string) : Cardinal;   {Hex-->Integer}
const cHex = '0123456789ABCDEF';
var mult,i,loop : integer;
begin
result := 0;
mult := 1;
for loop := length(Hex) downto 1 do begin
i := pos(Hex[loop],cHex)-1;
if (i < 0) then i := 0;
inc(result,(i*mult));
mult := mult * 16;
end;
end;



function To2Char(const I:integer):string ;   {°ÑÒ»Î»integer±íÊ¾Îª2Î»string}
var S:string;
begin
  s:=inttostr(i);
  if length(s)=1 then s:='0'+s;
  result:=s;
end;



function Getbtnindex(const S:string):integer ; {Ñ­»·¼ìË÷speedbuttonÊý×é£¬·µ»ØÖµÓÃÓÚÏú»Ù¶¯Ì¬speedbutton×é¼þ}
var i,btnindex:integer;
begin
    btnindex:=121;
    for i:=0 to frmmain.Panel2.ControlCount-1 do begin
      if leftstr(uppercase(frmmain.Panel2.Controls[i].Name),5)='C'+s then begin
         btnindex:=i;
         break;
      end;
    end;
    result:=btnindex;
end;


function Getlblindex(const S:string):integer; {Ñ­»·¼ìË÷panelÊý×é£¬·µ»ØÖµÓÃÓÚÏú»Ù¶¯Ì¬panel×é¼þ}
var i,lblindex:integer;
begin
  lblindex:=121;
  if s='all' then begin
    for i:=0 to frmmain.Panel2.ControlCount-1 do begin
      if lowercase(frmmain.Panel2.Controls[i].ClassName)='tpanel' then begin
         lblindex:=i;
         break;
      end;
    end;
    end
  else begin
    for i:=0 to frmmain.Panel2.ControlCount-1 do begin
      if uppercase(frmmain.Panel2.Controls[i].Name)=s then begin
         lblindex:=i;
         break;
      end;
    end;
  end;
  result:=lblindex;
end;


function bytetohex(src: byte): string;   {byte-->hex}
begin
  setlength(result, 2);
  asm
  mov edi, [result]
  mov edi, [edi]
  mov al, src
  mov ah, al // ±£´æÖÁ ah
  shr al, 4 // Êä³ö¸ß4Î»
  add al, '0'
  cmp al, '9'
  jbe @@outcharlo
  add al, 'a'-'9'-1
@@outcharlo:
  and ah, $f
  add ah, '0'
  cmp ah, '9'
  jbe @@outchar
  add ah, 'a'-'9'-1
@@outchar:
  stosw
  end;
end;

function GetPos15(const org:string;const adt:string):string; {µÃµ½Ò»¼þÎïÆ·´úÂëµÄµÚ15Î»}
begin
    if org='C' then
       begin
       case strtoint(adt) of
       1:result:='D';
       2:result:='E';
       3:result:='F';
       end;
       end
     else if org='8' then
       begin
       case strtoint(adt) of
       1:result:='9';
       2:result:='A';
       3:result:='B';
       end;
       end
     else
       result:=inttostr(strtoint(org)+strtoint(adt));

end;

procedure ResetWS();  {¸´Î»ÐéÄâ²Ö¿â}
var i,t:integer;
begin
  for i:=0 to 14 do
      for t:=0 to 7 do begin
          wscells[i,t].Flat:=false;
          wscells[i,t].Name:='';
          warehouse[i,t]:='FFFFFFFFFFFFFFFFFFFF';


      end;
  while getlblindex('all')<>121 do
        frmmain.Panel2.Controls[getlblindex('all')].Free;

end;


procedure initWS(); {³õÊ¼»¯ÐéÄâ²Ö¿â}
var i,t,szcell:integer;
    name1,name2:string;
begin
  szcell:=26;
  for i:=0 to 14 do
    for t:=0 to 7 do
      begin
            name1:=inttostr(i+1);
            name2:=inttostr(t+1);
            if length(name1)=1 then name1:='0'+name1;
            if length(name2)=1 then name2:='0'+name2;
            wscells[i,t]:=tspeedbutton.Create(frmmain);
            wscells[i,t].parent:=frmmain.Panel2 ;
            wscells[i,t].left:=t*szcell+1;
            wscells[i,t].top:=i*szcell+1;
            wscells[i,t].height:=szcell;
            wscells[i,t].width:=szcell;
            wscells[i,t].Name:='';
            wscells[i,t].ShowHint:=true;
            wscells[i,t].Hint:=name1+'  '+name2;
            wscells[i,t].OnClick:=frmmain.cellClick;
            //wscells[i,t].OnDblClick:=frmmain.cellDblClick;
          //  wscells[i,t].PopupMenu:=frmmain.popupmenu1;
      end;

end;

procedure freeWs(); {Ïú»ÙÐéÄâ²Ö¿â}
var i,t:integer;
begin
  for i:=0 to 14 do
    for t:=0 to 7 do
      wscells[i,t].Free ;
end;



function GetItemOption(const part1:string;const part2:string;const part3:string;const part4:string;const part5:string;const itemName:string):itemoption; {µÃµ½ÎïÆ·µÄ¸÷ÖÖÊôÐÔ}
var n,x,y,z,a,b,c,v,p15,aff,pex,p14:integer;
    iserr:boolean;
    sexopt,exctype,ancient:string;
begin
  iserr:=true;
  for n:=0 to 1 do
    for x:=0 to 15 do
      for y:=0 to 1 do
        for z:=0 to 3 do
          for a:=0 to 1 do
          begin
            if 128*n+8*x+4*y+z+a*108=hextoint(part1) then
              begin
                result.lvl:='Level:'+'+'+inttostr(x);
                level2:=x;
                result.opt:='Opção:'+'+'+inttostr(z*4);
                result.dur:='Durabilidade:'+inttostr(hextoint(part2));
                if n=1 then result.skill:='Skill' else result.skill:='Sem Skill';
                if y=1 then result.lucky:='Luck' else result.lucky:='Sem Luck';
                iserr:=false;
                if 1=1 then result.anc:='Ancient' else result.Anc:='Sem ser Ancient';
                p15:=hextoint(part3[1]);
                aff:=z*4;
                if p15>=12 then
                  begin
                    result.opt:='Option'+'+'+(inttostr(aff+16));
                    pex:=p15-12;
                  end
                    else if p15>=8 then
                      begin
                        pex:=p15-8;
                      end
                        else if p15>=4 then
                          begin
                            result.opt:='Option'+'+'+(inttostr(aff+16));
                            pex:=p15-4;
                          end
                            else
                              begin
                                pex:=p15;
                              end;
                {p14:=hextoint(part3[3]);
                if ((p14>=4) and (p14<=7)) or (p14>=12) then
                  begin
                    result.anc:='Ancient';
                    ancient:='Ancient';
                  end
                    else
                      begin
                        result.anc:='Sem ser Ancient';
                        ancient:='';
                      end;   }
              end;
          end;
  ancient:=part4;
  result.anc:='Não é ancient';
  Ancient2:='';
  if (vs)='MG' then
    begin
      if (hextoint(ancient)<4096) and (hextoint(ancient)>2303) then result.anc:='Ancient' else result.anc:='Não é ancient';
      if (hextoint(ancient)<4096) and (hextoint(ancient)>2303) then Ancient2:='Ancient' else Ancient2:='';
    end;
  if (vs)='MX' then
    begin
      if strtoint(ancient)>=5 then result.anc:='Ancient' else result.anc:='Não é ancient';
      if strtoint(ancient)>=5 then Ancient2:='Ancient' else Ancient2:='';
    end;
  result.ser:='Serial:'+part5;
  if iserr=true then
    begin
      result.lvl :='error';
      exit;
    end;
  //if (itemname='Absolute Sword of Archangel') or (itemname='Staff of Archangel') or (itemname='ArchAngel Crossbow') or (itemname='Archangel Crossbow') then colorred:=true else colorred:=false;
  with frmmain do
    begin
      itemquery.SQL.Clear;
      itemquery.SQL.Add('select excoptiontype from muitem where name='''+cboitem.Text+'''');
      itemquery.Open;
      exctype:=itemquery.Fields[0].asstring;
      itemquery.Close;
      pex:=hextoint(inttostr(pex)+part3[2]);
      for a:=0 to 1 do
        for b:=0 to 1 do
          for c:=0 to 1 do
            for x:=0 to 1 do
              for y:=0 to 1 do
                for z:=0 to 1 do
                  if a+2*b+4*c+8*x+16*y+32*z=pex then
                    if exctype='we' then
                      begin
                         if a<>0 then sexopt:=#13+'Increases Mana After Monster +Mana/8';
                         if b<>0 then sexopt:=sexopt+#13+'Increases Life After Monster +life/8';
                         if c<>0 then sexopt:=sexopt+#13+'Increase Attacking(wizardry)speed+7';
                         if x<>0 then sexopt:=sexopt+#13+'Increase Damage +2%';
                         if y<>0 then sexopt:=sexopt+#13+'Increase Damage +level/20';
                         if z<>0 then sexopt:=sexopt+#13+'Excellent Damage rate +10%';
                      end
                        else
                          if exctype='ar' then
                            begin
                              if a<>0 then sexopt:=#13+'Increases Zen After hunt +40%';
                              if b<>0 then sexopt:=sexopt+#13+'Defense sucess rate +10%';
                              if c<>0 then sexopt:=sexopt+#13+'Reflect Damage +5%';
                              if x<>0 then sexopt:=sexopt+#13+'Damage decrease +4%';
                              if y<>0 then sexopt:=sexopt+#13+'Increase Mana +4%';
                              if z<>0 then sexopt:=sexopt+#13+'Increase HP +4%';
                            end
                              else
                                if exctype='fen' then
                                  begin
                                    if a<>0 then sexopt:=#13+'Fenrir(Black)';
                                    if b<>0 then sexopt:=#13+'Fenrir(Blue)';
                                  end
                                    else if exctype='wi' then
                                      begin
                                        if a<>0 then sexopt:=#13+'HP Increase';
                                        if b<>0 then sexopt:=sexopt+#13+'MP Increase';
                                        if c<>0 then sexopt:=sexopt+#13+'Ignore oponent defence power 3%';
                                        if x<>0 then sexopt:=sexopt+#13+'Max Stamina increase';
                                        if y<>0 then sexopt:=sexopt+#13+'Increase atack (wizardry) speed +5';
                                      end
                                        else
                                          begin
                                            if a<>0 then sexopt:=#13+'Opção Excelent 1';
                                            if b<>0 then sexopt:=sexopt+#13+'Opção Excelent 2';
                                            if c<>0 then sexopt:=sexopt+#13+'Opção Excelent 3';
                                            if x<>0 then sexopt:=sexopt+#13+'Opção Excelent 4';
                                            if y<>0 then sexopt:=sexopt+#13+'Opção Excelent 5';
                                            if z<>0 then sexopt:=sexopt+#13+'Opção Excelent 6';
                                          end;
     end;
  if sexopt='' then result.exopt:='Sem opções excelents' else result.ExOpt:='Opções excelents:'+sexopt;
  sexopt2:=sexopt;
end;

function IntoWsGrid(const X:integer;const Y:integer;const itempropertyIn:itemproperty;const itemoptionIn:itemoption):boolean;{°ÑÒ»¼þÎïÆ··ÅÈëÐéÄâ²Ö¿â}
var i,t:integer;
    CanInsert:boolean;
    itemlabel:tpanel;
begin
  caninsert:=true;
  if ((x+itempropertyin.y-1)>14) or ((y+itempropertyin.x-1)>7) then caninsert:=false;
  if caninsert=false then begin
     application.MessageBox(pchar('O item '+itempropertyin.Name +' prescisa de '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y)+' espaço para ser adicionado!'+#13+#13+
     'Selecione um lugar que tenha um espaço de '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y)+' livre')  ,'Erro',mb_ok+mb_iconwarning);
     result:=false;
     exit;
  end;
  caninsert:=true;
  for i:=x to (x+itempropertyin.y-1) do begin
      for t:=y to (y+itempropertyin.x-1) do begin
          if wscells[i,t].Flat then
             caninsert:=false;
      end;
  end;
  if caninsert=false then begin
     application.MessageBox(pchar('O item '+itempropertyin.Name +' prescisa de '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y)+' espaço para ser adicionado!'+#13+#13+
     'Selecione um lugar que tenha um espaço de '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y)+' livre')  ,'Erro',mb_ok+mb_iconwarning);
     result:=false;
     exit;
  end;
  for i:=x to (x+itempropertyin.y-1) do
      for t:=y to (y+itempropertyin.x-1) do begin
         wscells[i,t].Name:='C'+to2char(x)+to2char(y)+to2char(i)+to2char(t);
         wscells[i,t].Flat:=true;
      end;
  itemlabel:=tpanel.Create(frmmain);
  itemlabel.Parent:=frmmain.Panel2;
  itemlabel.Name:='L'+to2char(x)+to2char(y);
  itemlabel.BevelOuter:=bvlowered;
  itemlabel.BevelInner:=bvnone;
  itemlabel.Color:=clteal;
  itemlabel.Font.Name:='MS Serif';
  itemlabel.Font.Size:=7;
 { if (level2>1) and (level2<3) then itemlabel.Font.Color:=clblack
      else if (level2<7) and (level2>3) then itemlabel.Font.Color:=clblue
        else if (level2<16) and (level2>7) then itemlabel.Font.Color:=clolive;    }
  //if colorred=true then itemlabel.Font.Color:=clred;
    if (sexopt2='') and (ancient2='') then
    begin
      itemlabel.Font.Color:=clblack;
      itemlabel.color:=cl3dlight;
    end
      else
        if (sexopt2='') and (ancient2<>'') then
          begin
            itemlabel.color:=clmoneyGreen;
            itemlabel.Font.Color:=clblack;
          end
            else
              if (sexopt2<>'') and (ancient2='') then
                begin
                  itemlabel.color:=clGreen;
                  itemlabel.Font.Color:=clblack;
                end
                  else
                    if (sexopt2<>'') and (ancient2<>'') then
                      begin
                        itemlabel.color:=$6AFF9B ;
                        itemlabel.Font.Color:=clblack;
                      end;
  itemlabel.Left:=y*26;
  itemlabel.Top :=x*26;
  itemlabel.Caption :=itempropertyin.Name;
  itemlabel.Width:=itempropertyin.X*26;
  itemlabel.Height:=itempropertyin.Y*26;
  itemlabel.Cursor:=crhandpoint;
  itemlabel.PopupMenu:=frmmain.popMenuitem;
  itemlabel.ShowHint:=false;
  itemlabel.Hint:='Nome:'+itempropertyin.Name+#13+itemoptionin.lvl+#13
                            +itemoptionin.opt+#13+itemoptionin.dur +#13+itemoptionin.skill
                            +#13+itemoptionin.lucky+#13+itemoptionin.anc+#13+itemoptionin.ExOpt+#13+#13+itemoptionin.ser;
  itemlabel.OnMouseDown:=frmmain.lblmousedown;
  itemlabel.OnClick:=frmmain.lblClick;
  itemlabel.OnMouseMove:=frmmain.lblMouseMove;
  result:=true;
end;

procedure killitem(const itemflag:string); {É¾³ýÒ»¼þÎïÆ·}
begin
  while getbtnindex(itemflag)<>121 do begin
    (frmmain.Panel2.Controls[getbtnindex(itemflag)] as tspeedbutton).Flat:=false;
    frmmain.Panel2.Controls[getbtnindex(itemflag)].Name:='';
  end;
end;


function warehouseCommit():boolean;  {Ìá½»¸ü¸Ä}
var  i,t:integer;
  sSql,sSqlSub:string;
begin
  screen.Cursor:=-11;
  application.ProcessMessages;
  ssql:='update '+warehouses+' set '+Money+'='+frmmain.edtZen.Text+','+Items+'=0x';
  for i:=0 to 14 do begin
      for t:=0 to 7 do ssqlsub:=ssqlsub+warehouse[i,t];
  end;
  ssql:=ssql+ssqlsub+' where '+AccountID+'='''+frmmain.cboID.Text+'''' ;
  if frmmain.cbsql.Checked then begin
    if application.MessageBox(pchar(ssql),'Query',mb_yesno+mb_iconinformation)=mrno then begin
       screen.Cursor:=0;
       result:=false;
       exit;                              // 8012
    end;
  end;
  if frmmain.checkbox3.checked then
    begin
      frmmain.richedit1.Lines.Clear;
      frmmain.richedit1.Lines.Add(ssql);
       frmmain.richedit1.SelectAll;
      frmmain.richedit1.CopyToClipboard;
    //  frmmain.richedit1.Lines.Clear;

    end;


  screen.Cursor:=0;
  with frmmain.cmtDB do begin
  commandtext:=ssql;
  try
  execute;
  result:=true;
  except
  on e:exception do begin
  application.MessageBox(pchar(e.Message),'Erro',mb_ok+mb_iconerror);
  result:=false;
  end;
  end;
  end;
end;

function IsNum(const S:string):boolean; {ÊÇ·ñÊÇÊý×Ö}
begin
  result:=StrToIntDef(S,0)=StrToIntDef(S,1);
end;

function GetItemProp(ID:string;Unique:string):itemproperty;
begin
  with frmmain.itemQuery do begin
       sql.Clear;
       sql.Add('select name,x,y from muitem where id='''+id+''' and unique='+unique+'');
       open;
       if eof and bof then
          result.Name:='miss'
       else begin
         result.Name :=fields[0].AsString;
         result.X:=fields[1].AsInteger;
         result.Y:=fields[2].AsInteger;
       end;
       close;
  end;
end;

procedure editlock();  {½ûÖ¹±à¼­}
var i:integer;
begin
  frmmain.edtZen.Enabled:=false;
  for i:=0 to frmmain.groupbox2.ControlCount -1 do
    frmmain.groupbox2.Controls[i].Enabled:=false;
  frmmain.Label2.Enabled:=false;
  //frmmain.Label1.Enabled:=false;
  for i:=0 to frmmain.groupbox7.ControlCount -1 do
    frmmain.groupbox7.Controls[i].Enabled:=false;
  for i:=0 to frmmain.GroupBox1.ControlCount  -1 do
    frmmain.GroupBox1.Controls[i].Enabled:=false;
  frmmain.groupbox6.enabled:=true;
  frmmain.btnsave.Enabled:=false;
  frmmain.bitbtn1.Enabled:=false;
  frmmain.groupbox2.enabled:=false;
  frmmain.groupbox1.enabled:=false;
  frmmain.cbSql.enabled:=false;
  frmmain.checkbox3.enabled:=false;
end;

procedure editunlock();  {ÔÊÐí±à¼­}
var i:integer;
begin
  frmmain.edtZen.Enabled:=true;
  frmmain.Label2.Enabled:=true;
  //frmmain.Label1.Enabled:=true;
  frmmain.btnin.enabled:=true;
  for i:=0 to frmmain.groupbox2.ControlCount -1 do
    frmmain.groupbox2.Controls[i].Enabled:=true;
  for i:=0 to frmmain.GroupBox1.ControlCount  -1 do
    frmmain.GroupBox1.Controls[i].Enabled:=true;
  for i:=0 to frmmain.groupbox7.ControlCount -1 do
    frmmain.groupbox7.Controls[i].Enabled:=true;
  frmmain.groupbox6.enabled:=true;
  frmmain.btnsave.Enabled:=true;
  frmmain.bitbtn1.Enabled:=true;
  frmmain.groupbox2.enabled:=true;
  frmmain.groupbox1.enabled:=true;
  frmmain.cbSql.enabled:=true;
  frmmain.checkbox3.enabled:=true;
end;

function GetTag(const I:integer):integer ;  {·µ»Ø×¿Ô½ÊôÐÔ´úÂë¸ø×¿Ô½checkboxµÄtag}
begin
 case i of
 1:result:=1;
 2:result:=2;
 3:result:=4;
 4:result:=8;
 5:result:=16;
 6:result:=32;
 end;
end;


procedure FillHexWS(item:TField); {Ìî³äÄ³¸öÕË»§µÄ²Ö¿â}
type Tcharset=set of char;
var A:tcharset;
    itemblock:array of byte;
    sWS,sItem,sUni,Stipo:string;
    wsrow,wscol,i,panelcount:integer;
    itemnow:itemproperty;
    itemoptnow:itemoption;

begin
  a:=['0'..'7'];
  with item do begin
      setlength(itemblock,datasize);
      try
      getdata(itemblock);
      {½ØÈ¡²Ö¿âµÄ16½øÖÆ´úÂë}
      for i:=2 to high(itemblock) do begin
          sws:=sws+uppercase(bytetohex(itemblock[i]));
      end;
      panelcount:=0;
      for wsrow:=0 to 14 do
        for wscol:=0 to 7 do
          begin
            sitem:=midstr(sws,160*(wsrow)+20*(wscol)+1,20);
            if (sitem<>'FFFFFFFFFFFFFFFFFFFF') and (sitem<>'FF000000000000000000') and (sitem<>'00000000000000000000') then inc(panelcount);
          end;

      if panelcount=0 then exit;//²Ö¿âÀïÃ»ÓÐÎïÆ·

      for wsrow:=0 to 14 do
        for wscol:=0 to 7 do
          begin
            sitem:=midstr(sws,160*(wsrow)+20*(wscol)+1,20);
            warehouse[wsrow,wscol]:=sitem;
            if (sitem='FFFFFFFFFFFFFFFFFFFF') or (sitem='FF000000000000000000') or (sitem='00000000000000000000') then sitem:='';
            if sitem<>'' then
              begin
                if sitem[15] in a then suni:='0' else suni:='8';
                itemnow:=getitemprop(leftstr(sitem,2),suni);
                if itemnow.Name='miss' then
                  begin
                    showmessage('Item nao indentificado na posição: '+inttostr(wsrow)+','+inttostr(wscol));
                    continue;
                  end;
                itemoptnow:=getitemoption(sitem[3]+sitem[4],sitem[5]+sitem[6],sitem[15]+sitem[16],sitem[17]+sitem[18]+sitem[19]+sitem[20],sitem[7]+sitem[8]+sitem[9]+sitem[10]+sitem[11]+sitem[12]+sitem[13]+sitem[14],itemnow.name);
                if itemnow.Name='miss' then
                if application.MessageBox(pchar('Não foi possivel ler o item:'+sitem+#13+'Voce deseja excluir ele?'),'Erro',mb_yesno+mb_iconwarning)=id_no then
                   continue;
                if intowsgrid(wsrow,wscol,itemnow,itemoptnow)=false then application.MessageBox(pchar('Não eh possivel adicionar o item:'+sitem+#13+'A seguinte posição deve estar ocupada:'+inttostr(wsrow+1)+','+inttostr(wscol+1)),'Erro',mb_ok+mb_iconwarning);
              end;
          end;
      except
      on E:exception do application.MessageBox(pchar(e.Message),'Erro',mb_ok+mb_iconerror);


      end;
  end;
end;

procedure Typechange(const S:string); {ÎïÆ·´óÀà±ä¸ü}
var i,j:integer;
begin
 itemspc:=nil;
 with frmmain do begin
     try
     lblspace.Caption :='0x0';
     cboitem.Items.Clear;
     itemquery.SQL.Clear;
     itemquery.SQL.Add('select name,x,y,setnumber from muitem where type='''+s+'''');
     itemquery.Open;
     if not (itemquery.Eof and itemquery.Bof) then begin
        setlength(itemspc,itemquery.RecordCount);
        for i:=0 to itemquery.RecordCount-1 do begin
          cboitem.Items.Add(itemquery.Fields[0].asstring);
          itemspc[i]:=itemquery.Fields[1].AsString+'x'+itemquery.Fields[2].AsString ;
          itemquery.Next;
        end;

     end;
     cboitem.ItemIndex:=0;
     lblspace.Caption :=itemspc[0];
     finally
     for i:=1 to itemquery.recordcount-1 do
       begin
         if (itemquery.Fields[3].asinteger=numordem) and (itemquery.Fields[3].asinteger<>0) then cboitem.text:=itemquery.Fields[0].asstring;
       end;
     itemquery.Close ;
     end;
 end;
end;

//×Ô¶¨Òåº¯Êý½áÊø================================================================

//×Ô¶¨ÒåÊÂ¼þ´¥·¢================================================================
procedure tfrmmain.lblClick(sender:tobject);
begin
  application.MessageBox (pchar((sender as tpanel).Hint),'Informação',mb_ok+mb_iconinformation);
end;

procedure tfrmmain.cellDblClick(sender:tobject);
begin
 if cbox.Enabled then begin
   itemadd;
 end;
end;




procedure TfrmMain.CheckBox1Click(Sender: TObject);
var i:integer;
valor:string;
begin
if edit1.enabled then
  begin
  muquery.sql.Clear;
  muquery.SQL.Add('select '+itemcount+' from '+gameserverinfo+'');
  muquery.Open;
  for i:=0 to muquery.RecordCount-1 do
    begin
      valor:=inttohex(muquery.Fields[0].asinteger+1,8);
      muquery.Next;
    end;
  muquery.Close;
  edit1.Text:=(valor);
  edit1.Enabled:=false;
  end
    else edit1.Enabled:=true;
end;

procedure tfrmmain.lblmousedown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
begin
  currentitem:=midstr((sender as tpanel).Name,2,4);
end;
procedure Tfrmmain.lblMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var wsPos:string;
    iName:string;
begin
  wspos:=midstr((sender as tpanel).Name,2,4);
  iname:=(sender as tpanel).Caption ;
  edtshow.Text :=iname+':'+warehouse[strtoint(leftstr(wspos,2)),strtoint(rightstr(wspos,2))];

end;
//×Ô¶¨ÒåÊÂ¼þ´¥·¢½áÊø============================================================

procedure tfrmmain.iniciar;
var i:integer;
  filename : string;
  f : textfile;
  ch : char;
  esc: boolean;
  s:array[1..6] of string;
  g:string;
begin
  numordem:=0;
  additem2b:=true;
  initws;
  editlock;
  muquery.ConnectionString:='Provider=MSDASQL.1;Password='+mupwd+';Persist Security Info=True;User ID='+muid+';Data Source='+mudsn+';Initial Catalog='+catalog;
  cmtdb.ConnectionString:=muquery.ConnectionString;
  itemquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(Application.ExeName)+'muitem.mdb'+';Mode=ReadWrite;Persist Security Info=False';
  filename:=ExtractFilePath(Application.ExeName)+'SQLNames.txt';
  assignfile(F,filename);
  reset(F);
  i:=0;
  while not eof(F) do
    begin
      read(F,ch);
      Case ch of
        '"'  :  begin
                  if esc=false then esc:=true
                    else
                      begin
                        esc:=false;
                        inc(i);
                        s[i]:=g;
                        g:='';
                      end;
                end;
         else begin
                if esc=true then
                  begin
                    g:=g+ch;
                  end;
               end;
      end;
    end;
  closefile(F);
  AccountID:=s[1];
  Money:=s[2];
  warehouses:=s[3];
  Items:=s[4];
  gameserverinfo:=s[5];
  itemcount:=s[6];
 {
  AccountID:='AccountID';
  Money:='Money';
  warehouses:='warehouse';
  Items:='Items';        }
  muquery.SQL.Add('select '+AccountID+','+Money+' from '+warehouses+'');
  muquery.Open;
  if (muquery.Eof) and (muquery.Bof) then
     application.MessageBox('Não foi possivel encontrar nenhuma account no server'+#13+'Contate o admin do server','Erro',mb_iconwarning)
    else
      begin
        for i:=0 to muquery.RecordCount-1 do
          begin
            cboid.Items.Add(muquery.Fields[0].asstring);
            muquery.Next;
          end;
      end;
  muquery.Close;
  itemquery.SQL.Add('select distinct type from muitem');
  itemquery.Open;
  while not itemquery.Eof do begin
    cbotype.Items.Add(itemquery.Fields[0].asstring);
    itemquery.Next;
  end;
  itemquery.Close;
  cbotype.ItemIndex:=0;
  typechange(cbotype.Text );
  frmmain.Update;
end;


procedure TfrmMain.btnHelpClick(Sender: TObject);
begin

 frmsd.ShowModal;
end;


procedure TfrmMain.btnExitClick(Sender: TObject);
begin
 application.Terminate;
end;



procedure TfrmMain.zy1Click(Sender: TObject);
begin
 with (sender as Tcheckbox) do begin
   if (name<>'jn') and (name<>'xy') then begin
      if checked then tag:=gettag(strtoint(name[3])) else tag:=0;
   end;
 end;
end;


procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
 if application.MessageBox('Salvar alterações no Vault?','CMT-VMAT Vault Editor',mb_yesno+mb_iconquestion)=id_no then exit;
 if not(isnum(edtzen.Text )) then begin
    application.MessageBox('Só são permitidos numeros no dinheiro','Erro',mb_iconerror);
    exit;
 end;

 if warehousecommit then application.MessageBox('O Vault foi salvo com Sucesso!','CMT-VMAT Vault Editor',mb_ok+mb_iconinformation) else
 application.MessageBox('Não foi possivel salvar o Vault!','Erro',mb_ok+mb_iconwarning);

end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var i,t:integer;
begin
 if application.MessageBox('Voce tem certeza que deseja apagar o Vault?','CMT-VMAT Vault Editor',mb_yesno+mb_iconwarning)=idno then exit;
 for i:=0 to 14 do begin
     for t:=0 to 7 do begin
         warehouse[i,t]:='FFFFFFFFFFFFFFFFFFFF'
     end;

 end;
 resetws;
end;





procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freews;
 application.Terminate;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
 freews;
end;

procedure TfrmMain.N1Click(Sender: TObject);
var i:integer;
begin
 i:=getlblindex('L'+currentitem);
 application.MessageBox (pchar(panel2.Controls[i].Hint),'Informação',mb_ok+mb_iconinformation);
end;

procedure TfrmMain.N3Click(Sender: TObject);
var i,t:integer;
begin
  if application.MessageBox('Você tem certeza que deseja excluir o item?','Excluindo item...',mb_yesno+mb_iconquestion)=id_no then exit;
  {Çå³ýÎÄ±¾±êÇ©}
  i:=getlblindex('L'+currentitem);
  frmmain.Panel2.Controls[i].Free;
  {´ÓwarehouseÊý×éÖÐÉ¾³ýÎïÆ·}
  i:=strtoint(leftstr(currentitem,2));
  t:=strtoint(rightstr(currentitem,2));
  warehouse[i,t]:='FFFFFFFFFFFFFFFFFFFF';
  {ÊÍ·Å²Ö¿â¿Õ¼ä}
  killitem(currentitem);
end;

procedure TfrmMain.cboTypeChange(Sender: TObject);
var setnumber,i:integer;
nome:string;
begin
  typechange(cbotype.Text );
 // cboitem.Style:=csDropDown;
  itemquery.SQL.Clear;
  itemquery.SQL.Add('select name,setnumber from muitem where type='''+cbotype.text+'''');
  itemquery.Open;
  for i:=1 to itemquery.recordcount-1 do
    begin
      if (itemquery.Fields[1].asinteger=numordem) and (itemquery.Fields[1].asinteger<>0) then cboitem.text:=itemquery.Fields[0].asstring;
      itemquery.next;
    end;

  itemquery.Close ;
 // cboitem.Style:=csDropDownList;
end;

procedure TfrmMain.btnINClick(Sender: TObject);
begin
itemadd;
end;

procedure tfrmmain.itemadd;
var sthisitem,smain,sopt,sdur,spos15,ancient
,sex,sser:string;
    ixy,izj,i:integer;
    insProp:itemproperty;
    insOpt:itemoption;
    lvlaff:byte;
    valor:string;
    tipo:boolean;
begin
   valor:=edit1.text;
   if checkbox1.Checked then
     begin
       cmtDB.commandtext:=('Update '+gameserverinfo+' set '+itemcount+'='+itemcount+'+1');
       cmtdb.Execute;
       muquery.sql.Clear;
       muquery.SQL.Add('select '+itemcount+' from '+gameserverinfo+'');
       muquery.Open;
       for i:=0 to muquery.RecordCount-1 do
         begin
           valor:=inttohex(muquery.Fields[0].asinteger+1,8);
           muquery.Next;
         end;
       muquery.Close;
     end;
   if trim(cboitem.Text)='' then begin
      application.MessageBox('Selecione um item para adicionar','Erro',mb_ok+mb_iconwarning);
      exit;
   end;
   if (isnum(edtdur.Text )=false) then begin
      application.MessageBox('A durabilidade não pode estar em branco','Erro',mb_ok+mb_iconwarning);
      exit;
   end;
   if (strtoint(edtdur.Text)>255) or (strtoint(edtdur.Text)<0) then begin
      application.MessageBox('A durabilidade deve ser um numero entre 0 e 255','Erro',mb_ok+mb_iconwarning);
      exit;
   end;
   insprop.Name:=cboitem.Text ;
   insprop.X:=strtoint(lblspace.Caption[pos('x',lblspace.Caption)-1]);
   insprop.y:=strtoint(lblspace.caption[pos('x',lblspace.Caption)+1]);
   itemquery.SQL.Clear;
   itemquery.SQL.Add('select id,unique,x,y,ExcOptionType,unique2 from muitem where name='''+cboitem.Text +'''');
   itemquery.Open ;
   smain:=itemquery.Fields[0].AsString ;
   spos15:=itemquery.Fields[1].AsString ;
   if itemquery.Fields[5].AsString='0' then tipo:=false else tipo:=true;
   itemquery.Close ;
   randomize;
   if xy.Checked then ixy:=4 else ixy:=0;
   if (vs)='MG' then
    begin
      if checkbox2.checked=true then ancient:='09'+inttostr(random(10))+inttostr(random(10)) else  ancient:='80'+inttostr(random(10))+inttostr(random(10)) ;
    end;
   if ((vs)='MX') then
    begin
      if tipo=true then
        if checkbox2.checked=true then ancient:='0085' else  ancient:='0080'
          else if checkbox2.checked=true then ancient:='0005' else  ancient:='0000'
    end;
   if (vs<>'MG') and (vs<>'MX')  then ancient:='80'+inttostr(random(10))+inttostr(random(10)) ;


   //if (checkbox2.Checked=true) then ancient:='0905' else ancient:='8012';
   if trackbar1.position=4 then
     begin
      izj:=0;
      if spos15='0' then spos15:='4' else spos15:='C';
     end
   else
     if trackbar1.position=5 then
       begin
        izj:=1;
        if spos15='0' then spos15:='4' else spos15:='C';
       end
     else
       if trackbar1.position=6 then
         begin
           izj:=2;
           if spos15='0' then spos15:='4' else spos15:='C';
         end
       else
         if trackbar1.position=7 then
           begin
             izj:=3;
             if spos15='0' then spos15:='4' else spos15:='C';
           end
         else
           izj:=trackbar1.Position;
   lvlaff:=trackbar2.Position;
   sopt:=inttohex(128*abs(strtoint(booltostr(jn.checked)))+ixy+izj+8*lvlaff,2);
   sdur:=inttohex(strtoint(edtdur.Text ),2);
   sex:=inttohex(zy1.Tag+zy2.Tag+zy3.Tag+zy4.Tag+zy5.Tag+zy6.Tag,2);
   if sex[1]='0' then sex:=sex[2];
   if length(sex)=2 then begin
      spos15:=getpos15(spos15,sex[1]);
      sex:=sex[2];

   end;
   insopt:=getitemoption(sopt,sdur,spos15+sex,ancient,edit1.text,cboitem.Text);
   randomize;
   {for i:=1 to 4 do begin
       randomize;
       sser:=sser+inttostr(random(10));

   end; }
  // repeat
   randomize;

   sthisitem:=smain+sopt+sdur+edit1.text+spos15+sex+ancient;
   if intowsgrid(strtoint(cbox.Text )-1,strtoint(cboy.Text )-1,insprop,insopt) then
   warehouse[strtoint(cbox.Text)-1,strtoint(cboy.Text )-1]:=sthisitem;
   edit1.Text:=valor;
end;




procedure TfrmMain.cboIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=vk_return then frmmain.cboIDclick(cboid);
end;

procedure TfrmMain.cboIDClick(Sender: TObject);
begin
 screen.Cursor:=-11;
 editlock;
 application.ProcessMessages;
 try
    muquery.SQL.Clear;
    muquery.SQL.Add('select '+Money+','+Items+' from '+warehouses+' where '+AccountID+'='''+cboid.text+'''');
    muquery.Open ;
    if (muquery.Eof) and (muquery.Bof) then begin
       application.MessageBox('Não foi possivel encontrar nenhuma account com item','Erro',mb_ok+mb_iconerror);
       screen.Cursor:=0;
       muquery.Close;
       exit;
    end;
    resetws;
    fillhexws(muquery.Fields[1]);
    edtzen.Text :=muquery.Fields[0].AsString ;
    muquery.Close;

 editunlock;
 finally
 screen.Cursor:=0;
 end;
end;



procedure TfrmMain.BitBtn6Click(Sender: TObject);
begin
form3.showmodal;
end;

procedure TfrmMain.TrackBar2Change(Sender: TObject);
begin
label3.caption:='+'+inttostr(trackbar2.position);
end;

procedure TfrmMain.TrackBar1Change(Sender: TObject);
begin
label7.caption:='z'+inttostr(trackbar1.position*4);
end;





procedure TfrmMain.Edit1Exit(Sender: TObject);
var i,x:byte;
begin
 i:=8-length(edit1.text);
 if i>0 then
   for x:=1 to i do
     edit1.text:=edit1.text+'0';
end;

procedure TfrmMain.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
key:=AnsiUpperCase(key)[1];
If Not (Key in ['0'..'9',#8,#0,'A','B','C','D','E','F']) then
Key:=#0;
end;

procedure TfrmMain.edtdurKeyPress(Sender: TObject; var Key: Char);
begin
If Not (Key in ['0'..'9',#8,#0]) then
Key:=#0;
end;

procedure TfrmMain.edtZenKeyPress(Sender: TObject; var Key: Char);
begin
If Not (Key in ['0'..'9',#8,#0]) then
Key:=#0;
end;

procedure TfrmMain.Adicionaritem1Click(Sender: TObject);
var sHint:string;
begin
  if cbox.Enabled then begin

     itemadd;
  end;
end;




procedure tfrmmain.cellClick(sender:tobject);
var sHint:string;
begin

  if cbox.Enabled then begin

       shint:=(sender as tspeedbutton).Hint ;
       cbox.ItemIndex:=strtoint(leftstr(shint,2))-1;
       cboy.ItemIndex:=strtoint(rightstr(shint,2))-1;
       if (cbox.ItemIndex=cbox2) and (cboy.itemindex=cboy2) then
         begin

           itemadd;
         end;
       cbox2:=cbox.itemindex;
       cboy2:=cboy.itemindex;
    end;



end;



procedure TfrmMain.cboIDChange(Sender: TObject);
var exctype:string;
begin
 lblspace.Caption:=itemspc[cboitem.itemindex];
 itemquery.SQL.Clear;
 itemquery.SQL.Add('select excoptiontype,setnumber from muitem where name='''+cboitem.Text+'''');
 itemquery.Open;
 exctype:=itemquery.Fields[0].asstring;
 numordem:=itemquery.Fields[1].asinteger;
 itemquery.Close;

 if exctype='we' then
   begin
     zy1.Caption:='Increases Mana After Monster +Mana/8';
     zy2.Caption:='Increases Life After Monster +life/8';
     zy3.Caption:='Increase Attacking(wizardry)speed+7';
     zy4.Caption:='Increase Damage +2%';
     zy5.Caption:='Increase Damage +level/20';
     zy6.Caption:='Excellent Damage rate +10%';
     zy1.Enabled:=true;
     zy2.Enabled:=true;
     zy3.Enabled:=true;
     zy4.Enabled:=true;
     zy5.Enabled:=true;
     zy6.Enabled:=true;
   end
     else
       if exctype='any' then
         begin
           zy1.Caption:='Sem Opção';
           zy2.Caption:='Sem Opção';
           zy3.Caption:='Sem Opção';
           zy4.Caption:='Sem Opção';
           zy5.Caption:='Sem Opção';
           zy6.Caption:='Sem Opção';
           zy1.Enabled:=false;
           zy2.Enabled:=false;
           zy3.Enabled:=false;
           zy4.Enabled:=false;
           zy5.Enabled:=false;
           zy6.Enabled:=false;
         end
           else
             if exctype='ar' then
               begin
                 zy1.Caption:='Increases Zen After hunt +40%';
                 zy2.Caption:='Defense sucess rate +10%';
                 zy3.Caption:='Reflect Damage +5%';
                 zy4.Caption:='Damage decrease +4%';
                 zy5.Caption:='Increase Mana +4%';
                 zy6.Caption:='Increase HP +4%';
                 zy1.Enabled:=true;
                 zy2.Enabled:=true;
                 zy3.Enabled:=true;
                 zy4.Enabled:=true;
                 zy5.Enabled:=true;
                 zy6.Enabled:=true;
               end
                 else
                   if exctype='fen' then
                     begin
                       zy1.Caption:='Fenrir(Black)';
                       zy2.Caption:='Fenrir(Blue)';
                       zy3.Caption:='Se voce quiser um fenrir vermelho ';
                       zy4.Caption:='então não marque nenhum opt exc,';
                       zy5.Caption:='mas se quiser outra cor ';
                       zy6.Caption:='entao marque a opção da cor do fenrir';
                       zy1.Enabled:=true;
                       zy2.Enabled:=true;
                       zy3.Enabled:=false;
                       zy4.Enabled:=false;
                       zy5.Enabled:=false;
                       zy6.Enabled:=false;
                     end
                       else if exctype='wi' then
                         begin
                           zy1.Caption:='HP Increase';
                           zy2.Caption:='MP Increase';
                           zy3.Caption:='Ignore oponent defence power 3%';
                           zy4.Caption:='Max Stamina increase';
                           zy5.Caption:='Increase atack (wizardry) speed +5';
                           zy6.Caption:='Opção Excelent 6';
                           zy1.Enabled:=true;
                           zy2.Enabled:=true;
                           zy3.Enabled:=true;
                           zy4.Enabled:=true;
                           zy5.Enabled:=true;
                           zy6.Enabled:=false;
                         end
                           else
                             begin
                               zy1.Caption:='Opção Excelent 1';
                               zy2.Caption:='Opção Excelent 2';
                               zy3.Caption:='Opção Excelent 3';
                               zy4.Caption:='Opção Excelent 4';
                               zy5.Caption:='Opção Excelent 5';
                               zy6.Caption:='Opção Excelent 6';
                               zy1.Enabled:=true;
                               zy2.Enabled:=true;
                               zy3.Enabled:=true;
                               zy4.Enabled:=true;
                               zy5.Enabled:=true;
                               zy6.Enabled:=true;
                            end;
end;

procedure TfrmMain.BitBtn7Click(Sender: TObject);
begin
form3.showmodal;
end;

end.




