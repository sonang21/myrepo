/* *************************************************************************
 * NAME : ASISTEST.UDP_SEARCH_LOG_BACKUP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:30
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SEARCH_LOG_BACKUP" AS 
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
  /*��������Ʈ �α� ����*/
  delete TBL_DQ_SEARCH_LOG_HISTORY where log_time < to_char(sysdate-100,'yyyymmddhhmiss');
  commit;    

 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('UDP_SEARCH_LOG_BACKUP error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END UDP_SEARCH_LOG_BACKUP;