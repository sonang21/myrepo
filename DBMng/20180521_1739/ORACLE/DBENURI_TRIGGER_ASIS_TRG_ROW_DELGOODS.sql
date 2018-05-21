/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_ROW_DELGOODS
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 15:09:40
 *        Modify: 2018-05-11 10:50:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_ROW_DELGOODS" AFTER DELETE ON ASIS_TBL_GOODS
FOR EACH ROW
  
 WHEN (nvl(old.jobcode, '0') <> '0' AND old.constrain = '1') BEGIN

  --DBMS_OUTPUT.ENABLE;
 	--DBMS_OUTPUT.PUT_LINE('trgRowDelGoods start ......');

/*	pac_Goods_DataLoop.g_index	:= pac_Goods_DataLoop.g_index + 1;
*/	pac_Goods_DataLoop.v_Modelno_old(pac_Goods_DataLoop.g_index) := NVL(:old.modelno, 0);
	pac_Goods_DataLoop.v_Modelnm_old(pac_Goods_DataLoop.g_index) := NVL(:old.modelnm, '');
	pac_Goods_DataLoop.v_Factory_old(pac_Goods_DataLoop.g_index) := NVL(:old.factory, '');
	pac_Goods_DataLoop.v_Spec_old(pac_Goods_DataLoop.g_index) := NVL(:old.spec, '');
	pac_Goods_DataLoop.v_Cdate_old(pac_Goods_DataLoop.g_index) := :old.c_date;
	pac_Goods_DataLoop.v_Imgchk_old(pac_Goods_DataLoop.g_index) := NVL(:old.imgchk, '');
	pac_Goods_DataLoop.v_Minprice_old(pac_Goods_DataLoop.g_index) := NVL(:old.minprice, 0);
	pac_Goods_DataLoop.v_Mallcnt_old(pac_Goods_DataLoop.g_index) := NVL(:old.mallcnt, 0);
	pac_Goods_DataLoop.v_Kbnum_old(pac_Goods_DataLoop.g_index) := NVL(:old.kb_num, 0);
	pac_Goods_DataLoop.v_Openexpectflag_old(pac_Goods_DataLoop.g_index) := NVL(:old.openexpectflag, '');
	pac_Goods_DataLoop.v_Recommend_old(pac_Goods_DataLoop.g_index) := NVL(:old.recommend, '');
	pac_Goods_DataLoop.v_Popular_old(pac_Goods_DataLoop.g_index) := NVL(:old.popular, 0);
	pac_Goods_DataLoop.v_Gbcnt_old(pac_Goods_DataLoop.g_index) := NVL(:old.gbcnt, 0);
	pac_Goods_DataLoop.v_Ca_code_old(pac_Goods_DataLoop.g_index) := NVL(:old.ca_code, '');
	pac_Goods_DataLoop.v_Modelnogroup_old(pac_Goods_DataLoop.g_index) := NVL(:old.modelno_group, 0);
	pac_Goods_DataLoop.v_Keyword_old(pac_Goods_DataLoop.g_index) := NVL(:old.keyword, '');
	pac_Goods_DataLoop.v_Jobcode_old(pac_Goods_DataLoop.g_index) := NVL(:old.jobcode, '');
	pac_Goods_DataLoop.v_Cateflag_old(pac_Goods_DataLoop.g_index) := NVL(:old.cateflag, '');
	pac_Goods_DataLoop.v_Constrain_old(pac_Goods_DataLoop.g_index) := NVL(:old.constrain, '');
	pac_Goods_DataLoop.v_Rsiflag_old(pac_Goods_DataLoop.g_index) := NVL(:old.rsiflag, '0');
	pac_Goods_DataLoop.v_Refshop_old(pac_Goods_DataLoop.g_index) := NVL(:old.refshop, '0');
	pac_Goods_DataLoop.v_Boxmodelnm_old(pac_Goods_DataLoop.g_index) := NVL(:old.box_modelnm, '');
    pac_Goods_DataLoop.v_Bbs_Num_old(pac_Goods_DataLoop.g_index) := NVL(:old.bbs_num, 0);

END;





ALTER TRIGGER "DBENURI"."ASIS_TRG_ROW_DELGOODS" DISABLE