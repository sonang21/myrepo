/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_PUPULAR_0
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_PUPULAR_0" 
IS 

 v_model_cnt           NUMBER(8) :=0;
  
BEGIN 
 --DBMS_OUTPUT.ENABLE; 
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST start ......'); 
     --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_PUPULAR_0','START');
    COMMIT;
    
 SELECT COUNT(DISTINCT modelno) INTO v_model_cnt FROM tbl_goods_popular;
          
 IF v_model_cnt > 1000000 THEN
 
     FOR tmp_loop in 
        (SELECT DISTINCT modelno FROM tbl_goods 
        WHERE modelno NOT IN (SELECT DISTINCT modelno FROM tbl_goods_popular WHERE SUM_POINT>0)
        AND jobcode>'0'
        AND mallcnt>0
        AND constrain='1'
        AND popular>0
        AND cateflag='0'
        AND NVL(popular,0) > 0
        --AND modelno=7907165
        AND rownum < 100000
        ) LOOP
          
        BEGIN                
            
            --DBMS_OUTPUT.PUT_LINE('tmp_loop.modelno...' || tmp_loop.modelno); 
            
         UPDATE TBL_GOODS SET POPULAR=0 WHERE modelno = tmp_loop.modelno AND NVL(popular,0)>0;
         COMMIT;
         
        END;
          
     END LOOP; 
     
  END IF;
 
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_PUPULAR_0','END');
    COMMIT;
    
END UDP_GOODS_PUPULAR_0;