/* *************************************************************************
 * NAME : ASISTEST.UDP_ZUM_MINPRICELIST2
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:33
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ZUM_MINPRICELIST2" AS 
BEGIN
  delete TBL_ZUM_MINPRICE_LIST2;

  insert into TBL_ZUM_MINPRICE_LIST2 (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'1',spec
    from (
    select * from (
    select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice-(case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) gap, a.minprice old_minprice, (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.spec
    from  TBL_ZUM_MINPRICELIST_SUM a , TBL_GOODS b
    where a.modelno = b.modelno 
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) > 0
    )  a 
    order by gap desc
    ) c where rownum <= 1000
  );
  insert into TBL_ZUM_MINPRICE_LIST2 (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'2',spec
    from (
    select * from (
    select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice/(case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) gap, a.minprice old_minprice, (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.spec
    from  TBL_ZUM_MINPRICELIST_SUM a , TBL_GOODS b
    where a.modelno = b.modelno 
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) > 0
    )  a 
    order by gap desc
    ) c where rownum <= 1000
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
          
          insert into TBL_ZUM_MINPRICE_LIST2 (
            select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
            imgchk,p_pl_no,p_imgurl,p_imgurlflag,'3',spec
            from (
            select * from (
            select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice-(case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) gap, a.minprice old_minprice, (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.spec
            from  TBL_ZUM_MINPRICELIST_SUM a , TBL_GOODS b
            where substr(a.ca_code,0,2) = v_cate and a.modelno = b.modelno 
            and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) > 0
            )  a 
            order by gap desc
            ) c where rownum <= 100
          );  
          
          insert into TBL_ZUM_MINPRICE_LIST2 (
            select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
            (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
            imgchk,p_pl_no,p_imgurl,p_imgurlflag,'4',spec
            from (
            select * from (
            select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice/(case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) gap, a.minprice old_minprice, (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.spec
            from  TBL_ZUM_MINPRICELIST_SUM a , TBL_GOODS b
            where substr(a.ca_code,0,2) = v_cate and a.modelno = b.modelno 
            and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) > 0
            )  a 
            order by gap desc
            ) c where rownum <= 100
          );  
        end loop;
      close cur01;
    end;
  COMMIT;
END UDP_ZUM_MINPRICELIST2;