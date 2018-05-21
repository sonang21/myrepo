/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_USED_STOCK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_USED_STOCK" 
IS
  CURSOR cur_tmp_no IS
  	SELECT US_NO
  	  FROM TBL_USED_STOCK tmp
		 WHERE (us_status = '2' AND us_delete_date < (sysdate-60)) OR us_status = '4';

	v_us_no_tmp		TBL_USED_STOCK.us_no%TYPE := 0;
	i_count 		NUMBER := 0;
BEGIN
	--DBMS_OUTPUT.ENABLE;
	--DBMS_OUTPUT.PUT_LINE('UDP_DEL_USED_STOCK start ......');

 	i_count := 0;

 	OPEN cur_tmp_no;
 	LOOP
 		FETCH cur_tmp_no INTO v_us_no_tmp;
 		EXIT WHEN cur_tmp_no%NOTFOUND;

		i_count := i_count + 1;

		DELETE FROM TBL_USED_STOCK WHERE US_NO = v_us_no_tmp ;
		DELETE FROM tbl_used_specinfo WHERE US_NO = v_us_no_tmp ;

    		IF i_count = 50 THEN
      			COMMIT;
      			i_count := 0;
     		END IF;

	END LOOP;
	CLOSE cur_tmp_no;

 	COMMIT;

END UDP_DEL_USED_STOCK;
 