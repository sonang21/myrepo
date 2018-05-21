/* *************************************************************************
 * NAME : DBENURI.TR_SEN_DELGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-23 12:56:03
 *        Modify: 2018-05-21 17:23:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_SEN_DELGOODS_BBS" 
AFTER DELETE ON TBL_GOODS_BBS
DECLARE
v_modelno_old             tbl_goods_bbs.modelno%TYPE := 0;
v_modelno_group_old       tbl_goods_bbs.modelno_group%TYPE := 0;    
      
v_bbs_num                 NUMBER(6)   := 0;
v_bbs_point               NUMBER(8)   := 0;
v_bbs_point_avg           NUMBER(6,2) := 0;
i                         NUMBER(8)   := 1;

BEGIN

     LOOP
      
      IF i <= pac_Goods_Bbs_DataLoop.g_index THEN
     
         v_modelno_old          :=  pac_Goods_Bbs_DataLoop.v_Modelno_old(i);
         v_modelno_group_old    :=  NVL(pac_Goods_Bbs_DataLoop.v_Modelno_Group_old(i),0);
         
         BEGIN
         
             IF v_modelno_group_old > 0 THEN
                 SELECT COUNT(*)
                      , NVL(AVG(case when point=0 then null else point end),0)
                      , SUM(NVL(point,0)) 
                   INTO v_bbs_num
                      , v_bbs_point_avg
                      , v_bbs_point 
                   FROM TBL_GOODS_BBS 
                  WHERE (modelno_group = v_modelno_group_old)
                    AND delflag = 'N';
             ELSE
                 SELECT COUNT(*)
                      , NVL(AVG(case when point=0 then null else point end),0)
                      , SUM(NVL(point,0)) 
                   INTO v_bbs_num
                      , v_bbs_point_avg
                      , v_bbs_point 
                   FROM TBL_GOODS_BBS 
                  WHERE (modelno = v_modelno_old)
                    AND delflag  = 'N';
             END IF;
         
             EXCEPTION WHEN OTHERS THEN
             v_bbs_num       := 0;
             v_bbs_point     := 0;
             v_bbs_point_avg := 0;
         END;
     
         IF v_modelno_group_old > 0 THEN
           
            UPDATE TBL_GOODS_SUM                  --0418 tbl_goods --> tbl_goods_sum
               SET BBS_NUM       = v_bbs_num
                 , BBS_POINT     = v_bbs_point
                 , BBS_POINT_AVG = v_bbs_point_avg
                 , moddate       = sysdate
                 , CHK_TRG_DATE  = SYSDATE
                 , CHK_TRG_FLAG  = 'DB1'
             -----------------------------------------------------------------------------------------------------------------------------------------
             -- 0418 수정 : WHERE modelno_group  = v_modelno_group_old;
             -----------------------------------------------------------------------------------------------------------------------------------------
             WHERE MODELNO IN (SELECT MODELNO
                                 FROM TBL_GOODS 
                                WHERE modelno_group  = v_modelno_group_old
                             ) ;
             -----------------------------------------------------------------------------------------------------------------------------------------

            UPDATE TBL_GOODS
               SET rsiflag       = NULL      
                 , MODDATE       = SYSDATE
                 , SUM_MODDATE   = SYSDATE
                 , CHK_TRG_DATE  = SYSDATE
                 , CHK_TRG_FLAG  = 'DB1'
             WHERE modelno_group = v_modelno_group_old;
     
         ELSE
            UPDATE TBL_GOODS_SUM                  --0418 tbl_goods --> tbl_goods_sum
               SET BBS_NUM       = v_bbs_num
                 , BBS_POINT     = v_bbs_point
                 , BBS_POINT_AVG = v_bbs_point_avg
                 , moddate       = sysdate
                 , CHK_TRG_DATE  = SYSDATE
                 , CHK_TRG_FLAG  = 'DB2'
             WHERE modelno       = v_modelno_old;
           
            UPDATE TBL_GOODS
               SET rsiflag       = NULL      
                 , MODDATE       = SYSDATE
                 , SUM_MODDATE   = SYSDATE
                 , CHK_TRG_DATE  = SYSDATE
                 , CHK_TRG_FLAG  = 'DB2'
             WHERE modelno       = v_modelno_old;

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
-- CREATE OR REPLACE TRIGGER "TRG_SEN_DELGOODS_BBS"
-- AFTER DELETE ON TBL_GOODS_BBS
-- DECLARE
--    v_modelno_old         tbl_goods_bbs.modelno%TYPE := 0;
--    v_modelno_group_old       tbl_goods_bbs.modelno_group%TYPE := 0;    
--        
--     v_bbs_num                   NUMBER(6) := 0;
--     v_bbs_point                 NUMBER(8) := 0;
--     v_bbs_point_avg             NUMBER(6,2) := 0;
--     i                           NUMBER(8) := 1;
-- 
-- BEGIN
-- 
-- --SET SERVEROUTPUT ON  
-- --DBMS_OUTPUT.ENABLE;
-- 
--  LOOP
--  
--   --DBMS_OUTPUT.PUT_LINE('pac_Goods_Bbs_DataLoop.g_index  ......' || pac_Goods_Bbs_DataLoop.g_index);
--  
--   IF i <= pac_Goods_Bbs_DataLoop.g_index THEN
-- 
--    v_modelno_old          :=  pac_Goods_Bbs_DataLoop.v_Modelno_old(i);
--     v_modelno_group_old    :=  NVL(pac_Goods_Bbs_DataLoop.v_Modelno_Group_old(i),0);
--     
--     --======================================================================================                        
--     BEGIN
--     
--         IF v_modelno_group_old > 0 THEN
--             SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
--             WHERE (modelno_group = v_modelno_group_old)
--             AND delflag='N';
--         ELSE
--             SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) INTO v_bbs_num,v_bbs_point_avg,v_bbs_point FROM TBL_GOODS_BBS 
--             WHERE (modelno = v_modelno_old)
--             AND delflag='N';
--         END IF;
--     
--         EXCEPTION WHEN OTHERS THEN
--         v_bbs_num := 0;
--         v_bbs_point := 0;
--         v_bbs_point_avg := 0;
--     END;
--     --====================================================================================== 
--     IF v_modelno_group_old > 0 THEN
--         UPDATE TBL_GOODS SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
--         --UPDATE TBL_GOODS SET BBS_NUM=v_bbs_num
--         WHERE modelno_group = v_modelno_group_old;
--     ELSE
--         UPDATE TBL_GOODS SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
--         --UPDATE TBL_GOODS SET BBS_NUM=v_bbs_num
--         WHERE modelno = v_modelno_old;
--     END IF;
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

ALTER TRIGGER "DBENURI"."TR_SEN_DELGOODS_BBS" ENABLE