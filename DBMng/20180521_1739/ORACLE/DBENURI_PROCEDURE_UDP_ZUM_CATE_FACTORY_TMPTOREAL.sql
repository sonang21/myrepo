/* *************************************************************************
 * NAME : DBENURI.UDP_ZUM_CATE_FACTORY_TMPTOREAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ZUM_CATE_FACTORY_TMPTOREAL" 
IS
  
BEGIN

  delete TBL_ZUM_CATE_FACTORY;
  insert into TBL_ZUM_CATE_FACTORY (select * from TBL_ZUM_CATE_FACTORY_TMP);
  delete TBL_ZUM_CATE_FACTORY_TMP;
  commit;
  
END UDP_ZUM_CATE_FACTORY_TMPTOREAL;