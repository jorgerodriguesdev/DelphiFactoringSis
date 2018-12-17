unit APrincipal;

//               Autor: Jorge Eduardo
//     Data da Criação: 29/05/2001
//              Função: Tela Inicial do Módulo Factoring
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DBTables, ComCtrls, ExtCtrls, StdCtrls, Buttons,  formulariosFundo, Formularios,
  ToolWin, ExtDlgs, Inifiles, constMsg, FunObjeto, Db, DBCtrls, Grids,
  DBGrids, Componentes1, PainelGradiente, Tabela, Localizacao,
  Mask, Registry, UnPrincipal, LabelCorMove,Shellapi;

const
  CampoPermissaoModulo = 'c_mod_cai';
  CampoFormModulos = 'c_mod_cai';
  NomeModulo = 'Factoring';

type
  TFPrincipal = class(TFormularioFundo)
    Menu: TMainMenu;
    MFAlteraSenha: TMenuItem;
    MAjuda: TMenuItem;
    BaseDados: TDatabase;
    BarraStatus: TStatusBar;
    MArquivo: TMenuItem;
    MSair: TMenuItem;
    MSobre: TMenuItem;
    MFAlterarFilialUso: TMenuItem;
    CorFoco: TCorFoco;
    CorForm: TCorForm;
    CorPainelGra: TCorPainelGra;
    MFAbertura: TMenuItem;
    N6: TMenuItem;
    CoolBar1: TCoolBar;
    Caixa1: TMenuItem;
    MFCidades: TMenuItem;
    MFCadEstados: TMenuItem;
    MFCadPaises: TMenuItem;
    N3: TMenuItem;
    MFContas: TMenuItem;
    MFBancos: TMenuItem;
    MFClientes: TMenuItem;
    N5: TMenuItem;
    MFSituacoesClientes: TMenuItem;
    MFProfissoes: TMenuItem;
    MFEventos: TMenuItem;
    N2: TMenuItem;
    MFUsuarioMenu: TMenuItem;
    BaseEndereco: TDatabase;
    Ajuda1: TMenuItem;
    ndice1: TMenuItem;
    MForarNovoUsurio: TMenuItem;
    MFBackup: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Factori: TMenuItem;
    NovaFactori1: TMenuItem;
    ConsultaPorPortador1: TMenuItem;
    ConsultaPorTitular1: TMenuItem;
    ToolBar1: TToolBar;
    BMFNovaFactori: TSpeedButton;
    BMFConsultaPorCliente: TSpeedButton;
    BMFConsultaPorNegocio: TSpeedButton;
    BMFClientes: TSpeedButton;
    BFCadEmitentes: TSpeedButton;
    BSaida: TSpeedButton;
    N1: TMenuItem;
    BaixaNegcio1: TMenuItem;
    Cliente1: TMenuItem;
    CadastrodeEmitentes1: TMenuItem;
    BFBaixaNegocio: TSpeedButton;
    Cliente2: TMenuItem;
    N4: TMenuItem;
    HistricodeCliente1: TMenuItem;
    CadastrodeHistrico1: TMenuItem;
    AgendadeCliente1: TMenuItem;
    ConsultadeAgenda1: TMenuItem;
    ConsultarHistrico1: TMenuItem;
    N7: TMenuItem;
    AniversriodeClienteseFornecedores1: TMenuItem;
    MalaDireta1: TMenuItem;
    N10: TMenuItem;
    Profisses1: TMenuItem;
    Eventos1: TMenuItem;
    SituaodeClientes1: TMenuItem;
    RegiodeVenda1: TMenuItem;
    VerndedoresporCliente1: TMenuItem;
    N11: TMenuItem;
    ManutenodaFactori1: TMenuItem;
    BFManutencao: TSpeedButton;
    Configuraes1: TMenuItem;
    MFConfiguracaoFactoring: TMenuItem;
    Aux: TQuery;
    N12: TMenuItem;
    procedure MostraHint(Sender : TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenuClick(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
    procedure ndice1Click(Sender: TObject);
  private
    TipoSistema : string;
    UnPri : TFuncoesPrincipal;
  public
     function AbreBaseDados( Alias : string ) : Boolean;
     procedure AlteraNomeEmpresa;
     Function  VerificaPermisao( nome : string ) : Boolean;
     procedure erro(Sender: TObject; E: Exception);
     procedure abre(var Msg: TMsg; var Handled: Boolean);
     procedure VerificaMoeda;
     procedure ValidaBotoesGrupos( botoes : array of TComponent);
     procedure ConfiguracaoModulos;
     procedure OrganizaBotoes;
end;

var
  FPrincipal: TFPrincipal;
  Ini : TInifile;

implementation

uses funstring, Abertura, FunIni, funsistema, funsql,
     Constantes, UnRegistro, AInicio, AAlterarFilialUso, ABackup,
  AProfissoes, ASituacoesClientes, AClientes, ACadPaises, ACadEstados,
  AEventos, ACadCidades, AAlterarSenha, ASobre, UsuarioMenu, ABancos,
  AContas, AConsultaPorCliente, AConsultaPorNegocio, ANovaFactori,
  ABaixaNegocio, ACadEmitentes, AHistoricoCliente,
  AMovHistoricoCliente, AconsultaHistorico, AConsultaAgenda, ARegiaoVenda,
  AMovVendedorCliente, AConsultaEmitentes, AConsultaRuas, AManutencao,
  AConfiguracaoFactoring;


{$R *.DFM}

// ----- Verifica a permissão do formulários conforme tabela MovGrupoForm -------- //
Function TFPrincipal.VerificaPermisao( nome : string ) : Boolean;
begin
  result := UnPri.VerificaPermisao(nome);
  if not result then
    abort;
end;

// ------------------ Mostra os comentarios ma barra de Status ---------------- }
procedure TFPrincipal.MostraHint(Sender : TObject);
begin
  BarraStatus.Panels[3].Text := Application.Hint;
end;

// ------------------ Na criação do Formulário -------------------------------- }
procedure TFPrincipal.FormCreate(Sender: TObject);
begin
 UnPri := TFuncoesPrincipal.criar(self, BaseDados, NomeModulo);
 Varia := TVariaveis.Create;   // classe das variaveis principais
 Config := TConfig.Create;     // Classe das variaveis Booleanas
 ConfigModulos := TConfigModulo.create; // classe que configura os modulos.
 Application.OnHint := MostraHint;
 Application.HintColor := $00EDEB9E;        // cor padrão dos hints
 Application.Title := 'Sistema Gerencial';  // nome a ser mostrado na barra de tarefa do Windows
 Application.OnException := Erro;
 Application.OnMessage := Abre;
end;

{************ abre base de dados ********************************************* }
function TFPrincipal.AbreBaseDados( Alias : string ) : Boolean;
begin
  BaseDados.AliasName :=  Alias;
  result := AbreBancoDadosAlias(BaseDados,alias);
end;

procedure TFPrincipal.erro(Sender: TObject; E: Exception);
begin
  Aviso(E.Message);
end;

// ------------------- Quando o formulario e fechado -------------------------- }
procedure TFPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseDados.Close;
  Varia.Free;
  Config.Free;
  ConfigModulos.Free;
  UnPri.free;
  Action := CaFree;
end;

// -------------------- Quando o Formulario é Iniciado ------------------------ }
procedure TFPrincipal.FormShow(Sender: TObject);
begin
     // Dados da Factoring
  AdicionaSQLAbreTabela(Aux, 'select * from cfg_Factori');
    if not Aux.Eof then
    begin
      with Config do
      begin
        FACJuroDiario:= TipoCheck(aux.fieldByName('C_JUR_DIA').AsString);
        FACSenhaLiberacao:= TipoCheck(aux.fieldByName('C_SEN_LIB').AsString);
      end;
    end;

 // configuracoes do usuario
 UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
  // configura modulos
 ConfiguracaoModulos;
 AlteraNomeEmpresa;
 FPrincipal.WindowState := wsMaximized;  // coloca a janela maximizada;
 // conforme usuario, configura menu
 UnPri.EliminaItemsMenu(self, Menu);
 OrganizaBotoes;
 Self.HelpFile := Varia.PathHelp + 'MCAIXA.HLP>janela';  // Indica o Paph e o nome do arquivo de Help
 VerificaVersaoSistema(CampoPermissaoModulo);
 if VerificaFormCriado('TFInicio') then
 begin
   finicio.close;
   finicio.free;
 end;
end;

{****************** organiza os botoes do formulario ************************ }
procedure TFPrincipal.OrganizaBotoes;
begin
 UnPri.OrganizaBotoes(0, [ BMFClientes, BMFNovaFactori,
                           BMFConsultaPorCliente, BMFConsultaPorNegocio, BFBaixaNegocio,
                           BFCadEmitentes, BFManutencao, BSaida]);
end;

// -------------------- Altera o Caption da Jabela Proncipal ------------------ }
procedure TFPrincipal.AlteraNomeEmpresa;
begin
  UnPri.AlteraNomeEmpresa(self, BarraStatus, NomeModulo, TipoSistema );
end;

// -------------Quando é enviada a menssagem de criação de um formulario------------- //
procedure TFPrincipal.abre(var Msg: TMsg; var Handled: Boolean);
begin
  if (Msg.message = CT_CRIAFORM) or (Msg.message = CT_DESTROIFORM) then
  begin
    UnPri.ConfiguraMenus(screen.FormCount,[],[MFAbertura,MSair]);
    if (Msg.message = CT_CRIAFORM) and (config.AtualizaPermissao) then
      UnPri.CarregaNomeForms(Screen.ActiveForm.Name, Screen.ActiveForm.Hint, CampoFormModulos, Screen.ActiveForm.Tag);
    if (Msg.message = CT_CRIAFORM) then
      Screen.ActiveForm.Caption := Screen.ActiveForm.Caption + ' [ ' + varia.NomeFilial + ' ] ';
  end;
end;

// --------- Verifica moeda --------------------------------------------------- }
procedure TFPrincipal.VerificaMoeda;
begin
if (varia.DataDaMoeda <> date) and (Config.AvisaDataAtualInvalida)  then
  aviso(CT_DataMoedaDifAtual)
else
  if (varia.MoedasVazias <> '') and (Config.AvisaIndMoeda) then
  avisoFormato(CT_MoedasVazias, [ varia.MoedasVazias]);
end;


// -------------  Valida ou naum Botoes para ususario master ou naum ------------- }
procedure TFPrincipal.ValidaBotoesGrupos( botoes : array of TComponent);
begin
  if Varia.GrupoUsuarioMaster <> Varia.GrupoUsuario then
    AlterarEnabledDet(botoes,false);
end;

{************************  M E N U   D O   S I S T E M A  ********************* }
procedure TFPrincipal.MenuClick(Sender: TObject);
begin
  if Sender is TComponent  then
  case ((Sender as TComponent).Tag) of
    1100 : begin
             FAlterarFilialUso := TFAlterarFilialUso.CriarSDI(application,'', VerificaPermisao('FAlterarFilialUso'));
             FAlterarFilialUso.ShowModal;
           end;
    1200, 1210 : begin
             // ----- Formulario para alterar o usuario atual ----- //
             FAbertura := TFAbertura.Create(Application);
             FAbertura.ShowModal;
             if Varia.StatusAbertura = 'OK' then
             begin
               AlteraNomeEmpresa;
               ResetaMenu(Menu, ToolBar1);
               UnPri.EliminaItemsMenu(self, menu);
               UnPri.ConfigUsu(varia.CodigoUsuario, CorFoco, CorForm, CorPainelGra, Self );
               ConfiguracaoModulos;
               OrganizaBotoes;
             end
             else
               if  ((Sender as TComponent).Tag) = 1210 then
                 FPrincipal.close;
           end;
  1250 : begin
           FUsuarioMenu := TFUsuarioMenu.CriarSDI(application,'',VerificaPermisao('FUsuarioMenu'));
           FUsuarioMenu.AbreFormulario(1);
         end;
  1270 : begin
           FBackup := TFBackup.CriarSDI(application,'',VerificaPermisao('FBackup'));
           FBackup.ShowModal;
         end;

           // ----- Sair do Sistema ----- //
    1300 : Close;
           // ----- Formulario de Empresas ----- //
    2300 : begin
             FEventos := TFEventos.CriarSDI(application, '', VerificaPermisao('FEventos'));
             FEventos.ShowModal;
           end;
    2400 : begin
             // ------- As profissões do Cliente ------- //
             FProfissoes := TFProfissoes.CriarSDI(application,'',VerificaPermisao('FProfissoes'));
             FProfissoes.ShowModal;
           end;
    2500 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
           // ------- Cadastro de Clientes ------- //
    2510 : begin
             FEventos := TFEventos.CriarSDI(application, '', VerificaPermisao('FEventos'));
             FEventos.ShowModal;
           end;
    2600 : FClientes := TFClientes.criarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FClientes'));
    2610 : begin
             // ------- As profissões do Cliente ------- //
             FProfissoes := TFProfissoes.CriarSDI(application,'',VerificaPermisao('FProfissoes'));
             FProfissoes.ShowModal;
           end;
    2700 : begin
             // ------ As Situções do Cliente ------- //
             FSituacoesClientes := TFSituacoesClientes.CriarSDI(Application,'',VerificaPermisao('FSituacoesClientes'));
             FSituacoesClientes.ShowModal;
           end;
    2793 : Begin
             FRegiaoVenda := TFRegiaoVenda.criarSDI(Application,'',VerificaPermisao('FRegiaoVenda'));
             FRegiaoVenda.ShowModal;
           end;
    2791 : Begin
             FMovVendedorCliente := TFMovVendedorCliente.criarSDI(Application,'',VerificaPermisao('FMovVendedorCliente'));
             FMovVendedorCliente.ShowModal;
           end;
    2920 : begin
             // ------ Cadastro de Paises ------ //
             FCadPaises := TFCadPaises.CriarSDI(Application,'',VerificaPermisao('FCadPaises'));
             FCadPaises.ShowModal;
           end;
    2930 : begin
             // ------ Cadastro de Estados ------ //
             FCadEstados := TFCadEstados.CriarSDI(Application,'',VerificaPermisao('FCadEstados'));
             FCadEstados.ShowModal;
           end;
    2940 : begin
             // ------ Cadastro de Cidades ------ //
             FCidades := TFCidades.CriarSDI(Application,'',VerificaPermisao('FCidades'));
             FCidades.ShowModal;
           end;
    4150 : begin
             // ------ Cadastro de Bancos ------ //
             FBancos := TFBancos.CriarSDI(Application,'',VerificaPermisao('FBancos'));
             FBancos.ShowModal;
           end;
    4160 : begin
             // ------ Cadastro de Contas Correntes ------ //
             FContas := TFContas.CriarSDI(Application,'',VerificaPermisao('FContas'));
             FContas.Showmodal;
           end;
    6100 : begin
             FAlteraSenha := TFAlteraSenha.CriarSDI(Application,'',VerificaPermisao('FAlteraSenha'));
             FAlteraSenha.ShowModal;
           end;
    8100 : begin
             // ---- Coloca as janelas em cacatas ---- //
             Cascade;
           end;
    8200 : begin
             // ---- Coloca as janelas em lado a lado ---- //
             Tile;
           end;
    8300 : begin
             // ---- Coloca a janela em tamanho normal ---- //
             if FPrincipal.ActiveMDIChild is TFormulario then
             (FPrincipal.ActiveMDIChild as TFormulario).TamanhoPadrao;
           end;
    9100 : begin
             FSobre := TFSobre.CriarSDI(application,'', VerificaPermisao('FSobre'));
             FSobre.ShowModal;
           end;
    9150 : begin
             FNovaFactori := TFNovaFactori.CriarSDI(application,'',VerificaPermisao('FNovaFactori'));
             FNovaFactori.ShowModal;
           end;
    9200 : begin
             FConsultaPorCliente := TFConsultaPorCliente.CriarSDI(application,'',VerificaPermisao('FConsultaPorCliente'));
             FConsultaPorCliente.ShowModal;
           end;
    9300 : begin
             FConsultaPorNegocio := TFConsultaPorNegocio.CriarSDI(application,'',VerificaPermisao('FConsultaPorNegocio'));
             FConsultaPorNegocio.ShowModal;
           end;
    9500 : begin
             FBaixaNegocio := TFBaixaNegocio.CriarSDI(application,'',VerificaPermisao('FBaixaNegocio'));
             FBaixaNegocio.ShowModal;
           end;

    9600 : FConsultaEmitentes := TFConsultaEmitentes.CriarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FConsultaEmitentes'));

    9700 : begin
             FManutencao := TFManutencao.CriarSDI(application,'',VerificaPermisao('FManutencao'));
             FManutencao.ShowModal;
           end;
  275000 : FClientes := TFClientes.criarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FClientes'));
           // ------ Cadastro de Transportadora ------- //
  275010 : begin
             FHistoricoCliente := TFHistoricoCliente.CriarSDI(application , '', VerificaPermisao('FHistoricoCliente'));
             FHistoricoCliente.ShowModal;
           end;
  275020 : begin
             UnPri.SalvaFormularioEspecial('FMovHistoricoCliente1','Cadastro de Historico de Cliente',CampoFormModulos,'MFMovHistoricoCliente1');
             FMovHistoricoCliente := TFMovHistoricoCliente.CriarSDI(application , '', VerificaPermisao('FMovHistoricoCliente1'));
             FMovHistoricoCliente.CadastraHistorico(0);
           end;
  275025 : begin
             FMovHistoricoCliente := TFMovHistoricoCliente.CriarSDI(application , '', VerificaPermisao('FMovHistoricoCliente'));
             FMovHistoricoCliente.CadastraAgenda(0);
           end;
  275030 : begin
             FConsultaHistorico := TFConsultaHistorico.CriarSDI(application , '', VerificaPermisao('FConsultaHistorico'));
             FConsultaHistorico.ShowModal;
           end;
  275040 : begin
             FConsultaAgenda := TFConsultaAgenda.CriarSDI(application ,'', VerificaPermisao('FConsultaAgenda'));
             FConsultaAgenda.MostraAgendaCliente(0);
           end;
    3100 : FConfiguracaoFactoring := TFConfiguracaoFactoring.CriarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FConfiguracaoFactoring'));
    3200 : Begin
              shellExecute( Handle,'open', StrToPChar(varia.PathInSig + 'AtualizaSistema.exe'),
                            nil, nil ,SW_NORMAL );
               self.close;
           end;


//  275050 : FAniversariante := TFAniversariante.CriarMDI(application, varia.CT_AreaX, varia.CT_AreaY,VerificaPermisao('FAniversariante'));
//  275060 : begin
//             FEtiquetaClientes := TFEtiquetaClientes.CriarSDI(application , '', VerificaPermisao('FEtiquetaClientes'));
//             FEtiquetaClientes.ShowModal;
//           end;
  end;
end;


{******************* configura os modulos do sistema ************************* }
procedure TFPrincipal.ConfiguracaoModulos;
var
  Reg : TRegistro;
begin
  Reg := TRegistro.create;
  reg.ValidaModulo( TipoSistema, [  ] );
  reg.ConfiguraModulo( CT_SENHAGRUPO, [ MFUsuarioMenu ] );
  reg.Free;
end;


procedure TFPrincipal.Ajuda1Click(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

procedure TFPrincipal.ndice1Click(Sender: TObject);
begin
   Application.HelpCommand(HELP_KEY,0);
end;




end.
