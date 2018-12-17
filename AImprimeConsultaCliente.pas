unit AImprimeConsultaCliente;

//     Data da Criação: 17/05/2001
//              Função: Imprimir Relatório de Cheques Por Cliente (Transação)
//        Alterado por:
//   Data da Alteração:
// Motivo da Alteração:

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, formularios,
  Qrctrls, QuickRpt, ExtCtrls, Db, DBTables, Geradores;

type
  TFImprimeConsultaCliente = class(TFormularioPermissao)
    CadFactori: TQuery;
    MovFactori: TQuery;
    MovFactoriD_DAT_VEN: TDateField;
    MovFactoriN_TOT_LIQ: TFloatField;
    MovFactoriN_VLR_JUR: TFloatField;
    Report: TQuickRepNovo;
    PageHeaderBand2: TQRBand;
    DetailBand2: TQRBand;
    SummaryBand2: TQRBand;
    PageFooterBand2: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRShape1: TQRShape;
    QRCliente: TQRLabel;
    QRLabel6: TQRLabel;
    EmpFil: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape2: TQRShape;
    Pagina: TQRLabel;
    Cliente: TQRLabel;
    Tran: TQRLabel;
    MovFactoriC_NOM_BAN: TStringField;
    Emitente: TQRLabel;
    Documento: TQRLabel;
    Banco: TQRLabel;
    QRLabel2: TQRLabel;
    VlrJuros: TQRLabel;
    QRLabel24: TQRLabel;
    Vcmento: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText7: TQRDBText;
    MovFactoriN_VLR_CPM: TFloatField;
    MovFactoriC_NRO_DOC: TStringField;
    MovFactoriN_VLR_DOC: TFloatField;
    Liquido: TQRLabel;
    Juros: TQRLabel;
    Bruto: TQRLabel;
    TotalBruto: TQRLabel;
    TotalLiquido: TQRLabel;
    TotalJuros: TQRLabel;
    MovFactoriC_NOM_EMI: TStringField;
    QRDBText2: TQRDBText;
    MovFactoriI_DIA_VEN: TIntegerField;
    QRDBText1: TQRDBText;
    QRLabel3: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure GeraCliente (Nlan, Iemp : integer; totjur, totliq, totbru, cpm, nomcli : string);
  end;

var
  FImprimeConsultaCliente: TFImprimeConsultaCliente;

implementation
   uses APrincipal, AClientes, Constantes, funsql, fundata, funobjeto, funnumeros;
{$R *.DFM}


{ ****************** Na criação do Formulário ******************************** }
procedure TFImprimeConsultaCliente.FormCreate(Sender: TObject);
begin
  MovFactori.Open;
end;

{ ******************* Quando o formulario e fechado ************************** }
procedure TFImprimeConsultaCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MovFactori.Close;
  Action := CaFree;
end;
{ ***************************** Gera Relatório ******************************* }
procedure TFImprimeConsultaCliente.GeraCliente (Nlan, Iemp : integer;
 totjur, totliq, totbru, cpm, nomcli : string);
begin
  MovFactori.SQL.Clear;
  MovFactori.SQL.Add(' Select Mfc.C_NRO_DOC, Mfc.I_DIA_VEN, Mfc.D_DAT_VEN, Mfc.I_LAN_FAC, ' +
                     '        Mfc.I_NRO_LAN, Mfc.N_PER_JUR, Mfc.N_TOT_LIQ, Mfc.N_VLR_DOC, ' +
                     '        Mfc.N_VLR_JUR, Mfc.N_VLR_PAG, Mfc.I_EMP_FIL, Mfc.N_VLR_CPM, ' +
                     '        EMI.I_COD_EMI, EMI.C_NOM_EMI, Ban.I_COD_BAN, Ban.C_NOM_BAN  ' +
                     '  From  MovFactori   as Mfc,                                        ' +
                     '        CadEmitentes as Emi,                                        ' +
                     '        CadBancos    as Ban                                         ' +
                     ' Where      Mfc.I_COD_BAN = Ban.I_COD_BAN    ' +
                     '        and Mfc.I_COD_EMI = EMI.I_COD_EMI    ' +
                     '        and Mfc.I_LAN_FAC = ' + inttostr(Nlan) +
                     '        and Mfc.I_EMP_FIL = ' + inttostr(Iemp) +
                     ' Order  by  Mfc.I_NRO_LAN' );
  MovFactori.Open;
  EmpFil.Caption := Varia.NomeFilial;
  Bruto.Caption := totbru;
  Juros.Caption := totjur;
  Liquido.Caption := totliq;
  Cliente.Caption := nomcli;
  Tran.Caption := IntToStr(Nlan);
  Report.Preview;
  Self.Close;
end;

{ *************** Registra a classe para evitar duplicidade ****************** }
Initialization
 RegisterClasses([TFImprimeConsultaCliente]);
end.
