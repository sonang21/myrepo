/* *************************************************************************
 * NAME : dbo.UDP_JCA_DUPLE_GOODS_REF
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-08-31 15:14:57.29
 *        Modify: 2017-01-11 15:51:45.967
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_jca_duple_goods_ref
	@category varchar(4)
as
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2009.08.31
	-- 설  명 : jca 상세문의 중복 리스트
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- 수정일:		수정자:		수정내용:
	-- ----------------------------------------------------------------------------------
	-- 2012.11.29	wookki25	처리 : 유사상품 제외처리 조건 추가 g_constrain not in ('5')
	--                          사유 : 권현영 요청
	-- ----------------------------------------------------------------------------------
	set nocount on;
	set transaction isolation level  read uncommitted;


	with cte_duple_ref(g_category, g_factory, g_refid, g_cnt, g_brand) as 
	(
		select	left(g_category,4) as g_category, g_factory, g_refid, count(*) as cnt, g_brand
		from	goods
		where	g_category like @category+'%'
		and		g_jobcode <> '0'
		and		g_mallcnt > 0
		and		g_constrain not in ('5')
		group by left(g_category,4), g_factory, g_refid, g_brand
	)
	select	a.g_category, a.g_factory, a.g_refid, a.g_cnt, gref_telnm, gref_tel, gref_url1nm, gref_url1, gref_url2nm, gref_url2, a.g_brand
	from	cte_duple_ref a 
				inner join 
			(select g_category, g_factory, g_brand from cte_duple_ref group by g_category, g_factory, g_brand having count(*) > 1) as b 
				on a.g_category = b.g_category and a.g_factory = b.g_factory and a.g_brand = b.g_brand
				left outer join
			goods_reference c 
				on a.g_refid = c.gref_no
	order by a.g_category, a.g_factory, a.g_refid
