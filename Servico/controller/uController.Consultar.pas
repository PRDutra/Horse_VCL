unit uController.Consultar;

interface

uses
  sysUtils, uInterface.Controller, uAbstract.Controller;

type
  TControllerConsultar = class(TAbstractController, IInterfaceController)
  public
    function Executar(var AlistaDados: TArray<string>): Boolean; override;
  end;

implementation

uses
  uDados, FireDAC.Comp.Client, Classes, FireDAC.Stan.Param, uDataSetToModelTarefaJson;

{ TControllerConsultar }

function TControllerConsultar.Executar(var AlistaDados: TArray<string>): Boolean;
var
  consulta: TFDQuery;
begin
  consulta := dmDados.CriarQuery;
  try
    consulta.SQL.Add('select * from tarefas');

    if (Length(AlistaDados) = 1)and(not AlistaDados[0].Trim.IsEmpty) then
    begin
      consulta.SQL.Add('where id_tarefa = :id_tarefa');
      consulta.Params[0].AsString := AlistaDados[0];
    end
    else if Length(AlistaDados) > 1 then
      consulta.SQL.Add('where id_tarefa in (' + string.Join(',', AlistaDados) + ')');

    consulta.Open;
    consulta.First;

    AlistaDados := TDataSetToModelTarefaJson.Executar(consulta);
    Result := consulta.RecordCount > 0;
  finally
    consulta.Free;
  end;
end;

initialization
  RegisterClass(TControllerConsultar);

end.
