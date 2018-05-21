/* *************************************************************************
 * NAME : ASISTEST.UDP_ZUM_CATE_BRAND_TMPTOREAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-07 13:11:16
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ZUM_CATE_BRAND_TMPTOREAL" AS 
BEGIN

  delete TBL_ZUM_CATE_BRAND;
  insert into TBL_ZUM_CATE_BRAND (select * from TBL_ZUM_CATE_BRAND_TMP);
  delete TBL_ZUM_CATE_BRAND_TMP;
  commit;
  
END UDP_ZUM_CATE_BRAND_TMPTOREAL;