unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, REST.Types, Data.Bind.Components, Data.Bind.ObjectScope, REST.Client;

type
  TfmTarefas = class(TForm)
    Button1: TButton;
    DBGrid1: TDBGrid;
    dsDados: TDataSource;
    qryDados: TFDMemTable;
    DBLabeledEdit1: TDBLabeledEdit;
    qryDadosid_tarefa: TIntegerField;
    qryDadosdescricao: TStringField;
    qryDadosdata: TDateField;
    qryDadoshora: TTimeField;
    qryDadosstatus: TStringField;
    DBLabeledEdit2: TDBLabeledEdit;
    DBLabeledEdit3: TDBLabeledEdit;
    DBLabeledEdit4: TDBLabeledEdit;
    DBLabeledEdit5: TDBLabeledEdit;
    Button2: TButton;
    Button3: TButton;
    RESTClient1: TRESTClient;
    Button4: TButton;
    Button5: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure ConsultarDados;
    procedure CarregarDados(const ADados: TArray<string>);
    procedure LimparDados;
    procedure InserirDados;
    procedure ExcluirItem;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTarefas: TfmTarefas;

implementation

uses
  uModel.Mensagem, REST.Json, uModel.Tarefa, StrUtils;

{$R *.dfm}

procedure TfmTarefas.Button1Click(Sender: TObject);
begin
  qryDados.Cancel;
  Close;
end;

procedure TfmTarefas.Button2Click(Sender: TObject);
begin
  qryDados.Append;
end;

procedure TfmTarefas.Button3Click(Sender: TObject);
begin
  if qryDados.State in dsEditModes then
    InserirDados;
end;

procedure TfmTarefas.CarregarDados(const ADados: TArray<string>);
begin
  qryDados.Close;
  qryDados.Open;
  for var item in ADados do
  begin
    var dado := TJson.JsonToObject<TModelTarefa>(item);
    try
      qryDados.Append;
      qryDadosid_tarefa.AsString := dado.id_tarefa.ToString;
      qryDadosdescricao.AsString := dado.descricao;
      qryDadosdata.AsString := FormatDateTime('dd/mm/yyyy', dado.data);
      qryDadoshora.AsString := FormatDateTime('hh:nn', dado.hora);
      qryDadosstatus.AsString := dado.status;
      qryDados.Post;
    finally
      dado.Free;
    end;
  end;
end;

procedure TfmTarefas.LimparDados;
begin
  qryDados.Close;
  qryDados.Open;
end;

procedure TfmTarefas.ConsultarDados;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONData: string;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTClient.BaseURL := 'http://127.0.0.1:9000';
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmPOST;
    RESTRequest.Resource := 'tarefa';

    var modelMensagem := TModelMensagem.Create([''], 'Consultar');
    try
      JSONData := TJson.ObjectToJsonString(modelMensagem);
    finally
      modelMensagem.Free;
    end;

    RESTRequest.AddBody(JSONData, TRESTContentType.ctAPPLICATION_JSON);

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
    begin
      var dados := TJson.JsonToObject<TModelMensagem>(RESTResponse.Content);
      if dados.status.Equals('ok') then
        CarregarDados(dados.parametros)
      else
        LimparDados;
    end
    else
    begin
      ShowMessage('Erro ao consultar: ' + RESTResponse.StatusText);
      LimparDados;
    end;
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

procedure TfmTarefas.InserirDados;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONData: string;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTClient.BaseURL := 'http://127.0.0.1:9000';
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmPOST;
    RESTRequest.Resource := 'tarefa';

    var parametros : TArray<String>;
    SetLength(parametros, 5);
    parametros[0] := qryDadosid_tarefa.AsString;
    parametros[1] := qryDadosdescricao.AsString;
    parametros[2] := qryDadosdata.AsString;
    parametros[3] := qryDadoshora.AsString;
    parametros[4] := qryDadosstatus.AsString;

    var modelMensagem := TModelMensagem.Create(parametros, ifthen(qryDados.State=dsEdit, 'Editar', 'Inserir'));
    try
      JSONData := TJson.ObjectToJsonString(modelMensagem);
    finally
      modelMensagem.Free;
    end;

    RESTRequest.AddBody(JSONData, TRESTContentType.ctAPPLICATION_JSON);

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
    begin
      var dados := TJson.JsonToObject<TModelMensagem>(RESTResponse.Content);
      if dados.status.Equals('ok') then
        qryDados.Post
      else
        ShowMessage('Não foi possível salvar os dados');
    end
    else
    begin
      ShowMessage('Erro ao consultar: ' + RESTResponse.StatusText);
      LimparDados;
    end;
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

procedure TfmTarefas.ExcluirItem;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONData: string;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  try
    RESTClient.BaseURL := 'http://127.0.0.1:9000';
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmPOST;
    RESTRequest.Resource := 'tarefa';

    var modelMensagem := TModelMensagem.Create([qryDadosid_tarefa.AsString], 'Excluir');
    try
      JSONData := TJson.ObjectToJsonString(modelMensagem);
    finally
      modelMensagem.Free;
    end;

    RESTRequest.AddBody(JSONData, TRESTContentType.ctAPPLICATION_JSON);

    RESTRequest.Execute;

    if RESTResponse.StatusCode = 200 then
    begin
      var dados := TJson.JsonToObject<TModelMensagem>(RESTResponse.Content);
      if dados.status.Equals('ok') then
      begin
        qryDados.Delete;
        ShowMessage('Deletado com sucesso!');
      end
      else
        ShowMessage('Não foi possível deletar o item');
    end
    else
    begin
      ShowMessage('Erro ao consultar: ' + RESTResponse.StatusText);
      LimparDados;
    end;
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

procedure TfmTarefas.Button4Click(Sender: TObject);
begin
  ConsultarDados;
end;

procedure TfmTarefas.Button5Click(Sender: TObject);
begin
  ExcluirItem;
end;

end.
