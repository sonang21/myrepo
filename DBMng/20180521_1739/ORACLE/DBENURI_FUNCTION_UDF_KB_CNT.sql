/* *************************************************************************
 * NAME : DBENURI.UDF_KB_CNT
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 09:27:32
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_KB_CNT" (v_modelno NUMBER)
RETURN int AS
/*
 NGIT 수정 반영 - 김영원 20180416
*/
    i_count     NUMBER := 0;

BEGIN

  SELECT CASE
           WHEN SUBSTR(A.CA_CODE,1,6) = '021201' 
                OR A.CA_CODE = '02090000'
                OR SUBSTR(A.CA_CODE,1,6) = '020906'
                OR SUBSTR(A.CA_CODE,1,6) = '020901'
                OR SUBSTR(A.CA_CODE,1,6) = '020902'
                OR SUBSTR(A.CA_CODE,1,6) = '020903'
                OR SUBSTR(A.CA_CODE,1,6) = '020905' THEN 
                  (SELECT NVL(SUM(TB.KB_NUM),0)
                     FROM TBL_GOODS TA, TBL_GOODS_SUM TB
                    WHERE TA.MODELNO = TB.MODELNO
                      AND TA.MODELNO_GROUP IN (SELECT T1.MODELNO_GROUP
                                                 FROM TBL_GOODS T1
                                                WHERE T1.MODELNO=v_modelno)
                  )
           ELSE (
             CASE
               WHEN (SUBSTR(A.CA_CODE,1,4) = '0304' AND SUBSTR(A.CA_CODE, 1, 6) <> '030406')
                     OR SUBSTR(A.CA_CODE,1,6) = '970201' THEN 
                        (SELECT NVL(SUM(TB.KB_NUM),0)
                               FROM TBL_GOODS TA, TBL_GOODS_SUM TB
                              WHERE TA.MODELNO = TB.MODELNO
                        )
               ELSE B.KB_NUM
             END
              ) 
         END AS KB_NUM
    INTO i_count
    FROM TBL_GOODS A, TBL_GOODS_SUM B
   WHERE A.MODELNO = v_modelno
     AND A.modelno = B.modelno
     AND ROWNUM<=1;

  RETURN i_count;

END;
