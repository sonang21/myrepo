/* *************************************************************************
 * NAME : DEAL.UDF_GOODS_LOC
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DEAL"."UDF_GOODS_LOC" (v_level NUMBER, v_cp_id NUMBER)
RETURN VARCHAR2 AS

    v_loc_code       VARCHAR2(150):=' ';
    v_loc_code1      VARCHAR2(150):='';
    v_loc_code2      VARCHAR2(150):='';
    
    i_count         NUMBER(4);

    CURSOR cur_goods_loc IS
        SELECT loccatetop,loccate
        FROM d4_coupon_loc
        WHERE cp_id = v_cp_id
        AND loccatetop IS NOT NULL;

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');
    BEGIN    

        OPEN cur_goods_loc;
        LOOP

            FETCH cur_goods_loc INTO v_loc_code1,v_loc_code2;
            EXIT WHEN cur_goods_loc%NOTFOUND;
            
            IF v_level = 1 THEN
                IF INSTR(v_loc_code, v_loc_code1 || ' ') = 0 THEN
                    v_loc_code := v_loc_code || v_loc_code1 || ' ';
                END IF;
            ELSE 
                IF v_level = 2 THEN
                    IF INSTR(v_loc_code, v_loc_code2 || ' ') = 0 THEN
                        v_loc_code := v_loc_code || v_loc_code2 || ' ';
                    END IF;                
                END IF;
            END IF;
            
            --v_loc_code := LTRIM(RTRIM(v_loc_code));
            
            i_count := i_count +1;
            
            IF i_count > 50 THEN
                EXIT;
            END IF;            

        END LOOP;
        v_loc_code := LTRIM(RTRIM(v_loc_code));
        --IF LENGTH(v_loc_code) > 1 THEN
        --    v_loc_code := SUBSTR(v_loc_code,2,LENGTH(v_loc_code));
        --    v_loc_code := SUBSTR(v_loc_code,0,LENGTH(v_loc_code)-1);
        --ELSE
        --    v_loc_code := '';
        --END IF;
        
        CLOSE cur_goods_loc;

    RETURN v_loc_code;            
    
    END;