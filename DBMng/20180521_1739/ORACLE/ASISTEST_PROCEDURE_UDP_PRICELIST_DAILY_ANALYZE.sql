/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_DAILY_ANALYZE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_DAILY_ANALYZE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
  v_str     VARCHAR2(4000) := '';
BEGIN

  --DBMS_OUTPUT.ENABLE;
  --DBMS_OUTPUT.PUT_LINE('UDP_PRICELIST_DAILY_ANALYZE start ......');

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