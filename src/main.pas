unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, Buttons, StdCtrls, ExtCtrls, Grids, ComCtrls, Menus, clipbrd;

type
  myInfo = record
    word: string;
    letters: array[1..101] of byte;
    sum: byte;
  end;
  TMainForm = class(TForm)
    Grid: TStringGrid;
    TopPanel: TPanel;
    edAna: TEdit;
    lblAna: TLabel;
    btnGo: TSpeedButton;
    lblErr: TLabel;
    edErr: TSpinEdit;
    lblDic: TLabel;
    edDic: TEdit;
    btnDic: TSpeedButton;
    OpenDialog: TOpenDialog;
    pnlWait: TPanel;
    Timer: TTimer;
    lblSearch: TLabel;
    edSearch: TEdit;
    btnSearch: TSpeedButton;
    chbOnly: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lblLegend: TLabel;
    chbTwo: TCheckBox;
    GoTimer: TTimer;
    StatusBar: TStatusBar;
    RightClickMenu: TPopupMenu;
    Copy1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnDicClick(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure edAnaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSearchClick(Sender: TObject);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GoTimerTimer(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    myDictionary: array of myInfo;
    procedure ReloadDictionary;
    procedure Anagramma;
    procedure CalculateArray(i: integer);
    procedure ClearArray(i: integer);
    procedure CalcDiff(i: integer; err: byte; alt: boolean);
    function  Podslovo(i: integer): Boolean;
    procedure EnableTopPanel(v: boolean);
    procedure RunReloadDictionaryTimer;
  end;

const
  DICT_LEN: Integer = 100000;
  aSize: Integer = 101;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
  Grid.Cells[0,0] := 'Слово';
  Grid.Cells[1,0] := 'Разница';
  RunReloadDictionaryTimer;
end;

procedure TMainForm.btnDicClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    edDic.Text := OpenDialog.FileName;
    RunReloadDictionaryTimer;
  end;
end;

procedure TMainForm.ReloadDictionary;
var
  fname, s: string;
  i: integer;
  fin: TextFile;
begin
  fname := edDic.Text;
  if FileExists(fname) then begin
    StatusBar.SimpleText := 'Словарь загружается...';
    SetLength(myDictionary, 0); // очистка массива
    SetLength(myDictionary, DICT_LEN);
    AssignFile(fin, fname);
    reset(fin);
    i := 1; // 0 - искомая аннаграмма, не трогаем пока
    while not eof(fin) do begin
      readln(fin, s);
      myDictionary[i].word := uppercase(s);
      CalculateArray(i);
      inc(i);
      if ((i mod DICT_LEN) = 0) then begin
        Application.ProcessMessages;
        Sleep(0);
        SetLength(myDictionary, i+DICT_LEN);
      end;
    end;
    SetLength(myDictionary, i);
    CloseFile(fin);
    StatusBar.SimpleText := 'Загружен словарь из ' + IntToStr(i) + ' слов.';
  end else begin
    MessageBox(Application.Handle, 'Не могу найти файл словаря. Он точно есть?',
               'Караул!!!', MB_OK);
    StatusBar.SimpleText := 'Словарь не загружен.';
  end;
end;

procedure TMainForm.btnGoClick(Sender: TObject);
begin
  EnableTopPanel(False);
  GoTimer.Enabled := True;
end;

procedure TMainForm.CalculateArray(i: integer);
const
//               0        1         2         3         4         5         6          7         8         9        10
//               1234567890123456789012345678901234567890123456789012345678901 2345678901234567890123456789012345678901
  sym: string = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ-&''.,`~!@#$%^*()_+=1234567890<>?/\:;"[]{}|';
var
  j,p: integer;
  s: string;
begin
  s := AnsiUpperCase(myDictionary[i].word);
  for j:=1 to length(s) do begin
    p := pos(s[j], sym);
    if p>0 then
      inc(myDictionary[i].letters[p])
    else
      exit;
  end;
end;

procedure TMainForm.CalcDiff(i: integer; err: byte; alt: boolean);
var
  j,tmp: integer;
  sum: byte;
begin
  sum := 0;
  if alt then begin
    for j:=1 to aSize do begin
      tmp := myDictionary[0].letters[j] - myDictionary[i].letters[j];
      if tmp<0 then begin
        myDictionary[i].sum := 255;
        exit;
      end;
      sum := sum + abs(tmp);
    end;
  end else begin
    for j:=1 to aSize do begin
      sum := sum + abs(myDictionary[0].letters[j] - myDictionary[i].letters[j]);
      if sum>err then begin
        myDictionary[i].sum := 255;
        exit;
      end;
    end;
  end;
  myDictionary[i].sum := sum;
end;

function TMainForm.Podslovo(i: integer): Boolean;
var
  j: integer;
  tmp: integer;
begin
  Podslovo := True;
  for j:=1 to aSize do begin
    tmp := myDictionary[0].letters[j] - myDictionary[i].letters[j];
    if tmp<0 then begin
      Podslovo := False;
      exit;
    end else
      myDictionary[0].letters[j] := tmp;
  end;
end;

procedure TMainForm.ClearArray(i: integer);
var
  j: integer;
begin
  for j:=1 to aSize do myDictionary[i].letters[j] := 0;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  ReloadDictionary;
  pnlWait.Visible := False;
  EnableTopPanel(True);
end;

procedure TMainForm.EnableTopPanel(v: boolean);
begin
  TopPanel.Enabled := v;
  lblAna.Enabled := v;
  lblErr.Enabled := v;
  lblDic.Enabled := v;
  lblSearch.Enabled := v;
  lblLegend.Enabled := v;
  edAna.Enabled := v;
  edErr.Enabled := v;
  edDic.Enabled := v;
  edSearch.Enabled := v;
  btnGo.Enabled := v;
  btnDic.Enabled := v;
  btnSearch.Enabled := v;
  chbOnly.Enabled := v;
  chbTwo.Enabled := v;
end;

procedure TMainForm.RunReloadDictionaryTimer;
begin
  EnableTopPanel(False);
  pnlWait.Visible := True;
  Timer.Enabled := True;
end;

procedure TMainForm.edAnaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then btnGoClick(Sender);
end;

Function MatchPattern(element, pattern:PChar): Boolean;
Begin
  If StrComp(pattern,'*')=0 Then Result := True
  Else If (element^ = Chr(0)) and (pattern^ <> Chr(0)) Then Result:=False
  Else If element^ = Chr(0) Then Result := True
  Else Begin
    Case pattern^ of
    '*': If MatchPattern(element,@pattern[1]) Then
           Result:=True
         Else
           Result:=MatchPattern(@element[1],pattern);
    '?': Result:=MatchPattern(@element[1],@pattern[1]);
    Else If element^=pattern^ Then
           Result:=MatchPattern(@element[1],@pattern[1])
         Else
           Result:=False;
         End;
  End;
End;

Function MatchStrings(source, pattern: string):Boolean;
var
  pSource : Array [0..255] of Char;
  pPattern : Array [0..255] of Char;
Begin
  StrPCopy(pSource,source);
  StrPCopy(pPattern,pattern);
  Result:=MatchPattern(pSource,pPattern);
End;

procedure TMainForm.btnSearchClick(Sender: TObject);
var
  i,j: integer;
  pos: integer;
  mask: string;
begin
  Grid.RowCount := 2;
  grid.Cells[0,1] := '';
  grid.Cells[1,1] := '';
  mask := edSearch.Text;
  j:=0;
  for i:=1 to length(myDictionary)-1 do begin
    if MatchStrings(myDictionary[i].word, mask) then begin
      inc(j);
      pos := Grid.RowCount-1;
      grid.Cells[0,pos] := myDictionary[i].word;
      grid.Cells[1,pos] := '';
      Grid.RowCount := pos + 2;
      if (j>1000) then begin
        grid.Cells[0,Grid.RowCount-1] := 'Показаны только первые 1000 слов.';
        grid.Cells[1,Grid.RowCount-1] := '';
        exit;
      end;
    end;
  end;
  grid.Cells[0,Grid.RowCount-1] := '';
  grid.Cells[1,Grid.RowCount-1] := '';
end;

procedure TMainForm.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then btnSearchClick(Sender);
end;

procedure TMainForm.GoTimerTimer(Sender: TObject);
begin
  GoTimer.Enabled := False;
  if length(myDictionary)>0 then
    Anagramma
  else
    MessageBox(Handle, 'Вы забыли загрузить словарь!', 'ААА!', MB_OK);
  EnableTopPanel(True);
end;

procedure TMainForm.Anagramma;
var
  i,j: integer;
  err: byte;
  pos: integer;
  alt: boolean;
  two: boolean;
  s: string;
begin
  s := StatusBar.SimpleText;
  Grid.RowCount := 2;
  grid.Cells[0,1] := '';
  grid.Cells[1,1] := '';
  alt := chbOnly.Checked;
  two := chbTwo.Checked;
  myDictionary[0].word := edAna.Text;
  ClearArray(0);
  CalculateArray(0);
  err := edErr.Value;
  if not two then begin
    for i:=1 to length(myDictionary)-1 do begin
      CalcDiff(i, err, alt);
      if myDictionary[i].sum<=err then begin
        pos := Grid.RowCount-1;
        grid.Cells[0,pos] := myDictionary[i].word;
        grid.Cells[1,pos] := inttostr(myDictionary[i].sum);
        Grid.RowCount := pos + 2;
      end;
    end;
  end else begin
    for i:=1 to length(myDictionary)-1 do begin
      ClearArray(0);
      CalculateArray(0);
      StatusBar.SimpleText := 'Ведётся поиск подходящих пар слов: ' + IntToStr(round(i*100/length(myDictionary))) + '%';
      Application.ProcessMessages;
      Sleep(0);
      if Podslovo(i) then begin
        for j:=1 to length(myDictionary)-1 do begin
          CalcDiff(j, err, alt);
          if myDictionary[j].sum<=err then begin
            pos := Grid.RowCount-1;
            grid.Cells[0,pos] := myDictionary[i].word + ' ' + myDictionary[j].word;
            grid.Cells[1,pos] := inttostr(myDictionary[j].sum);
            Grid.RowCount := pos + 2;
          end;
        end;
      end;
    end;
  end;
  grid.Cells[0,Grid.RowCount-1] := '';
  grid.Cells[1,Grid.RowCount-1] := '';
  StatusBar.SimpleText := s;
end;

procedure SGCopyToCLP(SG: TStringGrid; CopySel: Boolean; CL: integer = -1;
  RT: integer = -1; CR: integer = -1; RB: integer = -1);
var
  i, j: Integer;
  s: string;
begin
  s := '';
  with SG do
  begin
    if CopySel then
    begin
      CL := Selection.Left;
      CR := Selection.Right;
      RT := Selection.Top;
      RB := Selection.Bottom;
    end;
    //при необходимости FixedRows и FixedCols можно заменить на 0
    if (CL < FixedCols) or (CL > CR) or (CL >= ColCount) then
      CL := FixedCols;
    if (CR < FixedCols) or (CL > CR) or (CR >= ColCount) then
      CR := ColCount - 1;
    if (RT < FixedRows) or (RT > RB) or (RT >= RowCount) then
      RT := FixedRows;
    if (RB < FixedCols) or (RT > RB) or (RB >= RowCount) then
      RB := RowCount - 1;
    for i := RT to RB do
    begin
      for j := CL to CR do
      begin
        s := s + Cells[j, i];
        if j < CR then
          s := s + #9;
      end;
      s := s + #13#10;
  end;
  end;
  ClipBoard.AsText := s;
end;

procedure TMainForm.Copy1Click(Sender: TObject);
begin
  SGCopyToCLP(Grid, True);
end;

end.
