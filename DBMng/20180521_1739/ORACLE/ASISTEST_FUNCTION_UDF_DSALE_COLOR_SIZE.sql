/* *************************************************************************
 * NAME : ASISTEST.UDF_DSALE_COLOR_SIZE
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:34
 *        Modify: 2018-05-04 18:54:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_DSALE_COLOR_SIZE" (v_custid varchar2, v_prodinc NUMBER)
RETURN VARCHAR2 AS

    v_color_size  VARCHAR2(4000):= NULL;
    v_colortxt    VARCHAR2(2000):='';
    v_sizetxt     VARCHAR2(1000):='';

BEGIN

    FOR tmp_loop in (SELECT colortxt,colorvalue FROM enColorMain WHERE custid=v_custid AND prodinc=v_prodinc AND colortxt IS NOT NULL) LOOP   
                
       
         --==========================================================================================
         --size
         --==========================================================================================
         v_sizetxt := NULL;        
         FOR tmp_loop2 in (             
                SELECT sizetxt,sizevalue FROM enSizeMain
                WHERE custid=v_custid
                AND prodinc=v_prodinc
                AND colortxt=tmp_loop.colortxt                    
        ) LOOP      
        
            IF LENGTH(v_sizetxt || ' / ' || tmp_loop2.sizetxt) >= 1000 THEN
                EXIT;
            END IF;
            
            IF v_sizetxt IS NULL THEN
                v_sizetxt := ' (' || tmp_loop2.sizetxt;
            ELSE
                v_sizetxt := v_sizetxt || ' / ' || tmp_loop2.sizetxt;
            END IF;
            
            
            
        
        END LOOP;
        
        IF v_sizetxt IS NOT NULL THEN
            v_sizetxt := v_sizetxt || ')';
        END IF;
        --====================================================================
        IF LENGTH(v_color_size || ' / ' || tmp_loop.colortxt || v_sizetxt) >= 2000 THEN
            EXIT;
        END IF;
            
        IF v_color_size IS NULL THEN
            v_color_size := tmp_loop.colortxt || v_sizetxt;
        ELSE
            v_color_size := v_color_size || ' / ' || tmp_loop.colortxt || v_sizetxt;
        END IF;
        --====================================================================  
     
    END LOOP;    

    RETURN v_color_size;            
    
END UDF_DSALE_COLOR_SIZE;