unit UGestorBanco;

interface

type
  TGestorBanco = class
  private
    FLink: string;
  public
    procedure ConectarBanco(const Banco: string);
    procedure InserirBanco(const DataI, DataF: TDateTime; Link: string);
    procedure ConsultarBanco;
  end;

implementation

procedure TGestorBanco.ConectarBanco(const Banco: string);
begin
  // Conectar banco
end;

procedure TGestorBanco.InserirBanco(const DataI, DataF: TDateTime; Link: string);
begin
  // Inserir no banco
end;

procedure TGestorBanco.ConsultarBanco;
begin
  // Consultar dados banco
end;

end.
