/* *************************************************************************
 * NAME : ASISTEST.UDP_SOCIAL_MINPRICE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SOCIAL_MINPRICE" 
IS

social_minprice    NUMBER(10) := 0;

BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_CPC_MONEY start ......');
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SOCIAL_MINPRICE','START');
    COMMIT;
    
  --=======================================================================
  --일별 집계 테이블 생성
  --=======================================================================
  
  FOR tmp_loop in 
  
    (SELECT distinct modelno FROM tbl_goods
        WHERE CA_LCODE='87'
        AND CA_CODE LIKE '8701%'
        --AND nvl(socialprice,0) > 0
        --AND mallcnt > 0
        --AND mallcnt > 0
        --AND constrain='1'
        --AND jobcode>'0'
        --AND cateflag='1'
        
        ) LOOP
        
        BEGIN
            SELECT NVL(MIN(price),0) INTO social_minprice FROM tbl_pricelist 
            WHERE modelno=tmp_loop.modelno
            AND status in ('0','8','9')
            AND srvflag in ('0','L','S')
            AND NVL(option_flag2,'0') = '2'
            AND NVL(solddate,sysdate) >= sysdate; 
            
            EXCEPTION WHEN OTHERS THEN
                social_minprice := 0;
        END;
                
        UPDATE tbl_goods SET socialprice = social_minprice
        WHERE modelno=tmp_loop.modelno
        AND NVL(socialprice,0) <> social_minprice;
        
        COMMIT;
        

  END LOOP;
  COMMIT;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SOCIAL_MINPRICE','END');
    COMMIT;
    
END UDP_SOCIAL_MINPRICE;