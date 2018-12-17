unit AConsultaCheque;

//              Autor: Leonardo Emanuel Pretti
//        Data Criação: 17/04/2001
//              Função: Consulta de Cheques Recebidos
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Localizacao, Db, DBTables, Grids, DBGrids, Tabela, DBKeyViolation, constmsg,
  StdCtrls, Buttons, BotaoCadastro, Componentes1, ComCtrls, ExtCtrls,
  PainelGradiente, Mask, numericos;

type
  TFConsultaCheque = class(TFormularioPermissao)
    PainelGradiente1: TPainelGradiente;
    PanelColor1: TPanelColor;
    SpeedLocaliza1: TSpeedButton;
    SpeedLocaliza2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Data1: TCalendario;
    Data2: TCalendario;
    LocalizaCliente: TEditLocaliza;
    LocalizaBanco: TEditLocaliza;
    ECheque: TEditColor;
    PanelColor2: TPanelColor;
    BotaoFechar1: TBotaoFechar;
    Grade: TGridIndice;
    DCC: TDataSource;
    CadCC: TQuery;
    Localiza: TConsultaPadrao;
    CadCCC_NRO_CHE: TStringField;
    CadCCC_NOM_CLI: TStringField;
    CadCCD_CHE_VEN: TDateField;
    CadCCN_VLR_CHE: TFloatField;
    CadCCC_CON_CHE: TStringField;
    CadCCC_NOM_BAN: TStringField;
    PanelColor3: TPanelColor;
    Label8: TLabel;
    Aux: TQuery;
    Ntotal: Tnumerico;
    CadCCI_COD_BAN: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure Data1CloseUp(Sender: TObject);
    procedure LocalizaClienteRetorno(Retorno1, Retorno2: String);
    procedure EChequeExit(Sender: TObject);
  private
    procedure AtualizaConsulta;
    procedure AdicionaFiltros (VpaSelect : TStrings);
    function SomaValoresCheque : Double;
  public
  end;

var
  FConsultaCheque: TFConsultaCheque;

implementation
   uses APrincipal, ABancos, AClientes, Constantes,
        funsql, fundata, funobjeto,funnumeros;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFConsultaCheque.FormCreate(Sender: TObject);
begin
  Data1.Date := Date;
  Data2.Date := Date + 30;
  LimpaEdits (PanelColor1);
  AtualizaConsulta;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFConsultaCheque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadCC.close;{ fecha tabelas }
 Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFConsultaCheque.BotaoFechar1Click(Sender: TObject);
begin
  self.close;
end;

{ ***************************** Atualiza Consulta **************************** }
procedure TFConsultaCheque.AtualizaConsulta;
begin
  CadCC.SQL.Clear;
  CadCC.SQL.Add(' Select Mcr.C_NRO_CHE, Mcr.D_CHE_VEN, Mcr.I_LAN_REC, Mcr.I_COD_BAN, ' +
                '        Mcr.N_VLR_CHE, Mcr.C_CON_CHE, Mcr.I_EMP_FIL, Cli.C_NOM_CLI, ' +
                '        Ban.C_NOM_BAN, Ccr.I_EMP_FIL, Ccr.I_LAN_REC ' +
                '  From  MovContasAReceber as Mcr, ' +
                '        CadContasAReceber as Ccr, ' +
                '        CadClientes as Cli,       ' +
                '        CadBancos as Ban          ');
  AdicionaFiltros(CadCC.SQL);
  CadCC.SQL.Add('        and Ccr.I_EMP_FIL = Mcr.I_EMP_FIL ' +
                '        and Ccr.I_LAN_REC = Mcr.I_LAN_REC ' +
                '        and Ccr.I_COD_CLI = Cli.I_COD_CLI ' +
                '        and Mcr.I_COD_BAN = Ban.I_COD_BAN ');
  CadCC.SQL.Add(' Order  by  Mcr.D_CHE_VEN');
  CadCC.SQL.SaveToFile('C:\Meus documentos\SaveLeo');
  CADCC.OPEN;
  Ntotal.Text := FloatToStr(SomaValoresCheque);
end;

{ ***************************** Adiciona Filtros ***************************** }
procedure TFConsultaCheque.AdicionaFiltros (VpaSelect : TStrings);
begin
  VpaSelect.Add(' Where Mcr.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));

  VpaSelect.Add(SQLTextoDataEntreAAAAMMDD( 'D_CHE_VEN',Data1.Date, Data2.Date, true));

    if ECheque.Text <> '' then
      VpaSelect.Add(' and Mcr.C_NRO_CHE = '''+ ECheque.Text + '''')
    else
      VpaSelect.Add(' ');

    if LocalizaCliente.Text <> '' then
      VpaSelect.Add(' and Cli.I_COD_CLI = '+ LocalizaCliente.Text)
    else
      VpaSelect.Add(' ');

    if LocalizaBanco.Text <> '' then
      VpaSelect.Add(' and Ban.I_COD_BAN = '+ LocalizaBanco.Text)
    else
      VpaSelect.Add(' ');
end;

{ ****************** Atualiza Consulta ao Sair de Cada Edit ****************** }
procedure TFConsultaCheque.Data1CloseUp(Sender: TObject);
begin
 AtualizaConsulta;
end;

{ ******************** Soma o Valor dos Cheques Por Período ****************** }
function TFConsultaCheque.SomaValoresCheque : Double;
begin
  LimpaSQLTabela(aux);
  AdicionaSQLTabela(Aux,' select sum(N_VLR_CHE)SOMA      ' +
                        ' From MovContasAReceber as Mcr, ' +
                        '      CadContasAReceber as Ccr, ' +
                        '      CadClientes as Cli,       ' +
                        '      CadBancos as Ban          ');
  AdicionaFiltros(Aux.SQL);
  Aux.SQL.Add('and Ccr.I_EMP_FIL = Mcr.I_EMP_FIL ' +
              'and Ccr.I_LAN_REC = Mcr.I_LAN_REC ' +
              'and Ccr.I_COD_CLI = Cli.I_COD_CLI ' +
              'and Mcr.I_COD_BAN = Ban.I_COD_BAN ');
  Aux.Open;
  Result := Aux.FieldByname('SOMA').AsFloat;
  Aux.Close;
end;

procedure TFConsultaCheque.LocalizaClienteRetorno(Retorno1,
  Retorno2: String);
begin
  AtualizaConsulta;
end;

procedure TFConsultaCheque.EChequeExit(Sender: TObject);
begin
AtualizaConsulta;
end;

Initialization
 RegisterClasses([TFConsultaCheque]);
 end.
