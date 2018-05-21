/* *************************************************************************
 * NAME : ASISTEST.UDP_DEL_PRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:19
 *        Modify: 2018-05-04 18:53:41
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEL_PRICELIST" 
IS
 CURSOR cur_pl_no IS
   SELECT pl_no,shop_code,goodscode
     FROM TBL_PRICELIST p1
    WHERE u_date < ADD_MONTHS(sysdate, -1)
      AND status = '5';
      --AND rownum < 500000;

 v_pl_no_tmp    tbl_pricelist.pl_no%TYPE := 0;
 v_shop_code_tmp    tbl_pricelist.shop_code%TYPE := 0;
 v_goodscode_tmp    tbl_pricelist.goodscode%TYPE := '';
 i_count     NUMBER := 0;
 
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST start ......');

 i_count := 0;

 OPEN cur_pl_no;
 LOOP

   FETCH cur_pl_no INTO v_pl_no_tmp,v_shop_code_tmp,v_goodscode_tmp;
   EXIT WHEN cur_pl_no%NOTFOUND;

     --DELETE /*+ APPEND */ FROM TBL_PRICELIST WHERE pl_no = v_pl_no_tmp;
     DELETE FROM /*+ append NOLOGGING */ TBL_PRICELIST WHERE pl_no = v_pl_no_tmp;
     COMMIT;
     
     --DELETE FROM /*+ append NOLOGGING */ TBL_SDUL_GOODS WHERE shop_code=v_shop_code_tmp AND goods_code=v_goodscode_tmp;
     --COMMIT;

 END LOOP;
 CLOSE cur_pl_no;

 COMMIT;

 --delete /*+ APPEND */ from tbl_myever where ever_status = '2' and ever_date+60 < sysdate;
 --delete from tbl_myever where ever_status = '2' and ever_date+60 < sysdate;

 COMMIT;

END UDP_DEL_PRICELIST;