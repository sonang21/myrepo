/* *************************************************************************
 * NAME : dbo.upd_jca_shop_cate_search
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-09-20 17:18:30.803
 *        Modify: 2018-05-03 17:23:34.313
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC upd_jca_shop_cate_search
	@cate	varchar(4)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-09-20
	-- 설  명 : 중소형몰 카테고리별 검색
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	select shop_name, shop_vcode
	,	case when len(@cate)=4 then (
			select count(*) 
			from pricelist 
			where pl_vcode=shop_vcode and pl_modelno = 0 and pl_status not in ('3','4','5')
			and (pl_category like @cate+'%' or pl_category = Left(@cate,2))
		)
		else 
		0
		/*
		(
			select count(*) 
			from pricelist 
			where pl_vcode=shop_vcode and pl_modelno = 0 and pl_status not in ('3','4','5')
			and (pl_category like @cate+'%')
		)
		*/
		end as modelcnt,
		shop_datasource, 
		isNull(shop_comment, '') shop_comment		
	from	shoplist a 
				inner join 
			(
			select distinct nbc_vcode as vcode from nuribotdb.dbo.tbl_nb_category where nbc_category like @cate+'%'
			union
			select distinct vcode as vcode from nuribotdb.dbo.tbl_nb_shopcate where category like @cate+'%'
			) b
				on a.shop_vcode = b.vcode
	where shop_service = '0' and shop_apflag <> '1'
	order by shop_name
