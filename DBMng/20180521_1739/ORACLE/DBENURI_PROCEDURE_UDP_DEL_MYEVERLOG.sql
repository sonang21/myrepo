/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_MYEVERLOG
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_MYEVERLOG" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
 	tmp_start     VARCHAR2(100) := '';
 	tmp_end    VARCHAR2(100) := '';
 
  CURSOR cur_pl_no IS
    SELECT /*+ parallel(m 4) */ id, shop_code
      FROM TBL_MYEVER_LOG m
     WHERE LOG_DATE < sysdate-62;

	v_id_tmp   			tbl_myever_log.id%TYPE := 0;
	v_shop_code_tmp	tbl_myever_log.shop_code%TYPE := 0;
	i_count 				NUMBER := 0;
	v_totcnt 				NUMBER := 0;
BEGIN
	--DBMS_OUTPUT.ENABLE;
	--DBMS_OUTPUT.PUT_LINE('UDP_DEL_MYEVERLOG start ......');
  
  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
    FROM DUAL;
     
	startTime := startTime || '|10 : ' || tmp_start;     
	
 	i_count := 0;
 	v_totcnt := 0;

 	OPEN cur_pl_no;
 	LOOP
 	
 		FETCH cur_pl_no INTO v_id_tmp, v_shop_code_tmp;
 		EXIT WHEN cur_pl_no%NOTFOUND;
			v_totcnt := v_totcnt + 1;
			
      BEGIN
  			i_count := i_count + 1;
        DELETE TBL_MYEVER_LOG WHERE ID = v_id_tmp AND SHOP_CODE = v_shop_code_tmp;
  
        IF i_count = 500 THEN
          COMMIT;
          i_count := 0;
        END IF;
        
  		EXCEPTION WHEN OTHERS THEN                 
        COMMIT;
        i_count := 0;
  		END;
      	
 	END LOOP;
 	CLOSE cur_pl_no;

 	COMMIT;

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
    FROM DUAL;
 
	endTime   := endTime || '|10 : ' || tmp_end;  
 
  IF result_code = '' THEN
   result_code := '0';
  ELSE
   result_code := result_code || '|' || '0';
  END IF;
 
  IF result_desc = '' THEN
   result_desc := 'UDP_DEL_MYEVERLOG => SUCCESS total count : ' || v_totcnt;
  ELSE
   result_desc := result_desc || '|' || 'UDP_DEL_MYEVERLOG => SUCCESS total count : ' || v_totcnt;
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
         result_desc := 'UDP_DEL_MYEVERLOG => ERROR : ' || SQLERRM;
    ELSE
         result_desc := result_desc || '|' || 'UDP_DEL_MYEVERLOG => ERROR : ' || SQLERRM;
    END IF;
     
    endTime   := endTime || '|10 error: ' || tmp_end;  
    
END UDP_DEL_MYEVERLOG;
 