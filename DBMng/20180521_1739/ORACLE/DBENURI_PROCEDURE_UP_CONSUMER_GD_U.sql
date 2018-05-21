/* *************************************************************************
 * NAME : DBENURI.UP_CONSUMER_GD_U
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-15 10:41:14
 *        Modify: 2018-05-17 15:39:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UP_CONSUMER_GD_U" ( in_goods IN goods_type )
is

/******************************************************************************
**  Name: up_consumer_gd_u
**  Desc: Consumer���� ���� �� ���� update ���μ���
**
**  Called by: ȣ�� ���α׷� �Ǵ� ���
**
**  Parameters:
**     Input                         Output
**     ----------                    -----------
**     in_goods: �� �����ͼ�      ��º���: ��������
**
**  Example : ���� ���� (exec up_consumer_gd_u(v1))
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018.05.14   SSH              ���ν��� �ű� ����
*******************************************************************************/

begin

  UPDATE dbenuri.tbl_goods
	   SET NO = in_goods.model_seq
		   , RECOMMEND = in_goods.rcm_cd
		   , MODELNM = in_goods.model_nm
		   , FACTORY = in_goods.mkr_nm
		   , SPEC = in_goods.spec
		   , IMGCHK = in_goods.img_st_cd
		   , CONSTRAIN = in_goods.model_st_cd
		   , FLAG = in_goods.model_cyn
		   , REFID = in_goods.ref_no
		   , JOBCODE = in_goods.wrk_dcd
		   , REFSHOP = in_goods.be_ofr_img_cd
		   , KEYWORD = in_goods.srch_kwd
		   , MANUAL_LINK = in_goods.manl_url
		   , LINKSERVICEFLAG = in_goods.manl_dcd
		   , G_SIZE = in_goods.model_sz
		   , FUNC = in_goods.model_dtl_ds
		   , OPENEXPECTFLAG = in_goods.opn_exp_cd
		   , FACTORY_ETC = in_goods.pkg_mkr_nm
		   , BRAND = in_goods.brnd_nm
		   , FUNC_IMG = in_goods.fnc_img_nm
		   , KEYWORD2 = in_goods.srch_kwd2
		   , WEIGHT = in_goods.gd_wgh
		   , MODELNO_GROUP = in_goods.gr_model_no
		   , IMGCHK2 = in_goods.img_dcd2
		   , IMGCHK3 = in_goods.img_dcd3
		   , MODDATE = CAST(TO_TIMESTAMP(in_goods.chg_dtm, 'YYYY-MM-DD HH24:MI:SS.FF3') AS DATE)
		   , CONDINAME = in_goods.cnd_nm
		   , MODEL_SORT = in_goods.cnd_nm_ord
		   , SPEC_GROUP = in_goods.gr_model_spec
		   , EXT_CONDI_FLAG = UDF_MODEL_EXT_CONDI_FLAG(in_goods.cate_cd, in_goods.cnd_nm, in_goods.model_no)
		   , CA_CODE = in_goods.cate_cd
	 WHERE MODELNO = in_goods.model_no
	     AND  MODDATE <= CAST(TO_TIMESTAMP(in_goods.chg_dtm, 'YYYY-MM-DD HH24:MI:SS.FF3') AS DATE);


	/* UPDATE  tbl_cate_goods */
	UPDATE dbenuri.tbl_cate_goods
		 SET CA_CODE = in_goods.cate_cd
			 , CA_LCODE = SUBSTR(in_goods.cate_cd,1,2)
	 WHERE MODELNO = in_goods.model_no
	   AND CATEFLAG = '0';

  
exception
  when others then
  null;
end;