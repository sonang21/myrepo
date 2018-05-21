/* *************************************************************************
 * NAME : DEAL.MV_ECOUPON
 * TYPE : MATERIALIZED VIEW
 * TIME : Create: 2018-03-28 15:36:07
 *        Modify: 2018-05-21 15:45:58
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE MATERIALIZED VIEW "DEAL"."MV_ECOUPON" ("ORDERCNT", "CP_ID", "CP_COMPANY", "CP_ETAG", "CP_CATE1", "CP_CATE2", "CP_CATE3", "COMPANY_NM", "CP_NAME", "CP_URL", "PC_URL", "CP_COUPON_START", "CP_COUPON_END", "CP_TODAY", "CP_CLOSE", "CP_TODAY_USE", "CP_INSTANT_DELIVER", "CP_FREE_SHIP", "CP_IMAGE", "LIKE_CNT", "CP_SALEPRICE", "CP_SALERATE", "CP_DESCRIPT", "CP_SUMMARY", "CP_PRICE", "CP_SALECNT", "CP_ADDRESS", "CP_LAT", "CP_LNG", "CP_STARTDATE", "CP_LIMITDATE", "CP_MAXCNT", "CP_RANK", "MOMSORDER", "SOLDRATE", "CP_MOBILE_RANK", "CP_MOBILE_RANK_OLD", "ECOUPON_CATE")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "DEAL1" 
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND START WITH sysdate+0 NEXT SYSDATE + 6/24
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS SELECT ordercnt,
       cp_id,
       cp_company,
       cp_etag,
       cp_cate1,
       cp_cate2,
       cp_cate3,
       company_nm,
       cp_name,
       cp_url,
       pc_url,
       cp_coupon_start,
       cp_coupon_end,
       cp_today,
       cp_close,
       cp_today_use,
       cp_instant_deliver,
       cp_free_ship,
       cp_image,
       like_cnt,
       cp_saleprice,
       cp_salerate,
       cp_descript,
       cp_summary,
       cp_price,
       cp_salecnt,
       cp_address,
       cp_lat,
       cp_lng,
       cp_startdate,
       cp_limitdate,
       cp_maxcnt,
       cp_rank,
       momsorder,
       soldrate,
       cp_mobile_rank,
       cp_mobile_rank_old,
       CASE
         WHEN Regexp_like (cp_name, '커피빈|스타벅스|배스킨라빈스|설빙|Sulbing|이디야|할리스|마노핀|폴바셋|공차|엔제리너스|투썸플레이스|파스쿠찌|쥬씨|카페베네|탐앤탐스|주커피|스무디킹|커핀그루나루|말리커피|마노핀|나뚜루|빽다방|파리바게뜨|뚜레쥬르|던킨도너츠|매머드커피|크리스피크림도넛|크리스피도넛') THEN 'E101' --'커피/음료/제과'
         WHEN Regexp_like (cp_descript, '커피그루나루|설빙|뚜레쥬르|커핀그루나루|말리커피|마노핀') THEN 'E101' --'커피/음료/제과'
         WHEN Regexp_like (cp_name, '도미노피자|피자헛|미스터피자|KFC|롯데리아|버거킹|맥도날드|Mcdonald|맥카페|맘스터치|모스버거|떡볶이|피자|pizza|PIZZA') THEN 'E102' --'피자/햄버거/떡볶이'
         WHEN Regexp_like (cp_descript, '맥도날드') THEN 'E102' --'피자/햄버거/떡볶이'
         WHEN Regexp_like (cp_name, '본죽|본도시락|서가앤쿡|Seogaandcook|토끼정|아웃백|TGI|VIPS|빕스|후쿠오카함바그|토다이|Todai|무스쿠스|불고기브라더스|아비꼬|사보텐|뷔페') THEN 'E103' --'외식/뷔페'
         WHEN Regexp_like (cp_descript, 'VIPS|빕스') THEN 'E103' --'외식/뷔페'
         WHEN Regexp_like (cp_name, 'GS25|세븐일레븐|CU|이마트24|emart24|편의점|수퍼마켓|신세계|이마트|롯데마트|홈플러스|백화점|토이저러스|하이마트') THEN 'E104' --'편의점/마트/백화점'
         WHEN Regexp_like (cp_name, '문화상품권|해피머니|지류상품권|컬쳐랜드|모바일상품권|북앤라이프|메가박스|CGV|CJ|롯데씨네마') THEN 'E105' --'라이프/상품권'
       ELSE 'E199' --'기타'
END AS ecoupon_cate
FROM   (SELECT *
        FROM   deal.mv_coupon_a02_pop
        UNION ALL
        SELECT *
        FROM   deal.mv_coupon_else_pop)
WHERE  1 = 1
   AND cp_maxcnt > cp_salecnt
   AND Trim(cp_url) IS NOT NULL
   AND cp_price >= 0
   AND ( Regexp_like(cp_name, '상품권|교환권|금액권|식사권|GS25 |세븐일레븐|gifti|GIFTI|기프트카드|기프티카드|기프티쇼|기프티콘|\[선물하기\]')
          OR Regexp_like(cp_descript, '상품권|교환권|금액권|식사권|GS25 |세븐일레븐|gifti|GIFTI|기프트카드|기프티카드|기프티쇼|기프티콘|\[선물하기\]') )
   AND cp_cate3 IN ( 'C140', 'C103', 'C160', 'C101', 'C222' )
   AND NOT Regexp_like(cp_name, '증정|상담|보험|렌탈|대여|계수기')
   AND NOT Regexp_like(cp_descript, '증정|상담|보험|렌탈|대여|계수기')
