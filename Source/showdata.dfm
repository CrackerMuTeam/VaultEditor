object frmSD: TfrmSD
  Left = 268
  Top = 179
  Caption = 'CMT Vault Editor by Unneon'
  ClientHeight = 428
  ClientWidth = 671
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 671
    Height = 41
    Align = alTop
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 10
      Width = 540
      Height = 25
      DataSource = DataSource1
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 671
    Height = 368
    Align = alClient
    DataSource = DataSource1
    Font.Charset = GB2312_CHARSET
    Font.Color = clBtnText
    Font.Height = -12
    Font.Name = '??'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 409
    Width = 671
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Editando muitem.mdb'
  end
  object ADOTable1: TADOTable
    Left = 624
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = ADOTable1
    Left = 592
    Top = 8
  end
end
