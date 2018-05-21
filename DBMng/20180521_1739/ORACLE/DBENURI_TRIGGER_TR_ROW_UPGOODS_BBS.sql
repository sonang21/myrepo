/* *************************************************************************
 * NAME : DBENURI.TR_ROW_UPGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-23 13:22:18
 *        Modify: 2018-05-11 11:22:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_UPGOODS_BBS" 
AFTER UPDATE ON TBL_GOODS_BBS
FOR EACH ROW

BEGIN

  pg_Goods_Bbs_DataLoop.g_index          := pg_Goods_Bbs_DataLoop.g_index + 1;
    
  pg_Goods_Bbs_DataLoop.v_Modelno_old      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno, 0);
  pg_Goods_Bbs_DataLoop.v_Modelno_Group_old(pg_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno_group, 0);
  pg_Goods_Bbs_DataLoop.v_Delflag_old      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:old.delflag, 'N');

  pg_Goods_Bbs_DataLoop.v_Modelno_new      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno, 0);
  pg_Goods_Bbs_DataLoop.v_Modelno_Group_new(pg_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno_group, 0);
  pg_Goods_Bbs_DataLoop.v_Delflag_new      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:new.delflag, 'N');

END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- CREATE OR REPLACE TRIGGER "TRG_ROW_UPGOODS_BBS"
-- AFTER UPDATE ON TBL_GOODS_BBS
-- FOR EACH ROW
-- --WHEN (new.cateflag in ('0','1'))
-- BEGIN
-- 
--   pac_Goods_Bbs_DataLoop.g_index  := pac_Goods_Bbs_DataLoop.g_index + 1;
--     
--   pac_Goods_Bbs_DataLoop.v_Modelno_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno, 0);
--     pac_Goods_Bbs_DataLoop.v_Modelno_Group_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno_group, 0);
--     pac_Goods_Bbs_DataLoop.v_Delflag_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.delflag, 'N');
-- 
--     pac_Goods_Bbs_DataLoop.v_Modelno_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno, 0);
--     pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno_group, 0);
--     pac_Goods_Bbs_DataLoop.v_Delflag_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.delflag, 'N');
-- 
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 

ALTER TRIGGER "DBENURI"."TR_ROW_UPGOODS_BBS" ENABLE