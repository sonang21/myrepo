/* *************************************************************************
 * NAME : DBENURI.UDP_M_SEARCH_CATE_ORDER_UPDATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_M_SEARCH_CATE_ORDER_UPDATE" AS 
BEGIN
  DELETE TBL_M_SRP_KEYWORD_SORT;
  insert into TBL_M_SRP_KEYWORD_SORT (select * from TBL_M_SRP_KEYWORD_SORT_MAN );
  commit;

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_SEARCH_LOG_BACKUP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END UDP_M_SEARCH_CATE_ORDER_UPDATE;