/* *************************************************************************
 * NAME : DBENURI.UDP_MP_COMPONENT_SUMMARY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 11:11:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MP_COMPONENT_SUMMARY" 
(CP_CA_CODE TBL_CATE_GOODS.CA_CODE%TYPE, CP_MODELNO TBL_GOODS.MODELNO%TYPE)
IS
/*
 NGIT ���� �ݿ� - �迵�� 20180502
*/
BEGIN
	-- SUMMARY ����
	DELETE FROM TBL_COMPONENT_SUMMARY
 	WHERE MODELNO = CP_MODELNO;

	-- SUMMARY �߰�
	INSERT INTO TBL_COMPONENT_SUMMARY(MODELNO, CPT_ID, CP_IDS, CNT)
	SELECT CP_MODELNO, A.CPT_ID, NVL(IDS, ''), NVL(CNT, 0)
	  FROM TBL_COMPONENT_TITLE A
		      LEFT JOIN (SELECT B.CPT_ID, UDF_RTN_GET_CPIDS(CP_CA_CODE, CP_MODELNO, B.CPT_ID) IDS, COUNT(*) CNT
		                  	FROM TBL_COMPONENT_MODELNO A
				                      INNER JOIN TBL_COMPONENT_MAPPING B ON A.CP_ID = B.CP_ID
			                 WHERE MODELNO = CP_MODELNO
                      AND A.DEL_YN = 'N' 
                      AND B.DEL_YN = 'N'
			                 GROUP BY B.CPT_ID
		                ) B ON A.CPT_ID = B.CPT_ID
	 WHERE CA_CODE = CP_CA_CODE
    AND DEL_YN = 'N';

  COMMIT;
END;
