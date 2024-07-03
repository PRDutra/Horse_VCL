unit uController.Inserir;

interface

uses
  sysUtils, uInterface.Controller, uAbstract.Controller;

type
  TControllerInserir = class(TAbstractController, IInterfaceController)
  public
    function Executar(var AlistaDados: TArray<string>): Boolean; override;
  end;

implementation

uses
  uDados, FireDAC.Comp.Client, Classes, FireDAC.Stan.Param, uDataSetToModelTarefaJson, DB;

{ TControllerInserir }

function TControllerInserir.Executar(var AlistaDados: TArray<string>): Boolean;
var
  consulta: TFDQuery;
begin
  consulta := dmDados.CriarQuery;
  try
    consulta.SQL.Add('select * from tarefas');
    consulta.SQL.Add('where id_tarefa = 0');
    consulta.Open;
    consulta.Append;

    for var item := 0 to consulta.FieldCount - 1 do
      consulta.Fields[item].AsString := AlistaDados[item];

    consulta.Post;

    AlistaDados := TDataSetToModelTarefaJson.Executar(consulta);
    Result := True;
  finally
    consulta.Free;
  end;
end;

initialization
  RegisterClass(TControllerInserir);

end.
