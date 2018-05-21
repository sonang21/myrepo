/* *************************************************************************
 * NAME : ASISTEST.UDP_DAILY_ANALYZE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:18
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DAILY_ANALYZE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
  v_str     VARCHAR2(4000) := '';

 tmp_start     VARCHAR2(100) := '';
 tmp_end    VARCHAR2(100) := '';
BEGIN

  --DBMS_OUTPUT.ENABLE;
  --DBMS_OUTPUT.PUT_LINE('UDP_DAILY_ANALYZE start ......');
   
  v_str := 'analyze table TBL_CATEGORY compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_COPYCATE compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_SUPPLY compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_SHOPLIST compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_ENURI_BOARD compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_SHOP_DELIVERY compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BRAND1 compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BRAND2 compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BRAND_DETAIL compute statistics  FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_ERROR_PROPOSAL compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_ENURI_INTERGRATION_BOARD compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_SDU_BOARD compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_PRICELIST_STATIC compute statistics FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_REFERENCE COMPUTE STATISTICS FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_GOODS_BOOK COMPUTE STATISTICS FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_PRICELIST_POPULAR COMPUTE STATISTICS FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  v_str := '';
  v_str := 'analyze table TBL_MODELNO_SPEC COMPUTE STATISTICS FOR TABLE FOR ALL INDEXES FOR ALL INDEXED COLUMNS';
  EXECUTE IMMEDIATE v_str;

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
    FROM DUAL;

 endTime   := endTime || '|9 : ' || tmp_end;

 IF result_code = '' THEN
  result_code := '0';
 ELSE
  result_code := result_code || '|' || '0';
 END IF;

 IF result_desc = '' THEN
  result_desc := 'UDP_DAILY_ANALYZE => SUCCESS';
 ELSE
  result_desc := result_desc || '|' || 'UDP_DAILY_ANALYZE => SUCCESS';
 END IF;

 EXCEPTION
     WHEN OTHERS THEN
       COMMIT;
    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO tmp_end
     FROM DUAL;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_DAILY_ANALYZE => ERROR ';
    ELSE
         result_desc := result_desc || '|' || 'UDP_DAILY_ANALYZE => ERROR ';
    END IF;

    endTime   := endTime || '|9 error: ' || tmp_end;
END;