/* *************************************************************************
 * NAME : ASISTEST.UDP_ZUM_OH_LIST_COPY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:33
 *        Modify: 2018-05-07 13:11:16
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ZUM_OH_LIST_COPY" AS 
BEGIN
  delete TBL_ZUM_OH_LIST_BYE;
  insert into TBL_ZUM_OH_LIST_BYE ( select modelno,minprice,ca_code from TBL_ZUM_OH_LIST_YE where minprice > 0 );
  delete TBL_ZUM_OH_LIST_YE;
  insert into TBL_ZUM_OH_LIST_YE ( select modelno,minprice,ca_code,null,null from TBL_ZUM_OH_LIST  where minprice > 0);
  update TBL_ZUM_OH_LIST_YE a set gap_1 = (1-minprice/(select minprice from tbl_zum_oh_list_bye where modelno = a.modelno)) where minprice > 0;
  commit;
END UDP_ZUM_OH_LIST_COPY;