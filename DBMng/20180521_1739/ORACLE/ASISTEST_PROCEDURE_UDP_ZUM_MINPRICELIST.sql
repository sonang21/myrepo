/* *************************************************************************
 * NAME : ASISTEST.UDP_ZUM_MINPRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:33
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ZUM_MINPRICELIST" AS 
BEGIN
  delete TBL_ZUM_MINPRICE_LIST;

  insert into TBL_ZUM_MINPRICE_LIST (
    select modelno , modelnm,factory,c_date,gap,old_minprice,now_minprice,ca_code,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,2) ) lcate_name,
    (select distinct c_name from tbl_category where ca_code = substr(c.ca_code ,0,4) ) mcate_name,
    imgchk,p_pl_no,p_imgurl,p_imgurlflag
    from (
    select * from (
    select a.modelno,b.modelnm, b.factory, b.c_date, a.minprice-b.minprice gap, a.minprice old_minprice, b.minprice now_minprice,b.ca_code,b.imgchk,b.p_pl_no,b.p_imgurl,b.p_imgurlflag
    from  TBL_ZUM_MINPRICELIST_SUM a , TBL_GOODS b
    where a.modelno = b.modelno 
    and b.cateflag = '0' and b.jobcode > '0' and b.mallcnt > 0 and b.openexpectflag = '0' and b.constrain = '1'
    ) order by gap desc
    ) c where rownum <= 10000
  );
  COMMIT;
END UDP_ZUM_MINPRICELIST;