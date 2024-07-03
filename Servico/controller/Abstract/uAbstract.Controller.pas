unit uAbstract.Controller;

interface

uses
  Classes, uInterface.Controller;

type
  TAbstractController = class(TPersistent, IInterfaceController)
  private
    FRefCount: Integer;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    function Executar(var AlistaDados: TArray<string>): Boolean; virtual; abstract;
  end;

implementation

{ TAbstractController }

function TAbstractController.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TAbstractController._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TAbstractController._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if FRefCount = 0 then
    Destroy;
end;

end.
