unit AConsultaPorCliente;
//     Data da Criação: 10/05/2001
//              Função: Consulta Documentos Por Cliente (Transação)
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, BotaoCadastro, ExtCtrls, PainelGradiente, Mask,
  numericos, Grids, DBGrids, Tabela, DBKeyViolation, Componentes1,
  Localizacao, ComCtrls, Db, DBTables;

type
  TFConsultaPorCliente = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    Label10: TLabel;
    Data1: TCalendario;
    Data2: TCalendario;
    Grade: TGridIndice;
    PanelColor2: TPanelColor;
    Label12: TLabel;
    Label2: TLabel;
    ValorLiquido: Tnumerico;
    ValorBruto: Tnumerico;
    PanelColor3: TPanelColor;
    BotaoFechar1: TBotaoFechar;
    DataCadFactori: TDataSource;
    CadFactori: TQuery;
    Localiza: TConsultaPadrao;
    Aux: TQuery;
    Grade2: TGridIndice;
    DataMovFactori: TDataSource;
    PanelColor4: TPanelColor;
    Label6: TLabel;
    PanelColor5: TPanelColor;
    Label4: TLabel;
    Label5: TLabel;
    SpeedLocaliza2: TSpeedButton;
    Label7: TLabel;
    MovFactori: TQuery;
    MovFactoriD_DAT_PAG: TDateField;
    MovFactoriD_DAT_VEN: TDateField;
    MovFactoriI_LAN_FAC: TIntegerField;
    MovFactoriI_NRO_LAN: TIntegerField;
    MovFactoriN_PER_JUR: TFloatField;
    MovFactoriN_TOT_LIQ: TFloatField;
    MovFactoriN_VLR_JUR: TFloatField;
    MovFactoriN_VLR_PAG: TFloatField;
    MovFactoriI_EMP_FIL: TIntegerField;
    MovFactoriC_NOM_BAN: TStringField;
    CadFactoriD_DAT_MOV: TDateField;
    CadFactoriI_COD_CLI: TIntegerField;
    CadFactoriI_LAN_FAC: TIntegerField;
    CadFactoriC_NOM_CLI: TStringField;
    BtImprimir: TBitBtn;
    CadFactoriI_EMP_FIL: TIntegerField;
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriN_VLR_DOC: TFloatField;
    MovFactoriN_VLR_CPM: TFloatField;
    ValorJuro: Tnumerico;
    ValorCPMF: Tnumerico;
    Label1: TLabel;
    Label3: TLabel;
    MovFactoriC_NOM_EMI: TStringField;
    LocalizaCliente: TEditLocaliza;
    BtCadastrar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure EClienteExit(Sender: TObject);
    procedure CadFactoriAfterScroll(DataSet: TDataSet);
    procedure LocalizaClienteRetorno(Retorno1, Retorno2: String);
    procedure BtImprimirClick(Sender: TObject);
    procedure BtCadastrarClick(Sender: TObject);
  private
    procedure SomaTotais(var liquido, juro, cpmf, Bruto : Double);
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);

  public
    {Public declarations }
  end;

var
  FConsultaPorCliente: TFConsultaPorCliente;

implementation
   uses APrincipal, AClientes, Constantes, funsql, fundata, funobjeto, funnumeros,
        AImprimeConsultaCliente, ANovaFactori, ANovoCliente;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaPorCliente.FormCreate(Sender: TObject);
begin
   Data1.Date := PrimeiroDiaMes(Date);
   Data2.Date := UltimoDiaMes(Date);
   LimpaEdits (PanelColor1);
   AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaPorCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadFactori.Close;
 MovFactori.Close;
 Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConsultaPorCliente.BotaoFechar1Click(Sender: TObject);
begin
 self.close;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaPorCliente.AtualizaConsulta;
begin
  CadFactori.SQL.Clear;
  CadFactori.SQL.Add('Select  Cfc.I_EMP_FIL, Cfc.D_DAT_MOV, ' +
                     '        Cfc.I_COD_CLI, Cfc.I_LAN_FAC, ' +
                     '        Cli.C_NOM_CLI, Cli.I_COD_CLI  ' +
                     'From    CadFactori  as Cfc,           ' +
                     '        CadClientes as Cli,           ');
  AdicionaFiltros(CadFactori.SQL);
  CadFactori.SQL.Add('   and   Cfc.I_COD_CLI = Cli.I_COD_CLI ');
  CadFactori.SQL.Add('Order by Cfc.I_LAN_FAC');
  CadFactori.OPEN;
  if CadFactori.IsEmpty then // Se a Tabela Estiver Vasia
     BTImprimir.Enabled := False //Desabilita Botao Imprimir
  else
     BTImprimir.Enabled := True; //Abilita Botao Imprimir
end;

{ **************************** Limpa Filtros ********************************* }
procedure TFConsultaPorCliente.AdicionaFiltros (VpaSelect : TStrings);
begin
  VpaSelect.Add(' Where Cfc.I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil));

  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD('D_DAT_MOV',Data1.Date, Data2.Date, true));
                                           //DATA DE CADASTRO
  if LocalizaCliente.Text <> '' then
    VpaSelect.Add(' and CFC.I_COD_CLI = '+ LocalizaCliente.Text)
  else
    VpaSelect.Add(' ');

end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaPorCliente.EClienteExit(Sender: TObject);
begin
  AtualizaConsulta;
end;

{ ******************** Ao Selececionar um Item da Cad na Grade *************** }
procedure TFConsultaPorCliente.CadFactoriAfterScroll(DataSet: TDataSet);
var
  liquido, juro, cpmf, Bruto : Double;
begin
  LimpaSQLTabela(MovFactori);
  if not CadFactori.Eof then
  begin
   MovFactori.SQL.Clear;
   MovFactori.SQL.Add('Select Mfc.C_NRO_DOC, Mfc.D_DAT_PAG, Mfc.D_DAT_VEN, Mfc.I_LAN_FAC, ' +
                      '       Mfc.I_NRO_LAN, Mfc.N_PER_JUR, Mfc.N_TOT_LIQ, Mfc.N_VLR_DOC, ' +
                      '       Mfc.N_VLR_JUR, Mfc.N_VLR_PAG, Mfc.I_EMP_FIL, Mfc.N_VLR_CPM, ' +
                      '       Emi.C_NOM_EMI, Ban.C_NOM_BAN                                ' +
                      ' From  MovFactori   as Mfc,                                        ' +
                      '       CadEmitentes as Emi,                                        ' +
                      '       CadBancos    as Ban                                         ' +
                      'Where      Mfc.I_COD_BAN = Ban.I_COD_BAN                           ' +
                      '       and Mfc.I_COD_EMI = Emi.I_COD_EMI                           ' +
                      '       and Mfc.I_LAN_FAC = ' + CadFactoriI_LAN_FAC.AsString +
                      '       and Mfc.I_EMP_FIL = ' + CadFactoriI_EMP_FIL.AsString +
                      'Order  by  Mfc.I_NRO_LAN                                           ' );
  MovFactori.OPEN;
  SomaTotais(liquido,juro,cpmf,Bruto);
  ValorJuro.AValor := juro;              //JOGA VALORES PARA NOS NUMÉRICOS
  ValorCPMF.AValor := cpmf;
  ValorBruto.AValor := Bruto;
  ValorLiquido.AValor := liquido;
  end;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaPorCliente.LocalizaClienteRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

{ **************************** Soma Valores Totais *************************** }
procedure TFConsultaPorCliente.SomaTotais(var liquido, juro, cpmf, Bruto : Double);
begin
 LimpaSQLTabela(aux);                    //SOMA OS VALORES DE CADA TRANSAÇÃO DA CADFACTORI
  AdicionaSQLTabela(Aux,'  Select ' +
                        '  Sum (N_VLR_JUR) as SOMAJURO,   '+
                        '  Sum (N_VLR_CPM) as SOMACPMF,   '+
                        '  Sum (N_VLR_DOC) as SOMABRUTO,  '+
                        '  Sum (N_TOT_LIQ) as SOMALIQUIDO '+
                        '  From MovFactori '+
                        '  Where I_LAN_FAC = ' + CadFactoriI_LAN_FAC.AsString +
                        '   and  I_EMP_FIL = ' + CadFactoriI_EMP_FIL.AsString );
  Aux.Open;
  liquido := Aux.FieldByname('SOMALIQUIDO').AsFloat;
  Juro := Aux.FieldByname('SOMAJURO').AsFloat;
  cpmf := Aux.FieldByName('SOMACPMF').AsFloat;
  Bruto :=Aux.FieldByname('SOMABRUTO').Asfloat;
  Aux.Close;
end;

{ **************************** Imprime Relatório ***************************** }
procedure TFConsultaPorCliente.BtImprimirClick(Sender: TObject);
begin
   FImprimeConsultaCliente := TFImprimeConsultaCliente.CriarSDI(application,'',true);
   FImprimeConsultaCliente.GeraCliente(CadFactoriI_LAN_FAC.AsInteger,
                                       CadFactoriI_EMP_FIL.AsInteger,
                                       FormatFloat(Varia.MascaraValor, ValorJuro.AValor),
                                       FormatFloat(Varia.MascaraValor, ValorLiquido.AValor),
                                       FormatFloat(Varia.MascaraValor, ValorBruto.AValor),
                                       FormatFloat(Varia.MascaraValor, ValorCPMF.AValor),
                                       CadFactoriC_NOM_CLI.AsString);
   //PASSA VALORES E NOMES COMO PARÂMETROS PARA A TELA DE IMPRESSÃO
end;

{ ******************* Abre o Cadastro de Novas Factoris ********************** }
procedure TFConsultaPorCliente.BtCadastrarClick(Sender: TObject);
begin
  FNovaFactori := TFNovaFactori.CriarSDI(application,'',FPrincipal.VerificaPermisao('FNovaFactori'));
  FNovaFactori.ShowModal; //Abre Tela Para Cadastro de Uma Nova Transação
end;

Initialization
 RegisterClasses([TFConsultaPorCliente]);
end.
