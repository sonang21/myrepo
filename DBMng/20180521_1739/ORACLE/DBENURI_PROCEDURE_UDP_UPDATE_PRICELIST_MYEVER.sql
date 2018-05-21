/* *************************************************************************
 * NAME : DBENURI.UDP_UPDATE_PRICELIST_MYEVER
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_UPDATE_PRICELIST_MYEVER" 
IS
 CURSOR cur_ever_no IS
   SELECT /*+ parallel(p1 4) */ ever_no
     FROM TBL_MYEVER p1
    WHERE ever_status ='1';

 v_ever_no_tmp    tbl_myever.ever_no%TYPE := 0;
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST start ......');

 i_count := 0;

 OPEN cur_ever_no;
 LOOP

   FETCH cur_ever_no INTO v_ever_no_tmp;
   EXIT WHEN cur_ever_no%NOTFOUND;

     UPDATE /*+ APPEND */ TBL_MYEVER SET ever_status = '0' WHERE ever_no = v_ever_no_tmp;

     COMMIT;

 END LOOP;
 CLOSE cur_ever_no;

 COMMIT;

END UDP_UPDATE_PRICELIST_MYEVER;
 