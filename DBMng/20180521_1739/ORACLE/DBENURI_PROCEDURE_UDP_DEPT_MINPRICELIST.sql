/* *************************************************************************
 * NAME : DBENURI.UDP_DEPT_MINPRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 14:07:05
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEPT_MINPRICELIST" AS
/*
 NGIT 수정 반영 - 김영원 20180425
*/ 
BEGIN
  delete TBL_DEPT_MINPRICE_LIST;

  insert into TBL_DEPT_MINPRICE_LIST (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag,'1',keyword2,modelno_group,''
    from (
    select * from (
    select a.modelno,
           aa.modelnm, aa.factory, aa.c_date, --
           a.minprice-(case when nvl(bb.minprice4,0) = 0 then bb.minprice else bb.minprice4 end) gap, --
           a.minprice old_minprice, 
          (case when nvl(bb.minprice4,0) = 0 then bb.minprice else bb.minprice4 end) now_minprice, --
          aa.ca_code,aa.imgchk,aa.p_pl_no,aa.p_imgurl,aa.p_imgurlflag,aa.keyword2,nvl(aa.modelno_group,aa.modelno) modelno_group --
    from  TBL_DEPT_OH_LIST_YE a , TBL_GOODS aa, TBL_GOODS_SUM bb
    where aa.modelno = bb.modelno
    and a.modelno = aa.modelno 
    and aa.jobcode > '0' and bb.mallcnt3 > 0 and aa.openexpectflag = '0' and aa.constrain = '1' and (case when nvl(bb.minprice4,0) = 0 then bb.minprice else bb.minprice4 end) > 0
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
    select a.modelno,
           aa.modelnm, aa.factory, aa.c_date, --
           (1-(case when nvl(bb.minprice4,0) = 0 then bb.minprice else bb.minprice4 end)/a.minprice - a.gap_1)*100 gap , --
           a.minprice old_minprice, 
           (case when nvl(bb.minprice4,0) = 0 then bb.minprice else bb.minprice4 end) now_minprice, --
           aa.ca_code,aa.imgchk,aa.p_pl_no,aa.p_imgurl,aa.p_imgurlflag,aa.keyword2,nvl(aa.modelno_group,aa.modelno) modelno_group --
    from  TBL_DEPT_OH_LIST_YE a , TBL_GOODS aa, TBL_GOODS_SUM bb
    where aa.modelno = bb.modelno
    and a.modelno = aa.modelno 
    and aa.jobcode > '0' and bb.mallcnt3 > 0 and aa.openexpectflag = '0' and aa.constrain = '1' and (case when nvl(bb.minprice4,0) = 0 then bb.minprice else bb.minprice4 end) > 0
    and a.minprice > 0 and a.gap_1 is not null and a.gap_1 > 0
    )  a 
    order by gap desc
    ) c where rownum <= 2000
  );  
  update TBL_DEPT_MINPRICE_LIST a set dept_ca_code = (select c.ca_code from tbl_cate_goods c where c.modelno = a.modelno and c.ca_lcode = '86' and rownum = 1);

  COMMIT;
END UDP_DEPT_MINPRICELIST;
