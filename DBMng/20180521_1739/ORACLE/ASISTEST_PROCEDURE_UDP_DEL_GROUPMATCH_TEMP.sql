/* *************************************************************************
 * NAME : ASISTEST.UDP_DEL_GROUPMATCH_TEMP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:19
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEL_GROUPMATCH_TEMP" AS 
BEGIN

  delete TBL_GOODS_INDEXER_PREV;
  delete TBL_GOODS_INDEXER;
  delete tbl_group_match_skip_plno;
  delete TBL_SHOP_AUTO_MATHING_LIST;
  delete TBL_GOODS_SEARCH_LIST;
  delete TBL_GP_TMP_PLNO;
  delete TBL_GROUP_MATCH_GS2_SKIP_PLNO;
  commit;
END UDP_DEL_GROUPMATCH_TEMP;