/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_CHECK_SEARCH
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-04-19 18:32:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_CHECK_SEARCH" (v_modelno NUMBER)
RETURN VARCHAR2 AS

    --v_keyword_arr VARCHAR2(32767):='';
    v_keyword_arr VARCHAR2(4000):='';

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_BRAND1 start ......');
    BEGIN
    /*
    IF v_modelno > 0 THEN
        
        FOR tmp_loop in (
            
            SELECT DISTINCT rtrim(substr(GOODSNM,1,80)) GOODSNM FROM (
            SELECT GOODSNM,
            CASE WHEN SHOP_CODE=47 OR SHOP_CODE=49 OR SHOP_CODE=806 OR SHOP_CODE=663 OR SHOP_CODE=75 OR SHOP_CODE=57 OR SHOP_CODE=90 THEN 0 ELSE 1 END order_by,
            price
            FROM TBL_PRICELIST
            WHERE modelno=v_modelno
            AND STATUS IN ('0','5')
            AND SRVFLAG='0'
            --AND SHOP_CODE IN (47,49,806,663,75,57,90,974,1878,6389,3336,374,4027,536,55,5910,6547)
            order by order_by,price
            ) WHERE ROWNUM <= 24
            
        ) LOOP
                
        v_keyword_arr := rtrim(v_keyword_arr) || ' ' || rtrim(tmp_loop.GOODSNM);    
        
        END LOOP;    
        
    END IF;
    */
    RETURN v_keyword_arr;            
    END;