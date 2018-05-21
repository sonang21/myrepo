/* *************************************************************************
 * NAME : DBENURI.UDF_DEAL_CATE_MAPPING
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-04-19 18:32:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_DEAL_CATE_MAPPING" (v_ca_code varchar2)
RETURN VARCHAR2 AS
    re_mapping_cate  VARCHAR2(255) := '';
    mod_cate  VARCHAR2(255) := '';

BEGIN
    IF  LENGTH(v_ca_code) = 8 OR LENGTH(v_ca_code) = 10 THEN
        BEGIN
        SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = v_ca_code and rownum = 1;
        EXCEPTION WHEN OTHERS THEN
         mod_cate := '';
        END;        
        
        IF mod_cate is null or mod_cate = '' THEN
            BEGIN
            SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = SUBSTR(v_ca_code,0,6) and rownum = 1;
            EXCEPTION WHEN OTHERS THEN
            mod_cate := '';
            END;
        END IF;
        IF mod_cate is null or mod_cate = ''  THEN
            BEGIN
            SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = SUBSTR(v_ca_code,0,4) and rownum = 1;
            EXCEPTION WHEN OTHERS THEN
            mod_cate := '';
            END;
        END IF;  
        IF mod_cate is null or mod_cate = '' THEN
            BEGIN
            SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = SUBSTR(v_ca_code,0,2) and rownum = 1;
            EXCEPTION WHEN OTHERS THEN
            mod_cate := '';
            END;
        END IF;
    END IF;    
    IF LENGTH(v_ca_code) = 6 THEN
        BEGIN 
        SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = v_ca_code and rownum = 1;
        EXCEPTION WHEN OTHERS THEN
        mod_cate := '';        
        END;    
        IF mod_cate is null or mod_cate = '' THEN
            BEGIN
            SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = SUBSTR(v_ca_code,0,4) and rownum = 1;
            EXCEPTION WHEN OTHERS THEN
            mod_cate := '';
            END;
        END IF;
        IF mod_cate is null or mod_cate = '' THEN
            BEGIN
            SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = SUBSTR(v_ca_code,0,2) and rownum = 1;
            EXCEPTION WHEN OTHERS THEN
            mod_cate := '';
            END;
        END IF;
    END IF;    
    IF LENGTH(v_ca_code) = 4 THEN
        BEGIN
        SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = v_ca_code and rownum = 1;
        EXCEPTION WHEN OTHERS THEN
         mod_cate := '';
        END;
        IF mod_cate is null or mod_cate = '' THEN
            BEGIN
            SELECT ENURI_CATE into mod_cate FROM TBL_DAONEDAY_CATE_MAPPING WHERE ENURI_CATE = SUBSTR(v_ca_code,0,2) and rownum = 1;
            END;
        END IF;
    END IF;
    IF LENGTH(v_ca_code) = 2 THEN
        mod_cate := v_ca_code;
    END IF;
    SELECT
    (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE SUBSTR(A.DA_PCODE,0,3) = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
    (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.DA_PCODE = TBL_DAONEDAY_CATE.CODE and rownum = 1) || ' > ' ||
    (SELECT CODENAME FROM TBL_DAONEDAY_CATE WHERE A.DA_CODE = TBL_DAONEDAY_CATE.CODE and rownum = 1)  into re_mapping_cate
    FROM TBL_DAONEDAY_CATE_MAPPING A WHERE ENURI_CATE = mod_cate and rownum = 1;

RETURN re_mapping_cate;   
    
END;