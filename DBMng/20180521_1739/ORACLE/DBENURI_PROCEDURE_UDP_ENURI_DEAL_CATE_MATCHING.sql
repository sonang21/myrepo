/* *************************************************************************
 * NAME : DBENURI.UDP_ENURI_DEAL_CATE_MATCHING
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ENURI_DEAL_CATE_MATCHING" 
(
  CATE IN VARCHAR2 
) AS 
BEGIN
declare
  v_cnt number(20);
  BEGIN
  select count(*) into v_cnt from TBL_ENURI_DEAL_MODEL_TMP WHERE CA_CODE = CATE;
  if v_cnt > 5 then
    delete TBL_ENURI_DEAL_MODEL WHERE CA_CODE = CATE ;
    insert into TBL_ENURI_DEAL_MODEL (select * from TBL_ENURI_DEAL_MODEL_TMP WHERE CA_CODE = CATE);
    delete TBL_ENURI_DEAL_MODEL_TMP WHERE CA_CODE = CATE ;
    commit;
  end if;
  end;
END UDP_ENURI_DEAL_CATE_MATCHING;