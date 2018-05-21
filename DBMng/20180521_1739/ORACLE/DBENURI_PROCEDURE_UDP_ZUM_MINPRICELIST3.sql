/* *************************************************************************
 * NAME : DBENURI.UDP_ZUM_MINPRICELIST3
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ZUM_MINPRICELIST3" AS 
BEGIN
  delete TBL_ZUM_MINPRICE_LIST3;

  insert into TBL_ZUM_MINPRICE_LIST3 (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'1',keyword2,modelno_group,0,''
    from (
    select * from (
    select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice-(case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) gap, a.minprice old_minprice, (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
    from  TBL_ZUM_OH_LIST_YE a , TBL_GOODS b
    where a.modelno = b.modelno and a.ca_code = b.ca_code
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt3 > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) > 0
    and a.minprice > 0
    )  a 
    order by gap desc
    ) c where rownum <= 4000*5
  );

  insert into TBL_ZUM_MINPRICE_LIST3 (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'2',keyword2,modelno_group,0,''
    from (
    select * from (
    --select a.modelno,b.modelnm, b.factory, b.c_date, (1-(case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end)/a.minprice - a.gap_1)*100 gap , a.minprice old_minprice, (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
    select a.modelno,b.modelnm, b.factory, b.c_date, (a.minprice - (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end))/a.minprice*100 gap , a.minprice old_minprice, (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
    from  TBL_ZUM_OH_LIST_YE a , TBL_GOODS b 
    where a.modelno = b.modelno and a.ca_code = b.ca_code
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt3 > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) > 0
    and a.minprice > 0 --and a.gap_1 is not null and a.gap_1 > 0
    )  a 
    order by gap desc
    ) c where rownum <= 4000*5
  );  
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 1 and c_seqno > 0 and ca_code not in ('90','91','92','86') order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          
          insert into TBL_ZUM_MINPRICE_LIST3 (
            select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
            imgchk,p_pl_no,p_imgurl,p_imgurlflag,'3',keyword2,modelno_group,0,''
            from (
            select * from (
            select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice-(case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) gap, a.minprice old_minprice, (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
            from  TBL_ZUM_OH_LIST_YE a , TBL_GOODS b
            where substr(a.ca_code,0,2) = v_cate and a.modelno = b.modelno and a.ca_code = b.ca_code
            and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt3 > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) > 0
            and a.minprice > 0
            )  a 
            order by gap desc
            ) c where rownum <= 400*5
          );  
          
          insert into TBL_ZUM_MINPRICE_LIST3 (
            select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
            imgchk,p_pl_no,p_imgurl,p_imgurlflag,'4',keyword2,modelno_group,0,''
            from (
            select * from (
            --select a.modelno,b.modelnm, b.factory, b.c_date, (1-(case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end)/a.minprice - a.gap_1)*100 gap, a.minprice old_minprice, (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
            select a.modelno,b.modelnm, b.factory, b.c_date, (a.minprice - (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end))/a.minprice*100 gap, a.minprice old_minprice, (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
            from  TBL_ZUM_OH_LIST_YE a , TBL_GOODS b 
            where substr(a.ca_code,0,2) = v_cate and a.modelno = b.modelno and a.ca_code = b.ca_code
            and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt3 > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice3,0) = 0 then b.minprice else b.minprice3 end) > 0
            and a.minprice > 0 --and a.gap_1 is not null and a.gap_1 > 0
            )  a 
            order by gap desc
            ) c where rownum <= 400*5
          );  
        end loop;
      close cur01;
    end;
  COMMIT;
  
  declare
   v_modelno number(12);
   v_gap_order number(3);
   v_list_type char(1);
   v_new_minprice number(10);
    cursor cur01 is
      select modelno,list_type, row_number() over (partition by modelno_group,list_type order by gap desc) as gap_order, new_minprice  from TBL_ZUM_MINPRICE_LIST3;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_modelno,v_list_type,v_gap_order,v_new_minprice;
          if cur01%notfound
            then
            exit;
          end if;        
          --update TBL_ZUM_MINPRICE_LIST3 a set gap_order = v_gap_order where modelno = v_modelno and list_type = v_list_type ;
          --update TBL_ZUM_MINPRICE_LIST3 a set gap_order = v_gap_order, shop_code = 
          --                        (select shop_code from ( select a.shop_code, a.price from tbl_pricelist a  
          --                                              where a.modelno = v_modelno and a.status in ('0','8','9')  AND a.srvflag in ('0','L','R')  order by price asc  )
          --                                            where rownum = 1) where modelno = v_modelno and list_type = v_list_type ;
              update TBL_ZUM_MINPRICE_LIST3 a set gap_order = v_gap_order 
                  ,shop_code = (
                      --select ','|| wm_concat(shop_code)||','  from (
                      --  select shop_code, count(0) from tbl_pricelist 
                      --  where modelno = v_modelno
                       --   and price = v_new_minprice
                       --   and status in ('0','8','9')  AND srvflag in ('0','L','R')  
                       -- group by shop_code
                       select ','|| wm_concat(shop_code)||','  from (
                          select shop_code from (
                            select shop_code, price, rank() over(order by price) rnk
                            from tbl_pricelist
                            where modelno = v_modelno
                          )
                        where rnk = 1
                        group by shop_code
                        order by shop_code
                        )
                 ) 
              where modelno = v_modelno and list_type = v_list_type ;
          commit;
        end loop;
      close cur01; 
    end;          
    
END UDP_ZUM_MINPRICELIST3;