unit AConsultaEmitentes;
   {Autor: JORGE EDUARDO RODRIGUES
    Data Criação: 04 DE JUNHO DE 2001;
    Função: Cadastrar um EMITENTE Da FACTORING
    Data Alteração:
    Alterado por:
    Motivo alteração:}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Componentes1, ExtCtrls, PainelGradiente, Db, StdCtrls, Localizacao,
  DBTables, Grids, DBGrids, Tabela, DBKeyViolation, BotaoCadastro, Buttons;

type
  TFConsultaEmitentes = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    PanelColor2: TPanelColor;
    Label2: TLabel;
    ENome: TLocalizaEdit;
    Grade: TGridIndice;
    ConsEmitentes: TQuery;
    DSCONSULTAEMI: TDataSource;
    ConsEmitentesI_COD_EMI: TIntegerField;
    ConsEmitentesC_NOM_EMI: TStringField;
    ConsEmitentesC_TIP_PES: TStringField;
    ConsEmitentesD_ULT_ALT: TDateField;
    ConsEmitentesC_CGC_EMI: TStringField;
    ConsEmitentesC_CPF_EMI: TStringField;
    BotaoFechar1: TBotaoFechar;
    BBAjuda: TBitBtn;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoExcluir1: TBotaoExcluir;
    ConsEmitentesC_CID_EMI: TStringField;
    ConsEmitentesC_EST_EMI: TStringField;
    ConsEmitentesI_COD_CID: TIntegerField;
    BotaoAlterar1: TBotaoAlterar;
    Label12: TLabel;
    BCidade: TSpeedButton;
    LCidade: TEditLocaliza;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    LEstado: TEditLocaliza;
    Localiza: TConsultaPadrao;
    Label11: TLabel;
    Pessoas: TComboBoxColor;
    Label3: TLabel;
    Bevel1: TBevel;
    BSituacao: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure GradeNAOrdem(Ordem: String);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure BAlterarClick(Sender: TObject);
    procedure BotaoCadastrar1AntesAtividade(Sender: TObject);
    procedure BotaoCadastrar1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DepoisAtividade(Sender: TObject);
    procedure BotaoExcluir1DestroiFormulario(Sender: TObject);
    procedure BotaoAlterar1Atividade(Sender: TObject);
    procedure LEstadoRetorno(Retorno1, Retorno2: String);
    procedure ENomeExit(Sender: TObject);
    procedure GradeNAEnter(Sender: TObject);
    procedure BSituacaoClick(Sender: TObject);
    procedure GrADEEnter(Sender: TObject);
    procedure GrADEOrdem(Ordem: String);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GradeDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);
  end;

var
  FConsultaEmitentes: TFConsultaEmitentes;

implementation
uses  ACadEmitentes, APrincipal, constantes, funObjeto, funvalida, funSql, constmsg,
      AClientes, ASituacaoAtualCliente;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaEmitentes.FormCreate(Sender: TObject);
begin
 Self.HelpFile := Varia.PathHelp + 'MaGeral.hlp>janela';
 ConsEmitentes.Open;
 Pessoas.ItemIndex := 0;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaEmitentes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 ConsEmitentes.Close;
 Action := CaFree;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConsultaEmitentes.BitBtn2Click(Sender: TObject);
begin
  Self.Close;
end;

{**************** ORDENA EMITENTES PELO CODIGO ********************************}
procedure TFConsultaEmitentes.AtualizaConsulta;
begin
  ConsEmitentes.SQL.Clear;
  ConsEmitentes.SQL.Add('Select * from CadEmitentes');
  AdicionaFiltros(ConsEmitentes.SQL);
  ConsEmitentes.SQL.Add('Order by I_COD_EMI');
  ConsEmitentes.Open;
end;

{************************ ADICIONA FLITROS ************************************}
procedure TFConsultaEmitentes.AdicionaFiltros (VpaSelect : TStrings);
begin

  VpaSelect.Add('Where I_COD_EMI > 0');

  case Pessoas.ItemIndex of
    0 : VpaSelect.Add('');                       //  TODAS
    1 : VpaSelect.Add(' and C_TIP_PES = ''F'''); //  FISICAS
    2 : VpaSelect.Add(' and C_TIP_PES = ''J'''); //  JURIDICAS
  end;

  if LEstado.Text <> '' then
    VpaSelect.Add(' and C_EST_EMI = '''+ LEstado.Text + '''')
  else
    VpaSelect.Add(' ');

  if LCidade.Text <> '' then
    VpaSelect.Add(' and C_CID_EMI = '''+ LCidade.Text + '''')
  else
    VpaSelect.Add(' ');

  if ENome.Text <> '' then
    VpaSelect.Add(' and C_NOM_EMI LIKE ''' + ENome.Text +  '%''')
  else
    VpaSelect.Add(' ');
end;


{********************* ACAO DO GRID [ORDENA CAMPOS]****************************}
procedure TFConsultaEmitentes.GradeNAOrdem(Ordem: String);
begin
  ENome.AOrdem:=Ordem;
end;

{********************* ACAO DO BOTAO FECHAR ***********************************}
procedure TFConsultaEmitentes.BotaoFechar1Click(Sender: TObject);
begin
  Self.Close;
end;
{************************ ALTERAR EMITENTE SELECIONADO ************************}
procedure TFConsultaEmitentes.BAlterarClick(Sender: TObject);
begin
   FCadEmitentes := TFCadEmitentes.CriarSDI(application,'',FPrincipal.VerificaPermisao('FCadEmitentes'));
   FCadEmitentes.ShowModal;
end;

{*********************** CADASTRAR EMITENTES **********************************}
procedure TFConsultaEmitentes.BotaoCadastrar1AntesAtividade(
  Sender: TObject);
begin
   FCadEmitentes := TFCadEmitentes.CriarSDI(application,'',FPrincipal.VerificaPermisao('FCadEmitentes'));
end;

{*********************** CADASTRAR EMITENTES **********************************}
procedure TFConsultaEmitentes.BotaoCadastrar1DepoisAtividade(
  Sender: TObject);
begin
   FCadEmitentes.ShowModal;
   AtualizaConsulta;
end;

{****************************** ACAO BOTAO EXCLUIR ****************************}
procedure TFConsultaEmitentes.BotaoExcluir1DepoisAtividade(
  Sender: TObject);
begin
  FCadEmitentes.show;
end;

{****************************** ACAO BOTAO EXCLUIR ****************************}
procedure TFConsultaEmitentes.BotaoExcluir1DestroiFormulario(
  Sender: TObject);
begin
  AtualizaConsulta;
  FCadEmitentes.Close;
end;

{*************************** LOCALIZA O CAMPO CHAVE **************************}
procedure TFConsultaEmitentes.BotaoAlterar1Atividade(Sender: TObject);
begin
   FCadEmitentes.CadEmitentes.FindKey([ConsEmitentesI_COD_EMI.Value]);
end;

{********************** ACAO DO LOCALIZA ESTADO *******************************}
procedure TFConsultaEmitentes.LEstadoRetorno(Retorno1, Retorno2: String);
begin
  AtualizaConsulta;
end;

{************************** LOCALIZA POR NOME ********************************}
procedure TFConsultaEmitentes.ENomeExit(Sender: TObject);
begin
   AtualizaConsulta;
end;

{**************************  ATUALIZA DADOS  ********************************}
procedure TFConsultaEmitentes.GradeNAEnter(Sender: TObject);
begin
 AtualizaConsulta;
end;

procedure TFConsultaEmitentes.BSituacaoClick(Sender: TObject);
begin
    FSituacaoAtualCliente := TFSituacaoAtualCliente.CriarSDI(application,'',FPrincipal.VerificaPermisao('FSituacaoAtualCliente'));
    FSituacaoAtualCliente.AbreConsulta(ConsEmitentesI_COD_EMI.AsInteger,ConsEmitentesC_NOM_EMI.AsString);
end;

procedure TFConsultaEmitentes.GrADEEnter(Sender: TObject);
begin
  AtualizaConsulta;
end;

procedure TFConsultaEmitentes.GrADEOrdem(Ordem: String);
begin
ENome.AOrdem:=Ordem;
end;

procedure TFConsultaEmitentes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if BSituacao.Enabled then
    if Key = Vk_F7 then    //barra de espaco
    BSituacao.Click;
end;

procedure TFConsultaEmitentes.GradeDblClick(Sender: TObject);
begin
  FSituacaoAtualCliente := TFSituacaoAtualCliente.CriarSDI(application,'',FPrincipal.VerificaPermisao('FSituacaoAtualCliente'));
  FSituacaoAtualCliente.AbreConsulta(ConsEmitentesI_COD_EMI.AsInteger,ConsEmitentesC_NOM_EMI.AsString);
end;

Initialization
 RegisterClasses([TFConsultaEmitentes]);
end.
