/* *************************************************************************
 * NAME : DBENURI.UDF_KB_CNT_GROUP
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-10 15:56:08
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_KB_CNT_GROUP" (v_ca_code VARCHAR2,v_modelno_group NUMBER,v_box_modelnm VARCHAR2,v_kb_num NUMBER)
RETURN INT AS
/*
 NGIT 수정 반영 - 김영원 20180416
*/
    i_count     NUMBER := 0;

BEGIN

   CASE
   WHEN v_modelno_group > 0 THEN 
      SELECT SUM(NVL(S.kb_num,0)) 
        INTO i_count
        FROM TBL_GOODS G,
             TBL_GOODS_SUM S
       WHERE G.MODELNO = S.MODELNO
         AND G.MODELNO_GROUP = v_modelno_group
      ;
      
   ELSE
      i_count := v_kb_num;

 END CASE;
 
 IF i_count<0 THEN
    i_count := 0;
 END IF;

 RETURN i_count;

END;
