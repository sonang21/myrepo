/* *************************************************************************
 * NAME : DEAL.MV_COUPON_A02_PRICE
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 15:36:07
 *        Modify: 2018-05-21 15:58:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DEAL"."MV_COUPON_A02_PRICE" ("ORDERCNT", "CP_ID", "CP_COMPANY", "CP_ETAG", "CP_CATE1", "CP_CATE2", "CP_CATE3", "COMPANY_NM", "CP_NAME", "CP_URL", "PC_URL", "CP_COUPON_START", "CP_COUPON_END", "CP_TODAY", "CP_CLOSE", "CP_TODAY_USE", "CP_INSTANT_DELIVER", "CP_FREE_SHIP", "CP_IMAGE", "LIKE_CNT", "CP_SALEPRICE", "CP_SALERATE", "CP_DESCRIPT", "CP_SUMMARY", "CP_PRICE", "CP_SALECNT", "CP_ADDRESS", "CP_LAT", "CP_LNG", "CP_STARTDATE", "CP_LIMITDATE", "CP_MAXCNT", "CP_RANK", "MOMSORDER", "SOLDRATE", "CP_MOBILE_RANK", "CP_MOBILE_RANK_OLD", "PAGING_RNUM")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEAL1" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + 6/24
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS SELECT p.*,
       ROWNUM AS paging_rnum
FROM   (
	SELECT f.*
	FROM
		(
		SELECT o.ordercnt,
			t.cp_id,
			t.cp_company,
			t.cp_etag,
			t.cp_cate1,
			t.cp_cate2,
			t.cp_cate3,
			t.cp_company_name AS company_nm,
			t.cp_name,
			NVL(trim(t.cp_murl),t.cp_url) AS cp_url,t.cp_url as pc_url,
			t.cp_coupon_start,
			t.cp_coupon_end,
			CASE
				WHEN SUBSTR(t.cp_startdate, 0, 10) = TO_CHAR(sysdate, 'yyyy-mm-dd')
				THEN 'Y'
				ELSE 'N'
			END AS cp_today,
			CASE
				WHEN SUBSTR(t.cp_limitdate, 0, 10) = TO_CHAR(sysdate, 'yyyy-mm-dd')
				THEN 'Y'
				ELSE 'N'
			END AS cp_close,
			t.cp_today_use,
			t.cp_instant_deliver,
			t.cp_free_ship,
			NVL(NVL(cp_image_manager,cp_image5),cp_image1) AS cp_image,
			(NVL(t.cp_hit,0) + NVL(t.momsplus,0))                           AS like_cnt ,
			DECODE(t.cp_mobile_price, 0, t.cp_saleprice, t.cp_mobile_price) AS cp_saleprice,
			CASE
					WHEN t.cp_company_name = 'G9'
					THEN t.cp_salerate
					--ELSE DECODE(t.cp_mobile_discount, 0, t.cp_salerate, t.cp_mobile_discount)
					ELSE ROUND(decode(DECODE(t.cp_mobile_original, 0, t.cp_price, t.cp_mobile_original), 0, 0, 100-(DECODE(t.cp_mobile_price, 0, t.cp_saleprice, t.cp_mobile_price)/DECODE(t.cp_mobile_original, 0, t.cp_price, t.cp_mobile_original))*100),0)
			END  AS cp_salerate,
			t.cp_descript,
			t.cp_summary,
			DECODE(t.cp_mobile_original, 0, t.cp_price, t.cp_mobile_original) AS cp_price,
			t.cp_salecnt,
			t.cp_address,
			t.cp_lat,
			t.cp_lng,
			t.cp_startdate,
			t.cp_limitdate,
			t.cp_maxcnt,
			t.cp_rank,
			t.momsorder,
			CASE
				WHEN NVL(t.cp_maxcnt, 0) = 0
				OR NVL(t.cp_salecnt, 0)  = 0
				THEN 0
				WHEN t.cp_maxcnt = 0
				OR t.cp_salecnt  = 0
				THEN 0
				WHEN t.cp_salecnt / t.cp_maxcnt > 0
				THEN
					CASE
						WHEN ROUND(t.cp_salecnt / t.cp_maxcnt * 100, 1) = 0
						THEN 1
						ELSE ROUND(t.cp_salecnt / t.cp_maxcnt * 100, 1)
					END
				ELSE ROUND(t.cp_salecnt / t.cp_maxcnt * 100, 1)
			END AS soldrate,
			t.cp_mobile_rank,
			t.cp_mobile_rank_old
		FROM d4_coupon t,
			d4_coupon_order o
		WHERE t.cp_id    = o.cp_id(+)
		AND t.cp_del_yn != 'Y'
		AND t.cp_display_yn='Y'
		AND TO_CHAR(sysdate, 'YYYY-MM-DD hh24:mi:ss') BETWEEN t.cp_startdate AND t.cp_limitdate
		AND t.cp_cate1 IS NOT NULL
		AND t.cp_cate2 IS NOT NULL
		AND t.cp_cate3 IS NOT NULL
		AND t.cp_id    IN
			(
			SELECT DISTINCT v.cp_id
			FROM mv_coupon v
			WHERE 1     = 1
			AND v.cate1 = 'A02'
			)
		) f
	WHERE 1 = 1
	AND f.cp_maxcnt   > f.cp_salecnt
	AND trim(cp_url) IS NOT NULL
	AND f.cp_price >=0
	ORDER BY cp_saleprice
--	ORDER BY ordercnt,
--					cp_rank
) p
