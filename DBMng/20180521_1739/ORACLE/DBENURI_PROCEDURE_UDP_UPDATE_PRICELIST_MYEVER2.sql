/* *************************************************************************
 * NAME : DBENURI.UDP_UPDATE_PRICELIST_MYEVER2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-08 19:23:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_UPDATE_PRICELIST_MYEVER2" 
IS
 CURSOR cur_pl_no IS
   SELECT /*+ parallel(p1 4) */ pl_no
     FROM TBL_PRICELIST p1
    WHERE status = '0' and jobtype='2';

 v_pl_no_tmp    tbl_myever.pl_no%TYPE := 0;
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST start ......');

 i_count := 0;

 OPEN cur_pl_no;
 LOOP

   FETCH cur_pl_no INTO v_pl_no_tmp;
   EXIT WHEN cur_pl_no%NOTFOUND;

     UPDATE /*+ APPEND */ TBL_PRICELIST SET status = '4' WHERE pl_no = v_pl_no_tmp;

     COMMIT;

 END LOOP;
 CLOSE cur_pl_no;

 COMMIT;

END UDP_UPDATE_PRICELIST_MYEVER2;
 
