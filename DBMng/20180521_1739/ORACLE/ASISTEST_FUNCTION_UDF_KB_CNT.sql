/* *************************************************************************
 * NAME : ASISTEST.UDF_KB_CNT
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:34
 *        Modify: 2018-05-04 18:33:34
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_KB_CNT" (v_modelno NUMBER)
RETURN int AS
    i_count     NUMBER := 0;

BEGIN

  SELECT CASE
    WHEN SUBSTR(G.CA_CODE,1,6) = '021201' OR G.CA_CODE = '02090000' OR SUBSTR(G.CA_CODE,1,6) = '020906' OR SUBSTR(G.CA_CODE,1,6) = '020901' OR SUBSTR(G.CA_CODE,1,6) = '020902' OR SUBSTR(G.CA_CODE,1,6) = '020903' OR SUBSTR(G.CA_CODE,1,6) = '020905'
     THEN (
              SELECT NVL(SUM(T2.KB_NUM),0)
              FROM TBL_GOODS T2
        WHERE T2.CATEFLAG='0'
           AND T2.CA_LCODE=SUBSTR(G.CA_CODE,1,2)
           AND T2.MODELNO_GROUP IN (
                 SELECT T1.MODELNO_GROUP
               FROM TBL_GOODS T1
               --WHERE T1.CA_LCODE=SUBSTR(G.CA_CODE,1,2)
                   WHERE T1.MODELNO=v_modelno
                    AND T1.CATEFLAG='0'
                   )
        )
   ELSE (
      CASE
          WHEN (SUBSTR(G.CA_CODE,1,4) = '0304' AND SUBSTR(G.CA_CODE, 1, 6) <> '030406') OR SUBSTR(G.CA_CODE,1,6) = '970201' THEN (
                 --SELECT NVL(sum( kb_num ), 0)
                         -- FROM (
                         SELECT  NVL(sum(kb_num), 0)
                                  FROM TBL_GOODS
                                 WHERE ca_lcode = SUBSTR(G.CA_CODE,1,2)
                                   and cateflag='0'
                                   and box_modelnm = (SELECT box_modelnm
                                                        FROM TBL_GOODS
                                                       WHERE ca_lcode = SUBSTR(G.CA_CODE,1,2)
                                                         and modelno = v_modelno
                                                         AND cateflag='0'
                                                         AND rownum<=1)
                               --)
                 )
        ELSE G.KB_NUM
       END


     )
   END AS KB_NUM
  INTO i_count
     FROM TBL_GOODS G
     WHERE G.MODELNO = v_modelno
      AND G.CATEFLAG='0'
     AND ROWNUM<=1;

     RETURN i_count;

END;