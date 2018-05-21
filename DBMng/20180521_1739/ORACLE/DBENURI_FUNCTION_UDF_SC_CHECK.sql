/* *************************************************************************
 * NAME : DBENURI.UDF_SC_CHECK
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 11:08:36
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_SC_CHECK" (v_modelno_group CHAR, v_modelno NUMBER, v_type CHAR, v_shop_code NUMBER)
RETURN VARCHAR2 AS 
/*
 NGIT 체크 - 변경없음 김영원 20180418
*/
    v_check_shop_code     VARCHAR2(1000) := ''; 
    v_reault char(1) := '0';
     
BEGIN

    IF v_type = '1' THEN   -- PC(WEB)
    
        IF v_shop_code = 0 THEN -- 에누리상품
    
            IF v_modelno_group = '1' THEN --그룸상품
            
                BEGIN
                
                    SELECT '1'
                      INTO v_reault
                      FROM TBL_PRICELIST
                     WHERE modelno IN (SELECT a.modelno
                                         FROM tbl_goods a, tbl_goods_sum b
                                        WHERE modelno_group = v_modelno
                                          AND a.modelno = b.modelno 
                                          AND b.mallcnt > 0
                                          AND a.constrain='1'
                                          AND a.jobcode > '0')
                       AND status IN ('0','8','9')
                       AND srvflag in ('0','L','R')
                       AND NVL(option_flag2,'0') = '0'
                       AND esstockflag = '0'
                       AND shop_code IN (6508,536,4027,5910,55,47,806,57,75,49,663,90,1878,6606,6603,3367,6378,4861,4858,5962,374,974,6642,6634,4856,6165)
                       AND ROWNUM = 1;            
                    
                    EXCEPTION WHEN OTHERS THEN
                        v_reault := '0';
                END;
                
            ELSE
            
                BEGIN
                
                    SELECT '1'
                      INTO v_reault
                      FROM TBL_PRICELIST 
                     WHERE modelno = v_modelno
                       AND status IN ('0','8','9')
                       AND srvflag in ('0','L','R')
                       AND NVL(option_flag2,'0') = '0'
                       AND esstockflag = '0'
                       AND shop_code IN (6508,536,4027,5910,55,47,806,57,75,49,663,90,1878,6606,6603,3367,6378,4861,4858,5962,374,974)
                       AND ROWNUM = 1;
                    
                    EXCEPTION WHEN OTHERS THEN
                        v_reault := '0';
               
               END;
            
            END IF;
        
        ELSE --웹상품        
            
            v_check_shop_code := ',6508,536,4027,5910,55,47,806,57,75,49,663,90,1878,6606,6603,3367,6378,4861,4858,5962,374,974,'; 
            IF INSTR(v_check_shop_code, ',' || v_shop_code || ',') > 0 THEN
                v_reault := '1';
            END IF;            
            
        END IF;
    
    ELSE          --MOBILE
    
        IF v_shop_code = 0 THEN -- 에누리상품
    
            IF v_modelno_group = '1' THEN --그룸상품
            
                BEGIN
                
                    SELECT '1' 
                      INTO v_reault
                      FROM TBL_PRICELIST
                     WHERE modelno IN (SELECT a.modelno
                                         FROM tbl_goods a, tbl_goods_sum b
                                        WHERE modelno_group = v_modelno
                                          AND a.modelno = b.modelno 
                                          AND b.mallcnt > 0
                                          AND a.constrain='1'
                                          AND a.jobcode > '0')
                       AND status IN ('0','8','9')
                       AND srvflag in ('0','L','R')
                       AND NVL(option_flag2,'0') = '0'
                       AND esstockflag = '0'
                       AND shop_code IN (6508,5910,47,806,57,75,49,6603,3367,6378,374,4027)
                       AND ROWNUM = 1;            
                    
                EXCEPTION WHEN OTHERS THEN
                        v_reault := '0';
                END;
                
            ELSE
            
               BEGIN
                
                    SELECT '1'
                      INTO v_reault
                      FROM TBL_PRICELIST 
                     WHERE modelno = v_modelno
                       AND status IN ('0','8','9')
                       AND srvflag in ('0','L','R')
                       AND NVL(option_flag2,'0') = '0'
                       AND esstockflag = '0'
                       AND shop_code IN (6508,5910,47,806,57,75,49,6603,3367,6378,374,4027)
                       AND ROWNUM = 1;
                    
               EXCEPTION WHEN OTHERS THEN
                        v_reault := '0';
               
               END;
            
            END IF;
        
        ELSE --웹상품         

            v_check_shop_code := ',6508,5910,47,806,57,75,49,6603,3367,6378,374,4027,'; 
            IF INSTR(v_check_shop_code, ',' || v_shop_code || ',') > 0 THEN
                v_reault := '1';
            END IF; 
                
        END IF;
    
    END IF;
    
    RETURN v_reault;
    
END;
