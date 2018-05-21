/* *************************************************************************
 * NAME : ASISTEST.UDP_ENURI_DEAL_CATE_MATCHING_D
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:21
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ENURI_DEAL_CATE_MATCHING_D" 
(
  CATE IN VARCHAR2 
) AS 
BEGIN
declare
  v_cnt number(20);
  BEGIN
  select count(*) into v_cnt from TBL_ENURI_DEAL_MODEL_TMP_D WHERE CA_CODE = CATE;
  if v_cnt > 5 then
    delete TBL_ENURI_DEAL_MODEL_D WHERE CA_CODE = CATE ;
    insert into TBL_ENURI_DEAL_MODEL_D (select * from TBL_ENURI_DEAL_MODEL_TMP_D WHERE CA_CODE = CATE);
    delete TBL_ENURI_DEAL_MODEL_TMP_D WHERE CA_CODE = CATE ;
    commit;
  end if;
  end;
END UDP_ENURI_DEAL_CATE_MATCHING_D;