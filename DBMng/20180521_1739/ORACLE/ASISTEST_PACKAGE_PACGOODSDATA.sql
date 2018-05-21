/* *************************************************************************
 * NAME : ASISTEST.PACGOODSDATA
 * TYPE : PACKAGE
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "ASISTEST"."PACGOODSDATA" AS

 v_Modelno_old BINARY_INTEGER := 0;
 v_Modelno_new BINARY_INTEGER := 0;
 v_Ca_code_old VARCHAR2(12) := '';
 v_Ca_code_new VARCHAR2(12) := '';
 v_Mallcnt_old BINARY_INTEGER := 0;
 v_Mallcnt_new BINARY_INTEGER := 0;
 v_Minprice_old BINARY_INTEGER := 0;
 v_Minprice_new BINARY_INTEGER := 0;
 v_Jobcode_old VARCHAR2(12) := '';
 v_Jobcode_new VARCHAR2(12) := '';
 v_row_count BINARY_INTEGER := 0;
 v_Cateflag_new CHAR(1) := '';
 v_Weight_new BINARY_FLOAT := 0.0;
 v_Weight_old BINARY_FLOAT := 0.0;
 v_Info_sum_point_new BINARY_FLOAT := 0.0;
 v_Info_sum_point_old BINARY_FLOAT := 0.0;
 v_P_pl_no_old NUMBER(12) := 0;
 v_P_pl_no_new NUMBER(12) := 0;

 v_P_imgurl_old VARCHAR2(250) := '';
 v_P_imgurl_new VARCHAR2(250) := '';
 v_P_imgurlflag_old CHAR(1) :='';
 v_P_imgurlflag_new CHAR(1) :='';
 v_Condiname_old CHAR(1) :='';
 v_Condiname_new CHAR(1) :='';
END;
