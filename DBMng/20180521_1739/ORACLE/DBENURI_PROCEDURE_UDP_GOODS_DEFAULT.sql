/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_DEFAULT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 17:08:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_DEFAULT" 
IS
/*
 NGIT ¼öÁ¤ ¹Ý¿µ - ±è¿µ¿ø 20180426
*/
 CURSOR cur_goods_info IS
   select modelno
     from tbl_cate_goods
    where ca_code like '0708%'
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
      update tbl_goods
         set func = replace(replace(replace(replace(replace(func, 'Pentium', 'ÆæÆ¼¾ö'), 'Celeron', '¼¿·¯·Ð'), 'Front Side Bus', 'FSB'), 'Athlon', '¾Ö½½·Ð'), 'Sempron', '¼ÀÇÁ·Ð')
       where modelno = v_modelno_tmp;
    EXCEPTION WHEN OTHERS THEN
      v_ever_notfundcnt := v_ever_notfundcnt + 1;
    END;

    COMMIT;

 END LOOP;
 CLOSE cur_goods_info;

 COMMIT;

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
 
