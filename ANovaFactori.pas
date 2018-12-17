unit ANovaFactori;
{          Autor: JORGE EDUARDO RODRIGUES
    Data Criação: 22 DE JUNHO DE 2001;
          Função: Cadastrar NOVA FACTORING
  Data Alteração:
    Alterado por:
Motivo alteração:
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Buttons, Componentes1, ExtCtrls, PainelGradiente, StdCtrls, Grids,
  DBGrids, Tabela, DBKeyViolation, Mask, numericos, Localizacao,
  BotaoCadastro, Db, DBTables, DBCtrls, ComCtrls ,UnFactori;

type
  TFNovaFactori = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    Shape2: TShape;
    Label2: TLabel;
    SpeedButton3: TSpeedButton;
    Label4: TLabel;
    Consulta: TConsultaPadrao;
    PanelColor2: TPanelColor;
    BbFechar: TBitBtn;
    Label1: TLabel;
    BitNovo: TBitBtn;
    Shape1: TShape;
    numerico1: Tnumerico;
    numerico3: Tnumerico;
    Label3: TLabel;
    Shape4: TShape;
    Shape3: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    NValorTotal: Tnumerico;
    NTotalLiquido: Tnumerico;
    NTotalJuros: Tnumerico;
    NTotalCPMF: Tnumerico;
    Aux: TQuery;
    CadFactori: TSQL;
    DSCadFactori: TDataSource;
    CadFactoriI_EMP_FIL: TIntegerField;
    CadFactoriI_LAN_FAC: TIntegerField;
    CadFactoriI_COD_CLI: TIntegerField;
    CadFactoriD_DAT_MOV: TDateField;
    CadFactoriD_ULT_ALT: TDateField;
    CadFactoriN_PER_CPM: TFloatField;
    CadFactoriN_VAL_TOT: TFloatField;
    DBText1: TDBText;
    BotaoExcluir1: TBitBtn;
    BtImprimir: TBitBtn;
    Label8: TLabel;
    GridIndice1: TGridIndice;
    EditCliente: TEditLocaliza;
    Aux1: TQuery;
    BTAlteraDocumento: TBitBtn;
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
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriN_VLR_DOC: TFloatField;
    MovFactoriN_VLR_CPM: TFloatField;
    MovFactoriC_NOM_EMI: TStringField;
    DataMovFactori: TDataSource;
    BTNovaFactori: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBFecharClick(Sender: TObject);
    procedure BitNovoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BotaoExcluir1Click(Sender: TObject);
    procedure BTNovaFactoriClick(Sender: TObject);
    procedure BtImprimirClick(Sender: TObject);
    procedure EditClienteRetorno(Retorno1, Retorno2: String);
    procedure MovFactoriAfterPost(DataSet: TDataSet);
    procedure EditClienteCadastrar(Sender: TObject);
    procedure BTNovaFactoriKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BTAlteraDocumentoClick(Sender: TObject);
    procedure numerico1Exit(Sender: TObject);
  private
    Unfactori : TFuncoesNovaFactori;
    procedure InsertCad;
  public
    procedure CarregaMovimento;
    procedure CarregaAlteracao (EmpFil, LanFac, CodCli : Integer);
  end;

var
  FNovaFactori: TFNovaFactori;


implementation
uses APrincipal,Constantes,fundata, funstring,constmsg,funObjeto,
     FunSql,funnumeros,AMovFactori, ACadFactori,AConsultaPorCliente,
     AImprimeConsultaCliente, ANovoCliente, AClientes, AManutencao;

{$R *.DFM}
{ ****************** Na criação do Formulário *********************************}
procedure TFNovaFactori.FormCreate(Sender: TObject);
begin
  UnFactori:= TFuncoesNovaFactori.Criar(self, FPrincipal.BaseDados);
  LimpaEdits (PanelColor1);
end;

{ ******************* Quando o formulario e fechado ***************************}
procedure TFNovaFactori.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  UnFactori.free;
  MovFactori.Close;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade *******************}
procedure TFNovaFactori.BBFecharClick(Sender: TObject);
begin
  if (MovFactori.IsEmpty) and (not BTNovaFactori.Enabled) then
    UnFactori.ExcluirtodaFactori(Aux, CadFactoriI_EMP_FIL.AsInteger, CADFactoriI_Lan_Fac.AsInteger);
   close;
end;

{*********************    LOCALIZA MOVFACTORING   *****************************}
procedure TFNovaFactori.CarregaMovimento;
var
  liquido, juro, cpmf, total : Double;
  Valida : Boolean;
begin
  valida := true;
  if EditCliente.Text = '' then
    valida := false;
  if not CadFactori.Active then
    valida := false;
  if CadFactoriI_LAN_FAC.AsInteger = 0 then
    valida := false;

  if valida then
  begin
    MovFactori.Sql.Clear;
    MovFactori.Sql.add(' Select Mov.I_EMP_FIL, Mov.I_NRO_LAN, Mov.C_TIP_DOC, MOV.D_DAT_REA, '+
                       '        Cad.I_COD_CLI, Cli.C_NOM_CLI, MOV.D_DAT_REN, MOV.D_DAT_DEV, '+
                       '        Ban.I_Cod_Ban, Ban.C_NOM_BAN, Mov.C_NRO_DOC, Mov.N_VLR_PAG, '+
                       '        Mov.N_VLR_DOC, MOV.D_DAT_DEP, MOV.I_LAN_FAC, Mov.N_VLR_JUR, '+
                       '        Mov.N_PER_JUR, Cad.N_PER_CPM, Cad.D_DAT_MOV, CLI.I_COD_CLI, '+
                       '        Cad.N_VAL_TOT, CAD.I_EMP_FIL, CAD.I_COD_CLI, CAD.I_LAN_FAC, '+
                       '        Mov.N_TOT_LIQ, Cad.D_ULT_ALT, Mov.N_VLR_CPM, Mov.C_Nro_con, '+
                       '        Mov.I_Cod_Emi, Mov.D_DAT_PAG, Mov.D_DAT_VEN, '+
                       '        CadEmi.I_Cod_Emi, CadEmi.C_Nom_Emi ');
    MovFactori.Sql.add(' From                           '+
                       '        MovFactori as Mov,      '+
                       '        CadEmitentes as CadEmi, '+
                       '        CadFactori as Cad,      '+
                       '        CadClientes as Cli,     '+
                       '        CadBancos as Ban        '+
                       ' Where Mov.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil) +
                       ' and Cad.I_COD_Cli = ' + EditCliente.text +
                       ' and Cad.i_lan_fac = ' + CadFactoriI_LAN_FAC.AsString );
    MovFactori.Sql.add('      and MOV.I_EMP_FIL = CAD.I_EMP_FIL    '+
                       '      and Mov.I_LAN_FAC = Cad.I_LAN_FAC    '+
                       '      and Cad.I_COD_CLI = Cli.I_Cod_Cli    '+
                       '      and MOV.I_COD_EMI = CADEMI.I_COD_EMI '+
                       '      and Mov.I_COD_BAN = Ban.I_COD_BAN    ');
    MovFactori.SQL.Add(' Order by Mov.I_NRO_LAN ');
    MOVFACTORI.OPEN;
    Unfactori.SomaTotais(liquido,juro,cpmf,total, CadFactoriI_LAN_FAC.AsInteger);
    NtotalJuros.AValor := juro;         //JOGA VALORES PARA OS NUMERICOS
    NTotalCPMF.AValor := cpmf;
    NValorTotal.AValor:= total;
    NTotalLiquido.AValor:= liquido;
  end
  else
    aviso('Faltam dados para consultar o movimento ' );
end;

{******************** LOCALIZA FACTORING A SER ALTERADA ***********************}
procedure TFNovaFactori.CarregaAlteracao (EmpFil, LanFac, CodCli : Integer);
begin
  Unfactori.LocalizaCadfactori(CadFactori, EmpFil, LanFac);
  EditCliente.Enabled := True;
  EditCliente.Text := IntToStr (CodCli);
  EditCliente.Atualiza;
  AlterarEnabledDet([BitNovo,BtImprimir,BotaoExcluir1,BTAlteraDocumento], true);
  AlterarEnabledDet([EditCliente, BTNovaFactori, numerico1, numerico3], false);
  CarregaMovimento;
end;

{*********************  ABRE MOVFACTORI  E RECEBE INSERT **********************}
procedure TFNovaFactori.BitNovoClick(Sender: TObject);
begin
  FMovFactori := TFMovFactori.CriarSDI(application,'', FPrincipal.VerificaPermisao('FMovFactori'));
  FMovFactori.CarregaInsert(CadFactoriI_LAN_FAC.AsInteger,CadfactoriI_Emp_Fil.AsInteger, numerico1.avalor, numerico3.AValor);
  CarregaMovimento;
  if (MovFactori.IsEmpty) then
  begin
    AlterarEnabledDet([BTAlteraDocumento,BotaoExcluir1], false)
  end
  else
  AlterarEnabledDet([BTAlteraDocumento,BotaoExcluir1,BtImprimir], true);
  if BitNovo.Enabled then
    FNovaFactori.BitNovo.SetFocus;    //FOCA O BOTÃO NOVO DOCUMENTO
end;

{****** Abre o novo Cad e  ABRE TELA PARA CADASTRAR DADOS NO MOV **************}
procedure TFNovaFactori.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BTNovaFactori.Enabled then
   begin
    if  key = 113 then   // TECLA DE ATALHO F2
    begin
      BTNovaFactori.click;
      BTNovaFactori.Enabled := False;
    end;
   end;

  if BitNovo.Enabled then
   begin
    if  key = 115 then   // TECLA DE ATALHO F4
     BitNovo.click;
   end;

  if BTNovaFactori.Enabled then
   begin
    if  key = 116 then   // TECLA DE ATALHO F5
     BTAlteraDocumento.click;
   end;

end;

{*********************** Excluir nova Factori *********************************}
procedure TFNovaFactori.BotaoExcluir1Click(Sender: TObject);
var
  Liberado : Boolean;
begin
  Liberado := true;
  if Config.FACSenhaLiberacao then // VERIFICA SE NA CONFIG.FACTORI TEM SENHA DE LIBERACAO
    Liberado := SenhaAdministrativo;

  if Liberado then
  begin
    if confirmacao('Deseja realmente excluir este Documento?')   Then
    begin
      UnFactori.ExcluirItemFactori(aux,MovFactoriI_EMP_FIL.AsInteger,
                               MovFactoriI_LAN_FAC.AsInteger,
                               MovFactoriI_NRO_LAN.AsInteger);
      CarregaMovimento;
      AlterarEnabledDet([BTNovaFactori,EditCliente, SpeedButton3,BTAlteraDocumento,BotaoExcluir1,BtImprimir], false);
      if BitNovo.Enabled then
        BitNovo.SetFocus;
    end;
  end;
end;

{********************************** Inseri dados na CadFactori ****************}
procedure TFNovaFactori.InsertCad;
var
  Lancamento : integer;
begin
  Lancamento := ProximoCodigoFilial('CadFactori','i_Lan_fac','i_emp_fil',varia.CodigoEmpFil,FPrincipal.BaseDados);
  AdicionaSQLAbreTabela (CadFactori, ' select * from CadFactori ');
  Cadfactori.Insert;
  CadFactoriD_DAT_Mov.AsDateTime := date;      //D_DAT_MOV recebe a data do dia
  CadFactoriD_ULT_ALT.AsDateTime := date;      //D_ULT_ALT recebe a data do dia
  CadFactoriI_COD_CLI.AsInteger:= strtoint(EditCliente.text) ;
  CadfactoriI_EMP_FIL.AsInteger := Varia.CodigoEmpFil;
  CadfactoriI_Lan_fac.AsInteger :=  Lancamento;
  Cadfactori.Post;
  CadFactori.close;
  AdicionaSQLAbreTabela (CadFactori, ' select * from CadFactori ' +
                                     ' where i_emp_fil = ' + Inttostr(Varia.CodigoEmpFil) +
                                     ' and i_lan_fac = ' + IntToStr(lancamento));
  CarregaMovimento;
end;

{****** Passa o insert e nao permite passar com o código do cliente vazio *****}
procedure TFNovaFactori.BTNovaFactoriClick(Sender: TObject);
begin
  InsertCad;
  BTNovaFactori.Enabled:= False;
  BitNovo.Enabled := true;
  begin
    if (not MovFactori.IsEmpty) then
      begin
        AlterarEnabledDet([BTAlteraDocumento,BotaoExcluir1,BtImprimir], true);
      end;
        if BitNovo.Enabled then
          BitNovo.SetFocus;
  end;
end;

{*************** Movfactori Parametros Para Impressao  ************************}
procedure TFNovaFactori.BtImprimirClick(Sender: TObject);
begin
  FImprimeConsultaCliente := TFImprimeConsultaCliente.CriarSDI(application,'',true);
  FImprimeConsultaCliente.GeraCliente(CadFactoriI_LAN_FAC.AsInteger,
                                       CadFactoriI_EMP_FIL.AsInteger,
                                       FormatFloat(Varia.MascaraValor, NTotalJuros.AValor),
                                       FormatFloat(Varia.MascaraValor, NTotalLiquido.AValor),
                                       FormatFloat(Varia.MascaraValor, NValorTotal.AValor),
                                       FormatFloat(Varia.MascaraValor, NTotalCPMF.AValor),
                                       Label4.Caption);
  //PASSSA PARÂMETROS PRA TELA DE  IMPRESSÃO
end;

{********************** ABILITA E DESABILITA BOTÕES ************************** }
procedure TFNovaFactori.EditClienteRetorno(Retorno1, Retorno2: String);
begin
  if Retorno1 <> '' then
    begin
      AlterarEnabledDet([BTNovaFactori,EditCliente,SpeedButton3],false);
      BTNovaFactori.Enabled := true;
    end;
end;

{************************ FOCAR O BOTÃO NOVO DOCUMENTO *********************** }
procedure TFNovaFactori.MovFactoriAfterPost(DataSet: TDataSet);
begin
  if BitNovo.Enabled then
    BitNovo.SetFocus;
end;

{********************* SE NAO EXISTIR CLIENTE ABRE TELA DE CADASTRO DO MESMO ***}
procedure TFNovaFactori.EditClienteCadastrar(Sender: TObject);
begin
  FClientes := TFClientes.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FClientes'));
  FClientes.ShowModal;  //ABRE Clientes
  Consulta.AtualizaConsulta;
end;

{************************ SE PRESSIONADO F4 ENTAO CADASTRA TARNSAÇAO **********}
procedure TFNovaFactori.BTNovaFactoriKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 32 then    //barra de espaco
     BTNovaFactori.Click;
end;

{******************************** ACAO DO BOTAO ALTERAR DOCUMENTO **************}
procedure TFNovaFactori.BTAlteraDocumentoClick(Sender: TObject);
var
  Liberado : Boolean;
begin
  Liberado := true;
  if Config.FACSenhaLiberacao then    // VERIFICA SE NA CONFIG.FACTORI TEM SENHA DE LIBERACAO
    Liberado := SenhaAdministrativo;

  if Liberado then
  begin
    FMovFactori := TFMovFactori.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FMovFactori'));
    FMovFactori.CarregaAlteracao(MovFactoriI_EMP_FIL.AsInteger,
                                 MovFactoriI_LAN_FAC.AsInteger,
                                 MovFactoriI_NRO_LAN.AsInteger);
    FMovFactori.ShowModal;
  end;
end;

procedure TFNovaFactori.numerico1Exit(Sender: TObject);
begin
  if BTNovaFactori.Enabled then
  BTNovaFactori.SetFocus;
end;

Initialization
 RegisterClasses([TFNovaFactori]);
end.
