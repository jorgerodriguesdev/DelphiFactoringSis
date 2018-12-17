unit ACadEmitentes;
{            Autor: JORGE EDUARDO RODRIGUES
      Data Criação: 04 DE JUNHO DE 2001;
            Função: Cadastrar um EMITENTE Da FACTORING
    Data Alteração:
      Alterado por:
            Motivo:
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  ExtCtrls, Componentes1, Db, DBKeyViolation, DBTables, Tabela, StdCtrls,
  Localizacao, Grids, DBGrids, Mask, DBCtrls, PainelGradiente,
  BotaoCadastro, Buttons;

type
  TFCadEmitentes = class(TFormularioPermissao)
    DsEmitentes: TDataSource;
    PainelGradiente1: TPainelGradiente;
    PanelColor2: TPanelColor;
    Procurador: TConsultaPadrao;
    BotaoGravar1: TBotaoGravar;
    PanelColor3: TPanelColor;
    DBFilialColor1: TDBFilialColor;
    Label1: TLabel;
    DBEditColor1: TDBEditColor;
    Label5: TLabel;
    ProximoCodigo1: TProximoCodigo;
    ValidaGravacao1: TValidaGravacao;
    TipoPessoa: TDBRadioGroup;
    BotaoCancelar1: TBotaoCancelar;
    Label6: TLabel;
    DBEditCPF1: TDBEditCPF;
    Label2: TLabel;
    DBEditCGC1: TDBEditCGC;
    Label11: TLabel;
    DBEditUF1: TDBEditUF;
    SpeedButton11: TSpeedButton;
    Label3: TLabel;
    LocalizaCidade: TDBEditLocaliza;
    SpeedButton1: TSpeedButton;
    Label44: TLabel;
    Bevel1: TBevel;
    Label84: TLabel;
    PanelColor11: TBevel;
    CadEmitentes: TTabela;
    CadEmitentesI_COD_EMI: TIntegerField;
    CadEmitentesC_NOM_EMI: TStringField;
    CadEmitentesC_TIP_PES: TStringField;
    CadEmitentesD_ULT_ALT: TDateField;
    CadEmitentesC_CGC_EMI: TStringField;
    CadEmitentesC_CPF_EMI: TStringField;
    CadEmitentesC_CID_EMI: TStringField;
    CadEmitentesC_EST_EMI: TStringField;
    CadEmitentesI_COD_CID: TIntegerField;
    BotaoFechar1: TBotaoFechar;
    BBAjuda: TBitBtn;
    aux: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtFecharClick(Sender: TObject);
    procedure CadEmitentesAfterEdit(DataSet: TDataSet);
    procedure CadEmitentesAfterInsert(DataSet: TDataSet);
    procedure CadEmitentesAfterPost(DataSet: TDataSet);
    procedure CadEmitentesBeforePost(DataSet: TDataSet);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure DBFilialColor1Change(Sender: TObject);
    procedure TipoPessoaChange(Sender: TObject);
    procedure LocalizaCidadeCadastrar(Sender: TObject);
    procedure DBEditUF1Cadastrar(Sender: TObject);
    procedure CadEmitentesAfterDelete(DataSet: TDataSet);
    procedure LocalizaCidadeRetorno(Retorno1, Retorno2: String);
    procedure DBEditCGC1Exit(Sender: TObject);
    procedure DBEditCPF1Exit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    function  LocalizaEmitente( cgc_Cpf : string; cgc : Boolean) :  Boolean;
    procedure LimpaFiltros;
    Function  Clientes : String;
  public

  end;

var
  FCadEmitentes: TFCadEmitentes;

implementation
 uses APrincipal,constantes,funObjeto,funvalida,funSql,constmsg,AConsultaEmitentes,
  ACadCidades, ACadEstados, AClientes;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCadEmitentes.FormCreate(Sender: TObject);
begin
  Self.HelpFile := Varia.PathHelp + 'MaGeral.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
  DBFilialColor1.ACodFilial := Varia.CodigoFilCadastro;
   CadEmitentes.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCadEmitentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   CadEmitentes.close;
   Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFCadEmitentes.BtFecharClick(Sender: TObject);
begin
  Self.Close;
end;


{****************************  APOS ALTERAR ***********************************}
procedure TFCadEmitentes.CadEmitentesAfterEdit(DataSet: TDataSet);
begin
  DBFilialColor1.ReadOnly := True;
end;

{**************************** APOS CADASTRAR **********************************}
procedure TFCadEmitentes.CadEmitentesAfterInsert(DataSet: TDataSet);
begin
   CadEmitentesI_COD_EMI.AsInteger := Varia.CodigoFilCadastro;
   DBFilialColor1.ProximoCodigo;
   DBFilialColor1.ReadOnly := false;
   TipoPessoa.ItemIndex :=0 ;
   CadEmitentesC_TIP_PES.AsString := 'F';
  CadEmitentesD_ULT_ALT.AsDateTime := Date;
end;

{*************************** APOS SALVAR  *************************************}
procedure TFCadEmitentes.CadEmitentesAfterPost(DataSet: TDataSet);
begin
  CadEmitentes.Close;
  CadEmitentes.Open;
  if CadEmitentes.State = dsinsert then
  FConsultaEmitentes.AtualizaConsulta;
end;

{****************** PROXIMO CODIGO E DATA DE ALTERACAO ************************}
procedure TFCadEmitentes.CadEmitentesBeforePost(DataSet: TDataSet);
begin
//atualiza a data de alteracao para poder exportar
  if CadEmitentes.State = dsinsert then
    DBFilialColor1.VerificaCodigoRede;
end;

{*************************** ACAO DO BOTAO FECHAR *****************************}
procedure TFCadEmitentes.BotaoFechar1Click(Sender: TObject);
begin
  Self.Close;
end;

{**************** VERIFICA SE CGC OU CPF ESTAO CORRETOS ***********************}
function TFCadEmitentes.Clientes : String;
begin
  // cgc
  try
    StrToInt(DBEditCGC1.Text[1]);
    if not VerificaCGC(DBEditCGC1.Text) then
    begin
      DBEditCPF1.SetFocus;
      aviso(CT_ErroCGC);
    end
    else
      result := result + ' and C_CGC_EMI = ''' + DBEditCGC1.Text + '''';
   except
   end;

   // cpf
   try
    StrToInt(DBEditCPF1.Text[1]);
    if not VerificaCGC(DBEditCPF1.Text) then
    begin
      DBEditCPF1.SetFocus;
      aviso(CT_ErroCPF);
    end
    else
      result := result +  ' and C_CPF_EMI = ''' + DBEditCPF1.Text + '''';
  except
  end;

  if LocalizaCidade.text <> '' then
    result := result + ' and C_CID_EMI = ''' + LocalizaCidade.Text + '''';
end;

{******************* VERIFICA O CGC E CPF DUPLICADO ***************************}
function TFCadEmitentes.LocalizaEmitente(cgc_Cpf : string; cgc : Boolean) :  Boolean;
begin
  result := false;
if cgc_Cpf <> '' then
begin
  LimpaSQLTabela(aux);
  AdicionaSQLTabela(aux,'Select * from cademitentes');
  if cgc then
    AdicionaSQLTabela(aux,' where c_cgc_emi = ''' + cgc_Cpf + '''')
  else
    AdicionaSQLTabela(aux,' where c_cpf_emi = ''' + cgc_Cpf + '''');

  AbreTabela(aux);

  if not Aux.eof then
  begin
   result := true;
   aviso('Já existe um cadastro com este nº de cgc/cpf, Código ' +
          aux.fieldByName('I_COD_EMI').AsString + ' - Nome ' +
          aux.fieldByName('C_NOM_EMI').AsString );
  if DBEditCGC1.Visible = true then
  DBEditCGC1.SetFocus;
  if DBEditCPF1.Visible = true then
  DBEditCPF1.SetFocus;
  end;
  Aux.close;
end;
end;

{************************* VALIDA GRAVACAO ***********************************}
procedure TFCadEmitentes.DBFilialColor1Change(Sender: TObject);
begin
  if (CadEmitentes.State in [dsInsert, dsEdit]) then
  ValidaGravacao1.Execute;
end;

{*********************** LIMPA EDIT'S DO PANEL 3 *****************************}
procedure TFCadEmitentes.LimpaFiltros;
begin
  LimpaEdits(PanelColor3);
end;


{********** DEPENDENDO DO TIPO DE PESSOA MOSTRA O EDIT CORRESPONDENTE *********}
procedure TFCadEmitentes.TipoPessoaChange(Sender: TObject);
begin
  if TipoPessoa.ItemIndex = 0 then
    begin
      Label2.Visible := False;
      DBEditCGC1.Visible := False;
      Label6.Visible := True;
      DBEditCPF1.Visible := True;
    end
  else
    begin
      Label2.Visible := True;
      DBEditCGC1.Visible := True;
      Label6.Visible := False;
      DBEditCPF1.Visible := False;
    end;
end;

{******************** ABRE TELA DE CADASTRO DE CIDADES ***********************}
procedure TFCadEmitentes.LocalizaCidadeCadastrar(Sender: TObject);
begin
  FCidades := TFCidades.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FCidades'));
  FCidades.ShowModal;  //ABRE Cidades
  Procurador.AtualizaConsulta;
end;

{******************** ABRE TELA DE CADASTRO DE ESTADOS ***********************}
procedure TFCadEmitentes.DBEditUF1Cadastrar(Sender: TObject);
begin
  FCadEstados := TFCadEstados.CriarSDI(Application,'',FPrincipal.VerificaPermisao('FCadEstados'));
  FCadEstados.ShowModal;  //ABRE Estados
  Procurador.AtualizaConsulta;
end;

{*************************** ATUALIZA DASDOS APOS DELETAR**********************}
procedure TFCadEmitentes.CadEmitentesAfterDelete(DataSet: TDataSet);
begin
 FConsultaEmitentes.AtualizaConsulta;
end;
{************************** AO BUSCAR A CIDADE BUSCA O ESTADO *****************}
procedure TFCadEmitentes.LocalizaCidadeRetorno(Retorno1, Retorno2: String);
begin
  if (Retorno1 <> '') then
    if (CadEmitentes.State in [dsInsert, dsEdit]) then
    begin
      CadEmitentesI_COD_CID.AsInteger := StrToInt(Retorno1); // Grava a cidade;
      CadEmitentesC_EST_EMI.AsString := Retorno2; // Grava o Estado;
    end;
end;

{*************************** VERIFICA CGC DUPLICADO ***************************}
procedure TFCadEmitentes.DBEditCGC1Exit(Sender: TObject);
begin
 if CadEmitentes.State in [ dsInsert ] then
    LocalizaEmitente(DBEditCGC1.Field.AsString, true);
end;

{*************************** VERIFICA CPF DUPLICADO ***************************}
procedure TFCadEmitentes.DBEditCPF1Exit(Sender: TObject);
begin
if CadEmitentes.State in [ dsInsert ] then
    LocalizaEmitente(DBEditCPF1.Field.AsString, false);
end;

{*************************** ATUALIZA DADOS ***************************}
procedure TFCadEmitentes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BotaoGravar1.Enabled then
    if key = vk_f6 then
    begin
      CadEmitentes.post;
      self.close;
    end;
end;

Initialization
 RegisterClasses([TFCadEmitentes]);
end.


