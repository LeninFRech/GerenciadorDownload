unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.FileCtrl,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UGestorDownload;

type
  TFPrincipal = class(TForm)
    EUrlDownload: TEdit;
    LLink: TLabel;
    BIniciar: TButton;
    BParar: TButton;
    BExibirMsg: TButton;
    BExibirHistorico: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BIniciarClick(Sender: TObject);
    procedure BPararClick(Sender: TObject);
    procedure BExibirHistoricoClick(Sender: TObject);
    procedure BExibirMsgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FGestorDownload: TGestorDownload;
  end;

var
  FPrincipal: TFPrincipal;


implementation

uses UHistorico;

{$R *.dfm}

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  FGestorDownload := TGestorDownload.Create;
end;

procedure TFPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FGestorDownload);
end;

procedure TFPrincipal.BExibirHistoricoClick(Sender: TObject);
begin
  if FHistorico = nil then
    Application.CreateForm(tFHistorico, FHistorico);
  FHistorico.showmodal;
end;

procedure TFPrincipal.BExibirMsgClick(Sender: TObject);
begin
  if FGestorDownload.ExecutandoDownload then
  begin
    Application.MessageBox(Pchar(FGestorDownload.Progresso), 'Progresso Download', MB_OK);
  end;
end;

procedure TFPrincipal.BIniciarClick(Sender: TObject);
begin
  FGestorDownload.IniciarDownload(EUrlDownload.Text);
end;

procedure TFPrincipal.BPararClick(Sender: TObject);
begin
  FGestorDownload.PararDownload;
end;

procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not FGestorDownload.ExecutandoDownload then
  begin
    Exit;
  end;

  if MessageDlg('Existe um Download em andamento.  Deseja sair?',
    mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
  begin
    Abort;
  end;

  FGestorDownload.PararDownload;
end;





end.
