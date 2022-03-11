unit UHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  UGestorBanco, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient;

type
  TFHistorico = class(TForm)
    DBGridHist: TDBGrid;
    dsLogDownload: TDataSource;
    tbLogDownload: TFDTable;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FGestorBanco: TGestorBanco;
  end;

var
  FHistorico: TFHistorico;

implementation

{$R *.dfm}

procedure TFHistorico.FormCreate(Sender: TObject);
begin
  FGestorBanco := TGestorBanco.Create;
  FGestorBanco.ConsultarLogDownload(tbLogDownload);
end;

procedure TFHistorico.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGestorBanco);
end;

end.
