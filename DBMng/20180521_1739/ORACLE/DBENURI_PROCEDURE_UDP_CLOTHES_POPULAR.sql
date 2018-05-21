/* *************************************************************************
 * NAME : DBENURI.UDP_CLOTHES_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 13:34:35
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CLOTHES_POPULAR" 
IS
  i_count      NUMBER := 0;
/*
 NGIT 체크 - 변경없음 김영원 20180515
*/
BEGIN
   --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CLOTHES_POPULAR','START');
  COMMIT;
  i_count := 0;
   --=========================================================================================
  FOR tmp_loop in (SELECT PP.PL_NO, PP.POINT
                     FROM TBL_PRICE_SHOP_POPULAR PSP
                          INNER JOIN TBL_PRICELIST_WEBPOPULAR PP ON PSP.PL_NO = PP.PL_NO
                    WHERE PSP.PL_NO > 0
                      AND PSP.SRVFLAG = '0'
                      AND PSP.STATUS < '3'
                      AND PSP.DEL_FLAG = '0'
                      AND PSP.IMGURLFLAG = '1'
                      AND LENGTH(TRIM(PSP.CA_CODE)) = 10 ) 
  LOOP
    BEGIN
    
      UPDATE TBL_PRICELIST
         SET POPULAR=tmp_loop.POINT
       WHERE PL_NO=tmp_loop.PL_NO;
      
      UPDATE TBL_PRICE_SHOP_POPULAR
         SET POPULAR=tmp_loop.POINT
       WHERE PL_NO=tmp_loop.PL_NO;
      
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
  
  --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CLOTHES_POPULAR','END');
  COMMIT;
    
END UDP_CLOTHES_POPULAR;
