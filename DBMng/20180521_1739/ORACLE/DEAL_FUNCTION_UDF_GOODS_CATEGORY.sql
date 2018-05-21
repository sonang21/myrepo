/* *************************************************************************
 * NAME : DEAL.UDF_GOODS_CATEGORY
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DEAL"."UDF_GOODS_CATEGORY" (v_level NUMBER, v_cp_id NUMBER)
RETURN VARCHAR2 AS

    v_ca_code       VARCHAR2(150):='0';
    v_ca_code1      VARCHAR2(150):='';
    v_ca_code2      VARCHAR2(150):='';
    v_ca_code3      VARCHAR2(150):='';
    v_ca_code4      VARCHAR2(150):='';
    
    i_count         NUMBER(4);

    CURSOR cur_goods_category IS
        SELECT cate1,cate2,cate3
        FROM d4_coupon_cate
        WHERE cp_id = v_cp_id;

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');
    BEGIN    

        OPEN cur_goods_category;
        LOOP

            FETCH cur_goods_category INTO v_ca_code1,v_ca_code2,v_ca_code3;
            EXIT WHEN cur_goods_category%NOTFOUND;
            
            IF v_level = 1 THEN
                IF INSTR(v_ca_code, v_ca_code1) = 0 THEN
                    IF v_ca_code = '0' THEN
                        v_ca_code := v_ca_code1;
                    ELSE
                        v_ca_code := v_ca_code || ',' || v_ca_code1;
                    END IF;
                END IF;
                
                EXIT;
                
            ELSE 
                IF v_level = 2 THEN
                    IF INSTR(v_ca_code, v_ca_code2) = 0 THEN
                        IF v_ca_code = '0' THEN
                            v_ca_code := v_ca_code2;
                        ELSE
                            v_ca_code := v_ca_code || ',' || v_ca_code2;
                        END IF;
                    END IF;
                ELSE 
                    --IF v_level = 3 THEN
                        IF INSTR(v_ca_code, v_ca_code3 ) = 0 THEN
                            IF v_ca_code = '0' THEN
                                v_ca_code := v_ca_code3;
                            ELSE
                                v_ca_code := v_ca_code || ',' || v_ca_code3;
                            END IF;
                        END IF;
                    --END IF;
                END IF;
            END IF;
            
            v_ca_code := LTRIM(RTRIM(v_ca_code));
            
            i_count := i_count +1;
            
            IF i_count > 50 THEN
                EXIT;
            END IF;            

        END LOOP;
        
        --IF LENGTH(v_ca_code) > 1 THEN
        --    v_ca_code := SUBSTR(v_ca_code,2,LENGTH(v_ca_code));
        --    v_ca_code := SUBSTR(v_ca_code,0,LENGTH(v_ca_code)-1);
        --ELSE
        --    v_ca_code := '';
        --END IF;
        
        CLOSE cur_goods_category;

        IF v_ca_code='0' THEN
            v_ca_code := '';
        END IF;
            
    RETURN v_ca_code;            
    
    END;