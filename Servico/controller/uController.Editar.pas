unit uController.Editar;

interface

uses
  sysUtils, uInterface.Controller, uAbstract.Controller;

type
  TControllerEditar = class(TAbstractController, IInterfaceController)
  public
    function Executar(var AlistaDados: TArray<string>): Boolean; override;
  end;

implementation

uses
  uDados, FireDAC.Comp.Client, Classes, FireDAC.Stan.Param, uDataSetToModelTarefaJson, DB;

{ TControllerEditar }

function TControllerEditar.Executar(var AlistaDados: TArray<string>): Boolean;
var
  consulta: TFDQuery;
begin
  consulta := dmDados.CriarQuery;
  try
    consulta.SQL.Add('select * from tarefas');
    consulta.SQL.Add('where id_tarefa = :id_tarefa');
    consulta.ParamByName('id_tarefa').AsString := AlistaDados[0];
    consulta.Open;

    if consulta.RecordCount = 0 then
      Exit(False);

    consulta.Edit;

    for var item := 1 to consulta.FieldCount - 1 do
      consulta.Fields[item].AsString := AlistaDados[item];

    consulta.Post;

    AlistaDados := TDataSetToModelTarefaJson.Executar(consulta);
    Result := True;
  finally
    consulta.Free;
  end;
end;

initialization
  RegisterClass(TControllerEditar);

end.
