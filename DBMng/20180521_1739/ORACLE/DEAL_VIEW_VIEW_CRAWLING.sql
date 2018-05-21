/* *************************************************************************
 * NAME : DEAL.VIEW_CRAWLING
 * TYPE : VIEW
 * TIME : Create: 2018-03-28 15:35:56
 *        Modify: 2018-03-28 15:35:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DEAL"."VIEW_CRAWLING" ("CP_ID", "SHOP_CODE", "GOODS_CODE", "SHOP_IMAGE_URL", "INS_DATE", "UPD_DATE", "CP_COMPANY") AS 
  SELECT ''           AS CP_ID, 
			       mb_shop_code AS SHOP_CODE, 
			       cp_pid       AS GOODS_CODE, 
			       ''		      AS SHOP_IMAGE_URL, 
			       sysdate      AS INS_DATE, 
			       ''           AS UPD_DATE, 
			       cp_company   AS CP_COMPANY 
			FROM   (SELECT cp_pid, 
			               cp_company 
			        FROM   deal.d4_coupon 
			        WHERE  cp_pid IN ('21860798', '21840728', '21860710', '21860778')
--//			상품 노출 조건 시작
			               AND cp_del_yn != 'Y' 
			               AND cp_display_yn = 'Y' 
			               AND To_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') BETWEEN 
			                   cp_startdate AND cp_limitdate 
			               AND cp_cate1 IS NOT NULL 
			               AND cp_cate2 IS NOT NULL 
			               AND cp_cate3 IS NOT NULL 
			               AND cp_maxcnt > cp_salecnt 
			               AND Trim(cp_url) IS NOT NULL 
			               AND cp_price >= 0 
--//			상품 노출 조건 종료

			               AND cp_company = (SELECT mb_id 
			                                 FROM   deal.g4_member 
			                                 WHERE  mb_shop_code = 75)) d4 
			       LEFT JOIN (SELECT mb_id, 
			                         mb_shop_code 
			                  FROM   deal.g4_member 
			                  WHERE  mb_shop_code = 75) g4 
			              ON d4.cp_company = g4.mb_id