/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_POPULAR_CA_CODE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_POPULAR_CA_CODE" 
IS
  	tmp_start     VARCHAR2(20) := '';
  	tmp_end    VARCHAR2(20) := '';
    i_count      NUMBER := 0;
    v_ca_code VARCHAR2(12) := '';
BEGIN  	

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICELIST_POPULAR_CA_CODE','START');
    COMMIT;
    
    --===============================================================================================================
    --pricelist popular update
    --===============================================================================================================
    i_count := 0;
    FOR tmp_loop in (SELECT PL_NO, POPULAR FROM TBL_PRICELIST_POPULAR) LOOP

      BEGIN

         SELECt CA_CODE INTO v_ca_code FROM TBL_PRICELIST WHERE PL_NO=tmp_loop.pl_no;
         UPDATE TBL_PRICELIST_POPULAR SET CA_CODE = v_ca_code WHERE pl_no = tmp_loop.pl_no;         
         
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
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_PRICELIST_POPULAR_CA_CODE','END');
    COMMIT;
    
END UDP_PRICELIST_POPULAR_CA_CODE;