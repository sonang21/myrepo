/* *************************************************************************
 * NAME : ASISTEST.UDP_DEL_PRICELIST2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:19
 *        Modify: 2018-05-04 18:53:41
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEL_PRICELIST2" 
IS
  CURSOR cur_pl_no IS
    select pl_no
      from tbl_pricelist
     where ca_code = '0912';    

 v_pl_no_tmp    tbl_pricelist.pl_no%TYPE := 0;
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST2 start ......');

  i_count := 0;

  OPEN cur_pl_no;
  LOOP

   FETCH cur_pl_no INTO v_pl_no_tmp;
   EXIT WHEN cur_pl_no%NOTFOUND;

			i_count := i_count + 1;
      UPDATE /*+ append */ TBL_PRICELIST SET ca_code = '0914' WHERE pl_no = v_pl_no_tmp;

			IF i_count = 10 THEN
      	COMMIT;
      	i_count := 0;
   		END IF;
   		
 END LOOP;
 CLOSE cur_pl_no;

 COMMIT;

END UDP_DEL_PRICELIST2;