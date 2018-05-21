/* *************************************************************************
 * NAME : dbo.udp_popular_weight_modelno_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:09:12.503
 *        Modify: 2018-05-15 15:09:12.503
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_popular_weight_modelno_sel
	@category varchar(12) = ''
as
	set nocount on	
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.26
	-- 설  명 : 인기도 모델번호별 가중치 리스트
	-- 실  행 : exec udp_popular_weight_modelno_sel
	-- ----------------------------------------------------------------------------------
	select 	a.g_modelno,
			g_modelnm,
			p_weight,
			use_flag,
			mod_date,
			left(g_category,4) as mcate
	,		g_mallcnt
	,		a.memo
	,		g_factory
	,		g_brand
	from	goods_popular_weight_modelno a
				left outer join
			analstore.dbo.goods b
				on a.g_modelno = b.g_modelno
                left outer join 
            analstore.dbo.goods_sum c
                on a.g_modelno = c.g_modelno
	where	b.g_category like @category+'%'
	order by g_modelnm asc

