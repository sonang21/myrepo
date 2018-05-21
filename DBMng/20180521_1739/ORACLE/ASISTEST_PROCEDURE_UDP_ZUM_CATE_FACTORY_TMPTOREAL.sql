/* *************************************************************************
 * NAME : ASISTEST.UDP_ZUM_CATE_FACTORY_TMPTOREAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-07 13:11:16
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ZUM_CATE_FACTORY_TMPTOREAL" 
IS
  
BEGIN

  delete TBL_ZUM_CATE_FACTORY;
  insert into TBL_ZUM_CATE_FACTORY (select * from TBL_ZUM_CATE_FACTORY_TMP);
  delete TBL_ZUM_CATE_FACTORY_TMP;
  commit;
  
END UDP_ZUM_CATE_FACTORY_TMPTOREAL;