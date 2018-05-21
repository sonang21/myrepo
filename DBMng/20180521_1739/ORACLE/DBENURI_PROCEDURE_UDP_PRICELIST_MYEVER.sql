/* *************************************************************************
 * NAME : DBENURI.UDP_PRICELIST_MYEVER
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_PRICELIST_MYEVER" (
      result_code IN OUT VARCHAR2,
      result_desc IN OUT VARCHAR2,
      startTime IN OUT VARCHAR2,
      endTime IN OUT VARCHAR2)
IS
	CURSOR cur_pricelist IS     
   SELECT /*+ parallel(p 4) parallel(m 4) */ NVL(EVER_DELIVERYFLAG, ''), NVL(EVER_DELFEETYPE, ''), NVL(EVER_DELAREATYPE, ''), NVL(EVER_DELPRICE, 0), 
          NVL(EVER_DELFEEDESC, ''), NVL(EVER_DELAREADESC, ''), NVL(EVER_DELBASISFROM, 0), NVL(EVER_DELBASISTO, 0), 
          NVL(EVER_AIRCONDESC, ''), NVL(EVER_AIRCONFEETYPE, ''), p.shop_code, p.pl_no
     FROM TBL_PRICELIST p, TBL_MYEVER m
    WHERE p.JOBTYPE = '2'
      AND ( p.DELIVERYFLAG = ' ' OR p.DELFEETYPE = ' ' )
      AND p.STATUS <> '5' 
      AND p.shop_code = m.shop_code   
      AND p.pl_no = m.pl_no;
         
	v_deliveryflag 	tbl_pricelist.deliveryflag%TYPE := '';
	v_delfeetype   	tbl_pricelist.delfeetype%TYPE := '';
	v_delareatype  	tbl_pricelist.delareatype%TYPE := '';
	v_delprice    	tbl_pricelist.delprice%TYPE := 0;
	v_delfeedesc		tbl_pricelist.delfeedesc%TYPE := '';
	v_delareadesc		tbl_pricelist.delareadesc%TYPE := '';
	v_basisfrom			tbl_pricelist.basisfrom%TYPE := 0;
	v_basisto				tbl_pricelist.basisto%TYPE := 0;
	v_aircondesc		tbl_pricelist.aircondesc%TYPE := '';
	v_airconfeetype	tbl_pricelist.airconfeetype%TYPE := '';
  v_shop_code 		tbl_pricelist.shop_code%TYPE := 0;
  v_pl_no     		tbl_pricelist.pl_no%TYPE := 0;
  
 	tmp_start     	VARCHAR2(100) := '';
 	tmp_end    			VARCHAR2(100) := '';  
  i_count 				NUMBER := 0;
  i_tcount				NUMBER := 0;

  BEGIN

 	 --DBMS_OUTPUT.ENABLE;
 	 --DBMS_OUTPUT.PUT_LINE('UDP_PRICELIST_MYEVER start ......');
 
   SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO tmp_start
      FROM DUAL;

	 startTime := startTime || '|8 : ' || tmp_start;
	 
    i_count := 0;

		OPEN cur_pricelist;
 		LOOP

      FETCH cur_pricelist INTO v_deliveryflag, v_delfeetype, v_delareatype, v_delprice, v_delfeedesc, v_delareadesc, v_basisfrom, v_basisto, v_aircondesc, v_airconfeetype, v_shop_code, v_pl_no;
      EXIT WHEN cur_pricelist%NOTFOUND;

      i_count := i_count + 1;
      i_tcount := i_tcount + 1;
      
      UPDATE TBL_PRICELIST SET DELIVERYFLAG = v_deliveryflag, DELFEETYPE = v_delfeetype, DELAREATYPE = v_delareatype, DELPRICE = v_delprice, DELFEEDESC = v_delfeedesc, 
                               DELAREADESC = v_delareadesc, BASISFROM = v_basisfrom, BASISTO = v_basisto, AIRCONDESC = v_aircondesc, AIRCONFEETYPE = v_airconfeetype
       WHERE pl_no = v_pl_no
         AND shop_code = v_shop_code;
         
    	IF i_count = 500 THEN
      	COMMIT;
      	i_count := 0;
    	END IF;

		END LOOP;
		CLOSE cur_pricelist;

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
  	result_desc := 'UDP_PRICELIST_MYEVER => SUCCESS total count : ' || i_tcount;
 	ELSE
  	result_desc := result_desc || '|' || 'UDP_PRICELIST_MYEVER => SUCCESS total count : ' || i_tcount;
 	END IF;

	endTime   := endTime || '|8 : ' || tmp_end;
	
  EXCEPTION
   WHEN OTHERS THEN
    SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
     INTO tmp_end
     FROM DUAL;
     
    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_PRICELIST_MYEVER => ERROR ';
    ELSE
         result_desc := result_desc || '|' || 'UDP_PRICELIST_MYEVER => ERROR ';
    END IF;
    --result_desc := '8 => ERROR (' || SQLERRM || '), s : ' || v_shop_code || ', count : ' || i_count;

   	endTime   := endTime || '|8 error: ' || tmp_end;  
   	
END UDP_PRICELIST_MYEVER;
 