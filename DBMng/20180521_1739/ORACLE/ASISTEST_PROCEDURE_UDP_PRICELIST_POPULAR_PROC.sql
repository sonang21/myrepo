/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_POPULAR_PROC
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_POPULAR_PROC" (
		result_code IN OUT VARCHAR2,
		result_desc IN OUT VARCHAR2,
		startTime   IN OUT VARCHAR2,
		endTime     IN OUT VARCHAR2)
IS
  	tmp_start     VARCHAR2(20) := '';
  	tmp_end    VARCHAR2(20) := '';
    i_count      NUMBER := 0;
BEGIN
  	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    	INTO tmp_start
    	FROM DUAL;

		startTime := '' || '|1 : ' || tmp_start;

    --TRUNCATE TABLE TBL_PRICELIST_POPULAR;
    --EXECUTE IMMEDIATE ('TRUNCATE TABLE TBL_PRICELIST_POPULAR');
    DELETE /*+ APPEND NOLOGGING */ TBL_PRICELIST_POPULAR WHERE CA_CODE like '13%' OR CA_CODE like '9804%' OR CA_CODE like '14%' OR CA_CODE like '15%';
    COMMIT;

    INSERT /*+ PARALLEL(TBL_PRICELIST_POPULAR, 4) */ INTO TBL_PRICELIST_POPULAR (PL_NO, POPULAR,CA_CODE)
    SELECT /*+ full(P) parallel(P 4) */
    			 P.PL_NO,
    			 (CASE WHEN P.MODELNO>0 THEN NVL((SELECT G.SUM_POINT FROM TBL_GOODS_POPULAR G WHERE G.MODELNO=P.MODELNO),0) + NVL((SELECT W.POINT FROM TBL_PRICELIST_WEBPOPULAR W WHERE W.PL_NO=P.PL_NO),0)
        		ELSE NVL((SELECT W.POINT FROM TBL_PRICELIST_WEBPOPULAR W WHERE W.PL_NO=P.PL_NO),0)  END) AS POPULAR,
                CA_CODE
    	FROM TBL_PRICELIST P
	   WHERE SRVFLAG='0'
  	   AND STATUS='0'
    	 AND ((MODELNO>0 AND PJOBCODE = '1' AND JOBTYPE = '2' ) OR MODELNO <= 0 OR MODELNO IS NULL )
       AND (p.ca_code like '13%' OR p.ca_code like '9804%' OR p.ca_code like '14%' OR p.ca_code like '15%');
            --OR p.ca_code like '0914%' OR p.ca_code like '0311%' OR p.ca_code like '16%');

    COMMIT;
    --===============================================================================================================
    --pricelist popular update
    --===============================================================================================================
    i_count := 0;
    FOR tmp_loop in (SELECT PL_NO, POPULAR FROM TBL_PRICELIST_POPULAR WHERE CA_CODE like '13%' OR CA_CODE like '9804%' OR CA_CODE like '14%' OR CA_CODE like '15%') LOOP

      BEGIN

         UPDATE TBL_PRICELIST SET popular = tmp_loop.popular WHERE pl_no = tmp_loop.pl_no AND popular <> tmp_loop.popular;
         --COMMIT;
         i_count := i_count + 1;

         --EXCEPTION WHEN OTHERS THEN

         --COMMIT;

      END;

      IF i_count = 50 THEN
      	COMMIT;
       	i_count := 0;
      END IF;

    END LOOP;

    COMMIT;
    --================================================================================================================
    
   	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     	INTO tmp_end
     	FROM DUAL;

  	endTime   := '' || '|1 : ' || tmp_end;

   	IF result_code = '' THEN
    	result_code := '0';
   	ELSE
    	result_code := result_code || '|' || '0';
   	END IF;

   	IF result_desc = '' THEN
    	result_desc := 'UDP_PRICELIST_POPULAR_PROC SUCCESS ';
   	ELSE
    	result_desc := result_desc || '|' || 'UDP_PRICELIST_POPULAR_PROC SUCCESS ';
   	END IF;

EXCEPTION
	WHEN OTHERS THEN
  	COMMIT;
  	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE ;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_PRICELIST_POPULAR_PROC => ERROR : ' || SQLERRM;
    ELSE
         result_desc := result_desc || '|' || 'UDP_PRICELIST_POPULAR_PROC => ERROR : ' || SQLERRM;
    END IF;

		endTime   := endTime || '|1 error: ' || tmp_end;

END UDP_PRICELIST_POPULAR_PROC;