/* *************************************************************************
 * NAME : DBENURI.UDP_DEL_PRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 13:48:54
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEL_PRICELIST" 
IS
/*
 NGIT 체크 - 변경없음 김영원 20180424
*/
 CURSOR cur_pl_no IS
   SELECT pl_no,
          shop_code,
          goodscode
     FROM TBL_PRICELIST p1
    WHERE u_date < ADD_MONTHS(sysdate, -1)
      AND status = '5';

 v_pl_no_tmp        tbl_pricelist.pl_no%TYPE := 0;
 v_shop_code_tmp    tbl_pricelist.shop_code%TYPE := 0;
 v_goodscode_tmp    tbl_pricelist.goodscode%TYPE := '';
 i_count     NUMBER := 0;
 
BEGIN

 i_count := 0;

 OPEN cur_pl_no;
 LOOP

   FETCH cur_pl_no INTO v_pl_no_tmp,v_shop_code_tmp,v_goodscode_tmp;
   EXIT WHEN cur_pl_no%NOTFOUND;

     DELETE FROM TBL_PRICELIST WHERE pl_no = v_pl_no_tmp;
     COMMIT;
     
 END LOOP;
 CLOSE cur_pl_no;

 COMMIT;

END UDP_DEL_PRICELIST;
 
