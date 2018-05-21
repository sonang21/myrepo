/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_GOODS_DIRECT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_GOODS_DIRECT" 
IS
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_GOODS_DIRECT start ......');

  i_count := 0;

  DELETE FROM TBL_GOODS_SEARCH_DIRECT;
 COMMIT;

END UDP_DEL_GOODS_DIRECT;
 