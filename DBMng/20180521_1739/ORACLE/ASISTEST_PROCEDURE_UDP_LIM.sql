/* *************************************************************************
 * NAME : ASISTEST.UDP_LIM
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:26
 *        Modify: 2018-05-04 18:53:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_LIM" 
IS 

 v_modelno           NUMBER(8) :=0;
  
BEGIN 
 --DBMS_OUTPUT.ENABLE; 
 --DBMS_OUTPUT.PUT_LINE('11 ......'); 
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_LIM','START');
    COMMIT;
    

 FOR tmp_loop in (SELECT modelno FROM TBL_EBAY_IMAGE_JOB_ENURI WHERE NVL(ALLOWFLAG,'0') = '1' AND jobflag = '1') LOOP
      
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