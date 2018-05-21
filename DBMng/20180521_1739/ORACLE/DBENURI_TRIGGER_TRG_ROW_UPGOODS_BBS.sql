/* *************************************************************************
 * NAME : DBENURI.TRG_ROW_UPGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:09
 *        Modify: 2018-05-11 10:49:20
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TRG_ROW_UPGOODS_BBS" 
AFTER UPDATE ON TBL_GOODS_BBS
FOR EACH ROW
--WHEN (new.cateflag in ('0','1'))
BEGIN

	pac_Goods_Bbs_DataLoop.g_index	:= pac_Goods_Bbs_DataLoop.g_index + 1;
    
	pac_Goods_Bbs_DataLoop.v_Modelno_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno, 0);
    pac_Goods_Bbs_DataLoop.v_Modelno_Group_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno_group, 0);
    pac_Goods_Bbs_DataLoop.v_Delflag_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.delflag, 'N');

    pac_Goods_Bbs_DataLoop.v_Modelno_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno, 0);
    pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno_group, 0);
    pac_Goods_Bbs_DataLoop.v_Delflag_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.delflag, 'N');

END;


ALTER TRIGGER "DBENURI"."TRG_ROW_UPGOODS_BBS" DISABLE