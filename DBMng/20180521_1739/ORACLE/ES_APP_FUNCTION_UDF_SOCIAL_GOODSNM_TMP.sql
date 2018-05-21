/* *************************************************************************
 * NAME : ES_APP.UDF_SOCIAL_GOODSNM_TMP
 * TYPE : FUNCTION
 * TIME : Create: 2018-04-10 10:26:41
 *        Modify: 2018-04-10 10:38:19
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_SOCIAL_GOODSNM_TMP" (v_group_type char,v_modelno NUMBER)
RETURN VARCHAR2 AS 
 
    v_goodsnm_total  VARCHAR2(4000):=''; 
    v_goodsnm_temp   VARCHAR2(400):=''; 
    v_modelno_group  VARCHAR2(400):=''; 
     
BEGIN  

    IF v_modelno > 0 THEN 
    
        IF v_group_type = '1' THEN --그룹상품
          
           select b.modelno_group
                , listagg(CASE WHEN INSTR(a.goodsnm,'[') > 0 AND INSTR(a.goodsnm,']') > 0 THEN
                                    CASE WHEN INSTR(a.goodsnm,'[') < INSTR(a.goodsnm,']') THEN
                                              SUBSTR(a.goodsnm,INSTR(a.goodsnm,']'),LENGTH(a.goodsnm))
                                    END
                          END  , ' ') within group(order by a.pl_no) aa
             INTO V_modelno_group
                , v_goodsnm_total
             from tbl_pricelist a
                  join tbl_goods b on (b.modelno = a.modelno)
           where b.modelno_group = v_modelno 
           group by b.modelno_group
           ;
           
           /* 2018.4.10 수정 HYK UDF_SOCIAL_GOODSNM
            FOR tmp_loop in
                (SELECT goodsnm FROM tbl_pricelist 
                    WHERE modelno IN (SELECT distinct modelno FROM tbl_goods 
                                        WHERE modelno_group = v_modelno 
                                        AND cateflag='1' 
                                        AND ca_lcode='87' 
                                        AND ca_code LIKE '8701%'
                                        AND jobcode > '0'  
                                        AND constrain = '1'  
                                        AND mallcnt > 0  
                                        )
                    AND status in ('0','8','9')
                    AND srvflag in ('0','L','S')
                    AND NVL(option_flag2,'0') = '2'
                    AND NVL(solddate,sysdate) >= sysdate
                    ) LOOP
                    
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
            
            */
        
        ELSE --일반상품
        
            FOR tmp_loop in
                (SELECT goodsnm FROM tbl_pricelist 
                    WHERE modelno = v_modelno
                    AND status in ('0','8','9')
                    AND srvflag in ('0','L','S')
                    AND NVL(option_flag2,'0') = '2'
                    AND NVL(solddate,sysdate) >= sysdate
                    ) LOOP
                    
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
