unit AImprimeConsultaNegocio;

//     Data da Criação: 15/05/2001
//              Função: Imprimir Relatório de Cheques Por Negócio (Emitente)
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Db, DBTables, Qrctrls, QuickRpt, ExtCtrls, Geradores, StdCtrls, Mask,
  DBCtrls;

type
  TFImprimeConsultaNegocio = class(TFormularioPermissao)
    Report: TQuickRepNovo;
    PageHeaderBand2: TQRBand;
    SummaryBand2: TQRBand;
    PageFooterBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
    Documento: TQRLabel;
    Banco: TQRLabel;
    QRLabel2: TQRLabel;
    VlrJuros: TQRLabel;
    QRLabel24: TQRLabel;
    Vcmento: TQRLabel;
    EmpFil: TQRLabel;
    Liquido: TQRLabel;
    Juros: TQRLabel;
    Bruto: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape2: TQRShape;
    Pagina: TQRLabel;
    MovFactori: TQuery;
    MovFactoriD_DAT_VEN: TDateField;
    MovFactoriN_TOT_LIQ: TFloatField;
    MovFactoriI_EMP_FIL: TIntegerField;
    MovFactoriN_VLR_JUR: TFloatField;
    MovFactoriC_NOM_BAN: TStringField;
    DetailBand1: TQRBand;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText7: TQRDBText;
    MovFactoriN_VLR_CPM: TFloatField;
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriN_VLR_DOC: TFloatField;
    TotalBruto: TQRLabel;
    TotalLiquido: TQRLabel;
    TotalJuros: TQRLabel;
    MovFactoriC_NOM_EMI: TStringField;
    Emitente: TQRLabel;
    MovFactoriI_DIA_VEN: TIntegerField;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    QRLabel3: TQRLabel;
    QRDBText1: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure Carregarel( Sql : string; totliq, totbru, totjur, cpm : string);
  end;

var
  FImprimeConsultaNegocio: TFImprimeConsultaNegocio;


implementation

uses
   funsql, constantes;

{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeConsultaNegocio.FormCreate(Sender: TObject);
begin
  {  abre tabelas }
  { chamar a rotina de atualização de menus }
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeConsultaNegocio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { fecha tabelas }
 { chamar a rotina de atualização de menus }
 Action := CaFree;
end;

{ **************************** Carrega Relatório ***************************** }
procedure TFImprimeConsultaNegocio.Carregarel( Sql : string; totliq, totbru, totjur, cpm : string);
begin
  MovFactori.SQL.Clear;
  MovFactori.SQL.Add(SQL);
  MovFactori.Open;
  Bruto.Caption := totbru;
  Juros.Caption := totjur;
  Liquido.Caption := totliq;
  EmpFil.Caption := Varia.NomeFilial;
  Report.Preview;
  Self.Close;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
Initialization
 RegisterClasses([TFImprimeConsultaNegocio]);
end.
