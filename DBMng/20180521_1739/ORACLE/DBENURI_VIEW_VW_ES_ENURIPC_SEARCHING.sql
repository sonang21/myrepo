/* *************************************************************************
 * NAME : DBENURI.VW_ES_ENURIPC_SEARCHING
 * TYPE : VIEW
 * TIME : Create: 2018-03-28 18:50:04
 *        Modify: 2018-05-15 15:17:01
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FORCE VIEW "DBENURI"."VW_ES_ENURIPC_SEARCHING" ("ID", "PD_NO", "MODELNO", "MODELNO_GROUP", "P_CATE_CODE", "PD_VIEWCNT", "MODELNM", "MODELNM2", "FACTORY", "BRAND", "POPULAR", "POPULAR2", "SALE_CNT", "MODEL_FACTORY", "PD_DPRICE", "MINPRICE", "PD_REGDATE", "KEYWORD", "KEYWORD2", "BBS_NUM") AS 
  select 'G' || pc.pd_no as id,
       pc.pd_no as pd_no,
       min(nvl(modelno_group, g.modelno)) as modelno,
       case
         when max(modelno_group) is null or nvl(max(modelno_group), 0) = 0 then
            '0'
         else
           '1'
       end as modelno_group,
       min(p_cate_code) as p_cate_code,
       min(pd_viewcnt) as pd_viewcnt,
       max(replace(replace(modelnm, replace(condiname, '.', ''), ''), '[]', '')) as modelnm,
       udf_model_factory(max(factory), max(brand), max(modelnm  || '~!@'  || condiname)) as modelnm2,
       trim(max(factory)) as factory,
       trim(max(brand)) as brand,
       case
         when max(modelno_group) is null then
           nvl(max(popular), 0)
         else
           nvl(Max(sum_popular), 0)
       end as popular,
       case
         when max(modelno_group) is null then
           nvl(max(popular), 0)
         else
           nvl(max(sum_popular), 0)
       end as popular2,
       max(sale_cnt) as sale_cnt,
       udf_model_factory(max(factory), max(brand), max(modelnm || '~!@' || condiname)) as model_factory,
       min(pd_dprice) as pd_dprice,
       min(pd_minprice) as minprice,
       to_char(min(pd_regdate), 'YYYYMMDDHH24MISS') as pd_regdate,
       case
         when nvl(max(modelno_group), 0) = 0 then
           nvl(max(keyword), '') || ' '  || nvl(max(brand), '')
         else
           udf_model_group_keyword(nvl(max(modelno_group), 0)) || ' '  || nvl(max(brand), '')
       end as keyword,
       udf_category_keyword_popular2(min(g.modelno)) as keyword2,
       min(g.bbs_num) as bbs_num
  from asis_tbl_goods g,
       tbl_enuripc_product pc
 where g.jobcode >= '1'
   and ( g.constrain = '1'
          or ( g.constrain = '5' and g.mallcnt > 0 )
       )
   and g.cateflag = '0'
   and g.modelno = pc.modelno
   and pc.pd_ment <> 'Ç°Àý'
 group by pc.pd_no
