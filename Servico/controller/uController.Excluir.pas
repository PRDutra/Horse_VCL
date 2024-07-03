unit uController.Excluir;

interface

uses
  sysUtils, uInterface.Controller, uAbstract.Controller;

type
  TControllerExcluir = class(TAbstractController, IInterfaceController)
  public
    function Executar(var AlistaDados: TArray<string>): Boolean; override;
  end;

implementation

uses
  uDados, FireDAC.Comp.Client, Classes, FireDAC.Stan.Param, uDataSetToModelTarefaJson;

{ TControllerExcluir }

function TControllerExcluir.Executar(var AlistaDados: TArray<string>): Boolean;
var
  consulta: TFDQuery;
begin
  consulta := dmDados.CriarQuery;
  try
    consulta.SQL.Add('delete from tarefas');
    consulta.SQL.Add('where id_tarefa = :id_tarefa');
    consulta.ParamByName('id_tarefa').AsString := AlistaDados[0];
    consulta.ExecSQL;
    Result := consulta.RowsAffected > 0;
  finally
    consulta.Free;
  end;
end;

initialization
  RegisterClass(TControllerExcluir);

end.
