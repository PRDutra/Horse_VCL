program VisualizarTarefas;

uses
  Vcl.Forms,
  main in 'main.pas' {fmTarefas},
  uModel.Tarefa in '..\Servico\model\uModel.Tarefa.pas',
  uModel.Mensagem in '..\Servico\model\uModel.Mensagem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmTarefas, fmTarefas);
  Application.Run;
end.
