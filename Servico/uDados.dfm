object dmDados: TdmDados
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object ConexaoBanco: TFDConnection
    Left = 528
    Top = 176
  end
  object qryConsultas: TFDQuery
    Connection = ConexaoBanco
    Left = 536
    Top = 248
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 304
    Top = 224
  end
end
