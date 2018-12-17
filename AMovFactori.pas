unit AMovFactori;
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
   StdCtrls, Mask, DBCtrls, Tabela, Db, DBTables, ExtCtrls, Componentes1,
   Buttons, BotaoCadastro, DBKeyViolation, Localizacao, ComCtrls,
   PainelGradiente, numericos,UnFactori;

type
  TFMovFactori = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    MovFactori: TSQL;
    DataMovFactori: TDataSource;
    BotaoCancelar1: TBotaoCancelar;
    BBAjuda: TBitBtn;
    Procurador: TConsultaPadrao;
    ValidaGravacao1: TValidaGravacao;
    PainelGradiente1: TPainelGradiente;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    SpeedButton1: TSpeedButton;
    Label17: TLabel;
    Label19: TLabel;
    SpeedButton2: TSpeedButton;
    EditBanco: TDBEditLocaliza;
    EditDoc: TDBEditColor;
    EditDVencto: TDBEditColor;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Filial: TProximoCodigoFilial;
    ELanFac: TDBEditNumerico;
    Label5: TLabel;
    Aux: TQuery;
    TIPODOC: TDBRadioGroup;
    BotaoGravar1: TBotaoGravar;
    DBKeyViolation1: TDBKeyViolation;
    EDataEmi: TDBEditColor;
    Label8: TLabel;
    EDiaVen: TDBEditColor;
    Label11: TLabel;
    Label14: TLabel;
    Bevel1: TBevel;
    MovFactoriI_EMP_FIL: TIntegerField;
    MovFactoriI_LAN_FAC: TIntegerField;
    MovFactoriI_NRO_LAN: TIntegerField;
    MovFactoriI_COD_BAN: TIntegerField;
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriN_VLR_DOC: TFloatField;
    MovFactoriD_DAT_VEN: TDateField;
    MovFactoriI_DIA_VEN: TIntegerField;
    MovFactoriN_PER_JUR: TFloatField;
    MovFactoriN_VLR_JUR: TFloatField;
    MovFactoriN_TOT_LIQ: TFloatField;
    MovFactoriC_TIP_DOC: TStringField;
    MovFactoriD_DAT_PAG: TDateField;
    MovFactoriN_VLR_PAG: TFloatField;
    MovFactoriD_ULT_ALT: TDateField;
    MovFactoriN_PER_CPM: TFloatField;
    MovFactoriN_VLR_CPM: TFloatField;
    MovFactoriD_EMI_DOC: TDateField;
    MovFactoriC_NRO_CON: TStringField;
    MovFactoriC_SIT_DOC: TStringField;
    MovFactoriD_DAT_DEV: TDateField;
    MovFactoriD_DAT_DEP: TDateField;
    MovFactoriD_DAT_REN: TDateField;
    MovFactoriD_DAT_REA: TDateField;
    MovFactoriI_COD_EMI: TIntegerField;
    EPERCJUR: TDBEditNumerico;
    EVALJUR: TDBEditNumerico;
    EPERCPM: TDBEditNumerico;
    ETOTLIQ: TDBEditNumerico;
    EVALCPM: TDBEditNumerico;
    EVALDOC: TDBEditNumerico;
    EditEmitente: TDBEditLocaliza;
    EnumConta: TDBEditColor;
    MovFactoriD_DAT_CAD: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBFecharClick(Sender: TObject);
    procedure MovFactoriAfterInsert(DataSet: TDataSet);
    procedure MovFactoriBeforePost(DataSet: TDataSet);
    procedure EValDocChange(Sender: TObject);
    procedure BotaoGravar1AntesAtividade(Sender: TObject);
    procedure EditBancoCadastrar(Sender: TObject);
    procedure EditEmitenteRetorno(Retorno1, Retorno2: String);
    procedure EditDVenctoExit(Sender: TObject);
    procedure EditEmitenteCadastrar(Sender: TObject);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure EVALDOCExit(Sender: TObject);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
    procedure EditDocExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    Alterando : Boolean;
    UnFactori : TFuncoesNovaFactori;
    function VerificaNroDocConta(Doc_Conta, ContaNro : string) :  Boolean ;
  public
    procedure CarregaInsert(LanFac, CodEmpFil : Integer; ValorCpmf, ValorJuros : double);
    procedure CarregaAlteracao(EmpFil, LanFac, NroLan : Integer);
  end;

var
  FMovFactori: TFMovFactori;

implementation
  uses aPrincipal,Constantes,funObjeto,funSql,fundata,funstring,constmsg,
  AClientes,ABancos,ANovafactori, ACadEmitentes,AConsultaEmitentes, ASituacaoAtualCliente, AManutencao;

{$R *.DFM}

{ ****************** Na criação do Formulário ******************************** }
procedure TFMovFactori.FormCreate(Sender: TObject);
begin
  alterando := false;
  UnFactori := TFuncoesNovaFactori.Criar(self,FPrincipal.BaseDados);
  Self.HelpFile := Varia.PathHelp + 'MaGeral.hlp>janela';// Indica o Paph e o nome do arquivo de Help
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFMovFactori.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  aux.close;
  MovFactori.close;
  Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFMovFactori.BBFecharClick(Sender: TObject);
begin
  self.close;
end;

{********************   ACOES APOS INSERIR ************************************}
procedure TFMovFactori.MovFactoriAfterInsert(DataSet: TDataSet);
begin
  MovFactoriI_EMP_FIL.AsInteger := Varia.CodigoEmpFil;
  TipoDoc.ItemIndex := 0 ;                          // SELECIONA ITEM DO RADIOGROUP
  MovFactoriC_TIP_DOC.AsString := 'C';              // CHEQUE
  MovFactoriC_SIT_DOC.AsString := 'C';              // CARTEIRA
  EVALDOC.Text:='0,00';
  EVALJUR.Text:='0,00';
  EVALCPM.Text:='0,00';
  ETOTLIQ.Text:='0,00';
end;

{*********************  ACOES ANTES DE GRAVAR  ********************************}
procedure TFMovFactori.MovFactoriBeforePost(DataSet: TDataSet);
begin
  if (MovFactoriD_DAT_VEN).AsDateTime < (MovFactoriD_EMI_DOC).AsDateTime then
  begin
    informacao(CT_DataMenorQueAtual);         //NÃO PERMITE CAMPOS VAZIOS
    abort;
  end;
  if MovFactoriI_DIA_VEN.IsNull or
     MovFactoriC_NRO_CON.isnull or
     MovFactoriD_EMI_DOC.IsNull or
     MovFactoriC_Tip_Doc.IsNull or
     MovfactoriN_VLR_DOC.IsNull then
     begin
       Informacao ('Favor preencher os campos vazios!');               //NÃO PERMITE CAMPOS VAZIOS
       abort;
     end;
     if MovFactori.State = dsinsert then
     if (EditEmitente.text = '') or (EditBanco.Text= '') then
     begin
       Informacao ('Favor preencher os campos vazios!');             //NÃO PERMITE CAMPOS VAZIOS
       abort;
     end;
     MovFactoriD_ULT_ALT.AsDateTime := Date;  //D_ULT_ALT RECEBE A DATA DO DIA
end;

{********************** CARREGA INSERT ****************************************}
procedure TFMovFactori.CarregaInsert(LanFac, CodEmpFil : Integer; ValorCpmf, ValorJuros : double);
begin
  AdicionaSQLAbreTabela(MovFactori, ' Select * from movfactori ');
  MovFactori.Insert;
  MovFactoriD_EMI_DOC.AsDateTime := Date;            //DATA DE EMISSAO RECEBE DATA DO DIA
  MovFactoriD_DAT_CAD.AsDateTime := Date;            //DATA DE CADASTRO RECEBE DATA DO DIA
  MovFactoriI_LAN_FAC.AsInteger := LanFac;           //RECEBE O I_LAN_FAC DA CADFACTORI
  MovFactoriI_NRO_LAN.AsInteger := ProximoCodigoFilialCampo('MovFactori','I_Nro_lan','I_Emp_Fil','I_Lan_Fac',Varia.CodigoEmpFil,LanFac, FPrincipal.BaseDados);
  MovFactoriN_PER_JUR.AsCurrency := ValorJuros;      //RECEBE O N_PER_JUR DA CADFACTORI
  MovFactoriN_PER_CPM.AsCurrency := ValorCpmf;       //RECEBE O N_PER_CPM DA CADFACTORI
  FMovFactori.ShowModal;
end;

{*********************** ACOES DO BOTAO DEPOIS DE CANCELAR ********************}
procedure TFMovFactori.BotaoCancelar1DepoisAtividade(Sender: TObject);
begin
  LimpaLabel([Label17,Label19]);
end;

{****************************  SOMA VALORES  NA MOVFACTORI   ******************}
procedure TFMovFactori.EValDocChange(Sender: TObject);
begin
  if MovFactori.State in [dsInsert, dsEdit] then
  begin
    if Config.FACJuroDiario then // SE CHECK BOX  ESTIVER SELECIONADA
    begin                 // CONFIG. FACTORI  SOMA VALOR LIQUIDO COM JUROS DIARIOS
      if not MovFactoriD_DAT_VEN.IsNull then
      MovFactoriI_DIA_VEN.AsInteger := DiasPorPeriodo(DATE, MovFactoriD_DAT_VEN.AsDateTime);
      if (EVALDOC.text <> '') and (EPERCJUR.text <> '') then
      MovFactoriN_VLR_JUR.AsCurrency := (strtofloat(EVALDOC.text) *  (strtofloat(EPERCJUR.text) * (MovFactoriI_DIA_VEN.AsCurrency / 100)));
      if (EVALDOC.text <> '') and (EPERCPM.text <> '') then
      MovFactoriN_VLR_CPM.AsCurrency := (strtofloat(EVALDOC.text) * (StrToFloat(EPERCPM.text) / 100));
      if (EVALDOC.text <> '') then
      MovFactoriN_TOT_LIQ.AsCurrency := (strtofloat(EVALDOC.text) - (MovFactoriN_VLR_JUR.AsCurrency + MovFactoriN_VLR_CPM.AsCurrency));
    end
    else
    if( Config.FACJuroDiario  = False ) then  // SE CHECK BOX NAO ESTIVER SELECIONADA
    begin               // CONFIG. FACTORI  SOMA VALOR LIQUIDO COM JUROS MENSAIS  /30 DIAS}
      if not MovFactoriD_DAT_VEN.IsNull then
      MovFactoriI_DIA_VEN.AsInteger := DiasPorPeriodo(DATE, MovFactoriD_DAT_VEN.AsDateTime);
      if (EVALDOC.text <> '') and (EPERCJUR.text <> '') then
      MovFactoriN_VLR_JUR.AsCurrency := (strtofloat(EVALDOC.text)/30) * (MovFactoriI_DIA_VEN.AsCurrency) * (strtofloat(EPERCJUR.text)/100);
      if (EVALDOC.text <> '') and (EPERCPM.text <> '') then
      MovFactoriN_VLR_CPM.AsCurrency := (strtofloat(EVALDOC.text)/30) * (StrToFloat(EPERCPM.text) / 100);
      if (EVALDOC.text <> '') then
      MovFactoriN_TOT_LIQ.AsCurrency := (strtofloat(EVALDOC.text) - (MovFactoriN_VLR_JUR.AsCurrency + MovFactoriN_VLR_CPM.AsCurrency));
    end;
  end;
end;
{*******************  MENSAGEN SE ESTIVER CAMPO(S) VAZIO(S) ******************}
procedure TFMovFactori.BotaoGravar1AntesAtividade(Sender: TObject);
begin
  if MovFactori.State in [dsEdit, dsInsert ] then  //MODO DE INSERÇÃO
  begin
    if (EditDVencto.Text = '' ) or (Editdoc.Text = '')  then
    begin                                        //Verifica se os Campos estão preenchidos
      Informacao ('Favor preencher os campos vazios!');
      abort;
    end;
  end;
end;

{**************************  CHAMA FORMULARIO PARA CADASTRAR BANCO   **********}
procedure TFMovFactori.EditBancoCadastrar(Sender: TObject);
begin
  FBancos := TFBancos.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FBancos'));
  FBancos.ShowModal;  //ABRE FBANCOS
  Procurador.AtualizaConsulta;
end;


{************************** ABRE FORMULARIO NO RETORNO DO EMITENTE ************}
procedure TFMovFactori.EditEmitenteRetorno(Retorno1, Retorno2: String);
begin
  If (Retorno1 <> '') and ( not alterando) then  //ABRE A TELA COM OS VALORES JÁ NEGOCIADO COM O EMITENTE SELECIONADO
  begin
    FSituacaoAtualCliente := TFSituacaoAtualCliente.CriarSDI(application,'',FPrincipal.VerificaPermisao('FSituacaoAtualCliente'));
    FSituacaoAtualCliente.AbreConsulta(MovFactoriI_COD_EMI.AsInteger,FMovFactori.Label17.Caption);
  end;
end;

{ ****** VERIFICA SE DATA DE VENCIMENTO E MENOR QUE A DATA DA EMISSÃO ********* }
procedure TFMovFactori.EditDVenctoExit(Sender: TObject);
begin
  if MovFactori.State in [dsInsert, dsEdit] then   //SE ESTIVER EM MODO DE INSERÇÃO OU EDIÇÃO
  begin
    if ( MovFactoriD_DAT_VEN).AsDateTime <  (MovFactoriD_EMI_DOC).AsDateTime then
    begin
      informacao(CT_DataMenorQueAtual);         //NÃO PERMITE D_DAT_VEN MENOR QUE D_EMI_DOC
      EditDVencto.SetFocus;
    end;
  end;
  EValDocChange(nil);
end;

{ ************** ABRE FORMULARIO PARA CADASTRAR UM NOVO EMITENTE ************* }
procedure TFMovFactori.EditEmitenteCadastrar(Sender: TObject);
begin
  FCadEmitentes := TFCadEmitentes.CriarSDI(application,'',FPrincipal.VerificaPermisao('FCadEmitentes'));
  FCadEmitentes.CadEmitentes.Insert;
  FCadEmitentes.ShowModal;
  Procurador.AtualizaConsulta;
end;

{ *************************** AÇÃO DO BOTÃO FECHAR *************************** }
procedure TFMovFactori.BotaoFechar1Click(Sender: TObject);
begin
  Self.Close;    //FECHA O FORMULÁRIO CORRENTE
end;

{**************** NAO PERMITE PASSAR VALOR DO DOCUMENTO IGUAL A ZERO *********}
procedure TFMovFactori.EVALDOCExit(Sender: TObject);
begin
  if (MovFactoriN_VLR_DOC.AsInteger = 0) then   //N_VLR_DOC NAO PODE SER = 0
  begin
    Informacao('Valor Inválido');
    EVALDOC.SetFocus;
    abort;
  end;
end;
{***************** LOCALIZA FACTORING A SER ALTERADA **************************}
procedure TFMovFactori.CarregaAlteracao(EmpFil, LanFac, NroLan : Integer);
begin
  alterando := true;
  UnFactori.LocalizaItemMovFactori(MovFactori, EmpFil, LanFac, NroLan);
  MovFactori.Edit;
  EditBanco.Atualiza;
  EditEmitente.Atualiza;
end;

{****************** VERIFICA Nº DO DOC OU CONTA DUPLICADO *********************}
function TFMovFactori.VerificaNroDocConta(Doc_Conta, ContaNro : string) :  Boolean;
begin
  result := false;
  if Doc_conta <> '' then
  begin
    LimpaSQLTabela(aux);
    AdicionaSQLTabela(aux,'Select * from MovFactori');
    AdicionaSQLTabela(aux,' where c_nro_doc = ''' + Doc_Conta + '''' +
                            ' and c_nro_con = ''' + ContaNro + '''' );
    AbreTabela(aux);

    if not Aux.eof then
    begin
     result := true;
     aviso('Já existe uma Conta/Documento com este nº, Código ' +
            aux.fieldByName('c_nro_con').AsString + ' - Documento ' +
            aux.fieldByName('c_nro_doc').AsString );
    end;
    Aux.close;
  end;
end;

{************************* VERIFICA NºDO DOCUMENTO DUPLICADO ****************}
procedure TFMovFactori.EditDocExit(Sender: TObject);
begin
if (MovFactori.State in [ dsInsert ]) and
   (MovFactoriC_NRO_CON.AsString <> '') and
   (MovFactoriC_NRO_DOC.AsString <> '' )  then
     if VerificaNroDocConta(MovFactoriC_NRO_DOC.AsString, MovFactoriC_NRO_CON.AsString) then
       if EnumConta.Enabled then
         EnumConta.SetFocus;

end;

procedure TFMovFactori.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BotaoGravar1.Enabled then
    if key = vk_f6 then
    begin
      BotaoGravar1AntesAtividade(nil);
      MovFactori.post;
      BotaoCancelar1DepoisAtividade(nil);
      self.close;
    end;
end;

Initialization
 RegisterClasses([TFMovFactori]);
end.
