/* *************************************************************************
 * NAME : DBENURI.TR_ROW_INGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-23 13:20:52
 *        Modify: 2018-05-11 11:12:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_INGOODS_BBS" 
AFTER INSERT ON TBL_GOODS_BBS
FOR EACH ROW

BEGIN

  pg_Goods_Bbs_DataLoop.g_index  := pg_Goods_Bbs_DataLoop.g_index + 1;

  pg_Goods_Bbs_DataLoop.v_Modelno_new      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno, 0);
  pg_Goods_Bbs_DataLoop.v_Modelno_Group_new(pg_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno_group, 0);
  pg_Goods_Bbs_DataLoop.v_Delflag_new      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:new.delflag, '0');

END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- CREATE OR REPLACE TRIGGER "TRG_ROW_INGOODS_BBS"
-- AFTER INSERT ON TBL_GOODS_BBS
-- 
-- FOR EACH ROW
-- --WHEN (to_number(nvl(new., '0')) >= 1 OR new.constrain = '5' OR SUBSTR(new.ca_code,0,4) = '8701')
-- BEGIN
-- 
--   pac_Goods_Bbs_DataLoop.g_index  := pac_Goods_Bbs_DataLoop.g_index + 1;
--     
--   pac_Goods_Bbs_DataLoop.v_Modelno_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno, 0);
--     pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno_group, 0);
--     pac_Goods_Bbs_DataLoop.v_Delflag_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.delflag, '0');
-- 
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 


ALTER TRIGGER "DBENURI"."TR_ROW_INGOODS_BBS" ENABLE