unit uModel.Mensagem;

interface

type
  TModelMensagem = class
  private
    Fstatus: string;
    Fchamada: string;
    Fparametros: TArray<string>;
  public
    constructor Create(const Astatus: string); overload;
    constructor Create(const Astatus: string; var AParametros: TArray<string>); overload;
    constructor Create(var AParametros: TArray<string>; const Achamada: string); overload;
    property status: string read Fstatus write Fstatus;
    property chamada: string read Fchamada write Fchamada;
    property parametros: TArray<string> read Fparametros write Fparametros;
  end;

implementation

{ TModelMensagem }

constructor TModelMensagem.Create(const Astatus: string);
begin
  Fstatus := Astatus;
  Fchamada := '';
  Fparametros := [];
end;

constructor TModelMensagem.Create(const Astatus: string; var AParametros: TArray<string>);
begin
  Fstatus := Astatus;
  Fchamada := '';
  Fparametros := AParametros;
end;

constructor TModelMensagem.Create(var AParametros: TArray<string>; const Achamada: string);
begin
  Fparametros := AParametros;
  Fchamada := Achamada;
end;

end.
