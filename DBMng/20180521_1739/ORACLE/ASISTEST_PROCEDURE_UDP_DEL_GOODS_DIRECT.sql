/* *************************************************************************
 * NAME : ASISTEST.UDP_DEL_GOODS_DIRECT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:19
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEL_GOODS_DIRECT" 
IS
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_GOODS_DIRECT start ......');

  i_count := 0;

  DELETE FROM TBL_GOODS_SEARCH_DIRECT;
 COMMIT;

END UDP_DEL_GOODS_DIRECT;