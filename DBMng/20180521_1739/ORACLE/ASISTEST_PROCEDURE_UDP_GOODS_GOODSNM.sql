/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_GOODSNM
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_GOODSNM" 
IS
     CURSOR cur_goods_info IS
        SELECT modelno FROM TBL_GOODS 
        WHERE cateflag = '0'
         AND jobcode > 0
         AND mallcnt > '0'
         --AND SUBSTR(CA_CODE,0,4) <> '9301' 
         --AND (ca_code LIKE '0226%' OR ca_code LIKE '0214%')
         AND ca_code not like '0219%'
         AND ca_code not like '1457%'
         AND ca_code not like '1611%'
         AND ca_code not like '93%'
         AND ca_code not like '15%'
         AND ca_code not like '2104%' 
         AND ca_code not like '1005%' 
         AND ca_code not like '1007%' 
         AND ca_code not like '1020%'
         AND ca_code not like '12040302%'
         AND modelno NOT IN (select modelno FROM TBL_GOODS_GOODSNM);

    v_modelno           NUMBER(8) :=0;
    v_goodsnm           VARCHAR2(800) := '';
    v_group_goodsnm     VARCHAR2(4000) := '';

BEGIN
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_GOODSNM','START');
    COMMIT;

    OPEN cur_goods_info;
    LOOP

        FETCH cur_goods_info INTO v_modelno;
        EXIT WHEN cur_goods_info%NOTFOUND;


          BEGIN
          
            SELECT substr(goodsnm,0,400) INTO v_goodsnm FROM (
            SELECT goodsnm FROM TBL_PRICELIST 
            WHERE modelno=v_modelno 
            AND status in ('0','8','9')
            AND srvflag in ('0','L','R')
            AND NVL(option_flag2,'0') = '0'
            AND goodsnm IS NOT NULL
            ORDER BY length(goodsnm)
            )            
            WHERE rownum=1;
          
            INSERT INTO TBL_GOODS_GOODSNM(modelno,goodsnm) VALUES(v_modelno,v_goodsnm);
            
            COMMIT;
            
            EXCEPTION WHEN OTHERS THEN
                v_goodsnm :='';
                
          END;

    END LOOP;
     
    CLOSE cur_goods_info;

    COMMIT;
    
    --=============================================================================================================================================================================
    DELETE TBL_GOODS_GROUP_GOODSNM;
    COMMIT;
    
    FOR tmp_loop in (SELECT distinct modelno_group FROM TBL_GOODS WHERE modelno IN (select modelno FROM TBL_GOODS_GOODSNM) AND NVL(modelno_group,0) > 0 AND cateflag='0' AND NVL(modelno_group,0) > 0) LOOP
        v_group_goodsnm := '';
        
        FOR tmp_loop2 in (SELECT goodsnm FROM TBL_GOODS_GOODSNM WHERE modelno IN (SELECT modelno FROM TBL_GOODS WHERE modelno_group=tmp_loop.modelno_group AND mallcnt>0 AND constrain='1' AND jobcode>'0' AND cateflag='0' AND NVL(modelno_group,0) > 0)) LOOP
            IF length(v_group_goodsnm || ' ' || tmp_loop2.goodsnm) <= 1000 THEN
                v_group_goodsnm := v_group_goodsnm || ' ' || tmp_loop2.goodsnm;        
            END IF;
        END LOOP;
        
        --v_group_goodsnm := substr(v_group_goodsnm,0,1000);
        INSERT INTO TBL_GOODS_GROUP_GOODSNM(modelno,goodsnm) VALUES(tmp_loop.modelno_group,v_group_goodsnm);
        COMMIT;
    
    END LOOP;
    
    FOR tmp_loop in (SELECT distinct modelno FROM TBL_GOODS WHERE modelno IN (select modelno FROM TBL_GOODS_GOODSNM) AND NVL(modelno_group,0) = 0 AND cateflag='0' AND modelno NOT IN (select modelno FROM TBL_GOODS_GROUP_GOODSNM)) LOOP
        v_group_goodsnm := '';        
        SELECT goodsnm INTO v_group_goodsnm FROM TBL_GOODS_GOODSNM WHERE modelno =tmp_loop.modelno;
        
        v_group_goodsnm := substr(v_group_goodsnm,0,1000);
        INSERT INTO TBL_GOODS_GROUP_GOODSNM(modelno,goodsnm) VALUES(tmp_loop.modelno,v_group_goodsnm);
        COMMIT;
    
    END LOOP;
    --=============================================================================================================================================================================
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_GOODSNM','END');
    COMMIT;

END UDP_GOODS_GOODSNM;