object FHistorico: TFHistorico
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rico'
  ClientHeight = 299
  ClientWidth = 875
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    875
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridHist: TDBGrid
    Left = 22
    Top = 24
    Width = 835
    Height = 253
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsLogDownload
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'URL'
        Title.Caption = 'Link'
        Width = 458
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAINICIO'
        Title.Caption = 'Inicio'
        Width = 140
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFIM'
        Title.Caption = 'Fim'
        Width = 140
        Visible = True
      end>
  end
  object dsLogDownload: TDataSource
    DataSet = tbLogDownload
    Left = 208
    Top = 120
  end
  object tbLogDownload: TFDTable
    Left = 296
    Top = 120
  end
end
