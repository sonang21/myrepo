/* *************************************************************************
 * NAME : DBENURI.UDP_M_SEARCH_CATE_UPDATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_M_SEARCH_CATE_UPDATE" AS 
BEGIN
  DELETE TBL_M_SRP_KEYWORD;
  insert into TBL_M_SRP_KEYWORD (select KEYWORD,DISPLAY_TYPE,VIEW_FACTORY from TBL_M_SRP_KEYWORD_MAN WHERE DEL_FLAG <> 'Y');
  commit;

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_SEARCH_LOG_BACKUP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END UDP_M_SEARCH_CATE_UPDATE;