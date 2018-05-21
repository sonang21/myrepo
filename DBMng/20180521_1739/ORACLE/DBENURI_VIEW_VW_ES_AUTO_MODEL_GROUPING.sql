/* *************************************************************************
 * NAME : DBENURI.VW_ES_AUTO_MODEL_GROUPING
 * TYPE : VIEW
 * TIME : Create: 2018-03-28 18:50:04
 *        Modify: 2018-05-15 11:05:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBENURI"."VW_ES_AUTO_MODEL_GROUPING" ("ID", "MODELNO", "SHOP_CODE", "GOODSNM", "GOODSFACTORY", "PRICE", "CA_CODE") AS 
  with COMP_V as (
  select '[ ]|[-]|[_]|[.]' comp_str
       , '' bank_str
       , ' ' space_str
    from dual
)
select /*+ full(a) parallel(a 4)*/
       rownum as id
     , a.modelno as modelno
     , 0 as shop_code
     , case
         when regexp_instr(a.modelnm, v.comp_str) > 0 then
           regexp_replace(a.modelnm, v.comp_str, v.space_str) || ' ' ||
           regexp_replace(a.modelnm, v.comp_str, v.bank_str) || ' ' ||
           regexp_replace(a.keyword, v.comp_str, v.space_str)
         else
           a.modelnm || ' ' || regexp_replace(a.keyword, v.comp_str, v.space_str)
       end as goodsnm
     , a.brand || ' ' || a.factory as goodsfactory
     , case
         when a.minprice = 0 then
           iv.price
         else
           a.minprice
       end as price
     , a.ca_code as ca_code
  from ASIS_TBL_GOODS a,
       COMP_V v,
       (select /*+ no_merge full(b) parallel(b 8)*/
               b.modelno
             , nvl(min(b.price),0) as price
          from tbl_pricelist b
         where b.srvflag='0'
           and b.status in ('0','5')
         group by b.modelno) iv
 where cateflag='0'
   and a.modelno = iv.modelno
