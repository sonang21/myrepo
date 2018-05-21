/* *************************************************************************
 * NAME : DEAL.MV_COUPON_A02_CNT
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 15:36:07
 *        Modify: 2018-05-21 15:45:06
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DEAL"."MV_COUPON_A02_CNT" ("CP_CATE", "OPT", "CNT")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEAL1" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + 6/24
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS SELECT b.code CP_CATE,
       Nvl(opt, 0) OPT,
       Nvl(cnt, 0) CNT
FROM   (
       --a02
       SELECT 'A02'            cp_cate,
              0                opt,
              Max(paging_rnum) cnt
       FROM   mv_coupon_a02_pop
       UNION ALL
       SELECT 'A02'    cp_cate,
              1        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_close = 'Y'
       UNION ALL
       SELECT 'A02'    cp_cate,
              2        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_free_ship = 'Y'
       UNION ALL
       SELECT 'A02'    cp_cate,
              3        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_today_use = 'Y'
       UNION ALL
       SELECT 'A02'    cp_cate,
              4        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_today = 'Y'
       UNION ALL
       --cate2
       SELECT cp_cate2 cp_cate,
              0        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       GROUP  BY cp_cate2
       UNION ALL
       SELECT cp_cate2 cp_cate,
              1        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_close = 'Y'
       GROUP  BY cp_cate2
       UNION ALL
       SELECT cp_cate2 cp_cate,
              2        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_free_ship = 'Y'
       GROUP  BY cp_cate2
       UNION ALL
       SELECT cp_cate2 cp_cate,
              3        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_today_use = 'Y'
       GROUP  BY cp_cate2
       UNION ALL
       SELECT cp_cate2 cp_cate,
              4        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_today = 'Y'
       GROUP  BY cp_cate2
       UNION ALL
       --cate3
       SELECT cp_cate3 cp_cate,
              0        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       GROUP  BY cp_cate3
       UNION ALL
       SELECT cp_cate3 cp_cate,
              1        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_close = 'Y'
       GROUP  BY cp_cate3
       UNION ALL
       SELECT cp_cate3 cp_cate,
              2        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_free_ship = 'Y'
       GROUP  BY cp_cate3
       UNION ALL
       SELECT cp_cate3 cp_cate,
              3        opt,
              Count(0) cnt
       FROM   mv_coupon_a02_pop
       WHERE  cp_today_use = 'Y'
       GROUP  BY cp_cate3
        UNION ALL
        SELECT cp_cate3 cp_cate,
               4        opt,
               Count(0) cnt
        FROM   mv_coupon_a02_pop
        WHERE  cp_today = 'Y'
        GROUP  BY cp_cate3) a,
       d4_commoncode b
WHERE  a.cp_cate (+) = b.code
