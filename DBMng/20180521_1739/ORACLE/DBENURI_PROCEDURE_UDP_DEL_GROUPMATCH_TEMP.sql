/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_GROUPMATCH_TEMP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_GROUPMATCH_TEMP" AS 
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