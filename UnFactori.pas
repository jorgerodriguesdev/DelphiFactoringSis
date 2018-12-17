unit UnFactori;

interface
Uses Db, DBTables, classes, sysUtils;

//calculos da Nova Factori
Type TCalculosNovaFactori = class
  private
    calcula : TQuery;
  public
    constructor criar( aowner : TComponent; ADataBase : TDataBase ); virtual;
    destructor destroy; override;
    procedure SomaTotais(var liquido, juro, cpmf, total : Double; LanFactori : integer);
end;

// localizacao da Nova Factori
Type TLocalizaNovaFactori = class(TCalculosNovaFactori)
  public
    procedure LocalizaCadfactori(tabela : Tquery;  CodEmpFil, LanFac : integer);
    procedure LocalizaItemMovFactori(tabela : Tquery;  CodEmpFil, Lanfac, NroLan : integer);
end;

//funcoes da Nova Factori
Type TFuncoesNovaFactori = Class(TLocalizaNovaFactori)
  private
    Tabela : TQuery ;
    BaseDados : TDataBase;
  public
    Constructor Criar( aowner : TComponent; ADataBase : TDataBase ); override;
    destructor Destroy; Override;
    procedure ExcluirItemFactori(Tabela: TQuery;CodEmpFil, LanFac, NroLan : Integer);
    procedure ExcluirTodaFactori(Tabela: TQuery; CodEmpFil,Lanfac : Integer);
    procedure AlteraFactori(Tabela: TQuery;CodEmpFil, LanFac, NroLan : Integer);
 end;

implementation
  Uses  FunSql, Constantes, FunString, funNumeros, fundata, constmsg;


{ ****************** Na criação da classe ******************************** }
constructor TCalculosNovaFactori.criar( aowner : TComponent; ADataBase : TDataBase );
begin
  inherited;
  calcula := TQuery.Create(aowner);
  calcula.DatabaseName := ADataBase.DatabaseName;
end;

{ ******************* Quando destroy a classe ****************************** }
destructor TCalculosNovaFactori.destroy;
begin
  calcula.free;
  inherited;
end;

{********************************  SOMA TOTAIS JUROS **************************}
procedure TCalculosNovaFactori.SomaTotais(var liquido, juro, cpmf, total : Double; LanFactori : integer);
begin
  LimpaSQLTabela(calcula);
  AdicionaSQLTabela(calcula,'  Select ' +
                            '  Sum (N_VLR_JUR) as TOTAL_JUROS,  '+
                            '  Sum (N_VLR_CPM) as TOTAL_CPMF,   '+
                            '  Sum (N_VLR_DOC) as TOTAL_DOC,    '+
                            '  Sum (N_TOT_LIQ) as TOTAL_LIQUIDO '+
                            '  From MovFactori '+
                            '  Where I_EMP_FIL =  ' + IntToStr(Varia.CodigoEmpFil )+
                            '  AND  I_LAN_FAC  =  ' + Inttostr(LanFactori) );
  calcula.Open;
  liquido := calcula.FieldByname('Total_LIQUIDO').AsCurrency;
  Juro:=  calcula.FieldByname('TOTAL_JUROS').AsCurrency;
  cpmf:=  calcula.FieldByName('TOTAL_CPMF').AsCurrency;
  total:= calcula.FieldByname('TOTAL_DOC').AsCurrency;
  calcula.Close;
end;

{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                   Localiza
))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{****************************** LOCALIZA CADFACTOING **************************}
procedure TLocalizaNovaFactori.LocalizaCadFactori(tabela : Tquery; CodEmpFil, LanFac : integer);
begin
  AdicionaSQLAbreTabela(Tabela, ' Select * from  CadFactori' +
                                ' where i_emp_fil = ' + Inttostr(CodEmpFil) +
                                ' and I_Lan_Fac = ' + Inttostr(LanFac));
end;

{****************************** LOCALIZA MOVFACTOING **************************}
procedure TLocalizaNovaFactori.LocalizaItemMovFactori(tabela : Tquery; CodEmpFil, LanFac, Nrolan: integer);
begin
  AdicionaSQLAbreTabela(Tabela, ' Select * from  MovFactori' +
                                ' where i_emp_fil = ' + Inttostr(CodEmpFil) +
                                ' and I_Lan_Fac = ' + Inttostr(LanFac) +
                                ' and I_Nro_Lan = ' + IntToStr(NroLan));
end;


{(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((
                                    Funcoes
)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) }

{************************** ABRE TABELA TQUERY ********************************}
Constructor TFuncoesNovaFactori.Criar( aowner : TComponent; ADataBase : TDataBase );
begin
  inherited;
  Tabela := TQuery.Create(nil);
  Tabela.DataBaseName := ADataBase.DatabaseName;
  self.BaseDados := ADataBase
end;
{************************** FECHA  TABELA TQUERY ******************************}
destructor TFuncoesNovaFactori.Destroy;
begin
  tabela.close;
  tabela.free;
  inherited;
end;

{****************************** EXCLUIR Documentos da  Factoring **********************************}
procedure  TFuncoesNovaFactori.ExcluirItemFactori(Tabela: TQuery;CodEmpFil, LanFac, Nrolan : Integer);
begin
  ExecutaComandoSql(Tabela,' Delete MovFactori ' +
                           ' where i_emp_fil = ' + IntToStr(CodEmpFil) +
                           '  and  I_LAN_FAC = ' + IntToStr(LanFac) +
                           '  and  I_Nro_Lan = ' + IntToStr(NroLan));
end;
{****************************** EXCLUIR Toda  Factoring **********************************}
procedure  TFuncoesNovaFactori.ExcluirTodaFactori(Tabela: TQuery; CodEmpFil,Lanfac : Integer);
begin
  ExecutaComandoSql(Tabela,' Delete MovFactori ' +
                           ' where i_emp_fil =  ' + IntToStr( CodEmpFil) +
                           ' and I_Lan_fac = ' + IntToStr(LanFac));

  ExecutaComandoSql(Tabela,' Delete Cadfactori ' +
                           ' where i_emp_fil = ' + IntToStr( CodEmpFil) +
                           '  and  I_Lan_fac = ' + IntToStr(LanFac));
end;
{****************************** Altera Factoring **********************************}
procedure TFuncoesNovaFactori.AlteraFactori(Tabela: TQuery;CodEmpFil, LanFac, NroLan : Integer);
begin
   ExecutaComandoSql(Tabela,' Update MovFactori ' +
                            ' where  I_LAN_FAC = ' + IntToStr(LanFac) +
                            '  and  I_Nro_Lan = ' + IntToStr(NroLan));
end;

end.
