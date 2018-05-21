/* *************************************************************************
 * NAME : DBENURI.DELETE_SEARCH_LOG_HISTORY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."DELETE_SEARCH_LOG_HISTORY" AS 
BEGIN
  
  delete TBL_DQ_SEARCH_LOG_HISTORY where to_date(substr(log_time,1,8),'yyyymmdd') < to_date(to_char((ADD_MONTHS(SYSDATE, -3)),'yyyymmdd'),'yyyymmdd');
  commit; 
  delete TBL_HOT_SEARCHKEYWORD_HISTORY where to_date(substr(log_time,1,8),'yyyymmdd') < to_date(to_char((ADD_MONTHS(SYSDATE, -3)),'yyyymmdd'),'yyyymmdd');
  commit; 
 EXCEPTION
     WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('DELETE_SEARCH_LOG_HISTORY error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
         
END DELETE_SEARCH_LOG_HISTORY;