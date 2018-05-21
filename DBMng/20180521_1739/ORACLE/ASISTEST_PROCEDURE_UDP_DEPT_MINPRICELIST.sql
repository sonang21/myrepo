/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPT_MINPRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPT_MINPRICELIST" AS 
BEGIN
  delete TBL_DEPT_MINPRICE_LIST;

  insert into TBL_DEPT_MINPRICE_LIST (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'1',keyword2,modelno_group,''
    from (
    select * from (
    select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice-(case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) gap, a.minprice old_minprice, (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
    from  TBL_DEPT_OH_LIST_YE a , TBL_GOODS b
    where a.modelno = b.modelno 
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt3 > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) > 0
    and a.minprice > 0
    )  a 
    order by gap desc
    ) c where rownum <= 2000
  );
  insert into TBL_DEPT_MINPRICE_LIST (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'2',keyword2,modelno_group,''
    from (
    select * from (
    select a.modelno,b.modelnm, b.factory, b.c_date, (1-(case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end)/a.minprice - a.gap_1)*100 gap , a.minprice old_minprice, (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag,b.keyword2,nvl(b.modelno_group,b.modelno) modelno_group
    from  TBL_DEPT_OH_LIST_YE a , TBL_GOODS b 
    where a.modelno = b.modelno 
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt3 > 0 and b.openexpectflag = '0' and b.constrain = '1' and (case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end) > 0
    and a.minprice > 0 and a.gap_1 is not null and a.gap_1 > 0
    )  a 
    order by gap desc
    ) c where rownum <= 2000
  );  
  update TBL_DEPT_MINPRICE_LIST a set dept_ca_code = (select ca_code from tbl_goods where tbl_goods.modelno = a.modelno and ca_lcode = '86' and rownum = 1);

  COMMIT;
END UDP_DEPT_MINPRICELIST;