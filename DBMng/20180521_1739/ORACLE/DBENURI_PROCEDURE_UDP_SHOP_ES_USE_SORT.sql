/* *************************************************************************
 * NAME : DBENURI.UDP_SHOP_ES_USE_SORT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_SHOP_ES_USE_SORT" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
  CURSOR cur_shoplist_es_use_true IS
  	SELECT shop_no, shop_code
  	  FROM TBL_SHOPLIST 
  	 WHERE es_use = '9';
  	 
  CURSOR cur_shoplist_es_use_false IS
		SELECT shop_no, shop_code
  	  FROM TBL_SHOPLIST
  	 WHERE es_use <> '9' 
  	   AND es_use <> '0';

	v_shop_no			tbl_shoplist.shop_no%TYPE := 0;
	v_shop_code   tbl_shoplist.shop_code%TYPE := 0;
	i_count				NUMBER := 0;
	
	tmp_start     VARCHAR2(100) := '';
	tmp_end				VARCHAR2(100) := '';

BEGIN
	--DBMS_OUTPUT.ENABLE;
	--DBMS_OUTPUT.PUT_LINE('UDP_SHOP_ES_USE_SORT start ......');
  
 	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
 	  FROM DUAL;

	startTime := startTime || '|6 : ' || tmp_start;
	
	OPEN cur_shoplist_es_use_true;
	LOOP
	
		FETCH cur_shoplist_es_use_true INTO v_shop_no, v_shop_code;
		EXIT WHEN cur_shoplist_es_use_true%NOTFOUND;

			i_count := i_count + 1;
		  UPDATE TBL_SHOPLIST SET es_use_sort = '9'  WHERE shop_no = v_shop_no AND shop_code = v_shop_code;
		  
		  IF i_count = 1000 THEN
		  	COMMIT;
		  	i_count := 0;
		  END IF;
		                
 	END LOOP;
 	CLOSE cur_shoplist_es_use_true;
 	
 	COMMIT;
 	i_count := 0;
 	
 	OPEN cur_shoplist_es_use_false;
 	LOOP
 	
 		FETCH cur_shoplist_es_use_false INTO v_shop_no, v_shop_code;
 		EXIT WHEN cur_shoplist_es_use_false%NOTFOUND;

			i_count := i_count + 1;
 			UPDATE TBL_SHOPLIST SET es_use_sort = '0'  WHERE shop_no = v_shop_no AND shop_code = v_shop_code;

			IF i_count = 1000 THEN
				COMMIT;
				i_count := 0;
			END IF;
			
	END LOOP;
	CLOSE cur_shoplist_es_use_false;

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
		result_desc := 'UDP_SHOP_ES_USE_SORT => SUCCESS';
	ELSE
		result_desc := result_desc || '|' || 'UDP_SHOP_ES_USE_SORT => SUCCESS';
	END IF;

	endTime   := endTime || '|6 : ' || tmp_end;
	
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
	       	result_desc := 'UDP_SHOP_ES_USE_SORT => ERROR';
       	ELSE
  	     	result_desc := result_desc || '|' || 'UDP_SHOP_ES_USE_SORT => ERROR';
       	END IF;
       	
      	endTime   := endTime || '|6 error: ' || tmp_end;       	

END UDP_SHOP_ES_USE_SORT;
 