/* *************************************************************************
 * NAME : ASISTEST.UDP_CATE_POPULAR_KEYWORD
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:17
 *        Modify: 2018-05-04 18:53:41
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_CATE_POPULAR_KEYWORD" 
IS
  v_keyword             VARCHAR2(255) :='';
  v_isbrand             CHAR(1) := '';
  v_cnt                  NUMBER := 0;
  
BEGIN
    DELETE TBL_POPULAR_KEYWORD_10000;
    insert into TBL_POPULAR_KEYWORD_10000            
    ( 
        select keyword,cnt from (
            select keyword,count(*) as cnt from TBL_SEARCH_KEYWORD_LOG where reg_date >= sysdate-30 group by keyword order by count(*) desc
        ) 
        where rownum <= 10000
    );
    commit;
    insert into TBL_CATE_POPULAR_KEYWORD (keyword,is_brand) 
    (
      select keyword , case when brand is not null then 'Y' else 'N' end from TBL_POPULAR_KEYWORD_10000 A left outer join
      (select brand from 
      (select distinct upper(replace(brand_modelnm,mod_modelnm,'')) as brand  from TBL_GOODS_MODELNM )
      where brand is not null) B
      on A.keyword = b.brand
      where not exists (select 1 from TBL_CATE_POPULAR_KEYWORD where TBL_CATE_POPULAR_KEYWORD.keyword = A.keyword)
    );
    commit;
    
    For tmp_loop in (select keyword , IS_BRAND from TBL_CATE_POPULAR_KEYWORD) LOOP
        v_keyword := tmp_loop.keyword;
        v_isbrand := tmp_loop.is_brand;
        v_cnt := 0;
        FOR tmp_loop2 in (
          select A.keyword,A.cate from ( 
            select keyword,cate,sum(cnt) cnt  from 
            ( 
              select keyword,ca_code as cate,count(*) as cnt from 
              ( 
                select V.keyword,V.modelno,substr(G.ca_code,0,2) ca_code from TBL_SEARCH_KEYWORD_VIEW_LOG V,TBL_GOODS G  
                where 
                  V.reg_date>=to_date(sysdate-30, 'yyyy-mm-dd') and 
                  V.keyword = v_keyword and V.view_type = '1' and 
                  V.modelno = G.modelno and cateflag = '0' and V.modelno > 0 
              ) 
              group by keyword,ca_code 
              union all 
              select keyword,ca_code as cate,count(*) as cnt from 
              ( 
                select V.keyword,V.modelno,substr(trim(P.ca_code),0,2) ca_code from TBL_SEARCH_KEYWORD_VIEW_LOG V,TBL_PRICELIST P  
                where 
                  V.reg_date>=to_date(sysdate-30, 'yyyy-mm-dd') and 
                  V.keyword = v_keyword and V.view_type = '2' and  
                  V.pl_no = P.pl_no and V.pl_no > 0 
              ) 
              group by keyword,ca_code 
            )  
            group by keyword,cate  
            ) A
            order by  A.cnt desc         
        ) LOOP
         IF v_cnt = 0 THEN
            UPDATE TBL_CATE_POPULAR_KEYWORD SET CA_LCODE1 = tmp_loop2.cate WHERE KEYWORD = tmp_loop2.keyword and ISCHANGE1 <> 'Y';
          elsif v_cnt = 1 then
            UPDATE TBL_CATE_POPULAR_KEYWORD SET CA_LCODE2 = tmp_loop2.cate WHERE KEYWORD = tmp_loop2.keyword and ISCHANGE2 <> 'Y';
          elsif v_cnt = 2 then
            UPDATE TBL_CATE_POPULAR_KEYWORD SET CA_LCODE3 = tmp_loop2.cate WHERE KEYWORD = tmp_loop2.keyword and ISCHANGE3 <> 'Y';
          end if;
          v_cnt := v_cnt +1;

        END LOOP;
    END LOOP;
    COMMIT;

END UDP_CATE_POPULAR_KEYWORD;