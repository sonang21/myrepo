/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_PRICELIST_5217
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_PRICELIST_5217" 
IS
 CURSOR cur_pl_no IS
   SELECT pl_no
     FROM TBL_PRICELIST p1
    WHERE shop_code=5217
      AND status = '5';

 v_pl_no_tmp    tbl_pricelist.pl_no%TYPE := 0;
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST_5217 start ......');

 i_count := 0;

 OPEN cur_pl_no;
 LOOP

   FETCH cur_pl_no INTO v_pl_no_tmp;
   EXIT WHEN cur_pl_no%NOTFOUND;

     DELETE /*+APPEND NOLOGGING t */  FROM TBL_PRICELIST t WHERE t.pl_no = v_pl_no_tmp;

     COMMIT;

 END LOOP;
 CLOSE cur_pl_no;

 COMMIT;

 delete /*+ APPEND */ from tbl_myever where ever_status = '2' and ever_date+60 < sysdate;

 COMMIT;

END UDP_DEL_PRICELIST_5217;
 