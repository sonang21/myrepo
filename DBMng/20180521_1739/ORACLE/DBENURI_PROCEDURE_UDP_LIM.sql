/* *************************************************************************
 * NAME : DBENURI.UDP_LIM
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-16 10:52:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_LIM" 
IS 
/*
 NGIT 체크 - 변경없음 김영원 20180502
*/
 v_modelno           NUMBER(8) :=0;
  
BEGIN 

    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_LIM','START');
    COMMIT;
    

 FOR tmp_loop in (SELECT modelno 
                    FROM TBL_EBAY_IMAGE_JOB_ENURI 
                   WHERE NVL(ALLOWFLAG,'0') = '1'
                     AND jobflag = '1')
 LOOP
      
     BEGIN         
         
         UPDATE TBL_GOODS SET IMGCHK2='2' WHERE modelno = tmp_loop.modelno;
         COMMIT;
         
      
         EXCEPTION WHEN OTHERS THEN
       	 COMMIT;
         
      END;
      
 END LOOP; 
 
     --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_LIM','END');
    COMMIT;
    
END UDP_LIM;
