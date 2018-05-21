/* *************************************************************************
 * NAME : DBENURI.UDP_ZUM_CATE_BRAND_TMPTOREAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ZUM_CATE_BRAND_TMPTOREAL" AS 
BEGIN

  delete TBL_ZUM_CATE_BRAND;
  insert into TBL_ZUM_CATE_BRAND (select * from TBL_ZUM_CATE_BRAND_TMP);
  delete TBL_ZUM_CATE_BRAND_TMP;
  commit;
  
END UDP_ZUM_CATE_BRAND_TMPTOREAL;