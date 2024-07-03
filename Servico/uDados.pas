unit uDados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

type
  TdmDados = class(TDataModule)
    ConexaoBanco: TFDConnection;
    qryConsultas: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function CriarQuery: TFDQuery;
  end;

var
  dmDados: TdmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TdmDados.CriarQuery: TFDQuery;
begin
  Result := TFDQuery.Create(Self);
  Result.Connection := ConexaoBanco;
end;

procedure TdmDados.DataModuleCreate(Sender: TObject);
begin
  try
    ConexaoBanco.Params.Values['Database' ] := 'Lavanderia';
    ConexaoBanco.Params.Values['User_Name'] := 'root';
    ConexaoBanco.Params.Values['Password' ] := 'x4nd3';
    ConexaoBanco.Params.Values['Server'   ] := 'localhost';
    ConexaoBanco.Params.Values['DriverID' ] := 'MySQL';
    ConexaoBanco.Connected := True;
  except
    on e: exception do
    begin
      var data := TStringList.Create;
      try
        var nomeArquivo := ExtractFilePath(ParamStr(0)) + '\erroservidor.txt';
        data.LoadFromFile(nomeArquivo);
        data.Add(e.Message);
        data.SaveToFile(nomeArquivo);
      finally
        data.Free;
      end;
      raise e;
    end;
  end;
end;

end.
