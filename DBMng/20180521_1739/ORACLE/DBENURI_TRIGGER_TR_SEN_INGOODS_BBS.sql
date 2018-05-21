/* *************************************************************************
 * NAME : DBENURI.TR_SEN_INGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-23 13:08:53
 *        Modify: 2018-05-21 17:22:35
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_SEN_INGOODS_BBS" 
AFTER INSERT ON TBL_GOODS_BBS
DECLARE
  v_modelno_new         tbl_goods_bbs.modelno%TYPE := 0;
  v_modelno_group_new       tbl_goods_bbs.modelno_group%TYPE := 0;    
      
    v_bbs_num                   NUMBER(6) := 0;
    v_bbs_point                 NUMBER(8) := 0;
    v_bbs_point_avg             NUMBER(6,2) := 0;
    i                           NUMBER(8) := 1;

BEGIN

 LOOP
  IF i <= pac_Goods_Bbs_DataLoop.g_index THEN

    v_modelno_new           :=  pac_Goods_Bbs_DataLoop.v_Modelno_new(i);
    v_modelno_group_new     :=  NVL(pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(i),0);
    
    BEGIN
        IF v_modelno_group_new > 0 THEN
            SELECT COUNT(*)
                 , NVL(AVG(case when point=0 then null else point end),0)
                 , SUM(NVL(point,0)) 
              INTO v_bbs_num
                 , v_bbs_point_avg
                 , v_bbs_point 
              FROM TBL_GOODS_BBS 
             WHERE (modelno_group = v_modelno_group_new)
               AND delflag='N';
        ELSE
            SELECT COUNT(*)
                 , NVL(AVG(case when point=0 then null else point end),0)
                 , SUM(NVL(point,0)) 
              INTO v_bbs_num
                 , v_bbs_point_avg
                 , v_bbs_point 
              FROM TBL_GOODS_BBS 
             WHERE (modelno = v_modelno_new)
               AND delflag='N';
        END IF;
        
        EXCEPTION WHEN OTHERS THEN
        v_bbs_num       := 0;
        v_bbs_point     := 0;
        v_bbs_point_avg := 0;
    END;
    
    IF v_modelno_group_new > 0 THEN
        UPDATE TBL_GOODS_SUM         --0418 tbl_goods --> tbl_goods_sum
           SET BBS_NUM       = v_bbs_num
             , BBS_POINT     = v_bbs_point
             , BBS_POINT_AVG = v_bbs_point_avg
             , CHK_TRG_DATE  = SYSDATE
             , CHK_TRG_FLAG  = 'IB1'
             , moddate       = sysdate
             -----------------------------------------------------------------------------------------------------------------------------------------
             --  WHERE modelno_group = v_modelno_group_new;
             -----------------------------------------------------------------------------------------------------------------------------------------
         WHERE MODELNO IN (SELECT MODELNO
                             FROM TBL_GOODS 
                            WHERE modelno_group = v_modelno_group_new
                          ) ;
         ---------------------------------------------------------------------------------------------------------------------------------------------

        UPDATE TBL_GOODS
           SET rsiflag       = NULL      
             , MODDATE       = SYSDATE
             , SUM_MODDATE   = SYSDATE
             , CHK_TRG_DATE  = SYSDATE
             , CHK_TRG_FLAG  = 'IB1'
         WHERE modelno_group = v_modelno_group_new;

    ELSE
        UPDATE TBL_GOODS_SUM         --0418 tbl_goods --> tbl_goods_sum
           SET BBS_NUM       = v_bbs_num
             , BBS_POINT     = v_bbs_point
             , BBS_POINT_AVG = v_bbs_point_avg
             , moddate       = sysdate
             , CHK_TRG_DATE  = SYSDATE
             , CHK_TRG_FLAG  = 'IB2'
         WHERE modelno       = v_modelno_new;
         
        UPDATE TBL_GOODS
           SET rsiflag       = NULL      
             , MODDATE       = SYSDATE
             , SUM_MODDATE   = SYSDATE
             , CHK_TRG_DATE  = SYSDATE
             , CHK_TRG_FLAG  = 'IB2'
         WHERE modelno       = v_modelno_new;

    END IF;
   
  ELSE
  
    EXIT;
  
  END IF;
  
  i := i + 1;

 END LOOP;

 pac_Goods_Bbs_DataLoop.g_index := 0;
 i := 1;
 
END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- CREATE OR REPLACE TRIGGER "TRG_SEN_INGOODS_BBS"
-- AFTER INSERT ON TBL_GOODS_BBS
-- DECLARE
--    v_modelno_new         tbl_goods_bbs.modelno%TYPE := 0;
--    v_modelno_group_new       tbl_goods_bbs.modelno_group%TYPE := 0;    
--        
--     v_bbs_num                   NUMBER(6) := 0;
--     v_bbs_point                 NUMBER(8) := 0;
--     v_bbs_point_avg             NUMBER(6,2) := 0;
--     i                           NUMBER(8) := 1;
-- 
-- BEGIN
-- --DBMS_OUTPUT.ENABLE;
-- 
--  LOOP
--   IF i <= pac_Goods_Bbs_DataLoop.g_index THEN
-- 
--    v_modelno_new           :=  pac_Goods_Bbs_DataLoop.v_Modelno_new(i);
--     v_modelno_group_new     :=  NVL(pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(i),0);
--     
--     --======================================================================================                        
-- 
--     BEGIN
--         IF v_modelno_group_new > 0 THEN
--             SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
--             WHERE (modelno_group = v_modelno_group_new)
--             AND delflag='N';
--         ELSE
--             SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
--             WHERE (modelno = v_modelno_new)
--             AND delflag='N';
--         END IF;
--         
--         EXCEPTION WHEN OTHERS THEN
--         v_bbs_num := 0;
--         v_bbs_point := 0;
--         v_bbs_point_avg := 0;
--     END;
--     
--     --======================================================================================  
--     IF v_modelno_group_new > 0 THEN
--         UPDATE TBL_GOODS SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
--         WHERE modelno_group = v_modelno_group_new;
--     ELSE
--         UPDATE TBL_GOODS SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
--         WHERE modelno = v_modelno_new;
--     END IF;
--     --======================================================================================        
--    
--   ELSE
--   
--     EXIT;
--   
--   END IF;
--   
--   i := i + 1;
-- 
--  END LOOP;
-- 
--  pac_Goods_Bbs_DataLoop.g_index := 0;
--  i := 1;
--  
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 

ALTER TRIGGER "DBENURI"."TR_SEN_INGOODS_BBS" ENABLE