{***********************************************************}
{                    Systec Sistemas Ltda                   }
{                                                           }
{  Mensagens Constantes Para todas as aplica��es e Fun�oes  }
{  Sergio Luis Censi  10/08/98                              }
{***********************************************************}

unit ConstMsg;

interface

uses
  httpapp, Graphics, SysUtils, Controls, Dialogs, classes, stdctrls,Messages,Forms;

const
   ErroMaximo = 0.05;

const
  // mensagens de erros
  CT_AberturaBaseDados = 'ERRO BANCO DADOS - N�o foi poss�vel abrir o banco de dados. Problemas no banco de dados ou parametro de conec��o inv�lido( alias ).';  // ocorre quando n�o foi possivel executar o open na base de dados pelo DataBase.
  CT_SenhaInvalida = 'SENHA INVALIDA - Senha Inv�lida ou Usu�rio Incorreto';  // quando o usu�rio digitou a senha errada ou o usu�rio
  CT_AbortAbertura = 'ABERTURA - Tentativa de Abortagem Negada!';   //Tentativa de fechar o pedido de senha com ALT+F4
  CT_ConfirmaSenha = 'CONFIRMA SENHA - Senha de confirma��o � inv�lida';  // Na altera��o de Senha o usu�rio n�o digitou a senha de confirma��o correta
  CT_ErroGravacao = 'ERRO GRAVAR - Ocorreu um erro ao gravar este registro!!'; // ocorre quando houver um erro de post;
  CT_ErroMontaData = 'ERRO MONTADATA - Valor da Data Inv�lida'; // Ocorre quando motar uma data com valore invalidos
  CT_ErroFaltaDataset = 'ERRO DATASET -  N�o foi definido nenhum DatSet !!'; // quando um componente n�o for iniciado com o dataset
  CT_FormNaoVisivel = 'ERRO FORM - O Formul�rio n�o est� vis�vel para receber o foco!! '; // quando um componente recebe o foco com o seu formulario em visible = false;
  CT_ErroCGC = 'ERRO CGC - O %s � um CGC Inv�lido, deseja corrigir !!!';  //o valor digitado ao campo cgc � inv�lido
  CT_ErroCPF = 'ERRO CPF - O %s � um CPF Inv�lido, deseja corrigir !!!';  //o valor digitado ao campo cpf � inv�lido
  CT_ErroTipoField = 'ERRO CARREGA COMBO - O Campo definido s� pode ser String ou Inteiro'; //ocorre quando carrega o combobox, e o campo � diferente de integer ou string
  CT_ErroCampoString = 'ERRO CAMPO STRING - O campo de retorno n�o � uma string';
  CT_ErroCampoInteger = 'ERRO CAMPO INTEGER - O campo de retorno n�o � um inteiro';
  CT_ErroDeletaRegistroPai = 'ERRO DE EXCLUS�O DE REGISTRO - N�o � poss�vel excluir pois esta sendo utilizado por outro registro !!';
  CT_CodigoDuplicado = 'DUPLICA��O DE C�DIGO - Este c�digo j� existe';
  CT_FaixaInvalida = ' FAIXA INV�LIDA = Este c�digo est� fora da faixa de valores permitido a esta filial';
  CT_FimInclusaoClassificacao = 'INCLUS�O INV�LIDA  -  N�o � permitido incluir mais sub-grupos!'; // quando tentar incluir uma nova classifica��o e a mascara n�o permitir;
  CT_DuplicacaoClassificacao = 'DUPLICA��O CLASSIFICA��O - Esta Classifica��o j� existe!';
  CT_DuplicacaoPlanoConta = 'DUPLICA��O PLANO CONTA - Este C�digo do Plano de Conta j� existe!';
  CT_ErroInclusaoProduto = 'ERRO INCLUS�O - N�o � permitido incluir em um Produto!'; // tentativa de inser��o de um produto no tree em um produto
  CT_ErroInclusaoServico = 'ERRO INCLUS�O - N�o � permitido incluir em um Servi�o!'; // tentativa de inser��o de um produto no tree em um produto  
  CT_ErroExclusaoClassificaca = 'ERRO EXCLUS�O - Este item n�o pode ser apagado pois possui sub-grupos!'; // na tentativa de excluir uma classificacao ja existente
  CT_ClassificacacaoProdutoInvalida = 'ERRO INSER��O - N�o � permitido inserir um produto neste grupo!';
  CT_ClassificacacaoServicoInvalida = 'ERRO INSER��O - N�o � permitido inserir um servi�o neste grupo!';
  CT_ErroDataPagMaiorVen = 'DATA INV�LIDA - A Data de vencimento "%s" n�o pode ser menor que a data de pagamento "%s"!';
  CT_ErroCampoCliente = 'CAMPO CLIENTE - Campo cliente requer um valor';
  CT_ErroCampoVendedor = 'CAMPO VENDEDOR - Campo vendedor requer um valor';
  CT_DataMenorQueAtual = 'DATA INV�LIDA - A data de vencimento n�o pode ser menor que a atual'; // erro de data no conta a pagar, data menor que a data atual
  CT_DataMenorBAixa = 'DATA INV�LIDA - A data de pagamento n�o pode ser menor que a atual'; // erro de data no conta a pagar, data menor que a data atual
  CT_PathInvalido = 'PATH INV�LIDO - N�o foi poss�vel localizar a imagem, porque o caminho est� invalido ';
  CT_ExclusaoNota = 'NOTA FISCAL VINCULADA - N�o � permitido excluir uma conta que possua uma Nota Fiscal. Para excluir a conta � preciso estornar a nota antes';
  CT_ExcessoProduto = 'EXCESSO DE PRODUTO - N�o � possivel adicionar mais itens na Nota Fiscal, Cadastre uma nova.';
  CT_NaoUltimoNumero = 'OPERA��O INVALIDA - Est� Nota Fiscal so poder� ser cancelada porque ja existe outra subsequente.';
  CT_ErroUnidade = 'Esta unidade n�o � valida, para este produto use apenas as unidades '; // no componente valida unidade verifica  se a unidade � v�lida e adiciona as unidades validas no final do texto
  CT_ErroFaltaImpressora = 'ERRO IMPRESSORA - N�o existe a impressora especificada para a impress�o, verifique as configura��es gerais do sistema ';
  CT_ErroQuantidadeParcelas = 'A Quantidade de parcelas tem que ser maior que "0" !';
  CT_DuplicatDuplicada = ' DUPLICATA DUPLICADA - Esta duplicata j� foi cadastrada!';
  CT_AbortaFechar = 'TENTATIVA ABORTADA!!! Tentativa de fechar o formul�rio inv�lida...';
  CT_ValorQdadeNulo = 'VALOR NULO - O valor ou quantidade do produto esta vazia. ';
  CT_FechamentoEstoqueMesAnterior = 'FECHAMENTO ESTOQUE - N�o poder� ser efetuado o Fechamento de Estoque deste m�s, pois o m�s anterior ainda n�o foi Fechado.';
  CT_FechamentoEstoqueMes = 'FECHAMENTO ESTOQUE - N�o poder� ser efetuado o Fechamento de Estoque deste m�s, o mesmo ja foi fechado.';
  CT_FechamentoEstoqueMesProximo = 'FECHAMENTO ESTOQUE - N�o poder� ser Deletado o Fechamento de Estoque, pois o prox�mo m�s j� foi Fechado.';
  CT_AlteraDataSistema = 'ALTERA DATA - Voc� deseja alterar a data do sistema para %s';
  CT_BancoContaVinculada = 'CONTA VINCULADA - Est� conta est� vinvulada a um  t�tulo a pagar ou receber, voc� so pode alterar ou estornar atrav�s dos t�tulos.';
  CT_CancelaLancamentoBancario = 'CANCELA LANCAMENTO BANCARIO - Tem certeza que deseja cancelar este lancamento ?';
  CT_BancoContaConciliada = 'CONTA CONCILIADA - Est� conta est� concialida, n�o pode ser alterada nem cancelada.';
  CT_ErroConta = 'ERRO GERANDO CONTA - Houve um erro ao tentar gerar esta conta, o processo ser� abortado e a conta n�o ser� gerada.';
  CT_ErroContaDespesa = 'ERRO GERANDO DESPESA - Houve um erro ao tentar gerar a despesa desta conta, o processo ser� abortado e a despesa n�o ser� gerada.';
  CT_DescontoMaiorNota = 'DESCONTO MAIOR NOTA -  O desconto concedido e maior ou igual ao total dos produtos da nota fiscal.';
  CT_ExcluiConta = 'EXCLUIR CONTA - Esta opera��o ira excluir a conta e todos os seus t�tulos, voc� deseja continuar ? ';
  CT_NaoExcluiPossuiTEF = 'TEF - Est� opera��o n�o pode ser concluida, pois foi gerada atrav�s da solu��o TEF Discado quee n�o est� cancelada, voc� deve antes cancelar a conta TEF.!';
  CT_TEFCancelado = 'TEF CANCELADO - Ocorreu algum tipo de problema com a impressora fiscal, a transa��o  TEF foi cancelada.';
  CT_CancelouCancelamento = 'TEF CANCELADO - Est� opera��o foi cancelada.';
  CT_TempoEstourado = 'TEF TEMPO ESTOURADO - O tempo de impress�o estourou, ser� feita uma reimpress�o do cupom TEF.';
  CT_ExcluiTitulos  = 'EXCLUIR TITULO - Esta opera��o ira excluir o t�tulo selecionado, voc� deseja continuar ? ';
  CT_CancelarTitulo  = 'CANCELAR TITULO - Esta opera��o ira cancelar o t�tulo selecionado, voc� deseja continuar ? ';
  CT_EstornarTitulo  = 'ESTORNAR TITULO - Esta opera��o ira estornar o t�tulo selecionado, voc� deseja continuar ? ';
  CT_EstornarCancelamento  = 'ESTORNAR CANCELAMENTO - Esta opera��o ira estornar o cancelamento do t�tulo selecionado, voc� deseja continuar ? ';
  CT_ContaPagaCancelada = 'CONTA PAGA/CANCELADA - Esta opera��o n�o pode ser executada, pois a conta esta paga ou cancelada!';
  CT_ImpressoraFiscalFechada = 'IMPRESSORA FISCAL FECHADA -  A Impressora de cupom fiscal n�o est� ligada para a abertura da gaveta.';
  CT_AlteraVendedor = 'ALTERAR VENDEDOR - Tem Certeza que deseja alterar o vendedor desta comiss�o ?';
  Ct_faltaOpeEstoque = 'FAlTA OPERA��O DE ESTOQUE - Voc� deve informar as opera��es de estoque.';
  CT_DiaInvalido = 'DIA INVALIDO - Dia Inv�lido.';

  CT_FaltaCFGOpeEstoqueECF = 'CONFIGURA��ES DE SISTEMA - Configure a operera��o de estoque para o ECF na Configura��o de Sistema.';
  CT_FaltaCFGOpeCaixaRC = 'CONFIGURA��ES DE SISTEMA - Configure a operera��o padr�o a receber para o caixa na Configura��o de Sistema.';
  CT_FaltaCFGFiscalECF = 'CONFIGURA��ES DE SISTEMA - Falta configura��o do ECF na Configura��o de Sistema.';
  CT_FaltaCFGFinanceiro = 'CONFIGURA��ES DE SISTEMA - Falta configura��o da situa��o padr�o na Configura��o de Sistema / Configura��es Financeira.';
  CT_CupomVinculado = 'CUPOM VINCULADO -  N�o � possivel cancelar o ultimo cupom porque o mesmo possui cupom vinvulado, emita um nota de entrada para o cancelamento.';

  CT_EXTORNAR = 'Tem certeza que deseja extornar o %s ?';
  CT_CANCELAR = 'Tem certeza que deseja cancelar o %s ?';
  CT_ORCAMENTOESGOTADO = 'OR�AMENTO ESGOTADO!!! N�o � poss�vel gerar uma nota fiscal a partir deste %s, pois n�o existe mais produtos a serem entregues ou o %s foi cancelado...';
  CT_NAOEXISTENOTA = 'N�O EXISTE NOTA - N�o existe nota associada a este or�amento.';
  CT_POSSUIPARCIAL = 'POSSUI PARCIAL - Esta opera��o n�o poder� ser efetuada pois possui nota parcial, efetue uma altera��o.';

  // mensagens de sucesso
  CT_SenhaAlterada = 'SENHA ALTERADA - A Senha foi alterada com sucesso';  //Quando a senha foi alterada
  CT_ImportacaoCompleta = 'OPERA��O COMPLETADA - Sua importa��o foi efetuada com sucesso';  //Quando for efetuada uma importa��o de dados
  CT_NaturezaErrada = ' NATUREZA INCORRETA - Este cliente n�o � aceito com esta natureza, altere a natureza.';
  CT_DataMaiorFechamento = ' DATA INVALIDA - O m�s de fechamento n�o poder ser maior que o ultimo m�s fechado + 1.';
  CT_DataMenorFechamento = ' DATA INVALIDA - O m�s de fechamento n�o poder ser menor que o ultimo m�s fechado.';
  CT_MesSemMovimento = 'PERIODO INVALIDO - O in�cio de fechamento � inv�lido, sendo que o primeiro movimento ocorreu em %s .';

  // mensagens de confirma��o
  CT_DeletaRegistro = 'DELETAR REGISTRO - Deseja realmente excluir o registro " ';  // confirma��o de exclus�o de registro
  CT_DeletarItem = 'DELETAR ITEM - Deseja realmente deletar este item ';
  CT_ErroGravacaoCancela = 'ERRO GRAVACAO - Erro de Grava��o, por duplica��o de registro ou por algum outro problema interno, deseja cancelar opera��o ?';  // quando o post der erro
  CT_AtualizaMes = 'ATUALIZAR DESPESAS FIXAS - Virada de m�s, voc� deseja atualizar agora sua despesas fixas ?';
  CT_NaoAFotoAssociado = 'SEM FOTO - N�o h� foto associado a esta sele��o ';
  CT_FaltaEstoque = 'SEM ESTOQUE - Este Produto n�o possui estoque suficiente. Deseja continuar, sendo que o estoque atual � de '; //na nota fiscal;
  CT_FaltaEstoueTranca = 'SEM ESTOQUE - Este Produto n�o possui estoque suficiente. Deseja cancelar a opera�ao, sendo que o estoque atual � de '; //na nota fiscal;
  CT_NotaJaImpressa = 'NOTA J� IMPRESSA - A Nota Fiscal n� %d j� foi impressa deseja imprim�-la novamente?';
  CT_PedidoJaImpresso = 'PEDIDO J� IMPRESSO - O Pedido n� %d j� foi impresso. Deseja imprim�-lo novamente?';
  CT_NotaJaCancelada = 'NOTA J� CANCELADA - A Nota Fiscal n� %d j� foi cancelada !!';
  CT_NotaJaDevolvida = 'NOTA J� DEVOLVIDA - A Nota Fiscal n� %d j� foi devolvida !!';
  CT_AtualizarMoedaDia = 'ATUALIZAR MOEDA - Voc� deseja atualizar as moedas de hoje!';
  CT_ImprimirReserva = 'IMPRIMIR RESERVA - Voc� deseja imprimir a reserva ? ';
  CT_SemEstoqueTranca = 'SEM ESTOQUE - Este Produto n�o possui estoque suficiente. Seu estoque atual � de ';
  CT_KitQdadeNula = 'QUANTIDADE NULA - Existe kit com quantidades zerada.';
    // ecf
  CT_ReducaoZ = 'REDU��O Z - Deseja realmente emitir a redu��o Z do dia %s !';
  CT_LeituraX = 'REDU��O X - Deseja realmente emitir a redu��o X do dia %s !';
 CT_AlicotaNaoCadastradaECF = 'ALICOTA FALTANTE - A alicota %s n�o esta cadastrada na imrpessora de ECF, cadastre em configura��es de sistema, para esta venda ser� usado uma alicota padr�o.';
 CT_AlicotaNaoCadastradaNF = 'ALICOTA FALTANTE - A alicota do estado %s n�o esta cadastrada na tabela de icms, para esta venda ser� usado uma alicota padr�o.';
 CT_EstornoComissao = 'ESTORNO COMISS�O - A comiss�o desta conta ja foi paga, deseja continuar o estorno da conta, sendo que a comiss�o n�o ser� estornada!';
 CT_CancelaComissao = 'CANCELA COMISS�O - A comiss�o desta conta ja foi paga, deseja continuar o cancelamento da conta, sendo que a comiss�o n�o ser� cancelada!';
 CT_CanExcluiCP = 'CANCELA EXCLUI CONTA - Este t�tulo n�o pode ser excluido nem cancelado por que ja esta pago!';
 CT_ExcluidaConta = 'CONTA EXCLU�DA - A conta foi exclu�da pois n�o possuia mais parcelas.';
 CT_CanExcluiComissao = 'EXCLUI COMISS�O - A comiss�o deste t�tulo ja foi paga, deseja continuar a exclus�o, sendo que a comiss�o n�o ser� cancelada!';
 CT_ComissaoPaga = 'COMISS�O Paga - Esta conta possui comiss�o paga, voc� deve antes estornar a comiss�o!';
 CT_TodaParcelasPagas = 'PARCELAS PAGAS - Todas as parcelas ja foram pagas.';
 CT_BaixaBancario = 'MOVIMENTO BANC�RIO - Deseja lan�ar o movimento banc�rio deste t�tulo ?';
 CT_ValorMaiorSaldoCaixa = 'VALOR INV�LIDO - O valor � maior que o saldo atual do caixa !!!';
 CT_Titulo_Pago = 'T�TULO VINCULADO - O t�tulo a receber vinculado a este adicional j� foi pago.';
 CT_Cassificacao_Vazia = 'CLASSIFICA��O SEM PRODUTOS - N�o existem produtos para esta classifica��o.';
 CT_Drivers_Nao_Instalados = 'DRIVERS DE IMPRESS�O N�O INSTALADOS - N�o existem drivers de impress�o instalados.';
 CT_Cheque_Impresso = 'IMPRESS�O CORRETA - O Documento foi impresso corretamente? Efetuar Baixas?';
 CT_Caixa_Desativado = 'CAIXA INCORRETO - caixa ativo n�o esta aberto e ser� desativado.';
 CT_Sem_Parcial_Aberto = 'N�o existe caixa para lan�amento.';
 CT_Titulo_Nao_Encontrado = 'T�tulo n�o encontrado.';
 CT_Titulo_Sem_Parcelas = 'Este t�tulo n�o possui parcelas para baixa.';
 CT_Valor_Invalido = 'Valor Inv�lido.';
 CT_Caixa_Vinculado = 'LAN�AMENTO DE CAIXA VINCULADO - Este t�tulo possui um lan�amento de caixa vinculado.';
 CT_Documento_Ja_Cadastrado = 'DOCUMENTO J� CADASTRADO - Este n�mero de documento j� existe.';
 CT_CancelouTransacaoTFE = 'CANCELAMENTO TEF - N�o foi possivel completar a opera��o, por cancelamento da transa��o ou problemas com a operadora, escolha outra forma de pagamento ou outra operadora.';
 CT_CancelouCancelamentoTFE = 'CANCELAMENTO TEF - N�o foi possivel completar a opera��o, por cancelamento da transa��o ou problemas com a operadora.';

  // menagens de informa��o
  CT_FaltaCaixa = 'FALTA CAIXA - N�o foi definido nenhum caixa pard�o para esta m�quina, configure esta op��o no m�dulo de Configura��es de Sistema.';
  CT_CaixaGeralJaCriado = 'CAIXA J� FOI CRIADO PARA ESTA DATA - Um caixa geral n�o pode ser aberto duas vezes no mesmo dia.';
  CT_CaixaJaAberto = 'CAIXA J� ESTA ABERTO - Este caixa n�o pode ser aberto novamente!';
  CT_PArcialJaAberto = 'PARCIAL J� ESTA ABERTO - Este caixa ja possui uma parcial aberta!';
  CT_SemCaixaGeral = 'N�O EXISTE CAIXA ABERTO - N�o existe caixa geral aberto!';
  CT_CaixaDataInvalida = 'DATA ABERTURA INV�LIDA - Este caixa n�o pode ser aberto nesta data, pois existem caixas com data de abertura superior a esta.';
  CT_CaixaParcialDataInvalida = 'DATA ABERTURA INV�LIDA - Este caixa parcial n�o pode ser aberto nesta data, pois o caixa est� com data de abertura inferior.';
  CT_ItemDataInvalida = 'DATA ABERTURA INV�LIDA - O caixa est� com data de abertura inferior.';
  CT_CaixaJaFechado = 'CAIXA FECHADO OU N�O ABERTO - Este caixa est� fechado ou n�o foi aberto ainda!';
  CT_ParcialAberto = 'PARCIAL ABERTO - Existe parcial de caixa aberto, feche a parcial antes!';
  CT_FechaCaixaProblema = 'CAIXA COM PROBLEMA = Deseja realmente fechar este caixa com os valores incorretos ? ';
  CT_CaixaAtivo = 'SEM CAIXA ATIVO - N�o existe caixa ativo para lan�amentos.';
  CT_ParcialGeralAberto = 'ERRO REABERTURA - O Caixa j� est� aberto!';
  CT_CaixaJaFechadoData = 'CAIXA J� FECHADO NA DATA - Este caixa n�o pode ser reaberto nesta data.';
  CT_ERROCLIENTEDEVOLUCAO =  'ERRO CLIENTE - N�o existe nenhum cliente de devolu��o na configura��o de sistema.';
  CT_NotaFaltante = 'FALTA NOTA - N�o foi definido nenhuma nota fiscal pard�o para esta m�quina, configure esta op��o no m�dulo de Configura��es de Sistema.';

  CT_UsuarioSemAtividade = 'USU�RIO SEM ATIVIDADE - Usu�rio fora de atividade, para poder entrar no sistema pe�a ao seu administrador para alterar sua situa��o!';
  CT_UsuarioOutraFilial = 'USU�RIO VISITANTE - Este usu�rio n�o pertence a esta filial !!';
  CT_ProdutoJaEstourado = 'PRODUTO ESTOURADO - Este produto j� est� estourado!';
  CT_NaoExisteModelo = 'MODELO NULO - N�o existe modelo para altera��o!';
  CT_DuplicacaoChave = 'C�DIGO DUPLICADO - Este c�digo j� existe!';
  CT_CodigoNaoCadastrado='C�DIGO N�O EXISTE - Este c�digo n�o existe no cadastro!';
  CT_NaoExisteGrupoUSuarios = 'FILIAL SEM GRUPO - Esta filial n�o possui grupo para habilitar permiss�es do Sistema!';
  CT_PermissaoNegada = 'PERMISS�O NEGADA - Voc� n�o tem permiss�o para acessar este formul�rio, consulte o administrador do Sistema!';
  CT_FimNumerosFaixa = 'FIM DE FAIXA - N�o � possivel gerar um novo c�digo, pois estourou a faixa para este cadastro, procure o administrador do Sistema para liberar valores de c�digo para este cadastro!';
  CT_FilialSemMascara = 'FALTA M�SCARA - N�o foi definida nenhuma m�scara para a classifica��o de produtos desta filial, configure a m�scara em configura��es Gerais! '; // n�o foi defenido nenhuma picture para a classificacao de produtos
  CT_ClassificacaoDados = 'CLASSIFICA��O COM DADOS - Voc� n�o pode alterar a m�scara porque a tabela de classifica��es possui dados!';
  CT_NomeTabela = 'ERRO TABELA - N�o existe o nome da tabela, ou esta errada!'; // ocorre na unidade convers�o de indice kg,m,mm,cm
  CT_FaltaIndice = 'N�O EXISTE �NDICE - N�o foi cadastrado o �ndice de convers�o para esta opera��o ';
  CT_TipoVariant = 'TIPO VARIANT - O tipo de variante n�o � compat�vel';
  CT_ValorDiferente = 'VALOR DIFERENTE - O somat�rio das parcelas n�o � igual ao total da nota ';
  CT_ValorDiferenteCheques = 'VALOR DIFERENTE - O somat�rio dos valores n�o � igual ao total da a pagar ';
  CT_VerificaCapaLote = 'VERIFICAR CAPA LOTE - Favor conferir e verificar a capa de lote ';
  CT_ErroMaximoTolerado = 'ERRO M�XIMO - O erro m�ximo tolerado � de ';   //ocorre na verificacao no cadastro das parcelas do contas a pagar.
  CT_CodigojaUtilizado = 'C�DIGO J� UTILIZADO - O C�digo acabou de ser usado por um outro usu�rio da rede, o novo c�digo ser� ';
  CT_ProdutoNotaRepetido = 'PRODUTO REPETIDO - Este produto j� existe na Nota Fiscal';
  CT_FaltaDadosNroNota = 'FALTA DE DADOS - Dados do Corpo da Nota Incompletos ';
  CT_ServicoRepetido = 'SERVI�O REPETIDO - A Nota Fiscal j� possui este servi�o.';
  CT_CodServicoRepetido = 'SERVI�O REPETIDO - J� existe um servi�o com esta c�digo.';
  CT_ValorNotaNulo = 'VALOR NOTA NULO - O Valor da Nota Fiscal n�o pode ser nula! ';
  CT_NaoPossuiNota = 'N�O POSSUI NOTA - Esta conta n�o possui nota fiscal cadastrada.';
  CT_FornecedorProdutoRepetido = 'FORNECEDOR REPETIDO - Este Fornecedor j� foi informado neste produto';
  CT_NaoFoiCriadoParcelaPArcial = 'N�O FOI CRIADA PARCELA - N�o foi criada a parcela parcial';
  CT_EstoqueProdutoMinimo = 'ESTOQUE M�NIMO - A quantidade de produtos em estoque est� em sua quantidade m�nima';
  CT_EstoquePedido = 'ESTOQUE PEDIDO - A quantidade de produtos em estoque est� em sua quantidade de pedido ';
  CT_ProdutoPontoPedido = 'PONTO PEDIDO - Este produto est� em ponto de pedido.';
  CT_FaltaProduto = 'FALTA PRODUTO - N�o existe a quantidade suficiente do produto em estoque';
  CT_ProdutoJaEstaNoOrcamento = 'PRODUTO DUPLICADO - Produto j� existe na cota��o';
  CT_OrcamentoSemProduto = 'COTA��O SEM PRODUTO - N�o � poss�vel realizar a opera��o pois a cota��o n�o possui nenhum produto associado';
  CT_CondicaoPagtoNulo = 'CONDI��O DE PAGAMENTO NULO - N�o � poss�vel efetuar a opera��o porque a Condi��o de Pagamento est� nula !';
  CT_DescontoInvalido = 'DESCONTO INV�LIDO - O desconto concedido ao produto e superior ao permitido, o desconto maximo e de %s, mudar desconto?';
  CT_ExclusaoMovBancario = 'EXCLUSAO MOVIMENTO BANC�RIO - N�o podera ser excluido o movimento banc�rio, este j� esta conciliado!';
  CT_ImpressoraInvalida = 'IMPRESSORA INVALIDA -  Impressora configurada no sistema inv�lida ou n�o encontrada!!!';
  CT_AdicionaAtividade = 'ADICIONA FORA DE ATIVIDADE - Voc� deseja adicionar os produtos fora de atividade ? ';
  CT_AlteraTabelaPreco = 'ATEN��O - ALTERA��O NA TABELA DE PRECO !!! Voc� tem certeza que deseja alterar os valores da tabela de pre�o, sendo que n�o ser� possivel retornar ao estado anterior?';
  CT_RegravarBarra = 'REGRAVAR BARRA - Voc� tem certeza que deseja regravar o C�digo de Barra %s ';
  CT_InserirProdutoTodaFilial = 'TODAS FILIAIS - Deseja inserir este produto para todas as filiais da empresa atual.';
  CT_MemoriaFluxo =  'SEM MEM�RIA - Mem�ria insuficiente, Feche alguns Fluxo!';
  CT_FluxoFimNivel = 'FIM DE N�VEL - N�o existe mais nenhum n�vel com dados!';
  CT_ParcelaPaga = 'EXISTE PARCELA PAGA - Esta opera��o n�o pode ser executada porque possui parelas pagas. ';
  CT_BaixaInvalida = 'BAIXA INVALIDA - Esta conta n�o foi baixada por erro interno.';

  //ICMS
  CT_ErroICMS = 'ERRO ICMS - N�o foi poss�vel localizar o ICMS por falta de cadastro';
  // natureza de operacao
  CT_NaturezaInvalida = 'ERRO NATUREZA DE OPERA��O - Natureza de Opera��o Inv�lida ';  // quando a natureza de opera��o � invalida
  CT_DADOSINCOMPLETOS = 'DADOS INCOMPLETOS - Campos em branco'; // quando no estouro de mat pri ou servico faltar a unidade, quantidade ou valores;
  CT_NotaRepetida = 'NOTA CADASTRADA - A Nota fiscal de n�mero %d e s�rie %s j� foi cadastrada, o pr�ximo n�mero ser� %d .';
  CT_NotaRepetidaNroManual = 'NOTA CADASTRADA - A Nota fiscal de n�mero %d e s�rie %s j� foi cadastrada ';
  CT_NroNotaSerieNula = 'VALOR INV�LIDO - O N�mero ou a s�rie da Nota Fiscal esta em branco ';
  CT_SerieInvalida = 'SERIE INVALIDA - Este n�mero de s�rie n�o � v�lida, cadastre-a em configura��es de sistema.';
  CT_ImpressoraCondensada = 'IMPRESSORA CONDENSADA - Verifique se a configura��o da Fonte da Impressora est� em condensado.';
  CT_NotaJaImpressaExclusao = 'NOTA J� IMPRESSA = A Nota Fiscal de n�mero %s j� est� impressa, n�o pode ser exclu�da, esta dever� ser cancelada.';
  CT_DeletarNota = 'DELETAR NOTA - Deseja realmente excluir a nota nr. %s !!!';
  CT_CancelarNota = 'CANCELAR NOTA - Deseja realmente cancelar a nota nr. %s !!!';
  CT_DevolucaoNota = 'DEVOLU��O NOTA - Deseja realmente dar entrada de devolu��o da nota nr. %s !!!';
  CT_MoedasVazias = ' MOEDAS VAZIAS - As Moeda(s) %s de hoje esta(�o) com valores zerados, isto afetar� os c�lculos realizados a seguir! ';
  CT_DataMoedaDifAtual = 'DATA DIFERENTE - A Data do sistema est� diferente da data atual das moedas, voc� deve atualizar as moedas atuais, ou verificar a data do computador !';
  CT_MoedaVazia = 'MOEDAS VAZIAS - A Moeda  %s est� sem cota��o!';
  CT_ParcelaAntVAzia = 'PARCELA ANTERIOR EM ABERTO -  A parcela anterior n�o est� quitada, baixe primeiro a anterior!';
  CT_ParcelaPosPaga = 'PARCELA POSTERIOR PAGA -  Esta parcela n�o pode ser alterada, estorne primeiro a posterior.';  
  CT_EstonoPacialInvalida = 'PARCELA POSSUI PARCIAL - Esta parcela possui mais de um lan�amento parcial, estorne o pen�ltimo lan�amento!';
  CT_AutorizacaoMoedaBase = 'Autoriza��o M�xima de altera��o do Sistema, somente para suporte autorizado';
  CT_DiretorioInvalidoECF = 'PASTA INV�LIDA - N�o foi possivel localizar o a pasta %s !';
  CT_DataDifECF = 'DATA DIFERENTE DO ECF - Data da impressora do ECF est� diferente da data do sistema !';
  CT_KitConversaoMoeda = 'MUDAN�A DE MOEDA - N�o � possivel alterar a moeda de um kit ou de seus produtos que o comp�e !';
  CT_PortaVazia = 'LOCAL DE IMPRESSAO VAZIO - N�o foi definido nenhum local de impress�o para esta opera��o, configure a impressora no sistema.';
//  CT_NotaFiscalJaImpressa = 'NOTA IMPRESSA - Voc� deseja escluir a conta sendo que a Nota Fiscal n�o ser� excluida, nem cancelada por que ja foi impressa ? ';
type
  Uf = array[1..27] of string;
const
  // Estado para carregar no combo UF
  CT_UF : UF = ('AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO');

//envio Mensagens
procedure erro( texto : string);
procedure erroFormato( texto : string; adicional : array of Const);
procedure aviso( texto : string );
procedure AvisoFormato( texto : string; adicional : array of Const);
procedure Informacao( texto : string );
procedure InformacaoFormato( texto : string; adicional : array of Const);
function Confirmacao ( texto : string ) : boolean;
function ConfirmacaoFormato( texto : string; adicional : array of Const) : Boolean;
function Entrada(titulo : string; Texto : string; var retorno : string; senha : boolean; CorCaixa : Tcolor; CorFundo : Tcolor) : Boolean;
function EntradaNumero(titulo : string; Texto : string; var retorno : string; senha : boolean; CorCaixa : Tcolor; CorFundo : Tcolor; UsarMoeda : Boolean) : Boolean;
function EntraData(Titulo : String; Texto : string; var Data : TDateTime ) : Boolean;


implementation

uses
  Entrada, AEntraData;
{******************************************************************************}

{ mensagen de erro }
procedure erro( texto : string);
begin
   beep;
   MessageDlg(Texto,mterror,[mbOk],0);
end;

procedure erroFormato( texto : string; adicional : array of Const);
begin
   beep;
   MessageDlg(Format(Texto,adicional) ,mterror,[mbOk],0);
end;

{******************************************************************************}

{ mensagen de aviso }
procedure aviso( texto : string);
begin
   beep;
   MessageDlg(Texto,mtWarning,[mbOk],0);
end;

procedure AvisoFormato( texto : string; adicional : array of Const);
begin
   beep;
   MessageDlg(Format(Texto,adicional) ,mtWarning,[mbOk],0);
end;

{******************************************************************************}

{ mensagen de informacao }
procedure Informacao( texto : string);
begin
   beep;
   MessageDlg(Texto,mtInformation,[mbOk],0);
end;

procedure InformacaoFormato( texto : string; adicional : array of Const);
begin
   beep;
   MessageDlg(Format(Texto,adicional) ,mtInformation,[mbOk],0);
end;

{******************************************************************************}

{ mensagen de confirmacao }
function Confirmacao( texto : string) : Boolean;
begin
   result := false;
   beep;
  if MessageDlg(Texto, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    result := true;
end;

function ConfirmacaoFormato( texto : string; adicional : array of Const) : Boolean;
begin
   result := false;
   beep;
   if MessageDlg(Format(Texto,adicional) ,mtConfirmation,[mbYes, mbNo],0) = mrYes  then
      result := true;
end;

{******************************************************************************}
function entrada(titulo : string; Texto : string; var retorno : string; senha : boolean; CorCaixa : Tcolor; CorFundo : Tcolor) : Boolean;
var
  Form : TFEntrada;
begin
  Form := TFEntrada.Create(application);
  form.Caixa.Color := CorCaixa;
  form.Color := CorFundo;
  Form.Texto.Caption := texto;
  Form.Caixa.Text := retorno;
  Form.Caption := Titulo;
  if senha then
  begin
     form.Caixa.PasswordChar := '*';
     form.Caixa.CharCase := ecUpperCase;
  end;
  result := form.Executa(retorno);
end;


function EntraData(Titulo : String; Texto : string; var Data : TDateTime ) : Boolean;
begin
result := false;
FEntraData := TFEntraData.Create(application);
FEntraData.Caption := Titulo;
FEntraData.Textodata.Caption := texto;
FEntraData.CaixaData.Date := data;
if FEntraData.Executa(data) then
 result := true;
end;


function EntradaNumero(titulo : string; Texto : string; var retorno : string; senha : boolean; CorCaixa : Tcolor; CorFundo : Tcolor; UsarMoeda : Boolean) : Boolean;
var
  Form : TFEntrada;
begin
  Form := TFEntrada.Create(application);
  form.Caixa.Color := CorCaixa;
  form.Color := CorFundo;
  Form.Texto.Caption := texto;
  try
    Form.Numero.AValor := StrToFloat(retorno);
  except
  end;
  Form.Caption := Titulo;
  Form.SomenteNumeros(UsarMoeda);
  if senha then
  begin
     form.Caixa.PasswordChar := '*';
     form.Caixa.CharCase := ecUpperCase;
  end;
  result := form.Executa(retorno);
end;


end.
