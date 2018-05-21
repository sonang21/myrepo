/* *************************************************************************
 * NAME : DBENURI.TRG_ROW_INGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:09
 *        Modify: 2018-05-11 10:49:17
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TRG_ROW_INGOODS_BBS" 
AFTER INSERT ON TBL_GOODS_BBS

FOR EACH ROW
--WHEN (to_number(nvl(new., '0')) >= 1 OR new.constrain = '5' OR SUBSTR(new.ca_code,0,4) = '8701')
BEGIN

	pac_Goods_Bbs_DataLoop.g_index	:= pac_Goods_Bbs_DataLoop.g_index + 1;
    
	pac_Goods_Bbs_DataLoop.v_Modelno_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno, 0);
    pac_Goods_Bbs_DataLoop.v_Modelno_Group_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.modelno_group, 0);
    pac_Goods_Bbs_DataLoop.v_Delflag_new(pac_Goods_Bbs_DataLoop.g_index) := NVL(:new.delflag, '0');

END;


ALTER TRIGGER "DBENURI"."TRG_ROW_INGOODS_BBS" DISABLE