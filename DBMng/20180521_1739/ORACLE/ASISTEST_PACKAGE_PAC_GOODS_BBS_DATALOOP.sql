/* *************************************************************************
 * NAME : ASISTEST.PAC_GOODS_BBS_DATALOOP
 * TYPE : PACKAGE
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "ASISTEST"."PAC_GOODS_BBS_DATALOOP" AS
	TYPE g_modelno_type is table of TBL_GOODS_BBS.MODELNO%TYPE
	index by binary_integer;
	TYPE g_modelno_group_type is table of TBL_GOODS_BBS.MODELNO_GROUP%TYPE
	index by binary_integer;    
	TYPE g_delflag_type is table of TBL_GOODS_BBS.DELFLAG%TYPE
	index by binary_integer;        
	
	v_Modelno_old g_modelno_type;
	v_Modelno_new g_modelno_type;
    
    v_Modelno_group_old g_modelno_group_type;
	v_Modelno_group_new g_modelno_group_type;
    
    v_Delflag_old g_delflag_type;
	v_Delflag_new g_delflag_type;
	
	g_index	NUMBER(8) := 0;

END PAC_GOODS_BBS_DATALOOP;
