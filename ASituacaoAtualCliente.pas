unit ASituacaoAtualCliente;

//               Autor: Jorge Eduardo Rodrigues
//     Data da Criação: 23/05/2001
//              Função: Mostra a Situação Do Cliente Nos Negócios Anteriores
//        Alterado por: JORGE EDUARDO
//   Data da Alteração: 11 DE SETEMBRO 2001
// Motivo da Alteração: CHAMAR TELA NA CONSULTA DE EMITENTES

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  StdCtrls, Buttons, BotaoCadastro, Mask, numericos, PainelGradiente,
  ExtCtrls, Componentes1, Db, DBTables, Grids, DBGrids, Tabela,
  DBKeyViolation, DBCtrls;

type
  TFSituacaoAtualCliente = class(TFormularioPermissao)
    PanelColor3: TPanelColor;
    PanelColor4: TPanelColor;
    PainelGradiente1: TPainelGradiente;
    DataAux1: TDataSource;
    Aux: TQuery;
    Soma2: TQuery;
    DataSoma2: TDataSource;
    DataSoma3: TDataSource;
    Soma3: TQuery;
    GridIndice2: TGridIndice;
    PanelColor5: TPanelColor;
    Label7: TLabel;
    GridIndice1: TGridIndice;
    Label4: TLabel;
    BotaoFechar1: TBotaoFechar;
    Soma2c_sit_doc: TStringField;
    Soma2soma1: TFloatField;
    Soma2TIPO: TStringField;
    Soma3C_SIT_DOC: TStringField;
    Soma3I_COD_BAN: TIntegerField;
    Soma3C_NOM_BAN: TStringField;
    Soma3SOMA3: TFloatField;
    Soma3TIPO: TStringField;
    AuxGERAL: TFloatField;
    numerico1: Tnumerico;
    DsEmitentes: TDataSource;
    Emitentes: TQuery;
    Emitentesi_cod_emi: TIntegerField;
    Emitentesi_cod_emi_1: TIntegerField;
    Emitentesc_nom_emi: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BotaoFechar1Click(Sender: TObject);
    procedure Soma2CalcFields(DataSet: TDataSet);
    procedure Soma3CalcFields(DataSet: TDataSet);
  private
    procedure  SomaGeral (CodEmitente : integer);
    procedure SomaPorSituacao (CodEmitente : integer);
    procedure SomaPorBanco (CodEmitente : integer);
  public
     procedure AbreConsulta(CodEmitente : integer; NomEmitente : string);
  end;

var
  FSituacaoAtualCliente: TFSituacaoAtualCliente;

implementation
  uses APrincipal, funsql, AMovFactori,ACadEmitentes,AConsultaEmitentes;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFSituacaoAtualCliente.FormCreate(Sender: TObject);
begin

end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFSituacaoAtualCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Aux.Close;
 Soma2.Close;
 Soma3.Close;
 Action := CaFree;
end;

{ ************ Soma o Total Negociado Com Determinado Cliente **************** }
procedure TFSituacaoAtualCliente.SomaGeral (CodEmitente : integer);
begin
  LimpaSQLTabela(Aux);
  AdicionaSQLTabela(Aux,' Select sum(N_TOT_LIQ) GERAL ' +
                          ' From  MovFactori ' +
                          ' Where I_COD_EMI = ' + IntToStr (CodEmitente));
  Aux.Open;
  numerico1.avalor := Aux.FieldByName('GERAL').Ascurrency;
end;

{ ************ Soma Valores Negociados Agrupados por Situação **************** }
procedure TFSituacaoAtualCliente.SomaPorSituacao (CodEmitente : integer);
begin
 Soma2.SQL.Clear;
 Soma2.SQL.Add(' Select C_SIT_DOC, sum(N_TOT_LIQ) SOMA1 ' +
               ' From MovFactori ' +
               ' Where I_COD_EMI = ' + IntToStr (CodEmitente) +
               ' Group by C_SIT_DOC ');
 Soma2.Open;
end;

{ ******* Soma Valores Negociados Agrupados por Situação e por Banco ********* }
procedure TFSituacaoAtualCliente.SomaPorBanco (CodEmitente : integer);
begin
 Soma3.SQL.Clear;
 Soma3.SQL.Add(' Select MOV.C_SIT_DOC, MOV.I_COD_BAN, BAN.C_NOM_BAN, ' +
               ' sum(N_TOT_LIQ) SOMA3    ' +
               ' From MovFactori as MOV, ' +
               '      CadBancos  as BAN  ' +
               ' Where MOV.I_COD_BAN = BAN.I_COD_BAN ' +
               ' and  MOV.I_COD_EMI = ' + IntToStr (CodEmitente) +
               ' Group by MOV.C_SIT_DOC, MOV.I_COD_BAN, BAN.C_NOM_BAN ');
 Soma3.Open;
end;


procedure TFSituacaoAtualCliente.AbreConsulta(CodEmitente : integer; NomEmitente : string);
begin
  SomaGeral(CodEmitente);
  SomaPorSituacao(CodEmitente);
  SomaPorBanco(CodEmitente);
  label7.Caption := (NomEmitente);
  Self.ShowModal;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
procedure TFSituacaoAtualCliente.BotaoFechar1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFSituacaoAtualCliente.Soma2CalcFields(DataSet: TDataSet);
begin
  if Soma2c_sit_doc.AsString = 'C' then
     Soma2TIPO.AsString := 'Carteira'
  else
    if Soma2c_sit_doc.AsString = 'D' then
       Soma2TIPO.AsString := 'Depositado'
    else
      if Soma2c_sit_doc.AsString = 'R' then
         Soma2TIPO.AsString := 'Reapresentado'
      else
        if Soma2c_sit_doc.AsString = 'V' then
           Soma2TIPO.AsString := 'Devolvido'
        else
          if Soma2c_sit_doc.AsString = 'N' then
             Soma2TIPO.AsString := 'Renegociado';
end;

procedure TFSituacaoAtualCliente.Soma3CalcFields(DataSet: TDataSet);
begin
  if Soma3C_SIT_DOC.AsString = 'C' then
     Soma3TIPO.AsString := 'Carteira'
  else
    if Soma3c_sit_doc.AsString = 'D' then
       Soma3TIPO.AsString := 'Depositado'
    else
      if Soma3c_sit_doc.AsString = 'R' then
         Soma3TIPO.AsString := 'Reapresentado'
      else
        if Soma3c_sit_doc.AsString = 'V' then
           Soma3TIPO.AsString := 'Devolvido'
        else
          if Soma3c_sit_doc.AsString = 'N' then
            Soma3TIPO.AsString := 'Renegociado';
end;

Initialization
 RegisterClasses([TFSituacaoAtualCliente]);
end.
