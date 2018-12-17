unit AConsultaPorNegocio;
//     Data da Criação: 08/05/2001
//              Função: Consulta Documentos Por Negócio (Emitente)
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Componentes1, Localizacao, Db, DBTables, Grids, DBGrids,
  Tabela, DBKeyViolation, Mask, DBCtrls, Buttons, BotaoCadastro, ExtCtrls,
  ComCtrls, numericos, PainelGradiente;

type
  TFConsultaPorNegocio = class(TFormularioPermissao)
    PanelColor3: TPanelColor;
    BotaoFechar1: TBotaoFechar;
    PanelColor1: TPanelColor;
    Label1: TLabel;
    SpeedLocalizaCliente: TSpeedButton;
    Localiza: TConsultaPadrao;
    Label14: TLabel;
    Label4: TLabel;
    SpeedLocalizaBanco: TSpeedButton;
    DMovFactori: TDataSource;
    MovFactori: TQuery;
    LocalizaBanco: TEditLocaliza;
    LocalizaEmitente: TEditLocaliza;
    Aux: TQuery;
    EItem: TEditColor;
    BTCadastrar: TBitBtn;
    PainelGradiente1: TPainelGradiente;
    Grade: TGridIndice;
    BTImprimir: TBitBtn;
    Label12: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    ValorLiquido: Tnumerico;
    ValorBruto: Tnumerico;
    Label8: TLabel;
    Documentos: TComboBoxColor;
    ValorJuro: Tnumerico;
    ValorCPMF: Tnumerico;
    Label3: TLabel;
    Label15: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label9: TLabel;
    Datas: TComboBoxColor;
    Label10: TLabel;
    Data1: TCalendario;
    Data2: TCalendario;
    Situacao: TComboBoxColor;
    Label5: TLabel;
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriD_DAT_VEN: TDateField;
    MovFactoriI_NRO_LAN: TIntegerField;
    MovFactoriN_PER_JUR: TFloatField;
    MovFactoriN_TOT_LIQ: TFloatField;
    MovFactoriN_VLR_DOC: TFloatField;
    MovFactoriN_VLR_JUR: TFloatField;
    MovFactoriN_VLR_PAG: TFloatField;
    MovFactoriI_EMP_FIL: TIntegerField;
    MovFactoriI_LAN_FAC: TIntegerField;
    MovFactoriN_VLR_CPM: TFloatField;
    MovFactoriD_ULT_ALT: TDateField;
    MovFactoriD_DAT_MOV: TDateField;
    MovFactoriI_COD_CLI: TIntegerField;
    MovFactoriN_PER_CPM: TFloatField;
    MovFactoriC_NOM_EMI: TStringField;
    MovFactoriC_NOM_BAN: TStringField;
    MovFactoriI_COD_BAN: TIntegerField;
    PanelColor4: TPanelColor;
    Label7: TLabel;
    MovFactoriI_DIA_VEN: TIntegerField;
    MovFactorid_dat_cad: TDateField;
    MovFactorid_emi_doc: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LocalizaEmitenteRetorno(Retorno1, Retorno2: String);
    procedure LocalizaBancoRetorno(Retorno1, Retorno2: String);
    procedure EItemExit(Sender: TObject);
    procedure BTCadastrarClick(Sender: TObject);
    procedure BTImprimirClick(Sender: TObject);
  private
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);
    function SomaValorBruto : Double;
    function SomaValorLiquido : Double;
    function SomaValorJuro : Double;
    function SomaValorCPMF : Double;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConsultaPorNegocio: TFConsultaPorNegocio;

implementation
   uses APrincipal, ABancos, AClientes, AImprimeConsultaNegocio, ANovaFactori,
        Constantes, funsql, fundata, funobjeto, Funnumeros;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaPorNegocio.FormCreate(Sender: TObject);
begin
  Data1.Date := PrimeiroDiaMes(Date);
  Data2.Date := UltimoDiaMes(Date);
  LimpaEdits (PanelColor1);
  Datas.ItemIndex := 0;      // VENCIMENTO
  Documentos.ItemIndex := 1; // CHEQUES
  Situacao.ItemIndex := 1;   // CARTEIRA
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaPorNegocio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovFactori.Close; { fecha tabelas }
  Action := CaFree;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaPorNegocio.AtualizaConsulta;
var
  liquido, juro, cpmf, Bruto : Double;
begin
  MovFactori.SQL.Clear;
  MovFactori.SQL.Add(' Select Mfc.C_NRO_DOC, Mfc.I_DIA_VEN, Mfc.D_DAT_VEN, Mfc.N_VLR_CPM, ' +
                     '        Mfc.I_NRO_LAN, Mfc.N_PER_JUR, Mfc.N_TOT_LIQ, Mfc.N_VLR_DOC, ' +
                     '        Mfc.N_VLR_JUR, Mfc.N_VLR_PAG, Mfc.I_EMP_FIL, Mfc.I_LAN_FAC, ' +
                     '        Cfc.I_EMP_FIL, Cfc.D_ULT_ALT, Cfc.D_DAT_MOV, Cfc.I_EMP_FIL, ' +
                     '        Cfc.I_COD_CLI, Cfc.N_PER_CPM, Cfc.I_LAN_FAC, Cfc.N_PER_CPM, ' +
                     '        Cfc.I_LAN_FAC, EMI.C_NOM_EMI, Ban.C_NOM_BAN, Ban.I_COD_BAN,  ' +
                     '        mfc.d_dat_cad, mfc.d_emi_doc ' +  
                     '  From  MovFactori as Mfc, ' +
                     '        CadFactori as Cfc, ' +
                     '        CadEmitentes as Emi,' +
                     '        CadBancos as Ban   ');
  AdicionaFiltros(MovFactori.SQL);
  MovFactori.SQL.Add('        and Cfc.I_EMP_FIL = Mfc.I_EMP_FIL ' +
                     '        and Cfc.I_LAN_FAC = Mfc.I_LAN_FAC ' +
                     '        and Mfc.I_COD_EMI = EMI.I_COD_EMI ' +
                     '        and Mfc.I_COD_BAN = Ban.I_COD_BAN ');
  MovFactori.SQL.Add(' Order  by  Mfc.D_DAT_VEN');
  MovFactori.Open;
  if MovFactori.IsEmpty then //Se a Tabela Estiver Vazia
     BTImprimir.Enabled := False //Desabilita Botao Imprimir
  else
     BTImprimir.Enabled := True;  //Abilita Botao Imprimir
  ValorBruto.Text := FloatToStr(SomaValorBruto);        //JOGA VALORES NOS NUMÉRICOS
  ValorLiquido.Text := FloatToStr(SomaValorLiquido);
  ValorJuro.Text := FloatToStr (SomaValorJuro);
  ValorCPMF.Text := FloatToStr (SomaValorCPMF);
end;

{ ***************************** Adiciona Filtros ***************************** }
procedure TFConsultaPorNegocio.AdicionaFiltros (VpaSelect : TStrings);
begin
  VpaSelect.Add(' Where Mfc.I_EMP_FIL = ' + IntToStr (Varia.CodigoEmpFil));

  case Datas.ItemIndex of
    0 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('Mfc.D_DAT_VEN', Data1.Date, Data2.Date, true  ));
                                                   //DATA DE VENCIMENTO
    1 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('Mfc.D_DAT_CAD', Data1.Date, Data2.Date, true  ));
                                                   //DATA DE CADASTRO
    2 : VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('Mfc.D_EMI_DOC', Data1.Date, Data2.Date, true  ));
                                                   //DATA DE EMISSÃO
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

  if LocalizaEmitente.Text <> '' then
    VpaSelect.Add(' and Emi.I_COD_EMI = '+ LocalizaEmitente.Text)
  else
    VpaSelect.Add(' ');

  if LocalizaBanco.Text <> '' then
    VpaSelect.Add(' and Ban.I_COD_BAN = '+ LocalizaBanco.Text)
  else
    VpaSelect.Add(' ');

  if EItem.Text <> '' then
    VpaSelect.Add(' and Mfc.C_NRO_DOC = '''+ EItem.Text + '''')
  else
    VpaSelect.Add(' ');
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConsultaPorNegocio.LocalizaEmitenteRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaPorNegocio.LocalizaBancoRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaPorNegocio.EItemExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ ********************** Soma os Valores Brutos Dos Documentos *************** }
function TFConsultaPorNegocio.SomaValorBruto : Double;
begin
  LimpaSQLTabela(Aux);                         //Soma Valor Bruto dos Documentos
  AdicionaSQLTabela(Aux,' select sum(N_VLR_DOC)SOMABRUTO ' +
                        '  From  MovFactori as Mfc,   ' +
                        '        CadFactori as Cfc,   ' +
                        '        CadEmitentes as Emi, ' +
                        '        CadBancos as Ban   ');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add(' and Cfc.I_EMP_FIL = Mfc.I_EMP_FIL ' +
              ' and Cfc.I_LAN_FAC = Mfc.I_LAN_FAC ' +
              ' and Mfc.I_COD_EMI = Emi.I_COD_EMI ' +
              ' and Mfc.I_COD_BAN = Ban.I_COD_BAN ');
  Aux.Open;
  Result := Aux.FieldByname('SOMABRUTO').AsFloat;
  Aux.Close;
end;

{ **************** Soma os Valores Liquidos dos Documentos ********************}
function TFConsultaPorNegocio.SomaValorLiquido : Double;
begin
  LimpaSQLTabela(Aux);                       //Soma Valor Líquido dos Documentos
  AdicionaSQLTabela(Aux,' select sum(N_TOT_LIQ)SOMALIQUIDO ' +
                        '  From  MovFactori as Mfc,   ' +
                        '        CadFactori as Cfc,   ' +
                        '        CadEmitentes as Emi, ' +
                        '        CadBancos as Ban   ');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add(' and Cfc.I_EMP_FIL = Mfc.I_EMP_FIL ' +
              ' and Cfc.I_LAN_FAC = Mfc.I_LAN_FAC ' +
              ' and Mfc.I_COD_EMI = Emi.I_COD_EMI ' +
              ' and Mfc.I_COD_BAN = Ban.I_COD_BAN ');
  Aux.Open;
  Result := Aux.FieldByname('SOMALIQUIDO').AsFloat;
  Aux.Close;
end;

{ **************** Soma os Valores dos Juros dos Documentos *******************}
function TFConsultaPorNegocio.SomaValorJuro : Double;
begin
  LimpaSQLTabela(Aux);                     //Soma Valor dos Juros dos Documentos
  AdicionaSQLTabela(Aux,' select sum(N_VLR_JUR)SOMAJUROS ' +
                        '  From  MovFactori as Mfc,   ' +
                        '        CadFactori as Cfc,   ' +
                        '        CadEmitentes as Emi, ' +
                        '        CadBancos as Ban   ');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add(' and Cfc.I_EMP_FIL = Mfc.I_EMP_FIL ' +
              ' and Cfc.I_LAN_FAC = Mfc.I_LAN_FAC ' +
              ' and Mfc.I_COD_EMI = Emi.I_COD_EMI ' +
              ' and Mfc.I_COD_BAN = Ban.I_COD_BAN ');
  Aux.Open;
  Result := Aux.FieldByname('SOMAJUROS').AsFloat;
  Aux.Close;
end;

{ **************** Soma os Valores das CPMF Documentos ********************}
function TFConsultaPorNegocio.SomaValorCPMF : Double;
begin
  LimpaSQLTabela(Aux);                       //Soma Valor Da CPMF dos Documentos
  AdicionaSQLTabela(Aux,' select sum(N_VLR_CPM)SOMACPMF ' +
                        '  From  MovFactori as Mfc,   ' +
                        '        CadFactori as Cfc,   ' +
                        '        CadEmitentes as Emi, ' +
                        '        CadBancos as Ban   ');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add(' and Cfc.I_EMP_FIL = Mfc.I_EMP_FIL ' +
              ' and Cfc.I_LAN_FAC = Mfc.I_LAN_FAC ' +
              ' and Mfc.I_COD_EMI = Emi.I_COD_EMI ' +
              ' and Mfc.I_COD_BAN = Ban.I_COD_BAN ');
  Aux.Open;
  Result := Aux.FieldByname('SOMACPMF').AsFloat;
  Aux.Close;
end;

{ ******************* Abre o Cadastro de Novas Factoris ********************** }
procedure TFConsultaPorNegocio.BTCadastrarClick(Sender: TObject);
begin
  FNovaFactori := TFNovaFactori.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovaFactori'));
  FNovaFactori.ShowModal;
  //ABRE FORMULÁRIO PARA CADASTRAR NOVA TRANSAÇÃO
end;

{ **************************** Imprime Relatório ***************************** }
procedure TFConsultaPorNegocio.BTImprimirClick(Sender: TObject);
begin
   FImprimeConsultaNegocio := TFImprimeConsultaNegocio.CriarSDI(application,'',true);
   FImprimeConsultaNegocio.Carregarel(MovFactori.SQL.Text,
                                      FormatFloat(Varia.MascaraValor, ValorLiquido.AValor),
                                      FormatFloat(Varia.MascaraValor, ValorBruto.AValor),
                                      FormatFloat(Varia.MascaraValor, ValorJuro.AValor),
                                      FormatFloat(Varia.MascaraValor, ValorCPMF.AValor));
   //PASSA OS VALORES E OS NOMES COMO PARÂMETRO PARA A TELA DA IMPRESSÃO
end;

Initialization
 RegisterClasses([TFConsultaPorNegocio]);
end.
