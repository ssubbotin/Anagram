object MainForm: TMainForm
  Left = 244
  Top = 406
  Width = 592
  Height = 289
  Caption = #1040#1085#1072#1075#1088#1072#1084#1084#1072'-42 rel.07'
  Color = clBtnFace
  Constraints.MinHeight = 289
  Constraints.MinWidth = 592
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Grid: TStringGrid
    Left = 0
    Top = 137
    Width = 584
    Height = 106
    Align = alClient
    ColCount = 2
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    PopupMenu = RightClickMenu
    TabOrder = 0
    ColWidths = (
      302
      85)
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 137
    Align = alTop
    TabOrder = 1
    DesignSize = (
      584
      137)
    object lblAna: TLabel
      Left = 16
      Top = 56
      Width = 68
      Height = 13
      Caption = #1040#1085#1072#1075#1088#1072#1084#1084#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGo: TSpeedButton
      Left = 248
      Top = 48
      Width = 105
      Height = 22
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnGoClick
    end
    object lblErr: TLabel
      Left = 376
      Top = 56
      Width = 138
      Height = 13
      Caption = #1044#1086#1087#1091#1089#1090#1080#1084#1086#1077' '#1095#1080#1089#1083#1086' '#1086#1096#1080#1073#1086#1082':'
    end
    object lblDic: TLabel
      Left = 37
      Top = 16
      Width = 47
      Height = 13
      Caption = #1057#1083#1086#1074#1072#1088#1100':'
    end
    object btnDic: TSpeedButton
      Left = 536
      Top = 8
      Width = 23
      Height = 22
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1086#1082#1085#1086' '#1074#1099#1073#1086#1088#1072' '#1089#1083#1086#1074#1072#1088#1103
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDicClick
    end
    object lblSearch: TLabel
      Left = 10
      Top = 112
      Width = 74
      Height = 13
      Caption = #1055#1086#1080#1089#1082' '#1089#1083#1086#1074#1072':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnSearch: TSpeedButton
      Left = 248
      Top = 104
      Width = 105
      Height = 22
      Caption = #1053#1072#1081#1090#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnSearchClick
    end
    object Bevel1: TBevel
      Left = 10
      Top = 95
      Width = 572
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object Bevel2: TBevel
      Left = 10
      Top = 39
      Width = 572
      Height = 2
      Anchors = [akLeft, akTop, akRight]
    end
    object lblLegend: TLabel
      Left = 376
      Top = 104
      Width = 199
      Height = 26
      Caption = '? - '#1086#1076#1080#1085' '#1083#1102#1073#1086#1081' '#1089#1080#1084#1074#1086#1083#13#10'* - '#1083#1102#1073#1086#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1083#1102#1073#1099#1093' '#1089#1080#1084#1074#1086#1083#1086#1074
    end
    object edAna: TEdit
      Left = 88
      Top = 48
      Width = 161
      Height = 21
      BiDiMode = bdLeftToRight
      CharCase = ecUpperCase
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Text = #1054#1042#1040#1051#1071#1054#1057#1044#1041#1056#1040
      OnKeyUp = edAnaKeyUp
    end
    object edErr: TSpinEdit
      Left = 520
      Top = 48
      Width = 41
      Height = 22
      MaxValue = 10
      MinValue = 0
      TabOrder = 1
      Value = 2
    end
    object edDic: TEdit
      Left = 88
      Top = 8
      Width = 449
      Height = 21
      ReadOnly = True
      TabOrder = 2
      Text = 'litf-win.txt'
    end
    object edSearch: TEdit
      Left = 88
      Top = 104
      Width = 161
      Height = 21
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Text = '????'#1051'?'#1054'???'#1054'?'
      OnKeyUp = edSearchKeyUp
    end
    object chbOnly: TCheckBox
      Left = 88
      Top = 72
      Width = 265
      Height = 17
      Caption = #1058#1086#1083#1100#1082#1086' '#1080#1079' '#1101#1090#1080#1093' '#1073#1091#1082#1074' ('#1087#1086#1080#1089#1082' '#1087#1086#1076#1089#1083#1086#1074')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chbTwo: TCheckBox
      Left = 376
      Top = 72
      Width = 185
      Height = 17
      Caption = #1044#1074#1072' '#1089#1083#1086#1074#1072
      TabOrder = 5
    end
  end
  object pnlWait: TPanel
    Left = 0
    Top = 137
    Width = 584
    Height = 106
    Align = alClient
    BevelOuter = bvNone
    Caption = #1055#1086#1076#1086#1078#1076#1080#1090#1077' '#1087#1086#1078#1072#1083#1091#1081#1089#1090#1072', '#1079#1072#1075#1088#1091#1078#1072#1077#1090#1089#1103' '#1089#1083#1086#1074#1072#1088#1100'.'
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Visible = False
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 243
    Width = 584
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object OpenDialog: TOpenDialog
    Filter = 'All files|*.*|Text files|*.txt'
    InitialDir = '.'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = #1042#1099#1073#1077#1088#1080#1090#1077' '#1092#1072#1081#1083' '#1089#1086' '#1089#1083#1086#1074#1072#1088#1105#1084
    Left = 8
    Top = 240
  end
  object Timer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = TimerTimer
    Left = 40
    Top = 241
  end
  object GoTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = GoTimerTimer
    Left = 72
    Top = 241
  end
  object RightClickMenu: TPopupMenu
    Left = 104
    Top = 241
    object Copy1: TMenuItem
      Caption = '&Copy'
      OnClick = Copy1Click
    end
  end
end
