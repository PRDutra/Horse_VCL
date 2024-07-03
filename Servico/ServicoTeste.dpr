program ServicoTeste;

uses
  Vcl.SvcMgr,
  uController.Consultar in 'controller\uController.Consultar.pas',
  uController.Editar in 'controller\uController.Editar.pas',
  uController.Excluir in 'controller\uController.Excluir.pas',
  uController.Inserir in 'controller\uController.Inserir.pas',
  uAbstract.Controller in 'controller\Abstract\uAbstract.Controller.pas',
  uInterface.Controller in 'controller\Interface\uInterface.Controller.pas',
  uEngine_Horse in 'Engine\uEngine_Horse.pas',
  uModel.Mensagem in 'model\uModel.Mensagem.pas',
  uModel.Tarefa in 'model\uModel.Tarefa.pas',
  uDataSetToModelTarefaJson in 'util\uDataSetToModelTarefaJson.pas',
  MainServico in 'MainServico.pas' {Service3: TService},
  uDados in 'uDados.pas' {dmDados: TDataModule};

{$R *.RES}

begin
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TdmDados, dmDados);
  Application.CreateForm(TService3, Service3);
  Application.Run;
end.
