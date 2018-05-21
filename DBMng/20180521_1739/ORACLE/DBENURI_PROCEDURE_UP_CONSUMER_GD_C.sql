/* *************************************************************************
 * NAME : DBENURI.UP_CONSUMER_GD_C
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-15 10:38:01
 *        Modify: 2018-05-17 15:37:37
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UP_CONSUMER_GD_C" ( in_goods IN goods_type )
is

/******************************************************************************
**  Name: up_consumer_gd_c
**  Desc: Consumer에서 신규 모델 정보 반영 시 연관 테이블에 데이터 생성 프로세스
**
**  Called by: 호출 프로그램 또는 모듈
**
**  Parameters:
**     Input                         Output
**     ----------                    -----------
**     in_goods: 모델 데이터셋      출력변수: 변수설명
**
**  Example : 실행 예시 (exec up_consumer_gd_c(v1))
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018.05.14   SSH              프로시져 신규 생성
*******************************************************************************/

begin

  DELETE
    FROM dbenuri.tbl_goods
   WHERE MODELNO = in_goods.model_no;

  INSERT INTO dbenuri.tbl_goods
         ( MODELNO
         , NO
         , RECOMMEND
         , MODELNM
         , FACTORY
         , SPEC
         , C_DATE
         , IMGCHK
         , CONSTRAIN
         , FLAG
         , REFID
         , JOBCODE
         , REFSHOP
         , KEYWORD
         , MANUAL_LINK
         , LINKSERVICEFLAG
         , G_SIZE
         , FUNC
         , OPENEXPECTFLAG
         , FACTORY_ETC
         , BRAND
         , FUNC_IMG
         , KEYWORD2
         , MODELNO_GROUP
         , IMGCHK2
         , IMGCHK3
         , MODDATE
         , CONDINAME
         , MODEL_SORT
         , SPEC_GROUP
         , EXT_CONDI_FLAG
         , CA_CODE )
  VALUES
         ( in_goods.model_no
         , in_goods.model_seq
         , in_goods.rcm_cd
         , in_goods.model_nm
         , in_goods.mkr_nm
         , in_goods.spec
         , CAST(TO_TIMESTAMP(in_goods.reg_dtm, 'YYYY-MM-DD HH24:MI:SS.FF3') AS DATE)
         , in_goods.img_st_cd
         , in_goods.model_st_cd
         , in_goods.model_cyn
         , in_goods.ref_no
         , in_goods.wrk_dcd
         , in_goods.be_ofr_img_cd
         , in_goods.srch_kwd
         , in_goods.manl_url
         , in_goods.manl_dcd
         , in_goods.model_sz
         , in_goods.model_dtl_ds
         , in_goods.opn_exp_cd
         , in_goods.pkg_mkr_nm
         , in_goods.brnd_nm
         , in_goods.fnc_img_nm
         , in_goods.srch_kwd2
         , in_goods.gr_model_no
         , in_goods.img_dcd2
         , in_goods.img_dcd3
         , CAST(TO_TIMESTAMP(in_goods.chg_dtm, 'YYYY-MM-DD HH24:MI:SS.FF3') AS DATE)
         , in_goods.cnd_nm
         , in_goods.cnd_nm_ord
         , in_goods.gr_model_spec
         , UDF_MODEL_EXT_CONDI_FLAG(in_goods.cate_cd, in_goods.cnd_nm, in_goods.model_no)
         , in_goods.cate_cd );

  DELETE
    FROM dbenuri.tbl_goods_sum
   WHERE MODELNO = in_goods.model_no;

  INSERT INTO dbenuri.tbl_goods_sum
         ( MODELNO
         , MINPRICE
         , AVGPRICE
         , MAXPRICE
         , POPULAR
         , SUM_POPULAR
         , KB_NUM
         , MALLCNT
         , SALE_CNT
         , SUM_SALE_CNT
         , SOCIALPRICE
         , MINPRICE2
         , MINPRICE3
         , MINPRICE4
         , MALLCNT3
         , BBS_NUM
         , BBS_POINT
         , BBS_POINT_AVG
         , MODDATE )
  VALUES
         ( in_goods.model_no
          , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
         , 0
          , CAST(TO_TIMESTAMP(in_goods.chg_dtm, 'YYYY-MM-DD HH24:MI:SS.FF3') AS DATE) );

  DELETE
    FROM dbenuri.tbl_cate_goods
   WHERE MODELNO = in_goods.model_no;

  INSERT INTO dbenuri.tbl_cate_goods
         ( MODELNO
         , CA_CODE
         , CA_LCODE
         , CATEFLAG)
  VALUES
         ( in_goods.model_no
         , in_goods.cate_cd
         , '0'
         , SUBSTR(in_goods.cate_cd,1,2));

exception
  when others then
  null;
end;