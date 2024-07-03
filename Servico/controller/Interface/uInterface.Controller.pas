unit uInterface.Controller;

interface

uses
  Classes;

type
  IInterfaceController = interface
  ['{2E03BDB8-13C3-479D-9D16-E7BF24996D99}']
  function Executar(var AlistaDados: TArray<string>): Boolean;
  end;

implementation

end.
