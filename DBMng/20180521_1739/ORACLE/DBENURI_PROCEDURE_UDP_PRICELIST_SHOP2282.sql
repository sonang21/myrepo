/* *************************************************************************
 * NAME : DBENURI.UDP_PRICELIST_SHOP2282
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 13:06:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_PRICELIST_SHOP2282" (
      result_code IN OUT VARCHAR2,
      result_desc IN OUT VARCHAR2,
      startTime IN OUT VARCHAR2,
      endTime IN OUT VARCHAR2)
IS
 CURSOR cur_pricelist IS
   SELECT /*+ parallel(p 4) */  pl_no
     FROM TBL_PRICELIST p
     WHERE SHOP_CODE=2282 AND STATUS<>'5';

  v_pl_no       tbl_pricelist.pl_no%TYPE := 0;

  i_count     NUMBER := 0;
  i_tcount    NUMBER := 0;

  BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDP_PRICELIST_SHOP2282 start ......');

   SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO startTime
      FROM DUAL;

    i_count := 0;

  OPEN cur_pricelist;
   LOOP

      FETCH cur_pricelist INTO v_pl_no;
      EXIT WHEN cur_pricelist%NOTFOUND;

      i_count := i_count + 1;
      i_tcount := i_tcount + 1;

      UPDATE TBL_PRICELIST SET STATUS='5', U_DATE=SYSDATE WHERE PL_NO = v_pl_no;

     IF i_count = 500 THEN
       COMMIT;
       i_count := 0;
     END IF;

  END LOOP;
  CLOSE cur_pricelist;

  COMMIT;

   --DBMS_OUTPUT.PUT_LINE('total count : ' || i_tcount);

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO endTime
    FROM DUAL;

  IF result_code = '' THEN
   result_code := '0';
  ELSE
   result_code := result_code || '|' || '0';
  END IF;

  IF result_desc = '' THEN
   result_desc := 'UDP_PRICELIST_SHOP2282 => SUCCESS total count : ' || i_tcount;
  ELSE
   result_desc := result_desc || '|' || 'UDP_PRICELIST_SHOP2282 => SUCCESS total count : ' || i_tcount;
  END IF;

  EXCEPTION
   WHEN OTHERS THEN
    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO endTime
     FROM DUAL;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_PRICELIST_SHOP2282 => ERROR ';
    ELSE
         result_desc := result_desc || '|' || 'UDP_PRICELIST_SHOP2282 => ERROR ';
    END IF;
    --result_desc := 'UDP_PRICELIST_SHOP2282 => ERROR (' || SQLERRM || '), s : ' || v_shop_code || ', count : ' || i_count;

END UDP_PRICELIST_SHOP2282;
 
