/* *************************************************************************
 * NAME : DBENURI.UDP_MIDDLE_LIST_TEMP_TO_REAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MIDDLE_LIST_TEMP_TO_REAL" 
IS
  
BEGIN

  delete tbl_goods_middle_list;
  insert into tbl_goods_middle_list (select * from tbl_goods_middle_list_temp);
  delete tbl_goods_middle_list_count;
  insert into tbl_goods_middle_list_count (select * from tbl_goods_middle_list_cnt_tmp);
  commit;
  
END UDP_MIDDLE_LIST_TEMP_TO_REAL;