/* *************************************************************************
 * NAME : ES_APP.UDF_MODEL_FACTORY
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:43:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_MODEL_FACTORY" (factory VARCHAR2,brand VARCHAR2,modelnm_cond VARCHAR2)
RETURN VARCHAR2 AS

   v_model_factory VARCHAR2(2000) := '';
   v_modelnm VARCHAR2(200) := '';
   v_condiname VARCHAR2(100) := '';
   
   I_POS_FOUND NUMBER :=0;
   I_TOKEN_START NUMBER :=0;
   I_TOKEN_END NUMBER :=0;
    
BEGIN
  
    I_POS_FOUND := INSTR(modelnm_cond, '~!@', 1);
  
    IF I_POS_FOUND > 0 THEN
        I_TOKEN_START := 1;
        I_TOKEN_END := I_POS_FOUND - 1;
    ELSE
        I_TOKEN_START := 1;
        I_TOKEN_END := LENGTH(modelnm_cond);
    END IF;

    v_modelnm :=  SUBSTR(modelnm_cond,I_TOKEN_START,I_TOKEN_END);
    
    IF I_POS_FOUND > 0 THEN
        v_condiname :=  SUBSTR(modelnm_cond,I_POS_FOUND + 3 ,LENGTH(modelnm_cond)); 
    END IF;

    IF v_condiname IS NOT NULL THEN    
        IF INSTR(v_modelnm,v_condiname) > 0 THEN
            v_model_factory := REPLACE(v_modelnm,v_condiname,'');
        ELSE
            v_model_factory := REPLACE(v_modelnm,SUBSTR(v_condiname,2,LENGTH(v_condiname)),'');
        END IF;
        
    ELSE    
        v_model_factory := v_modelnm;
    END IF;
    /*
    IF INSTR(factory,brand) = 0 THEN
        IF INSTR(v_model_factory,brand) = 0 THEN
            v_model_factory := v_model_factory || ' ' || brand;
        END IF;
    END IF;
    
    IF INSTR(v_model_factory,factory) = 0 THEN
        v_model_factory := v_model_factory || ' ' || factory;
    END IF;
    */
     
    v_model_factory := REPLACE(REPLACE(v_model_factory,'[]',''),'_',' ');
    v_model_factory := REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(v_model_factory,'[]',''),'<',' '),'>',' '),'[',' '),']',' '),'/',' '),')',' '),'(',' '),'-',' '),'_',' '),',',' ');
    
    RETURN v_model_factory;            
END;