�
 TFSITUACAOATUALCLIENTE 0�  TPF0TFSituacaoAtualClienteFSituacaoAtualClienteLeftTopmWidth�Height�CaptionSitua��o do ClienteColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	PositionpoScreenCenterOnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TPanelColorPanelColor3Left TopTWidth�HeightAlignalClientColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TGridIndiceGridIndice2LeftTop|WidthHeight� ColorclInfoBk
DataSource	DataSoma3
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit 
ParentFontTabOrder TitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldNameTIPOWidth� Visible	 Expanded	FieldName	C_NOM_BANWidth� Visible	 Expanded	FieldNameSOMA3Width� Visible	    TGridIndiceGridIndice1LeftTopWidth8HeightmHint%Consulta da Situa��o Atual do ClienteColorclInfoBk
DataSource	DataSoma2Enabled
FixedColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style OptionsdgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgConfirmDeletedgCancelOnExit 
ParentFontTabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclBlueTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style ACorFocoFPrincipal.CorFocoAindiceInicial ALinhaSQLOrderBy ColumnsExpanded	FieldNameTIPOWidth� Visible	 Expanded	FieldNamesoma1Width� Visible	     TPanelColorPanelColor4Left ToprWidth�Height)AlignalBottomColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder AUsarCorFormACorFormFPrincipal.CorForm TLabelLabel4LeftTopWidthHeightCaptionMontante Negociado :Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsItalic 
ParentFont  TBotaoFecharBotaoFechar1Left�TopWidthdHeightHintFechar|FechaFormularioCaption&FecharTabOrder OnClickBotaoFechar1Click
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 3     33wwwww33333333333333333333333333333333333333333333333?33�33333s3333333333333���33��337ww�33��337���33��337ww3333333333333����33     33wwwwws3	NumGlyphsADataSetAux  	Tnumerico	numerico1Left0TopWidthyHeightACampoObrigatorioACorFocoFPrincipal.CorFocoANaoUsarCorNegativoColorclInfoBkAMascara,0.00;-,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder   TPainelGradientePainelGradiente1Left Top Width�Height)AlignalTop	AlignmenttaLeftJustifyCaption   Situa��o Atual do ClienteFont.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontTabOrderAConfiguracoesFPrincipal.CorPainelGra  TPanelColorPanelColor5Left Top)Width�Height+AlignalTopColorclSilverFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderAUsarCorFormACorFormFPrincipal.CorForm TLabelLabel7LeftTopWidth� Height"Caption                            Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameArial
Font.StylefsBoldfsItalic 
ParentFont   TDataSourceDataAux1DataSetAuxLeftTop  TQueryAuxDatabaseName	BaseDadosSQL.Strings+select sum(N_TOT_LIQ) GERAL from movfactori Left$Top	ParamData  TFloatFieldAuxGERAL	FieldNameGERALOriginMOVFACTORI.N_TOT_LIQcurrency	   TQuerySoma2OnCalcFieldsSoma2CalcFieldsDatabaseName	BaseDadosSQL.Strings6select c_sit_doc, sum(N_TOT_LIQ) soma1 from movfactori group by C_SIT_DOC Left�Top	ParamData  TStringFieldSoma2c_sit_doc	FieldName	c_sit_docSize  TFloatField
Soma2soma1	FieldNamesoma1currency	  TStringField	Soma2TIPO	FieldKindfkCalculated	FieldNameTIPO
Calculated	   TDataSource	DataSoma2DataSetSoma2LefthTop  TDataSource	DataSoma3DataSetSoma3Left�Top  TQuerySoma3OnCalcFieldsSoma3CalcFieldsDatabaseName	BaseDadosSQL.Strings4Select MOV.C_SIT_DOC, MOV.I_COD_BAN, BAN.C_NOM_BAN, sum(N_TOT_LIQ) SOMA3    From MovFactori as MOV,      CadBancos  as BAN  $Where MOV.I_COD_BAN = BAN.I_COD_BAN  and  MOV.I_COD_EMI = 11034Group by MOV.C_SIT_DOC, MOV.I_COD_BAN, BAN.C_NOM_BAN Left�Top	ParamData  TStringFieldSoma3C_SIT_DOCDisplayWidth	FieldName	C_SIT_DOCOriginMOVFACTORI.C_SIT_DOCSize  TIntegerFieldSoma3I_COD_BANDisplayWidth	FieldName	I_COD_BANOriginMOVFACTORI.I_COD_BAN  TStringFieldSoma3C_NOM_BANDisplayWidth	FieldName	C_NOM_BANOriginCADBANCOS.C_NOM_BANSize2  TFloatField
Soma3SOMA3DisplayWidth
	FieldNameSOMA3OriginMOVFACTORI.N_TOT_LIQcurrency	  TStringField	Soma3TIPODisplayWidth	FieldKindfkCalculated	FieldNameTIPO
Calculated	   TDataSourceDsEmitentesDataSet	EmitentesLeft8Top  TQuery	EmitentesDatabaseName	BaseDadosSQL.Strings0select  cad.i_cod_emi, mov.i_cod_emi, c_nom_emi frommovfactori as mov,cademitentes as cadwherecad.i_cod_emi = mov.i_cod_emi LeftXTop	ParamData  TIntegerFieldEmitentesi_cod_emi	FieldName	i_cod_emi  TIntegerFieldEmitentesi_cod_emi_1	FieldNamei_cod_emi_1  TStringFieldEmitentesc_nom_emi	FieldName	c_nom_emiSize2    