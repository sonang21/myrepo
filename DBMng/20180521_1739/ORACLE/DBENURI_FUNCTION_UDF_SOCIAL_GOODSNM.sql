/* *************************************************************************
 * NAME : DBENURI.UDF_SOCIAL_GOODSNM
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 11:27:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_SOCIAL_GOODSNM" (v_group_type char,v_modelno NUMBER)
RETURN VARCHAR2 AS 
/*
 NGIT 수정 반영 - 김영원 20180418
*/ 
    v_goodsnm_total  VARCHAR2(4000):=''; 
    v_goodsnm_temp   VARCHAR2(400):=''; 
     
BEGIN  

    IF v_modelno > 0 THEN 
    
        IF v_group_type = '1' THEN --그룹상품
        
            FOR tmp_loop in
                (SELECT goodsnm 
                   FROM tbl_pricelist 
                  WHERE modelno IN (SELECT distinct a.modelno
                                      FROM tbl_goods a, tbl_goods_sum b, tbl_cate_goods c
                                     WHERE a.modelno = b.modelno
                                       AND a.modelno = c.modelno
                                       AND a.modelno_group = v_modelno 
                                       AND c.cateflag='1' 
                                       AND c.ca_code LIKE '8701%'
                                       AND a.jobcode > '0'  
                                       AND a.constrain = '1'  
                                       AND b.mallcnt > 0  
                                   )
                    AND status in ('0','8','9')
                    AND srvflag in ('0','L','S')
                    AND NVL(option_flag2,'0') = '2'
                    AND NVL(solddate,sysdate) >= sysdate
                    ) 
            LOOP  
                    v_goodsnm_temp := tmp_loop.goodsnm;
                    IF INSTR(v_goodsnm_temp,'[') > 0 AND INSTR(v_goodsnm_temp,']') > 0 THEN
                        IF INSTR(v_goodsnm_temp,'[') < INSTR(v_goodsnm_temp,']') THEN
                            v_goodsnm_temp := SUBSTR(v_goodsnm_temp,INSTR(v_goodsnm_temp,']'),LENGTH(v_goodsnm_temp));
                        END IF;
                    END IF;
                    
                    IF INSTR(v_goodsnm_temp,'[') > 0 AND INSTR(v_goodsnm_temp,']') > 0 THEN
                        IF INSTR(v_goodsnm_temp,'[') < INSTR(v_goodsnm_temp,']') THEN
                            v_goodsnm_temp := SUBSTR(v_goodsnm_temp,INSTR(v_goodsnm_temp,']'),LENGTH(v_goodsnm_temp));
                        END IF;
                    END IF;
                    
                    v_goodsnm_total := v_goodsnm_total || ' ' || v_goodsnm_temp;
                    
                    IF length(v_goodsnm_total) > 1800 THEN
                        EXIT;
                    END IF;
                    
            END LOOP;
        
        ELSE --일반상품
        
            FOR tmp_loop in
                (SELECT goodsnm
                   FROM tbl_pricelist 
                  WHERE modelno = v_modelno
                    AND status in ('0','8','9')
                    AND srvflag in ('0','L','S')
                    AND NVL(option_flag2,'0') = '2'
                    AND NVL(solddate,sysdate) >= sysdate
                    ) 
            LOOP
                    
                    v_goodsnm_temp := tmp_loop.goodsnm;
                    IF INSTR(v_goodsnm_temp,'[') > 0 AND INSTR(v_goodsnm_temp,']') > 0 THEN
                        IF INSTR(v_goodsnm_temp,'[') < INSTR(v_goodsnm_temp,']') THEN
                            v_goodsnm_temp := SUBSTR(v_goodsnm_temp,INSTR(v_goodsnm_temp,']'),LENGTH(v_goodsnm_temp));
                        END IF;
                    END IF;
                    
                    v_goodsnm_temp := REPLACE(v_goodsnm_temp,'[',' ');
                    v_goodsnm_temp := REPLACE(v_goodsnm_temp,']',' ');
                    v_goodsnm_temp := REPLACE(v_goodsnm_temp,'_',' ');
                    v_goodsnm_temp := REPLACE(v_goodsnm_temp,'(',' ');
                    v_goodsnm_temp := REPLACE(v_goodsnm_temp,')',' ');
                    v_goodsnm_temp := RTRIM(LTRIM(v_goodsnm_temp));
                    
                    v_goodsnm_total := v_goodsnm_total || ' ' || v_goodsnm_temp;
                    
                    IF length(v_goodsnm_total) > 1800 THEN
                        EXIT;
                    END IF;
                    
            END LOOP;
            
        END IF;
         
        v_goodsnm_total := ltrim(rtrim(v_goodsnm_total));
    
    END IF;
    
    RETURN v_goodsnm_total;             
END;
