unit uEngine_Horse;

interface

type
  TEngineHorse = class
  public
    destructor Destroy; override;
    procedure Iniciar;
    procedure Terminar;
  end;

implementation

uses
  Horse, Horse.Jhonson, System.JSON, uModel.Mensagem,
  SysUtils, REST.Json, Classes, uInterface.Controller, uAbstract.Controller;

{ TEngineHorse }

destructor TEngineHorse.Destroy;
begin
  Terminar;
  inherited;
end;

procedure TEngineHorse.Iniciar;
begin
  if THorse.IsRunning then
    Exit;

  THorse.Use(Jhonson);

  THorse.Post('/tarefa',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      jsonObject: TJSONObject;
    begin
      try
        jsonObject := Req.Body<TJSONObject>;

        var dadosMensagem := TJson.JsonToObject<TModelMensagem>(jsonObject.ToJson);
        var classInfo := GetClass('TController' + dadosMensagem.chamada);
        var parametros := dadosMensagem.parametros;
        var objeto : IInterfaceController := TAbstractController(classInfo.Create);

        if objeto.Executar(parametros) then
          Res.Send(TJson.ObjectToJsonObject(TModelMensagem.Create('ok', parametros)))
        else
          Res.Send(TJson.ObjectToJsonObject(TModelMensagem.Create('no', parametros)));
      except
        on e: exception do
          Res.Send(TJson.ObjectToJsonObject(TModelMensagem.Create('Erro: ' + e.Message)));
      end
    end
  );

  THorse.Listen(9000);
end;

procedure TEngineHorse.Terminar;
begin
  if THorse.IsRunning then
    THorse.StopListen;
end;

end.
