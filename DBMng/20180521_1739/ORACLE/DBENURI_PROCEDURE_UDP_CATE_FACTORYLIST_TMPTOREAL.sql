/* *************************************************************************
 * NAME : DBENURI.UDP_CATE_FACTORYLIST_TMPTOREAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CATE_FACTORYLIST_TMPTOREAL" (v_code in VARCHAR2) AS
BEGIN
declare 
   v_cate_exists  NUMBER(10) := 0;   
  begin 
  select count(*) into v_cate_exists from TBL_CATE_FACTORY_LIST_TMP WHERE ca_code = v_code;
  if v_cate_exists > 0 then
    delete TBL_CATE_FACTORY_LIST WHERE ca_code = v_code ;
    insert into TBL_CATE_FACTORY_LIST (select * from TBL_CATE_FACTORY_LIST_TMP WHERE ca_code = v_code );
    delete TBL_CATE_FACTORY_LIST_TMP WHERE ca_code = v_code ;
    commit;
  end if;
  end;

END UDP_CATE_FACTORYLIST_TMPTOREAL;