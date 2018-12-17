unit AConfiguracaoFactoring;
{          Autor: Jorge Eduardo Rodrigues
    Data Criação: 18/06/2001;
          Função: Modificar Configurações da factoring
  Data Alteração:
    Alterado por:}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, formularios, constMsg, DBCtrls, Tabela,
  Mask, Db, DBTables, BotaoCadastro, Buttons, Componentes1, constantes,
  ColorGrd, LabelCorMove, Grids, DBGrids, Registry, PainelGradiente,
  FileCtrl,printers, Localizacao, numericos;

type
  TFConfiguracaoFactoring = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    BotaoAlterar1: TBotaoAlterar;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    Fechar: TBitBtn;
    kk0y: TPageControl;
    BBAjuda: TBitBtn;
    TabSheet1: TTabSheet;
    JurDiario: TDBCheckBox;
    SenhaLiberacao: TDBCheckBox;
    CFGFACTORI: TTabela;
    DSFactori: TDataSource;
    DBRadioGroup1: TDBRadioGroup;
    CFGFACTORIC_JUR_DIA: TStringField;
    CFGFACTORIC_SEN_LIB: TStringField;
    Geral: TTable;
    DataGeral: TDataSource;
    GeralC_MAS_DAT: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FecharClick(Sender: TObject);
    procedure BotaoAlterar1DepoisAtividade(Sender: TObject);
    procedure BotaoGravar1DepoisAtividade(Sender: TObject);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
  private
      ini : TRegIniFile;
 {   procedure AlteraSenha;}
  public
    { Public declarations }
  end;

var
  FConfiguracaoFactoring: TFConfiguracaoFactoring;

implementation

uses APrincipal, FunValida, FunSql, funobjeto;

{$R *.DFM}

{ |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
 |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
                            Modulo Básico
||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| }

{ ******************* Na Criacao do formulario ****************************** }
procedure TFConfiguracaoFactoring.FormCreate(Sender: TObject);
begin
   CFGFACTORI.open;
   Geral.open;
   IniciallizaCheckBox([JurDiario,SenhaLiberacao ],'T','F');
end;

{ ******************* No fechamento do formulário **************************** }
procedure TFConfiguracaoFactoring.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  geral.close;
  CFGFACTORI.close;
  ini.free;
  Action := cafree;
end;


procedure TFConfiguracaoFactoring.FecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFConfiguracaoFactoring.BotaoAlterar1DepoisAtividade(
  Sender: TObject);
begin
  geral.Edit;
end;

procedure TFConfiguracaoFactoring.BotaoGravar1DepoisAtividade(
  Sender: TObject);
begin
  geral.Post;
end;

procedure TFConfiguracaoFactoring.BotaoCancelar1DepoisAtividade(
  Sender: TObject);
begin
  geral.Cancel;
end;

Initialization
{*****************Registra a Classe para Evitar duplicidade********************}
   RegisterClasses([TFConfiguracaoFactoring]);
end.
