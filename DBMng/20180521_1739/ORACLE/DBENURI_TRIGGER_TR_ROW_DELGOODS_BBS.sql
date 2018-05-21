/* *************************************************************************
 * NAME : DBENURI.TR_ROW_DELGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-23 13:18:50
 *        Modify: 2018-05-11 11:03:38
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_DELGOODS_BBS" 
AFTER DELETE ON TBL_GOODS_BBS
FOR EACH ROW
BEGIN

  pg_Goods_Bbs_DataLoop.g_index                                            := pg_Goods_Bbs_DataLoop.g_index + 1;
  pg_Goods_Bbs_DataLoop.v_Modelno_old      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno,         0);
  pg_Goods_Bbs_DataLoop.v_Modelno_Group_old(pg_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno_group,   0);
  pg_Goods_Bbs_DataLoop.v_Delflag_old      (pg_Goods_Bbs_DataLoop.g_index) := NVL(:old.delflag,       '0');

END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- CREATE OR REPLACE TRIGGER "TRG_ROW_DELGOODS_BBS"
-- AFTER DELETE ON TBL_GOODS_BBS
-- FOR EACH ROW
-- --WHEN (nvl(old.jobcode, '0') <> '0' AND old.constrain = '1')
-- BEGIN
-- 
--     --DBMS_OUTPUT.ENABLE;
--    --DBMS_OUTPUT.PUT_LINE('trgRowDelGoods start ......');
--   pac_Goods_Bbs_DataLoop.g_index  := pac_Goods_Bbs_DataLoop.g_index + 1;
--     
--   pac_Goods_Bbs_DataLoop.v_Modelno_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno, 0);
--     pac_Goods_Bbs_DataLoop.v_Modelno_Group_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno_group, 0);
--     pac_Goods_Bbs_DataLoop.v_Delflag_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.delflag, '0');
-- 
-- END;
------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 

ALTER TRIGGER "DBENURI"."TR_ROW_DELGOODS_BBS" ENABLE