/* *************************************************************************
 * NAME : ASISTEST.PACPRICELISTDATA
 * TYPE : PACKAGE
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "ASISTEST"."PACPRICELISTDATA" AS

 v_Modelno_old BINARY_INTEGER := 0;
 v_Modelno_new BINARY_INTEGER := 0;
 v_Pl_no_old NUMBER(12) := 0;
 v_Pl_no_new NUMBER(12) := 0;

 v_Shop_code_old  BINARY_INTEGER := 0;
 v_Shop_code_new  BINARY_INTEGER := 0;
 v_Price_old    BINARY_INTEGER := 0;
 v_Price_new    BINARY_INTEGER := 0;
 v_Srvflag_old   CHAR(1) := '';
 v_Srvflag_new   CHAR(1) := '';
 v_Status_old   CHAR(1) := '';
 v_Status_new   CHAR(1) := '';
 v_Esstockflag_old CHAR(1) := '';
 v_Esstockflag_new CHAR(1) := '';
 v_Coupon_old   BINARY_INTEGER := 0;
 v_Coupon_new   BINARY_INTEGER := 0;
 v_Jobtype_old   CHAR(1) := '';
 v_Jobtype_new   CHAR(1) := '';
 v_Instance_price_old BINARY_INTEGER := 0;
 v_Instance_price_new BINARY_INTEGER := 0;
 v_Option_flag2_old   CHAR(1) := '0';
 v_Option_flag2_new   CHAR(1) := '0'; 

END pacPricelistData;
