/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_ESSTOCKFLAG
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_ESSTOCKFLAG" (
      result_code IN OUT VARCHAR2,
      result_desc IN OUT VARCHAR2,
      startTime IN OUT VARCHAR2,
      endTime IN OUT VARCHAR2)
IS
 CURSOR cur_pricelist IS
   select /*+ parallel(p 4) */ pl_no
     from tbl_pricelist p
    where modelno < 0 and esstockflag = 'O';
    --where modelno > 0
    --  and status < 3
    --  and srvflag = '0'
    --  and esstockflag = 'O';

  v_pl_no       tbl_pricelist.pl_no%TYPE := 0;

  tmp_start      VARCHAR2(100) := '';
  tmp_end       VARCHAR2(100) := '';
  i_count     NUMBER := 0;
  i_tcount    NUMBER := 0;

  BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDP_PRICELIST_ESSTOCKFLAG start ......');

   SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO tmp_start
      FROM DUAL;

  startTime := startTime || '|es : ' || tmp_start;

    i_count := 0;

  OPEN cur_pricelist;
   LOOP

      FETCH cur_pricelist INTO v_pl_no;
      EXIT WHEN cur_pricelist%NOTFOUND;

      i_count := i_count + 1;
      i_tcount := i_tcount + 1;

      UPDATE TBL_PRICELIST SET esstockflag = '0'
       WHERE pl_no = v_pl_no;

     IF i_count = 10 THEN
       COMMIT;
       i_count := 0;
     END IF;

  END LOOP;
  CLOSE cur_pricelist;

  COMMIT;

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
    FROM DUAL;

  IF result_code = '' THEN
   result_code := '0';
  ELSE
   result_code := result_code || '|' || '0';
  END IF;

  IF result_desc = '' THEN
   result_desc := 'UDP_PRICELIST_ESSTOCKFLAG => SUCCESS total count : ' || i_tcount;
  ELSE
   result_desc := result_desc || '|' || 'UDP_PRICELIST_ESSTOCKFLAG => SUCCESS total count : ' || i_tcount;
  END IF;

 endTime   := endTime || '|es : ' || tmp_end;

  EXCEPTION
   WHEN OTHERS THEN
    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO tmp_end
     FROM DUAL;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_PRICELIST_ESSTOCKFLAG => ERROR ';
    ELSE
         result_desc := result_desc || '|' || 'UDP_PRICELIST_MYEVER => ERROR ';
    END IF;
    --result_desc := 'UDP_PRICELIST_ESSTOCKFLAG => ERROR (' || SQLERRM || '), s : ' || v_shop_code || ', count : ' || i_count;

    endTime   := endTime || '|esstock er: ' || tmp_end;

END UDP_PRICELIST_ESSTOCKFLAG;