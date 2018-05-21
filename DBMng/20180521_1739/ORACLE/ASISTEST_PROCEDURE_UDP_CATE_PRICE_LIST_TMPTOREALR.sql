/* *************************************************************************
 * NAME : ASISTEST.UDP_CATE_PRICE_LIST_TMPTOREALR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:17
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_CATE_PRICE_LIST_TMPTOREALR" (v_code in VARCHAR2) AS 
BEGIN
  declare 
   v_cate_exists  NUMBER(10) := 0;   
  begin 
  select count(*) into  v_cate_exists from TBL_CATE_PRICE_LIST_R_TMP where ca_code = v_code;
  if v_cate_exists <= 5 then
    delete TBL_CATE_PRICE_LIST_R WHERE ca_code = v_code ;
    insert into TBL_CATE_PRICE_LIST_R (select * from TBL_CATE_PRICE_LIST_R_TMP WHERE ca_code = v_code );
    delete TBL_CATE_PRICE_LIST_R_TMP WHERE ca_code = v_code ;
    commit;
  end if;
  end;
END UDP_CATE_PRICE_LIST_TMPTOREALR;