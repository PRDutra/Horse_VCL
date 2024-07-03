unit MainServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  uEngine_Horse;

type
  TService3 = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
  private
    FEngineHorse: TEngineHorse;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  Service3: TService3;

implementation

uses
  Horse;

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service3.Controller(CtrlCode);
end;

function TService3.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService3.ServiceCreate(Sender: TObject);
begin
  FEngineHorse := TEngineHorse.Create;
end;

procedure TService3.ServiceDestroy(Sender: TObject);
begin
  FEngineHorse.Free;
end;

procedure TService3.ServiceExecute(Sender: TService);
begin
  while not self.Terminated do
  begin
    ServiceThread.ProcessRequests(true);
    Sleep(1000);
  end;
end;

procedure TService3.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FEngineHorse.Iniciar;
  Started := True;
end;

procedure TService3.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stopped := True;
end;

end.
