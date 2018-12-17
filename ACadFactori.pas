unit ACadFactori;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Mask, DBCtrls, Tabela, Db, DBTables, ExtCtrls, Componentes1,
  Buttons, BotaoCadastro, DBKeyViolation, Localizacao, ComCtrls, Grids,
  DBGrids, PainelGradiente, numericos;

type
  TFCadFactori = class(TFormularioPermissao)
    PanelColor1: TPanelColor;
    CadFactori: TSQL;
    DataCadFactori: TDataSource;
    EDataMovimentacao: TDBEditColor;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    ProximoCodigoFilial1: TProximoCodigoFilial;
    CadFactoriI_EMP_FIL: TIntegerField;
    CadFactoriI_LAN_FAC: TIntegerField;
    CadFactoriI_COD_CLI: TIntegerField;
    CadFactoriD_DAT_MOV: TDateField;
    CadFactoriD_ULT_ALT: TDateField;
    CadFactoriN_PER_CPM: TFloatField;
    CadFactoriN_VAL_TOT: TFloatField;
    Label2: TLabel;
    EditCliente: TEditLocaliza;
    SpeedButton3: TSpeedButton;
    Procurador: TConsultaPadrao;
    Label3: TLabel;
    ValidaGravacao1: TValidaGravacao;
    PainelGradiente1: TPainelGradiente;
    PanelColor3: TPanelColor;
    BotaoCadastrar1: TBotaoCadastrar;
    BotaoAlterar1: TBotaoAlterar;
    BotaoExcluir1: TBotaoExcluir;
    BotaoGravar1: TBotaoGravar;
    BotaoCancelar1: TBotaoCancelar;
    BBAjuda: TBitBtn;
    BBFechar: TBitBtn;
    Bevel2: TBevel;
    numerico1: Tnumerico;
    numerico2: Tnumerico;
    DBFilialColor1: TDBFilialColor;
    MoveBasico1: TMoveBasico;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BBFecharClick(Sender: TObject);
    procedure CadFactoriAfterInsert(DataSet: TDataSet);
    procedure CadFactoriBeforePost(DataSet: TDataSet);
    procedure CadFactoriAfterPost(DataSet: TDataSet);
    procedure CadFactoriAfterEdit(DataSet: TDataSet);
    procedure CadFactoriAfterCancel(DataSet: TDataSet);
    procedure EFactoriChange(Sender: TObject);
    procedure BotaoCancelar1DepoisAtividade(Sender: TObject);
  private
    procedure LimpaFiltros;
    procedure AdicionaFiltros(VpaSelect : TStrings);
  public
    procedure ConfiguraConsulta(acao:boolean);
  end;

var
  FCadFactori: TFCadFactori;

implementation
uses aPrincipal,Constantes,funObjeto,funSql, fundata, funstring, constmsg;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFCadFactori.FormCreate(Sender: TObject);
begin
 Self.HelpFile := Varia.PathHelp + 'MaGeral.hlp>janela';  // Indica o Paph e o nome do arquivo de Help
 DBFilialColor1.ACodFilial := Varia.CodigoEmpFil;
 cadFactori.SQL.clear;
 cadFactori.sql.Add('  Select * from Cadfactori' +
                    '  Where I_EMP_FIL = ' + IntToStr(Varia.CodigoEmpFil) );
 CadFactori.sql.Add(' Order by I_Lan_Fac' );
 cadFactori.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFCadFactori.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 CadFactori.close;
 Action := CaFree;
end;


{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFCadFactori.BBFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TFCadFactori.CadFactoriAfterInsert(DataSet: TDataSet);
begin
   DBFilialColor1.ProximoCodigo;
   CadFactoriI_EMP_FIL.AsInteger := Varia.CodigoEmpFil; 
   ProximoCodigoFilial1.execute('cadfactori','I_EMP_FIL',Varia.CodigoEmpFil);
   BotaoCadastrar1.Enabled:=false;
   BotaoExcluir1.Enabled:=false;
   BotaoAlterar1.Enabled:=false;
end;

procedure TFCadFactori.CadFactoriBeforePost(DataSet: TDataSet);
begin
  CadFactoriD_ULT_ALT.AsDateTime := Date;
  CadFactoriI_EMP_FIL.AsInteger := Varia.CodigoEmpFil;
  if CadFactori.State = dsinsert then
     DBFilialColor1.VerificaCodigoRede;
 if (EditCliente.text = '')    then
  begin
    Informacao (CT_ErroCampoCliente);
    abort;
  end;
end;

procedure TFCadFactori.CadFactoriAfterPost(DataSet: TDataSet);
begin
  CadFactori.Close;
  CadFactori.Open;
  ConfiguraConsulta(true);

end;

procedure TFCadFactori.CadFactoriAfterEdit(DataSet: TDataSet);
begin
   ConfiguraConsulta(false);
end;
procedure TFCadFactori.LimpaFiltros;
begin
   { LimpaEdits(PanelColor1);   }
end;
procedure TFCadFactori.ConfiguraConsulta(acao:boolean);
begin

end;

procedure TFCadFactori.CadFactoriAfterCancel(DataSet: TDataSet);
begin
  ConfiguraConsulta(True);
end;

procedure TFCadFactori.EFactoriChange(Sender: TObject);
begin
  if (CadFactori.State in [dsInsert, dsEdit]) then
  ValidaGravacao1.Execute;
end;

procedure TFCadFactori.AdicionaFiltros(VpaSelect : TStrings);
begin
   VpaSelect.add(' Where Cad.I_Emp_Fil = ' + IntToStr(Varia.CodigoEmpFil));
  if EditCliente.Text <> '' then
    VpaSelect.add('and Cad.I_COD_Cli = ' + EditCliente.text)
  else
   VpaSelect.add(' ');
end;

procedure TFCadFactori.BotaoCancelar1DepoisAtividade(Sender: TObject);
begin
  BotaoCadastrar1.Enabled:=false;
  BotaoExcluir1.Enabled:=false;
  BotaoAlterar1.Enabled:=false;
end;


        {insert into cadFactori(i_emp_fil, i_lan_fac, i_cod_cli, d_ult_alt)
values(11,proximo codigo,strtoint(edit .text), sqlcadFactori(date)}

Initialization
 RegisterClasses([TFCadFactori]);
end.
