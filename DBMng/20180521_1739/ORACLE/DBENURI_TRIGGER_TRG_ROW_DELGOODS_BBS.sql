/* *************************************************************************
 * NAME : DBENURI.TRG_ROW_DELGOODS_BBS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:07
 *        Modify: 2018-05-11 10:49:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TRG_ROW_DELGOODS_BBS" 
AFTER DELETE ON TBL_GOODS_BBS
FOR EACH ROW
--WHEN (nvl(old.jobcode, '0') <> '0' AND old.constrain = '1')
BEGIN

    --DBMS_OUTPUT.ENABLE;
 	--DBMS_OUTPUT.PUT_LINE('trgRowDelGoods start ......');
	pac_Goods_Bbs_DataLoop.g_index	:= pac_Goods_Bbs_DataLoop.g_index + 1;
    
	pac_Goods_Bbs_DataLoop.v_Modelno_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno, 0);
    pac_Goods_Bbs_DataLoop.v_Modelno_Group_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.modelno_group, 0);
    pac_Goods_Bbs_DataLoop.v_Delflag_old(pac_Goods_Bbs_DataLoop.g_index) := NVL(:old.delflag, '0');

END;
ALTER TRIGGER "DBENURI"."TRG_ROW_DELGOODS_BBS" DISABLE