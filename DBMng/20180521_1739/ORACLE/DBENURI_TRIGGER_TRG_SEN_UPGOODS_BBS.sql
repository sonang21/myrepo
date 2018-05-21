/* *************************************************************************
 * NAME : DBENURI.TRG_SEN_UPGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:09
 *        Modify: 2018-05-11 10:49:29
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TRG_SEN_UPGOODS_BBS" 
AFTER UPDATE ON TBL_GOODS_BBS
DECLARE
 	v_modelno_new 				tbl_goods_bbs.modelno%TYPE := 0;
 	v_modelno_group_new     	tbl_goods_bbs.modelno_group%TYPE := 0;    
    v_delflag_new     	        tbl_goods_bbs.delflag%TYPE := 0;    
    v_delflag_old     	        tbl_goods_bbs.delflag%TYPE := 0;    
 	    
    v_bbs_num                   NUMBER(8) := 0;
    v_bbs_point                 NUMBER(8) := 0;
    v_bbs_point_avg             NUMBER(6,2) := 0;
    i                           NUMBER(8) := 1;

BEGIN

--DBMS_OUTPUT.ENABLE;

 LOOP
 
  IF i <= pac_Goods_Bbs_DataLoop.g_index THEN

  	v_modelno_new           :=  pac_Goods_Bbs_DataLoop.v_Modelno_new(i);
    v_modelno_group_new     :=  NVL(pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(i),0);
    v_delflag_new           :=  NVL(pac_Goods_Bbs_DataLoop.v_Delflag_new(i),'N');
    v_delflag_old           :=  NVL(pac_Goods_Bbs_DataLoop.v_Delflag_old(i),'N');
    
    --DBMS_OUTPUT.PUT_LINE('v_delflag_new  ......' || v_delflag_new);
    --DBMS_OUTPUT.PUT_LINE('v_delflag_old  ......' || v_delflag_old);
  
    IF v_delflag_new <> v_delflag_old THEN
    --======================================================================================                        
        BEGIN
            
            IF v_modelno_group_new > 0 THEN
                SELECT	COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
                WHERE (modelno_group = v_modelno_group_new)
                AND delflag='N';
            ELSE
                SELECT	COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
                WHERE (modelno = v_modelno_new)
                AND delflag='N';
            END IF;
            
            EXCEPTION WHEN OTHERS THEN
            v_bbs_num := 0;
            v_bbs_point := 0;
            v_bbs_point_avg := 0;
        END;
            
        --======================================================================================      
        --DBMS_OUTPUT.PUT_LINE('v_bbs_num  ......' || v_bbs_num);
        IF v_modelno_group_new > 0 THEN
            UPDATE TBL_GOODS_SUM SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
            WHERE modelno in (select modelno from tbl_goods where modelno_group =  v_modelno_group_new);
        ELSE
            UPDATE TBL_GOODS_SUM SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
            WHERE modelno = v_modelno_new;
        END IF;       
        --======================================================================================    

    END IF;
   
  ELSE
  
    EXIT;
  
  END IF;  
  
  i := i + 1;

 END LOOP;

 pac_Goods_Bbs_DataLoop.g_index := 0;
 i := 1;
 
END;

ALTER TRIGGER "DBENURI"."TRG_SEN_UPGOODS_BBS" DISABLE