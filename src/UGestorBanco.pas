unit UGestorBanco;

interface

uses
  Vcl.Dialogs, System.SysUtils, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.SQLite, Data.DB;

type
  TGestorBanco = class
  private
    FBanco: TFDConnection;
    procedure ConectarBanco;
    procedure ExecutarSQL(const SQL:String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure InserirLogDownload(const Link: string);
    procedure AtualizarDataFinalLogDownload;
    procedure ConsultarLogDownload(var oTabela: TFDTable);
  end;

implementation

const
  INSERT_BANCO = 'INSERT INTO LOGDOWNLOAD (URL,DATAINICIO) VALUES (''%s'', DATETIME("now"))';
  UPDATE_BANCO = 'UPDATE LOGDOWNLOAD SET DATAFIM = DATETIME("now") WHERE CODIGO =(SELECT MAX(CODIGO) FROM LOGDOWNLOAD)';

constructor TGestorBanco.Create;
begin
  FBanco := TFDConnection.Create(nil);
  FBanco.Params.Values['Database'] := GetCurrentDir + '\BD.db';
  FBanco.DriverName := 'sQLite';
end;

destructor TGestorBanco.Destroy;
begin
  inherited;
  FreeAndNil(FBanco);
end;

procedure TGestorBanco.ConectarBanco;
begin
  if FBanco.Connected then
  begin
    Exit;
  end;

  try
    FBanco.Connected := True;
  except
    ShowMessage('Erro ao Conectar ao Banco de Dados!')
  end;
end;

procedure TGestorBanco.ExecutarSQL(const SQL: String);
begin
  FBanco.ExecSQL(SQL);
  FBanco.CommitRetaining;
  FBanco.Connected := False;
end;

procedure TGestorBanco.InserirLogDownload(const Link: string);
begin
  ConectarBanco;
  ExecutarSQL(Format(INSERT_BANCO, [Link]));
end;

procedure TGestorBanco.AtualizarDataFinalLogDownload;
begin
  ConectarBanco;
  ExecutarSQL(UPDATE_BANCO);
end;

procedure TGestorBanco.ConsultarLogDownload(var oTabela: TFDTable);
begin
  ConectarBanco;
  oTabela.TableName := 'LOGDOWNLOAD';
  oTabela.Connection := FBanco;
  oTabela.Open;
end;

end.
