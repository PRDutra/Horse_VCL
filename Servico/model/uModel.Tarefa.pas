unit uModel.Tarefa;

interface

type
  TModelTarefa = class
  private
    Fid_tarefa: Integer;
    Fdescricao: string;
    Fdata: TDate;
    Fhora: TTime;
    Fstatus: string;
  public
    constructor Create(Aid_tarefa: Integer; Adescricao: string; Adata: TDate; Ahora: TTime; Astatus: string);
    property id_tarefa: Integer read Fid_tarefa write Fid_tarefa;
    property descricao: string read Fdescricao write Fdescricao;
    property data: TDate read Fdata write Fdata;
    property hora: TTime read Fhora write Fhora;
    property status: string read Fstatus write Fstatus;
  end;

  TModelTarefas = TArray<TModelTarefa>;

implementation

{ TModelTarefa }

constructor TModelTarefa.Create(Aid_tarefa: Integer; Adescricao: string; Adata: TDate; Ahora: TTime; Astatus: string);
begin
  Fid_tarefa := Aid_tarefa;
  Fdescricao := Adescricao;
  Fdata := Adata;
  Fhora := Ahora;
  Fstatus := Astatus;
end;

end.
