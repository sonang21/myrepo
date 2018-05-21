/* *************************************************************************
 * NAME : DBENURI.UDP_HOT_SEARCHKEYWORD_MOVE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_HOT_SEARCHKEYWORD_MOVE" AS 
  intCount NUMBER := 0;
BEGIN
  SELECT count(*) 
  INTO intCount
 	FROM TBL_HOT_SEARCHKEYWORD_TMP;
  if intCount > 10 then
    delete TBL_HOT_SEARCHKEYWORD;
    insert into TBL_HOT_SEARCHKEYWORD ( select * from TBL_HOT_SEARCHKEYWORD_TMP);
    insert into TBL_HOT_SEARCHKEYWORD_HISTORY (keyword,rank_1,rank_2,new_rank_1,new_rank_2,log_time) 
    (select keyword,rank_1,rank_2,new_rank_1,new_rank_2,(select max(log_time) from TBL_DQ_SEARCH_LOG_HISTORY) AS log_time from  TBL_HOT_SEARCHKEYWORD);
    commit;
  end if;
END UDP_HOT_SEARCHKEYWORD_MOVE;