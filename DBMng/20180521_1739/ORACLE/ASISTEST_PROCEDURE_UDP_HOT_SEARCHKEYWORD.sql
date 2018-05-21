/* *************************************************************************
 * NAME : ASISTEST.UDP_HOT_SEARCHKEYWORD
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_HOT_SEARCHKEYWORD" AS 
BEGIN
  
  delete TBL_HOT_SEARCHKEYWORD_PREV;
  insert into TBL_HOT_SEARCHKEYWORD_PREV ( select KEYWORD ,RANK_1 ,RANK_2 ,NEW_RANK_1 ,NEW_RANK_2  from TBL_HOT_SEARCHKEYWORD_TMP);
  delete TBL_HOT_SEARCHKEYWORD_TMP;
  insert into TBL_HOT_SEARCHKEYWORD_TMP (Keyword,rank_1,rank_2)
  select a.keyword,a.num od1,b.num od2 from 
  (select rownum num,log_time,keyword,cnt from(select log_time,keyword,count(*) cnt from TBL_DQ_SEARCH_LOG WHERE keyword not in (select keyword from tbl_hot_search_except) and user_ip is not null group by log_time,keyword order by count(*) desc,keyword)) a right outer join
  (select rownum num,log_time,keyword,cnt from(select log_time,keyword,count(*) cnt from (select distinct log_time,keyword,user_ip from TBL_DQ_SEARCH_LOG WHERE keyword not in (select keyword from tbl_hot_search_except) and user_ip is not null) group by keyword,log_time order by count(*) desc,keyword)) b
  on a.keyword = b.keyword and a.log_time = b.log_time
  where  b.cnt > 2 order by a.num;

  update TBL_HOT_SEARCHKEYWORD_TMP a set (new_rank_1) =  
  (select new_rank_1 from ( select a.keyword , nvl(b.rank_1, (select count(*) from TBL_HOT_SEARCHKEYWORD_Prev)+1) - a.rank_1 as new_rank_1 from TBL_HOT_SEARCHKEYWORD_TMP a left outer join TBL_HOT_SEARCHKEYWORD_Prev b on a.keyword = b.keyword) b 
  where a.keyword= b.keyword
  );
  update TBL_HOT_SEARCHKEYWORD_TMP a set (new_rank_2) =  
  (select new_rank_2 from ( select a.keyword , nvl(b.rank_2, (select count(*) from TBL_HOT_SEARCHKEYWORD_Prev)+1) - a.rank_2 as new_rank_2 from TBL_HOT_SEARCHKEYWORD_TMP a left outer join TBL_HOT_SEARCHKEYWORD_Prev b on a.keyword = b.keyword) b 
  where a.keyword= b.keyword 
  );
  
  commit;
END UDP_HOT_SEARCHKEYWORD;