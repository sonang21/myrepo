/* *************************************************************************
 * NAME : ASISTEST.UDP_MIDDLE_LIST_TEMP_TO_REAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:28
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_MIDDLE_LIST_TEMP_TO_REAL" 
IS
  
BEGIN

  delete tbl_goods_middle_list;
  insert into tbl_goods_middle_list (select * from tbl_goods_middle_list_temp);
  delete tbl_goods_middle_list_count;
  insert into tbl_goods_middle_list_count (select * from tbl_goods_middle_list_cnt_tmp);
  commit;
  
END UDP_MIDDLE_LIST_TEMP_TO_REAL;