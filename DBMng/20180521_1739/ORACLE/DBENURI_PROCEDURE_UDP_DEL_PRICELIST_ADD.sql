/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_PRICELIST_ADD
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_PRICELIST_ADD" 
IS
 i_count     NUMBER := 0;
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST_ADD start ......');

  i_count := 0;

  DELETE FROM TBL_PRICELIST_SEARCH_ADD;
 COMMIT;

END UDP_DEL_PRICELIST_ADD;
 