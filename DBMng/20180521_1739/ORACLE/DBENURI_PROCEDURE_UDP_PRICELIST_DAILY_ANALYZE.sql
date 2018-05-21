/* *************************************************************************
 * NAME : DBENURI.UDP_PRICELIST_DAILY_ANALYZE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-10 15:11:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_PRICELIST_DAILY_ANALYZE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
/*
 NGIT 체크 - 변경없음 김영원 20180502
*/
  v_str     VARCHAR2(4000) := '';
BEGIN

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO startTime
    FROM DUAL;

  v_str := '';
  v_str := 'analyze table tbl_pricelist compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index XIF2TBL_PRICELIST compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index idx_pricelist_shop_model compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index idx_pricelist_auth compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index idx_pricelist_ca_shop compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index idx_pricelist_modelno compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index idx_pricelist_status compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IDX_GOODS_UPDATE_SELECT compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IDX_PRICELIST_CA_ETC compute statistics ';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze index IDX_PRICELIST_GOODSCODE compute statistics ';
  EXECUTE IMMEDIATE v_str;

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO endTime
    FROM DUAL;

 IF result_code = '' THEN
  result_code := '0';
 ELSE
  result_code := result_code || '|' || '0';
 END IF;

 IF result_desc = '' THEN
  result_desc := 'UDP_PRICELIST_DAILY_ANALYZE => SUCCESS';
 ELSE
  result_desc := result_desc || '|' || 'UDP_PRICELIST_DAILY_ANALYZE => SUCCESS';
 END IF;

 EXCEPTION
     WHEN OTHERS THEN
       COMMIT;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_PRICELIST_DAILY_ANALYZE => ERROR ';
    ELSE
         result_desc := result_desc || '|' || 'UDP_PRICELIST_DAILY_ANALYZE => ERROR ';
    END IF;

END;
 
