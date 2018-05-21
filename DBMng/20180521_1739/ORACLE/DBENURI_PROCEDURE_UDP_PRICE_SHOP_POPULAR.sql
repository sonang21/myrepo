/* *************************************************************************
 * NAME : DBENURI.UDP_PRICE_SHOP_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-10 15:10:59
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_PRICE_SHOP_POPULAR" 
IS
/*
 NGIT 체크 - 변경없음 김영원 20180502
*/
  	i_count      NUMBER := 0;
BEGIN
        
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICE_SHOP_POPULAR','START');
    COMMIT;
    
    --===============================================================================================================
    --price shop popular update (패션인기상품)
    --===============================================================================================================
    
    UPDATE TBL_PRICE_SHOP_POPULAR SET popular = 0 where NVL(popular,0) > 0; 
    COMMIT;
    
    i_count := 0;
    FOR tmp_loop in (SELECT PL_NO, POINT FROM TBL_PRICELIST_WEBPOPULAR WHERE NVL(POINT,0) > 0) LOOP

      BEGIN
      
         UPDATE TBL_PRICE_SHOP_POPULAR SET popular = tmp_loop.point WHERE pl_no = tmp_loop.pl_no;
         UPDATE TBL_PRICELIST SET popular = tmp_loop.point WHERE pl_no = tmp_loop.pl_no;
         
         EXCEPTION WHEN OTHERS THEN
         COMMIT;
         
         i_count := i_count + 1;
        
      END;

      IF i_count = 100 THEN
      	COMMIT;
       	i_count := 0;
      END IF;

    END LOOP;
    
    COMMIT;
    
    --===============================================================================================================
    --tbl_pricelist popular (초기화)
    --===============================================================================================================
    i_count := 0;
    FOR tmp_loop in (SELECT PL_NO FROM TBL_PRICELIST WHERE NVL(popular,0) > 0 AND PL_NO NOT IN (SELECT PL_NO FROM TBL_PRICELIST_WEBPOPULAR WHERE NVL(POINT,0) > 0)) LOOP

      BEGIN
         UPDATE TBL_PRICELIST SET popular = NULL WHERE pl_no = tmp_loop.pl_no;
         
         EXCEPTION WHEN OTHERS THEN
         COMMIT;
         
         i_count := i_count + 1;
      END;
      
      IF i_count = 100 THEN
      	COMMIT;
       	i_count := 0;
      END IF;
      
    END LOOP;
    
    COMMIT;
    --================================================================================================================
   
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICE_SHOP_POPULAR','END');
    COMMIT;
    
END UDP_PRICE_SHOP_POPULAR;
