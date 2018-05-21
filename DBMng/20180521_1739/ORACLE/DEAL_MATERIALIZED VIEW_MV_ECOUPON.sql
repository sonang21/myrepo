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
         WHEN Regexp_like (cp_name, 'Ŀ�Ǻ�|��Ÿ����|�轺Ų���|����|Sulbing|�̵��|�Ҹ���|������|���ټ�|����|�������ʽ�|�����÷��̽�|�Ľ�����|�꾾|ī�亣��|Ž��Ž��|��Ŀ��|������ŷ|Ŀ�ɱ׷糪��|����Ŀ��|������|���ѷ�|���ٹ�|�ĸ��ٰԶ�|�ѷ��긣|��Ų������|�Ÿӵ�Ŀ��|ũ������ũ������|ũ�����ǵ���') THEN 'E101' --'Ŀ��/����/����'
         WHEN Regexp_like (cp_descript, 'Ŀ�Ǳ׷糪��|����|�ѷ��긣|Ŀ�ɱ׷糪��|����Ŀ��|������') THEN 'E101' --'Ŀ��/����/����'
         WHEN Regexp_like (cp_name, '���̳�����|������|�̽�������|KFC|�Ե�����|����ŷ|�Ƶ�����|Mcdonald|��ī��|������ġ|�𽺹���|������|����|pizza|PIZZA') THEN 'E102' --'����/�ܹ���/������'
         WHEN Regexp_like (cp_descript, '�Ƶ�����') THEN 'E102' --'����/�ܹ���/������'
         WHEN Regexp_like (cp_name, '����|�����ö�|��������|Seogaandcook|�䳢��|�ƿ���|TGI|VIPS|����|�����ī�Թٱ�|�����|Todai|������|�Ұ�������|�ƺ�|�纸��|����') THEN 'E103' --'�ܽ�/����'
         WHEN Regexp_like (cp_descript, 'VIPS|����') THEN 'E103' --'�ܽ�/����'
         WHEN Regexp_like (cp_name, 'GS25|�����Ϸ���|CU|�̸�Ʈ24|emart24|������|���۸���|�ż���|�̸�Ʈ|�Ե���Ʈ|Ȩ�÷���|��ȭ��|����������|���̸�Ʈ') THEN 'E104' --'������/��Ʈ/��ȭ��'
         WHEN Regexp_like (cp_name, '��ȭ��ǰ��|���ǸӴ�|������ǰ��|���ķ���|����ϻ�ǰ��|�Ͼض�����|�ް��ڽ�|CGV|CJ|�Ե����׸�') THEN 'E105' --'������/��ǰ��'
       ELSE 'E199' --'��Ÿ'
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
   AND ( Regexp_like(cp_name, '��ǰ��|��ȯ��|�ݾױ�|�Ļ��|GS25 |�����Ϸ���|gifti|GIFTI|����Ʈī��|����Ƽī��|����Ƽ��|����Ƽ��|\[�����ϱ�\]')
          OR Regexp_like(cp_descript, '��ǰ��|��ȯ��|�ݾױ�|�Ļ��|GS25 |�����Ϸ���|gifti|GIFTI|����Ʈī��|����Ƽī��|����Ƽ��|����Ƽ��|\[�����ϱ�\]') )
   AND cp_cate3 IN ( 'C140', 'C103', 'C160', 'C101', 'C222' )
   AND NOT Regexp_like(cp_name, '����|���|����|��Ż|�뿩|�����')
   AND NOT Regexp_like(cp_descript, '����|���|����|��Ż|�뿩|�����')
