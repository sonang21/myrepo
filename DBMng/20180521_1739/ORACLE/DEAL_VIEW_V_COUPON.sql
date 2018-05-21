/* *************************************************************************
 * NAME : DEAL.V_COUPON
 * TYPE : VIEW
 * TIME : Create: 2018-03-28 15:35:56
 *        Modify: 2018-03-28 15:35:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DEAL"."V_COUPON" ("CP_ID", "CATE1", "CATE2", "CATE3", "LOCCATETOP", "LOCCATE") AS 
  select t.cp_id, c.cate1,  c.cate2, c.cate3, l.loccatetop, l.loccate
from D4_COUPON t , D4_COUPON_CATE C , D4_COUPON_LOC L
where t.cp_display_yn = 'Y'
and t.cp_del_yn != 'Y'
and t.cp_id = c.cp_id (+)
and t.cp_id = l.cp_id(+)
and t.cp_startdate <= To_Char(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
and t.cp_limitdate >= To_Char(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')

WITH READ ONLY