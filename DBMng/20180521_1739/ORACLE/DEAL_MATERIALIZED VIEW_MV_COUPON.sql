/* *************************************************************************
 * NAME : DEAL.MV_COUPON
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 15:36:07
 *        Modify: 2018-04-30 15:39:38
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DEAL"."MV_COUPON" ("CP_ID", "CATE1", "CATE2", "CATE3", "LOCCATETOP", "LOCCATE")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEAL1" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + 6/24
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS select t.cp_id, c.cate1,  c.cate2, c.cate3, l.loccatetop, l.loccate
from D4_COUPON t , D4_COUPON_CATE C , D4_COUPON_LOC L
where t.cp_display_yn = 'Y'
and t.cp_del_yn != 'Y'
and t.cp_id = c.cp_id (+)
and t.cp_id = l.cp_id(+)
and t.cp_startdate <= To_Char(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
and t.cp_limitdate >= To_Char(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
