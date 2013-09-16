unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls,strUtils, ValEdit, ExtCtrls, Buttons,dec,
  ComCtrls,showdata, Menus,  unit3,configform,
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
    edtZen: TEdit;
    cboID: TComboBox;
    CheckBox3: TCheckBox;
    RichEdit1: TRichEdit;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    Label8: TLabel;
    CheckBox2: TCheckBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure lerexc;
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
    procedure resetws;


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
  itemspc:array of string; {物品所占空间数组}
  warehouse:array[0..14,0..7] of string; {物品16进制代码数组，与虚拟仓库同步}
  wscells:array[0..14,0..7] of tspeedbutton; {组成虚拟仓库的speedbutton数组}
  currentitem:string; {跟踪当前选择的物品}
  sexopt2,ancient2:string;
  level2,numordem:integer;
  colorred,additem2b:boolean;
  cbox2,cboy2:byte;

implementation

{$R *.dfm}


//自定义 Procedure&Function 开始 ===============================================
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



function To2Char(const I:integer):string ;   {把一位integer表示为2位string}
var S:string;
begin
  s:=inttostr(i);
  if length(s)=1 then s:='0'+s;
  result:=s;
end;



function Getbtnindex(const S:string):integer ; {循环检索speedbutton数组，返回值用于销毁动态speedbutton组件}
var i,btnindex:integer;
begin
  btnindex:=121;
  for i:=0 to frmmain.Panel2.ControlCount-1 do
    begin
      if leftstr(uppercase(frmmain.Panel2.Controls[i].Name),5)='C'+s then
        begin
          btnindex:=i;
          break;
        end;
    end;
  result:=btnindex;
end;


function Getlblindex(const S:string):integer; {循环检索panel数组，返回值用于销毁动态panel组件}
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
  mov ah, al // 保存至 ah
  shr al, 4 // 输出高4位
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

function GetPos15(const org:string;const adt:string):string; {得到一件物品代码的第15位}
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

procedure tfrmmain.ResetWS();  {复位虚拟仓库}
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


procedure initWS(); {初始化虚拟仓库}
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
           // wscells[i,t].ShowHint:=true;
            wscells[i,t].Hint:=name1+'  '+name2;
            wscells[i,t].OnClick:=frmmain.cellClick;
            //wscells[i,t].OnDblClick:=frmmain.cellDblClick;
          //  wscells[i,t].PopupMenu:=frmmain.popupmenu1;
      end;

end;

procedure freeWs(); {销毁虚拟仓库}
var i,t:integer;
begin
  for i:=0 to 14 do
    for t:=0 to 7 do
      wscells[i,t].Free ;
end;



function GetItemOption(const part1:string;const part2:string;const part3:string;const part4:string;const part5:string;const itemName:string):itemoption; {得到物品的各种属性}
var n,x,y,z,a,b,c,v,p15,aff,pex,p14:integer;
    iserr:boolean;
    sexopt,exctype,ancient:string;
    numitemancient:string;
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
                result.lvl:=Leveltext+'+'+inttostr(x);
                level2:=x;
                result.opt:=optiontext+'+'+inttostr(z*4);
                result.dur:=durationtext+inttostr(hextoint(part2));
                if n=1 then result.skill:=Skilltext else result.skill:=withoutskill;
                if y=1 then result.lucky:=Lucktext else result.lucky:=withoutluck;
                iserr:=false;
               // if 1=1 then result.anc:=Ancienttext else result.Anc:=whitoutancienttext;
                p15:=hextoint(part3[1]);
                aff:=z*4;
                if p15>=12 then
                  begin
                    result.opt:=Optiontext+'+'+(inttostr(aff+16));
                    pex:=p15-12;
                  end
                    else if p15>=8 then
                      begin
                        pex:=p15-8;
                      end
                        else if p15>=4 then
                          begin
                            result.opt:=Optiontext+'+'+(inttostr(aff+16));
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

  //numitemancient:=ancientnum;

  ancient:=part4;
  result.anc:=withoutancient;
  Ancient2:='';
  if (vs)='MG' then
    begin
      if (hextoint(ancient)<4096) and (hextoint(ancient)>2303) then result.anc:=ancienttext else result.anc:=withoutancient;
      if (hextoint(ancient)<4096) and (hextoint(ancient)>2303) then Ancient2:='Ancient' else Ancient2:='';
    end;
  if (vs)='MX' then
    begin
      if strtoint(ancient)>=5 then result.anc:=ancienttext else result.anc:=withoutancient;
      if strtoint(ancient)>=5 then Ancient2:='Ancient' else Ancient2:='';
    end;
  if (vs)='CMT' then
    begin
      if (ancient[1]+ancient[2]=ancientnum5) then begin
        result.anc:=ancient5;
        Ancient2:='Ancient';
      end
        else if (ancient[1]+ancient[2]=ancientnum10) then begin
          result.anc:=ancient10;
          Ancient2:='Ancient';
        end
          else begin
            result.anc:=withoutancient;
            Ancient2:='';
          end;

      result.ser:=Serialtext+part5;
    end;
  if vs<>'CMT' then
    result.ser:=Serialtext+part5;
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
                         if a<>0 then sexopt:=#13+wemode1;
                         if b<>0 then sexopt:=sexopt+#13+wemode2;
                         if c<>0 then sexopt:=sexopt+#13+wemode3;
                         if x<>0 then sexopt:=sexopt+#13+wemode4;
                         if y<>0 then sexopt:=sexopt+#13+wemode5;
                         if z<>0 then sexopt:=sexopt+#13+wemode6;
                      end
                        else
                          if exctype='ar' then
                            begin
                              if a<>0 then sexopt:=#13+armode1;
                              if b<>0 then sexopt:=sexopt+#13+armode2;
                              if c<>0 then sexopt:=sexopt+#13+armode3;
                              if x<>0 then sexopt:=sexopt+#13+armode4;
                              if y<>0 then sexopt:=sexopt+#13+armode5;
                              if z<>0 then sexopt:=sexopt+#13+armode6;
                            end
                              else
                                if exctype='fen' then
                                  begin
                                    if a<>0 then sexopt:=#13+fenmode1;
                                    if b<>0 then sexopt:=#13+fenmode2;
                                  end
                                    else if exctype='wi' then
                                      begin
                                        if a<>0 then sexopt:=#13+wimode1;
                                        if b<>0 then sexopt:=sexopt+#13+wimode2;
                                        if c<>0 then sexopt:=sexopt+#13+wimode3;
                                        if x<>0 then sexopt:=sexopt+#13+wimode4;
                                        if y<>0 then sexopt:=sexopt+#13+wimode5;
                                      end
                                        else
                                          begin
                                            if a<>0 then sexopt:=#13+ormode1;
                                            if b<>0 then sexopt:=sexopt+#13+ormode2;
                                            if c<>0 then sexopt:=sexopt+#13+ormode3;
                                            if x<>0 then sexopt:=sexopt+#13+ormode4;
                                            if y<>0 then sexopt:=sexopt+#13+ormode5;
                                            if z<>0 then sexopt:=sexopt+#13+ormode6;
                                          end;
     end;
  if sexopt='' then result.exopt:=withoutexcopts else result.ExOpt:=excopts+sexopt;
  sexopt2:=sexopt;
end;

function IntoWsGrid(const X:integer;const Y:integer;const itempropertyIn:itemproperty;const itemoptionIn:itemoption):boolean;{把一件物品放入虚拟仓库}
var i,t:integer;
    CanInsert:boolean;
    itemlabel:tpanel;
begin
  caninsert:=true;
  if ((x+itempropertyin.y-1)>14) or ((y+itempropertyin.x-1)>7) then caninsert:=false;
  if caninsert=false then begin
     application.MessageBox(pchar(Error1part1+' '+itempropertyin.Name +' '+Error1part2+' '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y)+' '+Error1part3+' '+#13+#13+
     Error1part4+' '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y))  ,Pchar(ErrorCaption),mb_ok+mb_iconwarning);
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
     application.MessageBox(pchar(Error1part1+' '+itempropertyin.Name+' '+Error1part2+' '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y)+' '+Error1part3+' '+#13+#13+
     Error1part4+' '+inttostr(itempropertyin.X)+'x'+inttostr(itempropertyin.Y))  ,Pchar(ErrorCaption),mb_ok+mb_iconwarning);
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
  itemlabel.Hint:=Itemtext+itempropertyin.Name+#13+itemoptionin.lvl+#13
                            +itemoptionin.opt+#13+itemoptionin.dur +#13+itemoptionin.skill
                            +#13+itemoptionin.lucky+#13+itemoptionin.anc+#13+itemoptionin.ExOpt+#13+#13+itemoptionin.ser;
  itemlabel.OnMouseDown:=frmmain.lblmousedown;
  itemlabel.OnClick:=frmmain.lblClick;
  itemlabel.OnMouseMove:=frmmain.lblMouseMove;
  result:=true;
end;

procedure killitem(const itemflag:string); {删除一件物品}
begin
  while getbtnindex(itemflag)<>121 do begin
    (frmmain.Panel2.Controls[getbtnindex(itemflag)] as tspeedbutton).Flat:=false;
    frmmain.Panel2.Controls[getbtnindex(itemflag)].Name:='';
  end;
end;


function warehouseCommit():boolean;  {提交更改}
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

function IsNum(const S:string):boolean; {是否是数字}
begin
  result:=StrToIntDef(S,0)=StrToIntDef(S,1);
end;

function GetItemProp(ID:string;Unique:string;unique2:string):itemproperty;
begin
  with frmmain.itemQuery do begin
       sql.Clear;
       sql.Add('select name,x,y from muitem where id='''+id+''' and unique='+unique+' and unique2='+unique2+'');
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

procedure editlock();  {禁止编辑}
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

procedure editunlock();  {允许编辑}
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

function GetTag(const I:integer):integer ;  {返回卓越属性代码给卓越checkbox的tag}
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


procedure FillHexWS(item:TField); {填充某个账户的仓库}
type Tcharset=set of char;
var A:tcharset;
    itemblock:array of byte;
    sWS,sItem,sUni,Stipo:string;
    wsrow,wscol,i,panelcount:integer;
    itemnow:itemproperty;
    itemoptnow:itemoption;
    u2:string; //unique2
begin
  a:=['0'..'7'];
  with item do begin
      setlength(itemblock,datasize);
      try
      getdata(itemblock);
      {截取仓库的16进制代码}
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

      if panelcount=0 then exit;//仓库里没有物品

      for wsrow:=0 to 14 do
        for wscol:=0 to 7 do
          begin
            sitem:=midstr(sws,160*(wsrow)+20*(wscol)+1,20);
            warehouse[wsrow,wscol]:=sitem;
            if (sitem='FFFFFFFFFFFFFFFFFFFF') or (sitem='FF000000000000000000') or (sitem='00000000000000000000') then sitem:='';
            if sitem<>'' then
              begin
                if sitem[15] in a then suni:='0' else suni:='8';
                if sitem[7]+sitem[8]='F9' then u2:='1' else u2:='0';
                itemnow:=getitemprop(leftstr(sitem,2),suni,u2);
                if itemnow.Name='miss' then
                  begin
                    showmessage(Error2+' '+inttostr(wsrow)+','+inttostr(wscol));
                    continue;
                  end;
                itemoptnow:=getitemoption(sitem[3]+sitem[4],sitem[5]+sitem[6],sitem[15]+sitem[16],sitem[17]+sitem[18]+sitem[19]+sitem[20],sitem[7]+sitem[8]+sitem[9]+sitem[10]+sitem[11]+sitem[12]+sitem[13]+sitem[14],itemnow.name);
                if itemnow.Name='miss' then
                if application.MessageBox(pchar(Error3Part1+' '+sitem+#13+' '+Error3Part2),Pchar(ErrorCaption),mb_yesno+mb_iconwarning)=id_no then
                   continue;
                if intowsgrid(wsrow,wscol,itemnow,itemoptnow)=false then application.MessageBox(pchar(' '+Error4Part1+' '+sitem+#13+' '+Error4Part2+' '+inttostr(wsrow+1)+','+inttostr(wscol+1)),Pchar(ErrorCaption),mb_ok+mb_iconwarning);
              end;
          end;
      except
      on E:exception do application.MessageBox(pchar(e.Message),Pchar(ErrorCaption),mb_ok+mb_iconerror);


      end;
  end;
end;

procedure Typechange(const S:string); {物品大类变更}
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
     itemquery.Close ;
     itemquery.SQL.Clear;
     itemquery.SQL.Add('select name,setnumber from muitem where type='''+s+'''');
     itemquery.Open;
     itemquery.next;
     for i:=1 to itemquery.recordcount-1 do begin
       if (itemquery.Fields[1].asinteger=numordem) and (itemquery.Fields[1].asinteger<>0) then cboitem.itemindex:=i;
       itemquery.next;
     end;
     lblspace.Caption :=itemspc[numordem];
   finally
     itemquery.Close ;
   end;
 end;
end;

//自定义函数结束================================================================

//自定义事件触发================================================================
procedure tfrmmain.lblClick(sender:tobject);
begin
  application.MessageBox (pchar((sender as tpanel).Hint),'Informa玢o',mb_ok+mb_iconinformation);
end;

procedure tfrmmain.cellDblClick(sender:tobject);
begin
  if cbox.Enabled then
    itemadd;
end;




procedure TfrmMain.CheckBox1Click(Sender: TObject);
var
  valor:string;
begin
  if edit1.enabled=true then
    begin
      frmMain.muquery.sql.Clear;
      frmMain.muquery.SQL.Add('select '+itemcount+' from '+gameserverinfo+'');
      frmMain.muquery.Open;
      valor:=inttohex(frmMain.muquery.Fields[0].asinteger+1,8);
      frmMain.muquery.Close;
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
//自定义事件触发结束============================================================

procedure tfrmmain.iniciar;
var i:integer;
  filename : string;
  f : textfile;
  ch : char;
  esc: boolean;
  s:array[1..6] of string;
  g:string;
 caption,cap2:string;
begin
  cboid.items.Clear;
  caption:='XZ7sY697OoJuG7zy7K.xu�7V鏸S';
  for I := 0 to length(caption) do
    begin
      if caption[i]='X' then cap2:=cap2+'CM';
      if caption[i]='Z' then cap2:=cap2+'T';
      if caption[i]='s' then cap2:=cap2+'V';
      if caption[i]='Y' then cap2:=cap2+'a';
      if caption[i]='6' then cap2:=cap2+'ul';
      if caption[i]='9' then cap2:=cap2+'t';
      if caption[i]='O' then cap2:=cap2+'Ed';
      if caption[i]='o' then cap2:=cap2+'i';
      if caption[i]='J' then cap2:=cap2+'t';
      if caption[i]='u' then cap2:=cap2+'o';
      if caption[i]='G' then cap2:=cap2+'r';
      if caption[i]='z' then cap2:=cap2+'b';
      if caption[i]='y' then cap2:=cap2+'y';
      if caption[i]='7' then cap2:=cap2+' ';
      if caption[i]='K' then cap2:=cap2+'U';
      if caption[i]='�' then cap2:=cap2+'n';
      if caption[i]='�' then cap2:=cap2+'1.';
      if caption[i]='i' then cap2:=cap2+'1a';
      if caption[i]='.' then cap2:=cap2+'nn';
      if caption[i]='V' then cap2:=cap2+'[';
      if caption[i]='S' then cap2:=cap2+']';
      if caption[i]='x' then cap2:=cap2+'e';
    end;
  frmmain.caption:=cap2;
  caption:='J hxupkgnkGzygHgLjdt';
  cap2:='';
  for I := 0 to length(caption) do
    begin
      if caption[i]='J' then cap2:=cap2+'C';
      if caption[i]=' ' then cap2:=cap2+'MT ';
      if caption[i]='g' then cap2:=cap2+' ';
      if caption[i]='h' then cap2:=cap2+'V';
      if caption[i]='x' then cap2:=cap2+'a';
      if caption[i]='u' then cap2:=cap2+'u';
      if caption[i]='k' then cap2:=cap2+'t';
      if caption[i]='p' then cap2:=cap2+'l';
      if caption[i]='H' then cap2:=cap2+'by';
      if caption[i]='n' then cap2:=cap2+'Edi';
      if caption[i]='G' then cap2:=cap2+'t';
      if caption[i]='z' then cap2:=cap2+'o';
      if caption[i]='y' then cap2:=cap2+'r';
      if caption[i]='L' then cap2:=cap2+'Un';
      if caption[i]='j' then cap2:=cap2+'n';
      if caption[i]='d' then cap2:=cap2+'e';
      if caption[i]='t' then cap2:=cap2+'on';
    end;
  statusbar1.Panels[1].Text:=cap2;
  frmsd.Caption:=cap2;
  caption:='1qtyxupuozvb';
  cap2:='';
  for I := 0 to length(caption) do
    begin
      if caption[i]='1' then cap2:=cap2+'P';
      if caption[i]='q' then cap2:=cap2+'r';
      if caption[i]='t' then cap2:=cap2+'og';
      if caption[i]='y' then cap2:=cap2+'ra';
      if caption[i]='x' then cap2:=cap2+'m';
      if caption[i]='u' then cap2:=cap2+' ';
      if caption[i]='p' then cap2:=cap2+'by ';
      if caption[i]='o' then cap2:=cap2+'U';
      if caption[i]='z' then cap2:=cap2+'n';
      if caption[i]='v' then cap2:=cap2+'e';
      if caption[i]='b' then cap2:=cap2+'on';
    end;
  form3.label3.caption:=cap2;
  caption:='1qtyxupuozvb';
  cap2:='';
  for I := 0 to length(caption) do
    begin
      if caption[i]='1' then cap2:=cap2+'Lo';
      if caption[i]='q' then cap2:=cap2+'ad';
      if caption[i]='t' then cap2:=cap2+'i';
      if caption[i]='y' then cap2:=cap2+'n';
      if caption[i]='x' then cap2:=cap2+'g';
      if caption[i]='u' then cap2:=cap2+' ';
      if caption[i]='p' then cap2:=cap2+'by';
      if caption[i]='o' then cap2:=cap2+'S';
      if caption[i]='z' then cap2:=cap2+'tr';
      if caption[i]='v' then cap2:=cap2+'ik';
      if caption[i]='b' then cap2:=cap2+'er';
    end;
  form3.label5.caption:=cap2;
  caption:='QergomybHI鏫';
  cap2:='';
  for I := 0 to length(caption) do
    begin
      if caption[i]='Q' then cap2:=cap2+'V';
      if caption[i]='e' then cap2:=cap2+'a';
      if caption[i]='r' then cap2:=cap2+'u';
      if caption[i]='g' then cap2:=cap2+'l';
      if caption[i]='o' then cap2:=cap2+'t';
      if caption[i]='m' then cap2:=cap2+'';
      if caption[i]='y' then cap2:=cap2+' ';
      if caption[i]='b' then cap2:=cap2+'E';
      if caption[i]='H' then cap2:=cap2+'d';
      if caption[i]='I' then cap2:=cap2+'it';
      if caption[i]='�' then cap2:=cap2+'o';
      if caption[i]='\' then cap2:=cap2+'r';
    end;
  form3.label1.caption:=cap2;
  programname:=cap2;
  numordem:=0;
  additem2b:=true;
  initws;
  editlock;
  muquery.ConnectionString:='Provider=MSDASQL.1;Password='+mupwd+';Persist Security Info=True;User ID='+muid+';Data Source='+mudsn+';Initial Catalog='+catalog;
  cmtdb.ConnectionString:=muquery.ConnectionString;
  itemquery.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(Application.ExeName)+'muitem.mdb'+';Mode=ReadWrite;Persist Security Info=False';
  frmmain.caption:=frmmain.caption+' ('+vs+')';
  if (vs='WZ') or (vs='CMT') or (vs='DT') then vs:='CMT';
  muquery.close;
  muquery.sql.clear;
  muquery.SQL.Add('select '+AccountID+','+Money+' from '+warehouses+'');
  muquery.Open;
  if (muquery.Eof) and (muquery.Bof) then
     application.MessageBox('N鉶 foi possivel encontrar nenhuma account no server'+#13+'Contate o admin do server','Erro',mb_iconwarning)
    else
      begin
        for i:=0 to muquery.RecordCount-1 do
          begin
            cboid.Items.Add(muquery.Fields[0].asstring);
            muquery.Next;
          end;
      end;
  muquery.Close;
  itemquery.close;
  itemquery.sql.clear;
  itemquery.SQL.Add('select distinct type from muitem');
  itemquery.Open;
  while not itemquery.Eof do begin
    cbotype.Items.Add(itemquery.Fields[0].asstring);
    itemquery.Next;
  end;
  itemquery.Close;
  cbotype.ItemIndex:=0;
   typechange(cbotype.Text );
  //Unique2
  edit1.Text:='00000000';
  edit1.MaxLength:=8;

  if vs='CMT' then
    begin
      combobox1.Visible:=true;
      combobox1.Items.Clear;
      combobox1.Items.add(Ancientnormal);
      combobox1.Items.add(Ancient5);
      combobox1.Items.add(Ancient10);
      combobox1.ItemIndex:=0;
    end
      else
        begin
          combobox1.Visible:=true;
          combobox1.Items.Clear;
          combobox1.Items.add(Ancientnormal);
          combobox1.Items.add(ancienttext);
          combobox1.ItemIndex:=0;
        end;
  label1.Caption:=accounttext;
  label2.Caption:=zentext;

  label4.Caption:=typetext;
  label17.Caption:=itemtext;
  label14.Caption:=Leveltext;
  label5.Caption:=optiontext;
  label6.Caption:=durationtext;
  label13.Caption:=serialtext;
  jn.Caption:=skilltext;
  xy.Caption:=lucktext;
  label8.Caption:=ancient3;
  checkbox1.Caption:=autoserialtext;
  checkbox2.Caption:=ancienttext;

  zy1.Caption:=wemode1;
  zy2.Caption:=wemode2;
  zy3.Caption:=wemode3;
  zy4.Caption:=wemode4;
  zy5.Caption:=wemode5;
  zy6.Caption:=wemode6;

  label16.Caption:=itemsizetext;
  label15.caption:=vaultpostext;
  btnin.Caption:=itemaddtext;
  btnsave.Caption:=vaultedittext;
  bitbtn1.Caption:=vaultcleartext;
  btnhelp.Caption:=mdbedittext;
  btnexit.Caption:=closetext;
  bitbtn6.Caption:=creditstext;
  cbsql.Caption:=seequerytext;
  checkbox3.Caption:=copyquerytext;
  bitbtn2.Caption:=editcmtedit;

  groupbox1.Caption:=excopts;
  n1.Caption:=information;
  n3.caption:=deletetext;
  //langend
  frmmain.Update;
  cap2:=ParamStr(1);
  if (cap2<>'') and (cap2[1]='$') then
  begin
    g:='';
    for i:=2 to length(cap2) do
      g:=g+cap2[i];
    for i:=0 to cboid.Items.Count-1 do
      if cboid.Items[i]=g then
      begin
        cboid.ItemIndex:=i;
        frmmain.cboIDclick(cboid);
        lerexc;
      end;
  end;
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
   with (sender as Tcheckbox) do
     if (name<>'jn') and (name<>'xy') then
       if checked then tag:=gettag(strtoint(name[3])) else tag:=0;
end;


procedure TfrmMain.btnSaveClick(Sender: TObject);
begin
  if application.MessageBox(pchar(Question1),pchar(programname),mb_yesno+mb_iconquestion)=id_no then exit;
  if not(isnum(edtzen.Text )) then
    begin
      application.MessageBox(pchar(Error5),Pchar(ErrorCaption),mb_iconerror);
      exit;
    end;
  if warehousecommit then application.MessageBox(pchar(Confirm1),pchar(programname),mb_ok+mb_iconinformation) else
  application.MessageBox(pchar(Error6),Pchar(ErrorCaption),mb_ok+mb_iconwarning);
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
var i,t:integer;
begin
 if application.MessageBox(pchar(Question2),pchar(programname),mb_yesno+mb_iconwarning)=idno then exit;
 for i:=0 to 14 do
     for t:=0 to 7 do
         warehouse[i,t]:='FFFFFFFFFFFFFFFFFFFF';
 resetws;
end;





procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
 cfgform.iniciar;
 configtype:='using';
 cfgform.Button4.Visible:=false;
 cfgform.showmodal;
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
  application.MessageBox (pchar(panel2.Controls[i].Hint),Pchar(Info),mb_ok+mb_iconinformation);
end;

procedure TfrmMain.N3Click(Sender: TObject);
var i,t:integer;
begin
  if application.MessageBox(pchar(Question3),pchar(Question3caption),mb_yesno+mb_iconquestion)=id_no then exit;
  {清除文本标签}
  i:=getlblindex('L'+currentitem);
  frmmain.Panel2.Controls[i].Free;
  {从warehouse数组中删除物品}
  i:=strtoint(leftstr(currentitem,2));
  t:=strtoint(rightstr(currentitem,2));
  warehouse[i,t]:='FFFFFFFFFFFFFFFFFFFF';
  {释放仓库空间}
  killitem(currentitem);
end;

procedure TfrmMain.cboTypeChange(Sender: TObject);
var setnumber,i:integer;
nome:string;
begin
  typechange(cbotype.Text );
  itemquery.SQL.Clear;
  itemquery.SQL.Add('select name,setnumber from muitem where type='''+cbotype.text+'''');
  itemquery.Open;
  for i:=1 to itemquery.recordcount-1 do
    begin
      if (itemquery.Fields[1].asinteger=numordem) and (itemquery.Fields[1].asinteger<>0) then cboitem.text:=itemquery.Fields[0].asstring;
      itemquery.next;
    end;
  itemquery.Close ;
  lerexc;
end;

procedure TfrmMain.btnINClick(Sender: TObject);
begin
  itemadd;
end;

procedure tfrmmain.itemadd;
var sthisitem,smain,sopt,sdur,spos15,ancient,sex:string;
    ixy,izj,i,j:integer;
    insProp:itemproperty;
    insOpt:itemoption;
    lvlaff:byte;
    valor:string;
    tipo:boolean;
    poseqp:byte;
    u2serial:string;
begin
   if trim(cbotype.Text)='' then begin
      application.MessageBox(pchar(Error7),Pchar(ErrorCaption),mb_ok+mb_iconwarning);
      exit;
   end;
   if checkbox1.Checked then
     begin
       frmmain.muquery.sql.Clear;
       frmmain.muquery.sql.add('Update '+gameserverinfo+' set '+itemcount+'='+itemcount+'+1');
       frmmain.muquery.Execsql;
       frmmain.muquery.sql.Clear;
       frmmain.muquery.SQL.Add('select '+itemcount+' from '+gameserverinfo+'');
       frmmain.muquery.Open;
       for i:=0 to frmmain.muquery.RecordCount-1 do
       begin
         valor:=inttohex(frmmain.muquery.Fields[0].asinteger,8);
         frmmain.muquery.Next;
       end;
       frmmain.muquery.Close;
     end
       else begin
           if (length(edit1.text)<8) then begin
             i:=8-length(edit1.text);
             for j := 1 to i do
               edit1.text:='0'+edit1.text;
           end;
           valor:=edit1.text;
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
      if combobox1.ItemIndex=1 then ancient:='09'+inttostr(random(10))+inttostr(random(10)) else  ancient:='80'+inttostr(random(10))+inttostr(random(10)) ;
    end;
   if ((vs)='MX') then
    begin
      if tipo=true then
        if combobox1.ItemIndex=1 then ancient:='0085' else  ancient:='0080'
          else if combobox1.ItemIndex=1 then ancient:='0005' else  ancient:='0000'
    end;
   if vs='CMT' then
     begin
       if tipo=true then u2serial:=inttohex(hextoint('F9')+strtoint(valor[1]+valor[2]),2)
         else u2serial:=inttohex(hextoint('00')+strtoint(valor[1]+valor[2]),2);
       for I := 3 to length(valor) do
         u2serial:=u2serial+valor[i];
       if combobox1.ItemIndex=0 then ancient:='0000' ;
       if combobox1.ItemIndex=1 then ancient:=ancientnum5+'00' ;
 //      if combobox1.ItemIndex=1 then ancient:=ancientnum6+'00' ;
       if combobox1.ItemIndex=2 then ancient:=ancientnum10+'00' ;
   //    if combobox1.ItemIndex=2 then ancient:=ancientnum11+'00' ;
     end
       else u2serial:=valor;
   if (vs<>'MG') and (vs<>'MX') and (vs<>'CMT')  then ancient:='80'+inttostr(random(10))+inttostr(random(10)) ;

   if trackbar1.position>=4 then
   begin
    izj:=trackbar1.position-4;
    if spos15='0' then spos15:='4' else spos15:='C';
   end
     else izj:=trackbar1.Position;
     
   lvlaff:=trackbar2.Position;
   sopt:=inttohex(128*abs(strtoint(booltostr(jn.checked)))+ixy+izj+8*lvlaff,2);
   sdur:=inttohex(strtoint(edtdur.text) ,2);
   sex:=inttohex(zy1.Tag+zy2.Tag+zy3.Tag+zy4.Tag+zy5.Tag+zy6.Tag,2);
   if sex[1]='0' then sex:=sex[2];
   if length(sex)=2 then begin
      spos15:=getpos15(spos15,sex[1]);
      sex:=sex[2];

   end;

   insopt:=getitemoption(sopt,sdur,spos15+sex,ancient,u2serial,cboitem.Text);
   sthisitem:=smain+sopt+sdur+u2serial+spos15+sex+ancient;
   if length(sthisitem)<20 then
     for i := length(sthisitem)+1 to 20 do
       if i>=3 then sthisitem:=sthisitem+'0'
         else sthisitem:=sthisitem+'F';
   sthisitem:=smain+sopt+sdur+u2serial+spos15+sex+ancient;
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
    if (muquery.Eof) and (muquery.Bof) then
      begin
        application.MessageBox(pchar(Error10),Pchar(ErrorCaption),mb_ok+mb_iconerror);
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
  form3.Caption:=creditstext;
  form3.Label2.Caption:=OtherFiles;
  form3.Label4.Caption:=translate;
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
var i,x,z:byte;
begin
  z:=8;
  i:=z-length(edit1.text);
  if i>0 then
    for x:=1 to i do
      edit1.text:='0'+edit1.text;
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
  if cbox.Enabled then
    itemadd;
end;




procedure tfrmmain.cellClick(sender:tobject);
var sHint:string;
begin
  if cbox.Enabled then
    begin
      shint:=(sender as tspeedbutton).Hint ;
      cbox.ItemIndex:=strtoint(leftstr(shint,2))-1;
      cboy.ItemIndex:=strtoint(rightstr(shint,2))-1;
      if (cbox.ItemIndex=cbox2) and (cboy.itemindex=cboy2) then
        itemadd;
      cbox2:=cbox.itemindex;
      cboy2:=cboy.itemindex;
    end;
end;

procedure tfrmmain.lerexc;
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
      zy1.Caption:=wemode1;
      zy2.Caption:=wemode2;
      zy3.Caption:=wemode3;
      zy4.Caption:=wemode4;
      zy5.Caption:=wemode5;
      zy6.Caption:=wemode6;
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
            zy1.Caption:=anymode;
            zy2.Caption:=anymode;
            zy3.Caption:=anymode;
            zy4.Caption:=anymode;
            zy5.Caption:=anymode;
            zy6.Caption:=anymode;
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
                  zy1.Caption:=armode1;
                  zy2.Caption:=armode2;
                  zy3.Caption:=armode3;
                  zy4.Caption:=armode4;
                  zy5.Caption:=armode5;
                  zy6.Caption:=armode6;
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
                        zy1.Caption:=fenmode1;
                        zy2.Caption:=fenmode2;
                        zy3.Caption:=fenmode3;
                        zy4.Caption:=fenmode4;
                        zy5.Caption:=fenmode5;
                        zy6.Caption:=fenmode6;
                        zy1.Enabled:=true;
                        zy2.Enabled:=true;
                        zy3.Enabled:=false;
                        zy4.Enabled:=false;
                        zy5.Enabled:=false;
                        zy6.Enabled:=false;
                      end
                        else if exctype='wi' then
                          begin
                            zy1.Caption:=wimode1;
                            zy2.Caption:=wimode2;
                            zy3.Caption:=wimode3;
                            zy4.Caption:=wimode4;
                            zy5.Caption:=wimode5;
                            zy6.Caption:=anymode;
                            zy1.Enabled:=true;
                            zy2.Enabled:=true;
                            zy3.Enabled:=true;
                            zy4.Enabled:=true;
                            zy5.Enabled:=true;
                            zy6.Enabled:=false;
                          end
                            else
                              begin
                                zy1.Caption:=ormode1;
                                zy2.Caption:=ormode2;
                                zy3.Caption:=ormode3;
                                zy4.Caption:=ormode4;
                                zy5.Caption:=ormode5;
                                zy6.Caption:=ormode6;
                                zy1.Enabled:=true;
                                zy2.Enabled:=true;
                                zy3.Enabled:=true;
                                zy4.Enabled:=true;
                                zy5.Enabled:=true;
                                zy6.Enabled:=true;
                             end;
end;

procedure TfrmMain.cboIDChange(Sender: TObject);
begin
  lerexc;
end;

procedure TfrmMain.BitBtn7Click(Sender: TObject);
begin
  form3.showmodal;
end;

end.




