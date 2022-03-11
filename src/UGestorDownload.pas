unit UGestorDownload;

interface

uses
  System.Classes, Vcl.Dialogs, System.SysUtils, IdHTTP, IdComponent,
  IdSSLOpenSSL, System.IOUtils, IdURI, Vcl.ComCtrls;

type
  TEncerrarDownload = procedure(const Sucesso: Boolean) of object;
  TIniciarDownload = procedure of object;

  TGestorDownload = class
  private
    FLinkDonwload: string;
    FArquivo: string;
    FProgresso: string;
    FBarraProgresso: TProgressBar;
    FTamanhoArquivo: Int64;
    FThread: TThread;
    FExecutandoDownload: Boolean;
    FSucesso: Boolean;
    FEncerrarDownload: TEncerrarDownload;
    FIniciarDownload: TIniciarDownload;
    procedure IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure TerminarThreadDownload(Sender: TObject);
    procedure ExecutarThreadDownload;
    function SelecionarLocalParaSalvar(const NomeArquivo: string): Boolean;
    function RetornarNomeArquivo(const URL: String): String;
    function TestarThreadEstaExecutando: Boolean;
  public
    destructor Destroy; override;
    procedure IniciarDownload(const URL: string);
    procedure PararDownload;
    property BarraProgresso: TProgressBar read FBarraProgresso
      write FBarraProgresso;
    property Progresso: string read FProgresso;
    property ExecutandoDownload: Boolean read FExecutandoDownload;
    property OnEncerrarDownload: TEncerrarDownload read FEncerrarDownload
      write FEncerrarDownload;
    property OnIniciarDownload: TIniciarDownload read FIniciarDownload
      write FIniciarDownload;
  end;

implementation

uses
  Vcl.FileCtrl, UPrincipal;

destructor TGestorDownload.Destroy;
begin
  if Assigned(FThread) then
  begin
    FThread.Terminate;
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;
end;

procedure TGestorDownload.IdHTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  PercDownload: Double;
begin
  if not TestarThreadEstaExecutando then
  begin
    FExecutandoDownload := False;
    Abort;
  end;

  if Assigned(FBarraProgresso) then
  begin
    BarraProgresso.Position := AWorkCount;
  end;

  PercDownload := (AWorkCount / FTamanhoArquivo) * 100;
  FProgresso := FormatFloat('#,##0.00%', PercDownload);
end;

procedure TGestorDownload.IdHTTPWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  if Assigned(FBarraProgresso) then
  begin
    FBarraProgresso.Position := 0;
    FBarraProgresso.Max := AWorkCountMax
  end;

  FTamanhoArquivo := AWorkCountMax;
end;

procedure TGestorDownload.ExecutarThreadDownload;
var
  DownloadFile: TFileStream;
  IdHTTP: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  FSucesso := True;
  FExecutandoDownload := True;

  DownloadFile := TFileStream.Create(FArquivo, fmCreate);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  IdSSL.SSLOptions.Method := sslvSSLv23;
  IdSSL.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1,
    sslvTLSv1_2];

  IdHTTP := TIdHTTP.Create;
  IdHTTP.IoHandler := IdSSL;
  IdHTTP.OnWork := IdHTTPWork;
  IdHTTP.OnWorkBegin := IdHTTPWorkBegin;
  try
    try
      IdHTTP.Get(FLinkDonwload, DownloadFile);
    except
     on EAbort do begin
       FSucesso := False;
     end;
     on E: Exception do begin
       Showmessage(Format('Erro ao inicar download (%s)', [E.Message]));
       FSucesso := False;
     end;
    end;
  finally
    FreeAndNil(IdHTTP);
    FreeAndNil(IdSSL);
    FreeAndNil(DownloadFile);

    if (not TestarThreadEstaExecutando) and (TFile.Exists(FArquivo)) then
    begin
      TFile.Delete(FArquivo);
    end;
  end;
end;

procedure TGestorDownload.TerminarThreadDownload(Sender: TObject);
begin
  if Assigned(FEncerrarDownload) then
  begin
    FEncerrarDownload(FSucesso);
  end;
  FExecutandoDownload := False;
end;

function TGestorDownload.TestarThreadEstaExecutando: Boolean;
begin
  Result := not FThread.CheckTerminated;
end;

function TGestorDownload.SelecionarLocalParaSalvar(const NomeArquivo
  : string): Boolean;
var
  Diretorio: string;
begin
  Result := SelectDirectory('Selecione Local para Salvar', '', Diretorio);

  if Result then
  begin
    FArquivo := Format('%s\%s', [Diretorio, NomeArquivo]);
  end;
end;

function TGestorDownload.RetornarNomeArquivo(const URL: String): String;
var
  UltimoDelimitador: Integer;
begin
  UltimoDelimitador := LastDelimiter('/', URL);
  Result := Copy(URL, UltimoDelimitador + 1, MaxInt);
  Result := TIdURI.URLDecode(Result);
end;

procedure TGestorDownload.IniciarDownload(const URL: string);
begin
  if URL.Trim = EmptyStr then
  begin
    ShowMessage('Informe o Link de Download');
    Exit;
  end;
  FLinkDonwload := URL.Trim;

  if not SelecionarLocalParaSalvar(RetornarNomeArquivo(FLinkDonwload)) then
  begin
    Exit;
  end;

  if Assigned(FThread) then
  begin
    FThread.WaitFor;
    FreeAndNil(FThread);
  end;

  FTamanhoArquivo := 0;
  FProgresso := EmptyStr;

  FThread := TThread.CreateAnonymousThread(ExecutarThreadDownload);
  FThread.FreeOnTerminate := False;
  FThread.OnTerminate := TerminarThreadDownload;
  FThread.Start;

  if Assigned(FIniciarDownload) then
  begin
    FIniciarDownload;
  end
end;

procedure TGestorDownload.PararDownload;
begin
  if not FExecutandoDownload then
  begin
    Exit;
  end;

  FThread.Terminate;
end;

end.
