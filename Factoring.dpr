program Factoring;

uses
  Forms,
  sysutils,
  APrincipal in 'APrincipal.pas' {FPrincipal},
  Constantes in '..\MConfiguracoesSistema\Constantes.pas',
  ASobre in '..\MaGerais\ASobre.pas' {FSobre},
  AAlterarSenha in '..\MaGerais\AAlterarSenha.pas' {FAlteraSenha},
  AAlterarFilialUso in '..\MaGerais\AAlterarFilialUso.pas' {FAlterarFilialUso},
  UnRegistro in '..\MConfiguraModulos\UnRegistro.pas',
  Abertura in '..\MaGerais\Abertura.pas' {FAbertura},
  ANovoCliente in '..\MaGerais\ANovoCliente.pas' {FNovoCliente},
  AClientes in '..\MaGerais\AClientes.pas' {FClientes},
  AConsultaRuas in '..\MaGerais\AConsultaRuas.pas' {FConsultaRuas},
  ASituacoes in '..\MFinanceiro\ASituacoes.pas' {FSituacoes},
  AProfissoes in '..\MaGerais\AProfissoes.pas' {FProfissoes},
  ACadCidades in '..\MaGerais\ACadCidades.pas' {FCidades},
  ASituacoesClientes in '..\MaGerais\ASituacoesClientes.pas' {FSituacoesClientes},
  ACadEstados in '..\MaGerais\ACadEstados.pas' {FCadEstados},
  ACadPaises in '..\MaGerais\ACadPaises.pas' {FCadPaises},
  CadFormularios in '..\MConfiguracoesSistema\CadFormularios.pas' {FCadFormularios},
  UnPrincipal in '..\MaGerais\UnPrincipal.pas',
  ARegiaoVenda in '..\MaGerais\ARegiaoVenda.pas' {FRegiaoVenda},
  ABackup in '..\MaGerais\ABackup.pas' {FBackup},
  AconsultaHistorico in '..\MaGerais\AconsultaHistorico.pas' {FConsultaHistorico},
  AConsultaAgenda in '..\MaGerais\AConsultaAgenda.pas' {FConsultaAgenda},
  AHistoricoCliente in '..\MaGerais\AHistoricoCliente.pas' {FHistoricoCliente},
  AMovHistoricoCliente in '..\MaGerais\AMovHistoricoCliente.pas' {FMovHistoricoCliente},
  AMovVendedorCliente in '..\MaGerais\AMovVendedorCliente.pas' {FMovVendedorCliente},
  AMovContatos in '..\MaGerais\AMovContatos.pas' {FMovContatos},
  AContatos in '..\MaGerais\AContatos.pas' {FContatos},
  AInicio in '..\MaGerais\AInicio.pas' {FInicio},
  AEventos in '..\MaGerais\AEventos.pas' {FEventos},
  UsuarioMenu in '..\MConfiguracoesSistema\UsuarioMenu.pas' {FUsuarioMenu},
  ABancos in '..\MFinanceiro\ABancos.pas' {FBancos},
  AContas in '..\MFinanceiro\AContas.pas' {FContas},
  AConsultaPorCliente in 'AConsultaPorCliente.pas' {FConsultaPorCliente},
  AConsultaPorNegocio in 'AConsultaPorNegocio.pas' {FConsultaPorNegocio},
  ABaixaNegocio in 'ABaixaNegocio.pas' {FBaixaNegocio},
  AImprimeConsultaNegocio in 'AImprimeConsultaNegocio.pas' {FImprimeConsultaNegocio},
  AImprimeConsultaCliente in 'AImprimeConsultaCliente.pas' {FImprimeConsultaCliente},
  ANovaFactori in 'ANovaFactori.pas' {FNovaFactori},
  AMovFactori in 'AMovFactori.pas' {FMovFactori},
  ACadEmitentes in 'ACadEmitentes.pas' {FCadEmitentes},
  AConsultaEmitentes in 'AConsultaEmitentes.pas' {FConsultaEmitentes},
  ASituacaoAtualCliente in 'ASituacaoAtualCliente.pas' {FSituacaoAtualCliente},
  UnFactori in 'UnFactori.pas',
  AManutencao in 'AManutencao.pas' {FManutencao},
  AConfiguracaoFactoring in 'AConfiguracaoFactoring.pas' {FConfiguracaoFactoring},
  AFundoPrincipal in '..\MaGerais\AFundoPrincipal.pas' {FFundoPrincipal},
  AControleLigacoes in '..\MaGerais\AControleLigacoes.pas' {FControleLigacoes},
  AMostraRecados in '..\MaGerais\AMostraRecados.pas' {FMostraRecados};
{  UnFactori in 'UnFactori.pas';}


{$R *.RES}

var
  ParametroBase : String;

begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFInicio, FInicio);
  Application.CreateForm(TFFundoPrincipal, FFundoPrincipal);
  FInicio.show;
  FInicio.Refresh;
  if ParamCount = 0 then  // verifica se a parametros da base de dados
    ParametroBase := 'Sig'
  else
    ParametroBase := ParamStr(1);

  if FPrincipal.AbreBaseDados(ParametroBase) then  // caso naum abra a base de dados
  begin
    FAbertura := TFAbertura.create(application);
    if (ParamStr(2) <> '') and (ParamStr(3) <> '') then    // caso a senha e ususario venham como parametro
    begin
      if FAbertura.VerificaSenha(Uppercase(ParamStr(2)),Uppercase(ParamStr(3)), ParamStr(4), ParamStr(5)) then // verifica a senha
         FAbertura.close
      else
         FAbertura.ShowModal;
      end
      else
        FAbertura.ShowModal;


    if Varia.StatusAbertura = 'CANCELADO' then
      FPrincipal.close
    else
      Application.Run;
  end
  else
    FPrincipal.close;
end.
