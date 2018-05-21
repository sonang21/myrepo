/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_POPULAR_UPDATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:30
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_POPULAR_UPDATE" 
IS
  	
BEGIN
  
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICELIST_POPULAR_UPDATE','START');
    COMMIT;
    
    --===============================================================================================================
    --tbl_pricelist 인기도 업데이트
    --===============================================================================================================
    FOR tmp_loop in (SELECT pl_no FROM TBL_PRICELIST WHERE NVL(popular,0) > 0) LOOP

      BEGIN

         UPDATE TBL_PRICELIST SET popular=null WHERE pl_no = tmp_loop.pl_no;
         COMMIT;

      END;

    END LOOP;

    COMMIT;
    
    --===============================================================================================
    /*
    FOR tmp_loop in (SELECT PL_NO, POINT FROM TBL_PRICELIST_WEBPOPULAR) LOOP

      BEGIN

         UPDATE TBL_PRICE_SHOP_POPULAR SET popular = tmp_loop.point WHERE pl_no = tmp_loop.pl_no AND NVL(popular,0) <> tmp_loop.point;
         --i_count := i_count + 1;
         COMMIT;

      END;

    END LOOP;
    */
    COMMIT;
    --================================================================================================================

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICELIST_POPULAR_UPDATE','END');
    COMMIT;
    
END UDP_PRICELIST_POPULAR_UPDATE;