/* *************************************************************************
 * NAME : ASISTEST.UDP_METAGOODS_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:28
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_METAGOODS_POPULAR" 
IS
v_modelno TBL_META_GOODS_NEW.modelno%TYPE := 0;

v_cur_time           NUMBER(2) :=0; 

    
CURSOR METAGOODS_POPULAR_CURSOR IS
SELECT MODELNO  FROM TBL_META_GOODS_NEW WHERE DEAL_STATUS = '1';
    
BEGIN

    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
    
    IF v_cur_time >= 7 AND v_cur_time <= 21 THEN
        OPEN METAGOODS_POPULAR_CURSOR;
        LOOP

            FETCH  METAGOODS_POPULAR_CURSOR INTO v_modelno;
            EXIT WHEN METAGOODS_POPULAR_CURSOR%NOTFOUND;    
            --BEGIN
            UDP_METAGOODS_POPULAR_ONE(v_modelno);
            --END;
        END LOOP;
        CLOSE METAGOODS_POPULAR_CURSOR;    
            
        COMMIT;
        
    END IF;


END UDP_METAGOODS_POPULAR;