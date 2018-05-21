/* *************************************************************************
 * NAME : ASISTEST.UDP_SHOP_CA_MINPRICE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SHOP_CA_MINPRICE" 
IS 
 --v_tmp_cnt  NUMBER(8) := 0; 
 --v_md_hit    NUMBER(8) := 0; 
BEGIN 
 --DBMS_OUTPUT.ENABLE; 
 --DBMS_OUTPUT.PUT_LINE('UDP_CPC_MONEY start ......'); 
 
  --======================================================================= 
  --일별 집계 테이블 생성 
  --======================================================================= 
  DELETE /*+ append nologging */ TBL_SHOP_CA_MINPRICE;
 
  FOR tmp_loop in  
    (select b.shop_code,substr(a.ca_code,0,4) ca_mcode,count(*) min_cnt_1,count(distinct a.modelno) min_cnt_2 
        from tbl_goods a, tbl_pricelist b 
        where a.modelno = b.modelno 
        and a.constrain='1' 
        and a.jobcode>'0' 
        and a.mallcnt>0 
        and a.minprice=b.price 
        and b.shop_code in (55,4027,536,5910) 
        group by b.shop_code,substr(a.ca_code,0,4)) 
    LOOP 
 
    INSERT /*+ append nologging */ INTO TBL_SHOP_CA_MINPRICE(shop_code,ca_mcode,min_cnt_1,min_cnt_2) 
    VALUES(tmp_loop.shop_code,tmp_loop.ca_mcode,tmp_loop.min_cnt_1,tmp_loop.min_cnt_2); 
 
  END LOOP; 
  COMMIT; 
  
END UDP_SHOP_CA_MINPRICE;