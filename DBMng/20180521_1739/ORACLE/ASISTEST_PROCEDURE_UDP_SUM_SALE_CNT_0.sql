/* *************************************************************************
 * NAME : ASISTEST.UDP_SUM_SALE_CNT_0
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SUM_SALE_CNT_0" 
IS

BEGIN
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SUM_SALE_CNT_0','START');
    COMMIT;
    
    --=============================================================================================================================================================================
    FOR tmp_loop in (SELECT distinct modelno FROM TBL_GOODS WHERE cateflag = '0' AND sum_sale_cnt IS NULL) LOOP

        UPDATE TBL_GOODS SET sum_sale_cnt=0 WHERE modelno=tmp_loop.modelno AND sum_sale_cnt IS NULL;
        COMMIT;
    
    END LOOP;
    --=============================================================================================================================================================================
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_SUM_SALE_CNT_0','END');
    COMMIT;

END UDP_SUM_SALE_CNT_0;