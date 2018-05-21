/* *************************************************************************
 * NAME : DBENURI.UDP_G_POPULAR_ALL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-10 15:09:59
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_G_POPULAR_ALL" (
    result_code IN OUT VARCHAR2,
    result_desc IN OUT VARCHAR2,
    startTime   IN OUT VARCHAR2,
    endTime     IN OUT VARCHAR2)
IS
  CURSOR cur_modelno_group IS
    SELECT /*+ parallel(g1 4) */ distinct modelno_group
      FROM TBL_GOODS g1
   WHERE (ca_code like '0304%' or ca_code like '021201%' or ca_code like '0209%' or ca_code like '021010%' or (ca_code like '1005%' and ca_code not like '100504%') or
        ca_code like '0206%' or ca_code like '040601%' or ca_code like '040606%' or ca_code like '070205%' or ca_code like '070202%' or ca_code like '070203%' or
        ca_code like '070204%' or ca_code like '02100401%' or ca_code like '02100410%' or ca_code like '02100411%' or ca_code like '02100412%' or
        ca_code like '02100108%' or ca_code like '021206%' or ca_code like '02120401%' or ca_code like '97020801%' or ca_code like '97020803%' or
        ca_code = '970103' or ca_code = '97010301' or ca_code = '97010302' or ca_code = '70021001' or ca_code = '07021002')
       AND modelno_group IS NOT NULL;

 v_modelno_tmp   tbl_goods.modelno%TYPE := 0;
 v_modelno_group_tmp  tbl_goods.modelno_group%TYPE := 0;
 i_count     NUMBER := 0;
 v_totcnt     NUMBER := 0;
BEGIN

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO startTime
    FROM DUAL;

  i_count := 0;

  OPEN cur_modelno_group;
  LOOP

   FETCH cur_modelno_group INTO v_modelno_group_tmp;
   EXIT WHEN cur_modelno_group%NOTFOUND;

   i_count := i_count + 1;
   --   UPDATE TBL_GOODS SET popular = NVL((SELECT NVL(popular, 0)
   --                                         FROM TBL_GOODS
   --                                        WHERE modelno = v_modelno_group_tmp AND (ca_code like '0304%' or ca_code like '021201%' or ca_code like '0209%' or ca_code like '021010%' or (ca_code like '1005%' and ca_code not like '100504%') or
   --                                                                             ca_code like '0206%' or ca_code like '040601%' or ca_code like '040606%' or ca_code like '070205%' or ca_code like '070202%' or ca_code like '070203%' or
   --                                                                             ca_code like '070204%' or ca_code like '02100401%' or ca_code like '02100410%' or ca_code like '02100411%' or ca_code like '02100412%' or
   --                                                                             ca_code like '02100108%' or ca_code like '021206%' or ca_code like '02120401%' or ca_code like '97020801%' or ca_code like '97020803%' or
   --                                                                             ca_code = '970103' or ca_code = '97010301' or ca_code = '97010302' or ca_code = '70021001' or ca_code = '07021002') AND rownum = 1), 0)
   --    WHERE modelno_group = v_modelno_group_tmp
   --  AND (ca_code like '0304%' or ca_code like '021201%' or ca_code like '0209%' or ca_code like '021010%' or (ca_code like '1005%' and ca_code not like '100504%') or
   --           ca_code like '0206%' or ca_code like '040601%' or ca_code like '040606%' or ca_code like '070205%' or ca_code like '070202%' or ca_code like '070203%' or
   --           ca_code like '070204%' or ca_code like '02100401%' or ca_code like '02100410%' or ca_code like '02100411%' or ca_code like '02100412%' or
   --           ca_code like '02100108%' or ca_code like '021206%' or ca_code like '02120401%' or ca_code like '97020801%' or ca_code like '97020803%' or
   --           ca_code = '970103' or ca_code = '97010301' or ca_code = '97010302' or ca_code = '70021001' or ca_code = '07021002');

      v_totcnt := v_totcnt + 1;

      IF i_count = 1000 THEN
       COMMIT;
       i_count := 0;
      END IF;

 END LOOP;
 CLOSE cur_modelno_group;

  COMMIT;

 result_code := '0';
 result_desc := 'UDP_G_POPULAR_ALL => SUCCESS total count : ' || v_totcnt;

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO endTime
    FROM DUAL;

 EXCEPTION
     WHEN OTHERS THEN
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
         INTO endTime
         FROM DUAL;
       result_code := '' || SQLCODE;
        result_desc := 'UDP_G_POPULAR_ALL => ERROR';

END UDP_G_POPULAR_ALL;
 
