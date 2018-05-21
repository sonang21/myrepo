/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_DEFAULT2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_DEFAULT2" 
IS
 CURSOR cur_pricelist_info IS
   select pl_no, modelno
     from tbl_pricelist;

 v_plno_tmp       tbl_pricelist.pl_no%TYPE := 0;
 v_modelno_tmp     tbl_pricelist.modelno%TYPE := 0; 
 v_jobcode_new     tbl_goods.jobcode%TYPE := '';
 v_pjobcode_tmp     tbl_pricelist.pjobcode%TYPE := '';

 i_count    NUMBER := 0;
 v_totcnt  NUMBER := 0;
 v_ever_notfundcnt NUMBER := 0;

 result_code VARCHAR2(1000) := '';
 result_desc VARCHAR2(1000) := '';
 startTime   VARCHAR2(1000) := '';
 endTime     VARCHAR2(1000) := '';

BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_PRICELIST_DEFAULT2 start ......');

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO startTime
   FROM DUAL;

 i_count := 0;
 v_totcnt := 0;
 v_ever_notfundcnt := 0;

 OPEN cur_pricelist_info;
 LOOP

   FETCH cur_pricelist_info INTO  v_plno_tmp, v_modelno_tmp;
   EXIT WHEN cur_pricelist_info%NOTFOUND;

      i_count := i_count + 1;
      v_totcnt := v_totcnt + 1;

      BEGIN
       select jobcode
         into v_jobcode_new
          from tbl_goods
         where modelno = v_modelno_tmp
           and cateflag = '0';
      EXCEPTION WHEN OTHERS THEN
         v_jobcode_new := '0';
      END;

    IF  v_jobcode_new > '0' THEN
     v_pjobcode_tmp := '1';
    ELSE
     v_pjobcode_tmp := '0';
    END IF;

    BEGIN
     	UPDATE /*+ append */ TBL_PRICELIST SET PJOBCODE = v_pjobcode_tmp WHERE PL_NO = v_plno_tmp;
    EXCEPTION WHEN OTHERS THEN
     	v_ever_notfundcnt := v_ever_notfundcnt + 1;
   	END;

   	COMMIT;
   	v_jobcode_new := '';
   	v_pjobcode_tmp := '';

 END LOOP;
 CLOSE cur_pricelist_info;

 COMMIT;
 --DBMS_OUTPUT.PUT_LINE('v_totcnt : ' || v_totcnt);

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO endTime
   FROM DUAL;

 insert into tbl_pricelist_update (totcnt, start_time, end_time) values (v_totcnt, to_date(startTime, 'YYYY-MM-DD HH24:MI:SS'), to_date(endTime, 'YYYY-MM-DD HH24:MI:SS'));
 commit;

 result_code := '0';
 result_desc := 'UDP_PRICELIST_DEFAULT2 => SUCCESS total count : ' || v_totcnt || ', ever_notfundcnt : ' || v_ever_notfundcnt;

 --DBMS_OUTPUT.PUT_LINE('result_desc : ' || result_desc);

 EXCEPTION
     WHEN OTHERS THEN
       COMMIT;
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
         INTO endTime
         FROM DUAL;
    result_code := SQLCODE;
    result_desc := 'UDP_PRICELIST_DEFAULT2 => ERROR : ' || SQLERRM;

END UDP_PRICELIST_DEFAULT2;