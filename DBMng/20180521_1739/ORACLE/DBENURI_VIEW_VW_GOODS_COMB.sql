/* *************************************************************************
 * NAME : DBENURI.VW_GOODS_COMB
 * TYPE : VIEW
 * TIME : Create: 2018-05-02 14:09:35
 *        Modify: 2018-05-15 11:06:48
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBENURI"."VW_GOODS_COMB" ("MODELNO", "RECOMMEND", "MODELNM", "FACTORY", "SPEC", "C_DATE", "IMGCHK", "CONSTRAIN", "FLAG", "REFID", "MANUAL_LINK", "LINKSERVICEFLAG", "G_SIZE", "FUNC", "KEYWORD", "JOBCODE", "MODDATE", "OPENEXPECTFLAG", "MODELNO_GROUP", "CONDINAME", "MODEL_SORT", "NO", "REFERMODELNO", "FACTORY_ETC", "RSIFLAG", "P_PL_NO", "P_IMGURL", "P_IMGURLFLAG", "REFSHOP", "BRAND", "FUNC_IMG", "KEYWORD2", "WEIGHT", "HEIGHT", "SPEC_GROUP", "P_IMGURL2", "KB_TITLE", "IMGCHK2", "IMGCHK3", "MOBILE_FLAG", "EXT_CONDI_FLAG", "STANDARD", "AMOUNT", "CHANGE", "UNIT", "MINPRICE", "AVGPRICE", "MAXPRICE", "POPULAR", "SUM_POPULAR", "KB_NUM", "MALLCNT", "SALE_CNT", "SUM_SALE_CNT", "MINPRICE2", "MINPRICE3", "MINPRICE4", "MALLCNT3", "SUM_MODDATE", "BBS_NUM", "BBS_POINT", "BBS_POINT_AVG", "SOCIALPRICE", "CA_CODE", "CA_LCODE", "CATEFLAG", "ESCNT", "BOX_MODELNM", "GBCNT", "IMGCHK_ROLLING", "GOODS_INFO", "GOODS_INFO_DATE", "IMGCHK_GROUP", "INFO_POINT1", "INFO_POINT2", "INFO_POINT3", "INFO_SUM_POINT", "GOOGLE_FLAG", "RSIFLAG2", "ECATALOG_FLAG", "ECATALOG_URL") AS 
  select g.modelno
     , g.recommend
     , g.modelnm
     , g.factory
     , g.spec
     , g.c_date
     , g.imgchk
     , g.constrain
     , g.flag
     , g.refid
     , g.manual_link
     , g.linkserviceflag
     , g.g_size
     , g.func
     , g.keyword
     , g.jobcode
     , g.moddate
     , g.openexpectflag
     , g.modelno_group
     , g.condiname
     , g.model_sort
     , g.no
     , g.refermodelno
     , g.factory_etc
     , g.rsiflag
     , g.p_pl_no
     , g.p_imgurl
     , g.p_imgurlflag
     , g.refshop
     , g.brand
     , g.func_img
     , g.keyword2
     , g.weight
     , g.height
     , g.spec_group
     , g.p_imgurl2
     , g.kb_title
     , g.imgchk2
     , g.imgchk3
     , g.mobile_flag
     , g.ext_condi_flag
     , g.standard
     , g.amount
     , g.change
     , g.unit
     , s.minprice
     , s.avgprice
     , s.maxprice
     , s.popular
     , s.sum_popular
     , s.kb_num
     , s.mallcnt
     , s.sale_cnt
     , s.sum_sale_cnt
     , s.minprice2
     , s.minprice3
     , s.minprice4
     , s.mallcnt3
     , s.moddate as sum_moddate
     , s.bbs_num
     , s.bbs_point
     , s.bbs_point_avg
     , s.socialprice
     , c.ca_code
     , c.ca_lcode
     , c.cateflag
     , null as escnt
     , null as box_modelnm
     , null as gbcnt
     , null as imgchk_rolling
     , null as goods_info
     , null as goods_info_date
     , null as imgchk_group
     , null as info_point1
     , null as info_point2
     , null as info_point3
     , null as info_sum_point
     , null as google_flag
     , null as rsiflag2
     , null as ecatalog_flag
     , null as ecatalog_url
  from TBL_GOODS g
     , TBL_GOODS_SUM s
     , TBL_CATE_GOODS c
 where g.modelno = s.modelno(+)
   and g.modelno = c.modelno(+)
