/* *************************************************************************
 * NAME : DEAL.VW_ES_SOCIAL_SEARCHING
 * TYPE : VIEW
 * TIME : Create: 2018-03-28 15:35:56
 *        Modify: 2018-03-28 15:35:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DEAL"."VW_ES_SOCIAL_SEARCHING" ("CP_ID", "CP_COMPANY", "CP_NAME", "CP_DESCRIPT", "CP_SUMMARY", "CP_SALEPRICE", "CP_SALERATE", "CP_SALECNT", "CP_STARTDATE", "CP_LIMITDATE", "CP_RANK", "CP_HIT", "CP_CATEGORY", "CP_SALE_ENDING", "CP_SALE_ENDING_SEQ", "CP_TODAY_USE", "CP_FREE_SHIP", "CP_MOBILE_RANK", "CP_CATEGORY1", "CP_CATEGORY2", "CP_CATEGORY3", "CP_LOCCATE1", "CP_LOCCATE2") AS 
  select d4.cp_id,
       d4.cp_company,
       d4.cp_name,
       d4.cp_descript,
       d4.cp_summary,
       d4.cp_saleprice,
       d4.cp_salerate,
       d4.cp_salecnt,
       replace(substr(d4.cp_startdate, 0, 10), '-', '') cp_startdate,
       replace(substr(d4.cp_limitdate, 0, 10), '-', '') cp_limitdate,
       d4.cp_rank,
       d4.cp_hit,
       d4.cp_category,
       case
         when d4.cp_maxcnt > 0 and ( d4.cp_salecnt / d4.cp_maxcnt ) * 100 >= 80 then
           'Y'
         else
           'N'
       end cp_sale_ending,
       case
         when d4.cp_maxcnt > 0 and ( d4.cp_salecnt / d4.cp_maxcnt ) * 100 >= 80 then
           ( d4.cp_salecnt / d4.cp_maxcnt ) * 100
         else
           0
       end cp_sale_ending_seq,
       d4.cp_today_use,
       d4.cp_free_ship,
       d4.cp_mobile_rank,
       cate.cate_1             cp_category1,
       cate.cate_2             cp_category2,
       cate.cate_3             cp_category3,
       loc.cp_loccate1         cp_loccate1,
       loc.cp_loccate2         cp_loccate2
  from D4_COUPON d4,
       (select cp_id,
               regexp_replace(listagg(loccatetop, ' ') within group (order by loccatetop), '([^ ]+)( \1)*', '\1') as cp_loccate1,
               regexp_replace(listagg(loccate, ' ') within group (order by loccate), '([^ ]+)( \1)*', '\1') as cp_loccate2
          from D4_COUPON_LOC
         group by cp_id
       ) loc,
       (select cp_id,
               regexp_replace(listagg(cate1, ',') within group (order by cate1), '([^,]+)(,\1)*', '\1') as cate_1,
               regexp_replace(listagg(cate2, ',') within group (order by cate2), '([^,]+)(,\1)*', '\1') as cate_2,
               regexp_replace(listagg(cate3, ',') within group (order by cate3), '([^,]+)(,\1)*', '\1') as cate_3
          from D4_COUPON_CATE
         group by cp_id
       ) cate
 where d4.cp_id = loc.cp_id(+)
   and d4.cp_id = cate.cp_id(+)
   and cate.cate_1 is not null
   and cate.cate_2 is not null
   and cate.cate_3 is not null
   and to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between d4.cp_startdate and d4.cp_limitdate
   and d4.cp_display_yn = 'Y'
   and d4.cp_del_yn != 'Y'
   and d4.cp_maxcnt > d4.cp_salecnt
   and trim(d4.cp_url) is not null
