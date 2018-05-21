/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_DEFAULT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:24
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_DEFAULT" 
IS
 CURSOR cur_goods_info IS
   select modelno
     from tbl_goods
    where ca_lcode = '07'
      and ca_code like '0708%'
      and cateflag = '0';

 v_modelno_tmp     tbl_goods.modelno%TYPE := 0;

 i_count    NUMBER := 0;
 v_totcnt  NUMBER := 0;
 v_ever_notfundcnt NUMBER := 0;

 result_code VARCHAR2(1000) := '';
 result_desc VARCHAR2(1000) := '';
 startTime   VARCHAR2(1000) := '';
 endTime     VARCHAR2(1000) := '';

BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_DEFAULT start ......');

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO startTime
   FROM DUAL;

 i_count := 0;
 v_totcnt := 0;
 v_ever_notfundcnt := 0;

 OPEN cur_goods_info;
 LOOP

   FETCH cur_goods_info INTO  v_modelno_tmp;
   EXIT WHEN cur_goods_info%NOTFOUND;

      i_count := i_count + 1;
      v_totcnt := v_totcnt + 1;

    BEGIN
      update /*+ append */ tbl_goods
      set func = replace(replace(replace(replace(replace(func, 'Pentium', 'ÆæÆ¼¾ö'), 'Celeron', '¼¿·¯·Ð'), 'Front Side Bus', 'FSB'), 'Athlon', '¾Ö½½·Ð'), 'Sempron', '¼ÀÇÁ·Ð')
      where modelno = v_modelno_tmp;
    EXCEPTION WHEN OTHERS THEN
      v_ever_notfundcnt := v_ever_notfundcnt + 1;
    END;

    COMMIT;

 END LOOP;
 CLOSE cur_goods_info;

 COMMIT;
 --DBMS_OUTPUT.PUT_LINE('v_totcnt : ' || v_totcnt);

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO endTime
   FROM DUAL;

 EXCEPTION
     WHEN OTHERS THEN
       COMMIT;
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
         INTO endTime
         FROM DUAL;
    result_code := SQLCODE;
    result_desc := 'UDP_GOODS_DEFAULT => ERROR : ' || SQLERRM;

END UDP_GOODS_DEFAULT;