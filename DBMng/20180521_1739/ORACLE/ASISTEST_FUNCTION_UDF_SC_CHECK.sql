/* *************************************************************************
 * NAME : ASISTEST.UDF_SC_CHECK
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_SC_CHECK" (v_modelno_group CHAR, v_modelno NUMBER, v_type CHAR, v_shop_code NUMBER) 
RETURN VARCHAR2 AS 
 
    v_check_shop_code     VARCHAR2(1000) := ''; 
    v_reault char(1) := '0';
    
    -- v_shop_code(0) : 에누리상품
    -- v_shop_code(>0) : 웹상품
    
    -- v_modelno_group('0') 일반상품(웹상품포함)
    -- v_modelno_group('1') 그룹상품
    
    -- v_modelno : modelno, modelno_group
    
    -- v_type('1') PC(WEB)
    -- v_type('2') 모바일
     
BEGIN

    IF v_type = '1' THEN   -- PC(WEB)
    
        IF v_shop_code = 0 THEN -- 에누리상품
    
            IF v_modelno_group = '1' THEN --그룸상품
            
                BEGIN
                
                    SELECT '1'  INTO v_reault FROM TBL_PRICELIST
                    WHERE modelno IN 
                        (SELECT modelno FROM TBL_GOODS
                        WHERE modelno_group = v_modelno
                        AND cateflag='0'
                        AND mallcnt > 0
                        AND constrain='1'
                        AND jobcode > '0'
                        )
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
                
                    SELECT '1' INTO v_reault FROM TBL_PRICELIST 
                    /*
                    WHERE modelno IN 
                        (SELECT modelno FROM TBL_GOODS
                        WHERE modelno = v_modelno
                        AND cateflag='0'
                        AND mallcnt > 0
                        AND constrain='1'
                        AND jobcode > '0'
                        )
                    */
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
                
                    SELECT '1'  INTO v_reault FROM TBL_PRICELIST
                    WHERE modelno IN 
                        (SELECT modelno FROM TBL_GOODS
                        WHERE modelno_group = v_modelno
                        AND cateflag='0'
                        AND mallcnt > 0
                        AND constrain='1'
                        AND jobcode > '0'
                        )
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
                
                    SELECT '1' INTO v_reault FROM TBL_PRICELIST 
                    /*
                    WHERE modelno IN 
                        (SELECT modelno FROM TBL_GOODS
                        WHERE modelno = v_modelno
                        AND cateflag='0'
                        AND mallcnt > 0
                        AND constrain='1'
                        AND jobcode > '0'
                        )
                    */
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