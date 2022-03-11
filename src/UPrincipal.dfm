object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 170
  ClientWidth = 536
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object LLink: TLabel
    Left = 24
    Top = 21
    Width = 68
    Height = 13
    Caption = 'Link Download'
  end
  object EUrlDownload: TEdit
    Left = 24
    Top = 40
    Width = 489
    Height = 21
    TabOrder = 0
    Text = 
      'https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363e' +
      'b56d2835f9903a/VSCodeUserSetup-x64-1.43.0.exe'
  end
  object BIniciar: TButton
    Left = 24
    Top = 120
    Width = 100
    Height = 25
    Caption = 'Iniciar Download'
    TabOrder = 1
    OnClick = BIniciarClick
  end
  object BParar: TButton
    Left = 133
    Top = 120
    Width = 100
    Height = 25
    Caption = 'Parar Download'
    TabOrder = 2
    OnClick = BPararClick
  end
  object BExibirMsg: TButton
    Left = 243
    Top = 120
    Width = 100
    Height = 25
    Caption = 'Exibir Mensagem'
    TabOrder = 3
    OnClick = BExibirMsgClick
  end
  object BExibirHistorico: TButton
    Left = 352
    Top = 120
    Width = 161
    Height = 25
    Caption = 'Exibir Hist'#243'rico de Downloads'
    TabOrder = 4
    OnClick = BExibirHistoricoClick
  end
  object BarraProgresso: TProgressBar
    Left = 24
    Top = 81
    Width = 489
    Height = 21
    TabOrder = 5
  end
end
