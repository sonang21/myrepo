/* *************************************************************************
 * NAME : ASISTEST.UDP_EVERMALL_SECEDE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:22
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_EVERMALL_SECEDE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS

	tmp_start     VARCHAR2(100) := '';
	tmp_end				VARCHAR2(100) := '';

BEGIN
	--DBMS_OUTPUT.ENABLE;
	--DBMS_OUTPUT.PUT_LINE('UDP_EVERMALL_SECEDE start ......');
  
 	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
 	  FROM DUAL;

	startTime := startTime || '|7 : ' || tmp_start;
	
  ---------------------------------------------------------
  -- �����층 : ������ Ż�� ȸ�� 6���� �� : �ֹι�ȣ ����
  ---------------------------------------------------------
  --    Ż���� ���� ��ü ó�� ��� ���  
  BEGIN
    UPDATE	TBL_SHOPLIST
  	   SET	es_president = '',
  	   		  es_regno1	= '',
            es_regno2 = ''
     WHERE 	es_use = '7'	-- ������ Ż��(�Ƚɱ��� ����)
       AND	service	= '1'	-- ����		(���θ� ���� ����)
       AND	opt = '0'	-- ���Ұ� (sdu ����Ʈ ��� �ɼ�)
    	 AND  nvl(es_enddate, sysdate) < to_date(to_char(sysdate, 'yyyy/mm/dd'),'yyyy/mm/dd') - 179	-- 6����
       AND  nvl(es_enddate, sysdate) >= to_date(to_char(sysdate, 'yyyy/mm/dd'),'yyyy/mm/dd') - 180;	-- 6����  
       
    COMMIT;

  EXCEPTION WHEN OTHERS THEN
    result_code := result_code || '' || SQLCODE;
    result_desc := result_desc || 'UDP_EVERMALL_SECEDE => 1 ERROR';
  	COMMIT;
 	END;
		  
  BEGIN
		UPDATE TBL_NSHOP_DETAIL
       SET ns_regno = '',
           ns_president	= '',
           ns_preregno = ''
     WHERE ns_withdraw_flag= '2'		-- ������ Ż��
       AND shop_code in (SELECT	shop_code
                        	 FROM	TBL_SHOPLIST
		                      WHERE es_use = '7'	-- ������ Ż��(�Ƚɱ��� ����)
		                        AND	service = '1'	-- ����		(���θ� ���� ����)
		                        AND	opt = '0'	-- ���Ұ� (sdu ����Ʈ ��� �ɼ�)
		                        AND nvl(es_enddate,sysdate) < to_date(to_char(sysdate, 'yyyy/mm/dd'),'yyyy/mm/dd') - 179	-- 6����
		                        AND	nvl(es_enddate,sysdate) >= to_date(to_char(sysdate, 'yyyy/mm/dd'),'yyyy/mm/dd') - 180); 	-- 6����
       
    COMMIT;

  EXCEPTION WHEN OTHERS THEN
    result_code := result_code || '' || SQLCODE;
    result_desc := result_desc || 'UDP_EVERMALL_SECEDE => 2 ERROR';
  	COMMIT;
 	END;

  BEGIN
    UPDATE TBL_NSHOP_WDETAIL
       SET ns_regno	= '',
       		 ns_president	= '',
       		 ns_preregno = ''
     WHERE shop_code in (SELECT	shop_code
    		                   FROM	TBL_SHOPLIST
    		                  WHERE	es_use = '7'	-- ������ Ż��(�Ƚɱ��� ����)
    		                    AND	service = '1'	-- ����		(���θ� ���� ����)
    		                    AND	opt = '0'	-- ���Ұ� (sdu ����Ʈ ��� �ɼ�)
    		                    AND nvl(es_enddate,sysdate) < to_date(to_char(sysdate, 'yyyy/mm/dd'),'yyyy/mm/dd') - 179	-- 6����
    		                    AND nvl(es_enddate,sysdate) >= to_date(to_char(sysdate, 'yyyy/mm/dd'),'yyyy/mm/dd') - 180); 	-- 6����
       
    COMMIT;

  EXCEPTION WHEN OTHERS THEN
    result_code := result_code || '' || SQLCODE;
    result_desc := result_desc || 'UDP_EVERMALL_SECEDE => 3 ERROR';
  	COMMIT;
 	END;
 	
 	COMMIT;
 	
	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
 	  FROM DUAL;

	IF result_code = '' THEN
		result_code := '0';
	ELSE
		result_code := result_code || '|' || '0';
	END IF;
	
	IF result_desc = '' THEN
		result_desc := 'UDP_EVERMALL_SECEDE => SUCCESS';
	ELSE
		result_desc := result_desc || '|' || 'UDP_EVERMALL_SECEDE => SUCCESS';
	END IF;

	endTime   := endTime || '|7 : ' || tmp_end;
	
	EXCEPTION
     WHEN OTHERS THEN
     		COMMIT;
      	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
 	  	    INTO tmp_end
   		    FROM DUAL;
   		    
				IF result_code = '' THEN
       		result_code := SQLCODE;
       	ELSE
       		result_code := result_code || '|' || SQLCODE;
       	END IF;
       	
       	IF result_desc = '' THEN
	       	result_desc := 'UDP_EVERMALL_SECEDE => ERROR';
       	ELSE
  	     	result_desc := result_desc || '|' || 'UDP_EVERMALL_SECEDE => ERROR';
       	END IF;
       	
      	endTime   := endTime || '|7 error: ' || tmp_end;       	

END UDP_EVERMALL_SECEDE;