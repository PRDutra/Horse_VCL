object fmTarefas: TfmTarefas
  Left = 0
  Top = 0
  Caption = 'Lista de Tarefas'
  ClientHeight = 397
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Button1: TButton
    Left = 672
    Top = 364
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 756
    Height = 249
    DataSource = dsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id_tarefa'
        Title.Caption = 'C'#243'digo'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descricao'
        Width = 410
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data'
        Title.Caption = 'Data'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'hora'
        Title.Caption = 'Hora'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'status'
        Title.Caption = 'Status'
        Width = 80
        Visible = True
      end>
  end
  object DBLabeledEdit1: TDBLabeledEdit
    Left = 8
    Top = 288
    Width = 81
    Height = 23
    DataField = 'id_tarefa'
    DataSource = dsDados
    TabOrder = 2
    EditLabel.Width = 73
    EditLabel.Height = 15
    EditLabel.Caption = 'C'#243'digo Tarefa'
    EditLabel.Layout = tlCenter
  end
  object DBLabeledEdit2: TDBLabeledEdit
    Left = 95
    Top = 288
    Width = 313
    Height = 23
    DataField = 'descricao'
    DataSource = dsDados
    TabOrder = 3
    EditLabel.Width = 51
    EditLabel.Height = 15
    EditLabel.Caption = 'Descri'#231#227'o'
    EditLabel.Layout = tlCenter
  end
  object DBLabeledEdit3: TDBLabeledEdit
    Left = 414
    Top = 288
    Width = 81
    Height = 23
    DataField = 'data'
    DataSource = dsDados
    TabOrder = 4
    EditLabel.Width = 24
    EditLabel.Height = 15
    EditLabel.Caption = 'Data'
    EditLabel.Layout = tlCenter
  end
  object DBLabeledEdit4: TDBLabeledEdit
    Left = 501
    Top = 288
    Width = 81
    Height = 23
    DataField = 'hora'
    DataSource = dsDados
    TabOrder = 5
    EditLabel.Width = 26
    EditLabel.Height = 15
    EditLabel.Caption = 'Hora'
    EditLabel.Layout = tlCenter
  end
  object DBLabeledEdit5: TDBLabeledEdit
    Left = 588
    Top = 288
    Width = 81
    Height = 23
    DataField = 'status'
    DataSource = dsDados
    TabOrder = 6
    EditLabel.Width = 32
    EditLabel.Height = 15
    EditLabel.Caption = 'Status'
    EditLabel.Layout = tlCenter
  end
  object Button2: TButton
    Left = 507
    Top = 364
    Width = 75
    Height = 25
    Caption = 'Abrir Novo'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 591
    Top = 364
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 364
    Width = 105
    Height = 25
    Caption = 'Consultar Dados'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 426
    Top = 364
    Width = 75
    Height = 25
    Caption = 'Excluir Item'
    TabOrder = 10
    OnClick = Button5Click
  end
  object dsDados: TDataSource
    DataSet = qryDados
    Left = 640
    Top = 136
  end
  object qryDados: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 640
    Top = 176
    object qryDadosid_tarefa: TIntegerField
      FieldName = 'id_tarefa'
    end
    object qryDadosdescricao: TStringField
      FieldName = 'descricao'
      Size = 100
    end
    object qryDadosdata: TDateField
      FieldName = 'data'
    end
    object qryDadoshora: TTimeField
      FieldName = 'hora'
    end
    object qryDadosstatus: TStringField
      FieldName = 'status'
      Size = 10
    end
  end
  object RESTClient1: TRESTClient
    Params = <>
    SynchronizedEvents = False
    Left = 640
    Top = 96
  end
end
