/* *************************************************************************
 * NAME : ASISTEST.UDF_KB_CNT_GROUP
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:34
 *        Modify: 2018-05-04 18:33:34
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_KB_CNT_GROUP" (v_ca_code VARCHAR2,v_modelno_group NUMBER,v_box_modelnm VARCHAR2,v_kb_num NUMBER)
RETURN INT AS
    i_count     NUMBER := 0;

BEGIN

   CASE
   WHEN v_modelno_group > 0 THEN 
   /*
      SELECT
      CASE NVL(MAX(dbms_lob.GETLENGTH(goods_info)),0) 
        WHEN 0 THEN NVL(SUM(KB_NUM),0) 
        ELSE NVL(SUM(KB_NUM),0)-COUNT(KB_NUM)+1 
        END as kb_num INTO i_count
      FROM TBL_GOODS
      WHERE MODELNO_GROUP = v_modelno_group
      AND CATEFLAG='0';
   */
   /*
      SELECT SUM(kb_num1) - SUM(kb_num2) + MAX(kb_num2) kb_num INTO i_count FROM
      (
          SELECT
            kb_num kb_num1,        
            CASE NVL(dbms_lob.GETLENGTH(goods_info),0)
            WHEN 0 THEN 0
            ELSE 1
            END as kb_num2
            
          FROM TBL_GOODS
          WHERE MODELNO_GROUP = v_modelno_group
          AND CATEFLAG='0'
      );
   */
   
      SELECT
        SUM(NVL(kb_num,0)) INTO i_count
      FROM TBL_GOODS
      WHERE MODELNO_GROUP = v_modelno_group
      AND CATEFLAG='0';
      
   ELSE
      i_count := v_kb_num;

 END CASE;
 
 IF i_count<0 THEN
    i_count := 0;
 END IF;

 RETURN i_count;

END;