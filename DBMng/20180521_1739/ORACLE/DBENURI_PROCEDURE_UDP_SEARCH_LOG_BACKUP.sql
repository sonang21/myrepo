/* *************************************************************************
 * NAME : DBENURI.UDP_SEARCH_LOG_BACKUP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_SEARCH_LOG_BACKUP" AS 
BEGIN
  insert into TBL_LIST_KEYWORD_LOG_BAK (select * from TBL_LIST_KEYWORD_LOG where reg_date <= sysdate - 100);
  delete TBL_LIST_KEYWORD_LOG where reg_date <= sysdate - 100;
  commit;
  
  insert into TBL_LIST_KEYWORD_VIEW_LOG_BAK (select * from TBL_LIST_KEYWORD_VIEW_LOG where reg_date <= sysdate - 100);
  delete TBL_LIST_KEYWORD_VIEW_LOG where reg_date <= sysdate - 100;
  commit;
   
  insert into tbl_search_keyword_log_bak (select * from tbl_search_keyword_log where reg_date <= sysdate - 100);
  delete tbl_search_keyword_log where reg_date <= sysdate - 100;
  commit;  

  insert into tbl_search_keyword_view_log_b (select * from tbl_search_keyword_view_log where reg_date <= sysdate - 100);
  delete tbl_search_keyword_view_log where reg_date <= sysdate - 100;
  commit;    
  /*다이퀘스트 로그 삭제*/
  delete TBL_DQ_SEARCH_LOG_HISTORY where log_time < to_char(sysdate-100,'yyyymmddhhmiss');
  commit;    

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_SEARCH_LOG_BACKUP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END UDP_SEARCH_LOG_BACKUP;