�
 TFCONSULTAPORCLIENTE 0q5  TPF0TFConsultaPorClienteFConsultaPorClienteLeft�Top� Width(Height�Hint"Consulta de Documentos por ClienteCaption"Consulta de Documentos por ClienteColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterWindowStatewsMaximizedOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPainelGradientePainelGradiente1Left Top Width Height)AlignalTop	AlignmenttaLeftJustifyCaption   Consulta por ClienteFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderAConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor1Left Top)Width HeightEAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder AUsarCorFormACorFormFPrincipal.CorForm TLabelLabel10Left.Top)Width=Height	AlignmenttaRightJustifyCaption
Cadastro :Font.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTransparent	  TLabelLabel5Left<TopWidth/Height	AlignmenttaRightJustifyCaption	Cliente :Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFont  TSpeedButtonSpeedLocaliza2Left� Top	WidthHeight
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333333333333?3333330 333333�w333333 33333?ws333330 333333�w333333 333?�?ws337 ;p333?ws�w333ww �333w37ws330��p3337�337�33w����s3373337?33����33333333����33333333����33s�333s33w����s337�337�330��p3337?�3�3333ww3333w?�s33337 333333ws3333	NumGlyphs  TLabelLabel7Left� TopWidthHeight  TCalendarioData1LeftnTop&WidthVHeightCalAlignmentdtaLeftDate @7�ݮ��@Time @7�ݮ��@ColorclInfoBk
DateFormatdfShortDateMode
dmComboBoxFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style KinddtkDate
ParseInput
ParentFontTabOrder	OnCloseUpEClienteExitOnChangeEClienteExitACorFocoFPrincipal.CorFoco  TCalendarioData2Left� Top&WidthVHeightCalAlignmentdtaLeftDate �Y&஛�@Time �Y&஛�@ColorclInfoBk
DateFormatdfShortDateMode
dmComboBoxFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style KinddtkDate
ParseInput
ParentFontTabOrder	OnCloseUpEClienteExitOnChangeEClienteExitACorFocoFPrincipal.CorFoco  TEditLocalizaLocalizaClienteLeftnTopWidth<HeightColorclInfoBkFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder ACampoObrigatorioACorFocoFPrincipal.CorFocoATextoLabel7ABotaoSpeedLocaliza2	ADataBaseFPrincipal.BaseDados	ALocalizaLocalizaASelectValida.StringsSselect  c_tip_cad, i_cod_cli, c_nom_cli, c_end_cli + ' / ' + c_cid_cli as endereco from dba.CadClienteswhere I_COD_CLI = @and C_Tip_Cad <> 'F' ASelectLocaliza.StringsRSelect c_tip_cad, i_cod_cli, c_nom_cli, c_end_cli + ' / ' + c_cid_cli as endereco  from dba.CadClientes where c_nom_cli like '@%'and C_Tip_Cad <> 'F'order by C_nom_Cli ACorFormFPrincipal.CorFormACorPainelGraFPrincipal.CorPainelGraAPermitirVazio	ASomenteNumeros	AInfo.CampoCodigo	I_COD_CLIAInfo.CampoNome	C_NOM_CLIAInfo.CampoMostra3enderecoAInfo.Nome1C�digoAInfo.Nome2NomeAInfo.Tamanho1AInfo.Tamanho2AInfo.Tamanho3#AInfo.TituloForm   Localiza Clientes   AInfo.RetornoExtra1	I_COD_CLI	OnRetornoLocalizaClienteRetorno   TGridIndiceGradeLeft Top� Width Height� AlignalTopColorclInfoBk
DataSourceDataCadFactori
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAListaCAmpos.Strings	C_NOM_CLI	D_DAT_MOV AindiceInicial ALinhaSQLOrderBy Columns	AlignmenttaCenterExpanded	FieldName	I_LAN_FACTitle.CaptionTranWidth+Visible	 Expanded	FieldName	C_NOM_CLITitle.CaptionClienteWidth|Visible	 	AlignmenttaCenterExpanded	FieldName	D_DAT_MOVTitle.CaptionCadastroWidthPVisible	    TPanelColorPanelColor2Left TopbWidth Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel12Left^TopWidthUHeight	AlignmenttaRightJustifyCaptionValor L�quido :  TLabelLabel2LeftTopWidthHHeight	AlignmenttaRightJustifyCaptionValor Bruto :  TLabelLabel1Left�TopWidthNHeight	AlignmenttaRightJustifyCaptionValor CPMF :  TLabelLabel3Left� TopWidthJHeight	AlignmenttaRightJustifyCaptionValor Juros :  	TnumericoValorLiquidoLeft�TopWidthdHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara,0.00;-,0.00EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder  	Tnumerico
ValorBrutoLeftSTopWidthdHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara,0.00;-,0.00EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder   	Tnumerico	ValorJuroLeftTopWidthdHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara,0.00;-,0.00EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder  	Tnumerico	ValorCPMFLeft�TopWidthdHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara,0.00;-,0.00EnabledFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder   TPanelColorPanelColor3Left Top�Width Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TBitBtnBtCadastrarLeftTopWidth� HeightCaption&Cadastrar Transa��oTabOrder OnClickBtCadastrarClick
Glyph.Data
z  v  BMv      v   (                   �  �               �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3333�33;3�3333�;�w{�w{�7����s3�    33wwwwww330����337�333330����337��?�330����337�sws330����3?����?��������ww�wssw;������7w��?�ww30��  337�swws330���3337��7�330��3337�sw�330�� ;�337��w7�3�  3�33www3w�;�3;�3;�7s37s37s�33;333;s3373337	NumGlyphs  TBotaoFecharBotaoFechar1Left�TopWidthdHeightHintFechar|FechaFormularioCaption&FecharTabOrderOnClickBotaoFechar1Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsADataSet
CadFactori  TBitBtn
BtImprimirLeft� TopWidth� HeightCaption	&ImprimirTabOrderOnClickBtImprimirClick
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 0      ?��������������wwwwwww�������wwwwwww        ���������������wwwwwww�������wwwwwww�������wwwwww        wwwwwww30����337���?330� 337�wss330����337��?�330�  337�swws330���3337��73330��3337�ss3330�� 33337��w33330  33337wws333	NumGlyphs   TGridIndiceGrade2Left TopWidth HeightFAlignalClientColorclInfoBk
DataSourceDataMovFactori
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAListaCAmpos.Strings	I_NRO_LAN	I_COD_CLI	I_COD_BAN	D_DAT_VEN AindiceInicial ALinhaSQLOrderBy Columns	AlignmenttaCenterExpanded	FieldName	I_NRO_LANTitle.CaptionLanWidth(Visible	 	AlignmenttaCenterExpanded	FieldName	C_NRO_DOCTitle.CaptionNro Doc.WidthRVisible	 Expanded	FieldName	C_NOM_EMITitle.CaptionEmitenteWidthVisible	 Expanded	FieldName	C_NOM_BANTitle.CaptionBancoWidth� Visible	 Expanded	FieldName	N_VLR_DOCTitle.CaptionValor BrutoWidthaVisible	 Expanded	FieldName	N_VLR_JURTitle.Caption	Vlr JurosVisible	 Expanded	FieldName	N_VLR_CPMTitle.CaptionVlr CPMFVisible	 Expanded	FieldName	N_TOT_LIQTitle.CaptionValor L�quidoWidthaVisible	 	AlignmenttaCenterExpanded	FieldName	D_DAT_VENTitle.Caption
VencimentoWidthPVisible	    TPanelColorPanelColor4Left TopWidth HeightAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel6LeftTopWidthHeight	AlignmenttaCenterAutoSizeCaption
DocumentosFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTransparent	   TPanelColorPanelColor5Left TopnWidth HeightAlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel4LeftTopWidthHeight	AlignmenttaCenterAutoSizeCaption
Transa��esFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTransparent	   TDataSourceDataCadFactoriDataSet
CadFactoriLeft�Top  TQuery
CadFactoriAutoCalcFieldsAfterScrollCadFactoriAfterScrollDatabaseName	BaseDadosSQL.Strings&Select  Cfc.D_DAT_MOV, Cfc.I_COD_CLI, 9             Cfc.I_EMP_FIL, Cfc.I_LAN_FAC, Cli.C_NOM_CLI From        CadFactori as Cfc,         CadClientes as Cli,where&        Cfc.I_COD_CLI = Cli.I_COD_CLI Order  by  Cfc.I_LAN_FAC Left�Top	ParamData  
TDateFieldCadFactoriD_DAT_MOV	FieldName	D_DAT_MOV  TIntegerFieldCadFactoriI_COD_CLI	FieldName	I_COD_CLI  TIntegerFieldCadFactoriI_LAN_FAC	FieldName	I_LAN_FAC  TStringFieldCadFactoriC_NOM_CLI	FieldName	C_NOM_CLISize2  TIntegerFieldCadFactoriI_EMP_FIL	FieldName	I_EMP_FIL   TConsultaPadraoLocaliza
ACadastrarLeft�Top  TQueryAuxDatabaseName	BaseDadosSQL.Stringsselect * from MovFactori Left�Top	ParamData   TDataSourceDataMovFactoriDataSet
MovFactoriLeftTTop  TQuery
MovFactoriDatabaseName	BaseDadosSQL.Strings       Select ;Mfc.C_NRO_DOC, Mfc.D_DAT_PAG, Mfc.D_DAT_VEN, Mfc.I_LAN_FAC,;Mfc.I_NRO_LAN, Mfc.N_PER_JUR, Mfc.N_TOT_LIQ, Mfc.N_VLR_DOC,;Mfc.N_VLR_JUR, Mfc.N_VLR_PAG, Mfc.I_EMP_FIL, Mfc.N_VLR_CPM,EMi.C_NOM_EMI, Ban.C_NOM_BAN    FromMovFactori as Mfc,CadEmitentes as Emi,CadBancos as Ban        Where      $       Mfc.I_COD_BAN = Ban.I_COD_BAN!and Mfc.I_COD_EMI = Emi.I_COD_EMI,     Order  by  Mfc.I_LAN_FAC, Mfc.I_NRO_LAN LeftpTop	ParamData  
TDateFieldMovFactoriD_DAT_PAG	FieldName	D_DAT_PAGOriginMOVFACTORI.D_DAT_PAG  
TDateFieldMovFactoriD_DAT_VEN	FieldName	D_DAT_VENOriginMOVFACTORI.D_DAT_VEN  TIntegerFieldMovFactoriI_LAN_FAC	FieldName	I_LAN_FACOriginMOVFACTORI.I_LAN_FAC  TIntegerFieldMovFactoriI_NRO_LAN	FieldName	I_NRO_LANOriginMOVFACTORI.I_NRO_LAN  TFloatFieldMovFactoriN_PER_JUR	FieldName	N_PER_JUROriginMOVFACTORI.N_PER_JURDisplayFormat###,###,##0.00 %
EditFormat###,###,##0.00  TFloatFieldMovFactoriN_TOT_LIQ	FieldName	N_TOT_LIQOriginMOVFACTORI.N_TOT_LIQDisplayFormat###,###,###,###,##0.00  TFloatFieldMovFactoriN_VLR_JUR	FieldName	N_VLR_JUROriginMOVFACTORI.N_VLR_JURDisplayFormat###,###,###,###,##0.00  TFloatFieldMovFactoriN_VLR_PAG	FieldName	N_VLR_PAGOriginMOVFACTORI.N_VLR_PAGDisplayFormat###,###,###,###,##0.00  TIntegerFieldMovFactoriI_EMP_FIL	FieldName	I_EMP_FILOriginMOVFACTORI.I_EMP_FIL  TStringFieldMovFactoriC_NOM_BAN	FieldName	C_NOM_BANOriginCADBANCOS.C_NOM_BANSize2  TStringFieldMovFactoriC_NRO_DOC	FieldName	C_NRO_DOCOriginMOVFACTORI.C_NRO_DOC  TFloatFieldMovFactoriN_VLR_DOC	FieldName	N_VLR_DOCOriginMOVFACTORI.N_VLR_DOCDisplayFormat###,###,###,###,##0.00  TFloatFieldMovFactoriN_VLR_CPM	FieldName	N_VLR_CPMOriginMOVFACTORI.N_VLR_CPMDisplayFormat###,###,###,###,##0.00  TStringFieldMovFactoriC_NOM_EMI	FieldName	C_NOM_EMIOriginCADEMITENTES.C_NOM_EMISize2    