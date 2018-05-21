/* *************************************************************************
 * NAME : dbo.udp_get_eloc_pricelist
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-05-25 17:34:58.223
 *        Modify: 2018-05-03 17:23:34.16
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_get_eloc_pricelist
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2016.05.25
	-- 설  명 : 가중치 적용할 pl_no 추출
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	*/

	-- 일반상품 인기도
	select pl_no, mpa_po_point as point
	into #tmp_pricelist_popular
	from openquery(oltplog_196, ' select pl_no, mpa_po_point from oltplog.dbo.tbl_mx_popular_acc where mpa_date = cast(cast(getdate()-1 as date) as smalldatetime)')

	-- 일반상품 인기도 적용 중분류
	select cate as category 
	into #tmp_pricelist_popular_cate
	from openquery(oltplog_196, ' select cate from oltplog.dbo.tbl_pricelist_popset where use_yn = ''y'' ')


	alter table #tmp_pricelist_popular add is_srv bit null
	alter table #tmp_pricelist_popular add category char(4)
	alter table #tmp_pricelist_popular add goodsnm nvarchar(200)

	create clustered index tmp_pricelist_popular_plno on #tmp_pricelist_popular(pl_no)
	create nonclustered index tmp_pricelist_popular_is_srv on #tmp_pricelist_popular(is_srv)

	-- 서비스상태, 매핑여부, 분류정보 입히기
	update top (1000) a
	set is_srv = isnull(sign(b.pl_no),0)
	,	category = left(pl_category,4)
	,	goodsnm = pl_goodsnm
	from #tmp_pricelist_popular a 
	left outer join pricelist b on a.pl_no = b.pl_no and pl_status in ('0', '8','9') and pl_srvflag in ('0', 'L', 'R', 'M') and pl_modelno <=0  and pl_category like '____%'
	where is_srv is null

	while @@rowcount > 0 begin
		update top (1000) a
		set is_srv = isnull(sign(b.pl_no),0)
		,	category = left(pl_category,4)
		,	goodsnm = pl_goodsnm
		from #tmp_pricelist_popular a 
		left outer join pricelist b on a.pl_no = b.pl_no and pl_status in ('0', '8','9') and pl_srvflag in ('0', 'L', 'R', 'M') and pl_modelno <=0  and pl_category like '____%'
		where is_srv is null
	end


	-- 인기순 50개
	-- drop table #tmp_pricelist_popular_result
	select pl_no, category, goodsnm, point
	into #tmp_pricelist_popular_result
	from 
	(
		select pl_no, goodsnm, a.category, point, row_number ()  over (partition by a.category order by a.point desc) rownum 
		from #tmp_pricelist_popular a inner join #tmp_pricelist_popular_cate b on a.category = b.category
	) a
	where rownum<= 50


	-- 최근순 50개
	declare @cate varchar(4)
	declare category_cursor cursor for select category from #tmp_pricelist_popular_cate
	open category_cursor

	fetch next from category_cursor into @cate
	while @@fetch_status = 0 begin

		insert into #tmp_pricelist_popular_result(pl_no, category, goodsnm, point)		
		select a.pl_no, a.category, a.pl_goodsnm, isnull(b.point,0)
		from
		(
			select top 50 pl_no, @cate category, pl_goodsnm
			from pricelist 
			where pl_category like @cate+'%'
			order by pl_no desc
		) a left outer join #tmp_pricelist_popular b on a.pl_no = b.pl_no

		fetch next from category_cursor into @cate	
	end

	close category_cursor
	deallocate category_cursor

	insert openquery (oltplog_196, 'select cate, pl_no, goodsnm, popular, reg_date from oltplog.dbo.tbl_pricelist_topn') 
	select max(category) category, pl_no, max(goodsnm), max(point), getdate() from #tmp_pricelist_popular_result group by pl_no
