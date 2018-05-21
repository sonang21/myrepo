/* *************************************************************************
 * NAME : DBENURI.UDP_MYEVER_STATUS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MYEVER_STATUS" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
 CURSOR cur_ever_info IS
    select pl_no
      from tbl_myever m2
     where pl_no in (select pl_no
                       from tbl_myever m
                      where decode(pl_no, null, 0, pl_no) > 0
                        and ever_status <> '2'
                      minus
                     select pl_no
                       from tbl_pricelist p
                      where jobtype = '2' and status <> '5');

 v_plno_tmp       tbl_myever.pl_no%TYPE := 0;

 i_count    NUMBER := 0;
 v_totcnt  NUMBER := 0;
 v_ever_notfundcnt NUMBER := 0;

 --result_code VARCHAR2(1000) := '';
 --result_desc VARCHAR2(1000) := '';
 --startTime   VARCHAR2(1000) := '';
 --endTime     VARCHAR2(1000) := '';

BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_MYEVER_STATUS start ......');

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO startTime
   FROM DUAL;

 i_count := 0;
 v_totcnt := 0;
 v_ever_notfundcnt := 0;

 OPEN cur_ever_info;
 LOOP

   FETCH cur_ever_info INTO v_plno_tmp;
   EXIT WHEN cur_ever_info%NOTFOUND;

      i_count := i_count + 1;
      v_totcnt := v_totcnt + 1;

      BEGIN
       UPDATE TBL_MYEVER SET ever_status = '2' WHERE pl_no = v_plno_tmp;
    EXCEPTION WHEN OTHERS THEN
      v_ever_notfundcnt := v_ever_notfundcnt + 1;
    END;

      IF i_count = 10 THEN
        COMMIT;
        i_count := 0;
      END IF;

 END LOOP;
 CLOSE cur_ever_info;

 COMMIT;
 --DBMS_OUTPUT.PUT_LINE('v_totcnt : ' || v_totcnt);

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO endTime
   FROM DUAL;

 result_code := '0';
 result_desc := 'UDP_MYEVER_STATUS => SUCCESS total count : ' || v_totcnt || ', ever_notfundcnt : ' || v_ever_notfundcnt;

 --DBMS_OUTPUT.PUT_LINE('result_desc : ' || result_desc);

 EXCEPTION
     WHEN OTHERS THEN
       COMMIT;
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
         INTO endTime
         FROM DUAL;
    result_code := SQLCODE;
    result_desc := 'UDP_MYEVER_STATUS => ERROR : ' || SQLERRM;

END UDP_MYEVER_STATUS;
 