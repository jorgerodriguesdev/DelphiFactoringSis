unit ABaixaNegocio;

//     Data da Criação: 25/05/2001
//              Função: Adiciona Data de Pagamento e Tipo de Situação aos Doc's
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, BotaoCadastro, Grids, DBGrids, Tabela, DBKeyViolation,
  Componentes1, ComCtrls, ExtCtrls, PainelGradiente, Db, DBTables,
  Localizacao;

type
  TFBaixaNegocio = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label14: TLabel;
    EDocumento: TEditColor;
    Grade: TGridIndice;
    PanelColor3: TPanelColor;
    BotaoFechar1: TBotaoFechar;
    Depositar: TBitBtn;
    Reapresentar: TBitBtn;
    DMovFactori: TDataSource;
    MovFactori: TQuery;
    Tempo: TPainelTempo;
    MovFactoriD_DAT_PAG: TDateField;
    MovFactoriD_DAT_VEN: TDateField;
    MovFactoriI_EMP_FIL: TIntegerField;
    MovFactoriI_NRO_LAN: TIntegerField;
    MovFactoriN_TOT_LIQ: TFloatField;
    MovFactoriN_VLR_DOC: TFloatField;
    MovFactoriI_LAN_FAC: TIntegerField;
    MovFactoriI_EMP_FIL_1: TIntegerField;
    MovFactoriI_EMP_FIL_2: TIntegerField;
    MovFactoriI_LAN_FAC_1: TIntegerField;
    MovFactoriI_LAN_FAC_2: TIntegerField;
    MovFactoriC_NOM_BAN: TStringField;
    MovFactoriI_COD_BAN: TIntegerField;
    Devolver: TBitBtn;
    Renegociar: TBitBtn;
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriN_VLR_JUR: TFloatField;
    MovFactoriN_VLR_CPM: TFloatField;
    MovFactoriN_VLR_PAG: TFloatField;
    Label8: TLabel;
    Localiza: TConsultaPadrao;
    Aux: TQuery;
    Situacao: TComboBoxColor;
    Label1: TLabel;
    Todos: TCheckBox;
    Label11: TLabel;
    Documentos: TComboBoxColor;
    MovFactoriI_COD_CLI: TIntegerField;
    MovFactoriC_NOM_EMI: TStringField;
    Label2: TLabel;
    SpeedLocalizaCliente: TSpeedButton;
    Label4: TLabel;
    SpeedLocalizaBanco: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    LocalizaBanco: TEditLocaliza;
    LocalizaEmitente: TEditLocaliza;
    Datas: TComboBoxColor;
    Data1: TCalendario;
    Data2: TCalendario;
    Label13: TLabel;
    MovFactoriD_DAT_MOV: TDateField;
    MovFactoriI_COD_EMI: TIntegerField;
    PanelColor4: TPanelColor;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EDocumentoExit(Sender: TObject);
    procedure DepositarClick(Sender: TObject);
    procedure ReapresentarClick(Sender: TObject);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure DevolverClick(Sender: TObject);
    procedure RenegociarClick(Sender: TObject);
    procedure LocalizaBancoRetorno(Retorno1, Retorno2: String);
    procedure DocumentosChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Data1CloseUp(Sender: TObject);
  private
    procedure MudaSituacao(Situacao, NomeCampoData : string; Lancamento, NroLan,  CodFilial : integer);
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);
  public
    { Public declarations }
  end;

var
  FBaixaNegocio: TFBaixaNegocio;

implementation
   uses APrincipal, Constantes, funsql, fundata, funobjeto, funnumeros;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFBaixaNegocio.FormCreate(Sender: TObject);
begin
  Data1.DateTime := PrimeiroDiaMes(Date);
  Data2.DateTime := UltimoDiaMes(Date);
  LimpaEdits(PanelColor1);
  Datas.ItemIndex := 0;
  Situacao.ItemIndex := 1;
  Documentos.ItemIndex := 0;
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFBaixaNegocio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 MovFactori.Close;
 Action := CaFree;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFBaixaNegocio.AtualizaConsulta;
begin
  MovFactori.SQL.Clear;
  MovFactori.SQL.Add(' Select Mfc.C_NRO_DOC, Mfc.D_DAT_PAG, Mfc.D_DAT_VEN, ' +
                     '        Mfc.I_NRO_LAN, Mfc.N_TOT_LIQ, Mfc.N_VLR_DOC, Mfc.N_VLR_PAG, ' +
                     '        Mfc.N_VLR_CPM, Mfc.I_EMP_FIL, Mfc.I_LAN_FAC, Mfc.N_VLR_JUR, ' +
                     '        Cfc.I_EMP_FIL, Cfc.I_EMP_FIL, Cfc.I_COD_CLI, Cfc.I_LAN_FAC, ' +
                     '        Cfc.I_LAN_FAC, Cfc.D_DAT_MOV, Emi.C_NOM_EMI, Emi.I_COD_EMI, ' +
                     '        Ban.C_NOM_BAN, Ban.I_COD_BAN  ' +
                     '  From  MovFactori as Mfc,   ' +
                     '        CadFactori as Cfc,   ' +
                     '        CadEmitentes as Emi, ' +
                     '        CadBancos as Ban     ');
  AdicionaFiltros(MovFactori.SQL);
  MovFactori.SQL.Add('        and Cfc.I_EMP_FIL = Mfc.I_EMP_FIL ' +
                     '        and Cfc.I_LAN_FAC = Mfc.I_LAN_FAC ' +
                     '        and Mfc.I_COD_EMI = Emi.I_COD_EMI ' +
                     '        and Mfc.I_COD_BAN = Ban.I_COD_BAN ');
  MovFactori.SQL.Add(' Order  by  Cfc.I_LAN_FAC');
  MovFactori.Open;
  todos.Checked := false;
end;

{ ***************************** Adiciona Filtros ***************************** }
procedure TFBaixaNegocio.AdicionaFiltros (VpaSelect : TStrings);
begin
  VpaSelect.Add(' Where Mfc.I_EMP_FIL = ' + IntToStr (Varia.CodigoEmpFil));

  case Datas.ItemIndex of
    0 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('Mfc.D_DAT_VEN', Data1.Date, Data2.Date, true  ));
    1 : VpaSelect.Add(' ');
  end;

  case Situacao.ItemIndex of
    0 : VpaSelect.Add('');                           //  TODOS
    1 : VpaSelect.Add(' and Mfc.C_SIT_DOC = ''C'''); //  CARTEIRA
    2 : VpaSelect.Add(' and Mfc.C_SIT_DOC = ''D'''); //  DEPOSITADO
    3 : VpaSelect.Add(' and Mfc.C_SIT_DOC = ''R'''); //  REAPRESENTADO
    4 : VpaSelect.Add(' and Mfc.C_SIT_DOC = ''V'''); //  DEVOLVIDO
    5 : VpaSelect.Add(' and Mfc.C_SIT_DOC = ''N'''); //  RENEGOCIADO
    6 : VpaSelect.Add(' and ( Mfc.C_SIT_DOC = ''C'' or  Mfc.C_SIT_DOC = ''D'')' ); //  CARTEIRA + DEPOSITADO
  end;

  case Documentos.ItemIndex of
    0 : VpaSelect.Add('');                           //  TODOS
    1 : VpaSelect.Add(' and Mfc.C_TIP_DOC = ''C'''); //  CHEQUE
    2 : VpaSelect.Add(' and Mfc.C_TIP_DOC = ''D'''); //  DUPLICATA
  end;

  if EDocumento.Text <> '' then
    VpaSelect.Add(' and Mfc.C_NRO_DOC = '''+ EDocumento.Text + '''')
  else
    VpaSelect.Add(' ');

  if LocalizaBanco.Text <> '' then
    VpaSelect.Add(' and Ban.I_COD_BAN = '+ LocalizaBanco.Text)
  else
    VpaSelect.Add(' ');

  if LocalizaEmitente.Text <> '' then
    VpaSelect.Add(' and Emi.I_COD_EMI = '+ LocalizaEmitente.Text)
  else
    VpaSelect.Add(' ');

end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFBaixaNegocio.EDocumentoExit(Sender: TObject);
begin
  AtualizaConsulta;
  Depositar.Enabled := (Situacao.ItemIndex = 1) or (Situacao.ItemIndex = 3);
  Reapresentar.Enabled := Situacao.ItemIndex = 2;
  Devolver.Enabled := Situacao.ItemIndex = 3;
  Renegociar.Enabled := Situacao.ItemIndex = 4;
end;

{ ********************** Muda Situação do Documento ************************** }
procedure TFBaixaNegocio.MudaSituacao(Situacao, NomeCampoData : string; Lancamento, NroLan, CodFilial : integer);
begin
  Tempo.execute('Mudando a Situação do Documento ...');
  Aux.SQL.Clear;
  Aux.SQL.Add(' Update MovFactori ' +
              ' Set C_SIT_DOC = ''' + Situacao + ''',' +
              NomeCampoData + ' = ' + SQLTextoDataAAAAMMMDD(Date) +
              ' where I_EMP_FIL = ' + IntToStr (CodFilial) +
              ' and i_lan_fac = ' + IntToStr(Lancamento) +
              ' and i_nro_lan = ' + IntToStr(NroLan));
  Aux.ExecSQL;
  AtualizaConsulta;
  Tempo.fecha;
end;

{ *********************** Adiciona Data de Pagamento ************************* }
procedure TFBaixaNegocio.DepositarClick(Sender: TObject);
begin
   if Todos.Checked then
   begin
     MovFactori.First;
     while not MovFactori.eof do
       MudaSituacao('D', 'D_DAT_DEP',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
       MovFactori.next;
   end
   else
     MudaSituacao('D', 'D_DAT_DEP', MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
end;

{ *********************** Adiciona Data de Pagamento ************************* }
procedure TFBaixaNegocio.ReapresentarClick(Sender: TObject);
begin
   if Todos.Checked then
   begin
     MovFactori.First;
     while not MovFactori.eof do
       MudaSituacao('R', 'D_DAT_REA',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
       MovFactori.next;
   end
   else
     MudaSituacao('R', 'D_DAT_REA',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
end;

{ *********************** Adiciona Data de Pagamento ************************* }
procedure TFBaixaNegocio.DevolverClick(Sender: TObject);
begin
   if Todos.Checked then
   begin
     MovFactori.First;
     while not MovFactori.eof do
       MudaSituacao('V', 'D_DAT_DEV',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
       MovFactori.next;
   end
   else
   MudaSituacao('V', 'D_DAT_DEV',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
end;

{ *********************** Adiciona Data de Pagamento ************************* }
procedure TFBaixaNegocio.RenegociarClick(Sender: TObject);
begin
   if Todos.Checked then
   begin
     MovFactori.First;
     while not MovFactori.eof do
       MudaSituacao('N', 'D_DAT_REN',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
       MovFactori.next;
   end
   else
   MudaSituacao('N', 'D_DAT_REN',MovFactoriI_LAN_FAC.AsInteger, MovFactoriI_NRO_LAN.AsInteger, MovFactoriI_EMP_FIL.AsInteger);
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFBaixaNegocio.BotaoFechar1Click(Sender: TObject);
begin
  Self.Close;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFBaixaNegocio.LocalizaBancoRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFBaixaNegocio.DocumentosChange(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFBaixaNegocio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 116 then
   begin
    if Depositar.Enabled then
      Depositar.Click;
   end;

  if Key = 117 then
   begin
    if Reapresentar.Enabled then
      Reapresentar.Click;
   end;

  if Key = 118 then
   begin
    if Devolver.Enabled then
      Devolver.Click;
   end;

  if Key = 119 then
   begin
    if Renegociar.Enabled then
      Renegociar.Click;
   end;                

  Todos.Checked := False;
end;

procedure TFBaixaNegocio.Data1CloseUp(Sender: TObject);
begin
  AtualizaConsulta;
end;

Initialization
 RegisterClasses([TFBaixaNegocio]);
end.
