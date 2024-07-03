unit uDataSetToModelTarefaJson;

interface

uses
  DB;

type
  TDataSetToModelTarefaJson = class
  public
    class function Executar(AConsulta: TDataSet): TArray<string>;
  end;

implementation

uses
  REST.Json, uModel.Tarefa;

{ TDataSetToModelTarefaJson }

class function TDataSetToModelTarefaJson.Executar(AConsulta: TDataSet): TArray<string>;
begin
  SetLength(Result, AConsulta.RecordCount);

  while not AConsulta.Eof do
  begin
     Result[AConsulta.RecNo - 1] :=
       TJson.ObjectToJsonString(
         TModelTarefa.Create(
           AConsulta.FieldByName('id_tarefa').AsInteger,
           AConsulta.FieldByName('descricao').AsString,
           Trunc(AConsulta.FieldByName('data').AsDateTime),
           Frac(AConsulta.FieldByName('hora').AsDateTime),
           AConsulta.FieldByName('status').AsString
       ));
    AConsulta.Next;
  end;
end;

end.
