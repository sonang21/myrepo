/* *************************************************************************
 * NAME : dbo.udp_orderdata_ord_now_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:02:55.87
 *        Modify: 2018-05-15 15:02:55.87
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_orderdata_ord_now_cate
	@sdate smalldatetime
,	@edate smalldatetime
,	@category varchar(12)
,	@shop_code int
,	@device char(1)
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017-06-22
	-- 설  명 : 현시점 체결 데이터
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select modelno, category
	, SUM(total_price) total_price, SUM(amount)  amount, COUNT(*) cnt
	into  #result
	from 
	(
			-- pc 배송 or 체결
			select case when PL_MODELNO>0 then PL_MODELNO else 0 end modelno, 'p' device
			,		case when pl_modelno>0 then '' else left(isnull(nullif(replace(replace(replace(od_category,' ',''), char(10), ''), CHAR(13), ''), ''), '00000000'), len(isnull(@category,0))+2) end as category
			,		(od_price*od_cnt) as total_price
			,		od_cnt amount
			from dbo.tbl_orderdata
			where shop_vcode not in (55, 536, 5910, 4027)
			and od_date>=@sdate and od_date <@edate+1
			and shop_vcode = isnull(@shop_code, shop_vcode)
			and isnull(@device,'p') = 'p'

			union all

			-- pc 체결
			select case when PL_MODELNO>0 then PL_MODELNO else 0 end modelno, 'p' device
			,		case when pl_modelno>0 then '' else  left(isnull(nullif(replace(replace(replace(od_category,' ',''), char(10), ''), CHAR(13), ''), ''), '00000000'), len(isnull(@category,0))+2)  end
			,		(od_price*od_cnt) as total_price
			,		od_cnt 
			from dbo.tbl_orderdata_gmarket_auction
			where od_date>=@sdate and od_date <@edate+1
			and shop_vcode = isnull(@shop_code, shop_vcode)
			and isnull(@device,'p') = 'p'

			union all

			-- 모바일 체결
			select case when PL_MODELNO>0 then PL_MODELNO else 0 end modelno, 'p' device
			,		case when pl_modelno>0 then '' else left(isnull(nullif(replace(replace(replace(od_category,' ',''), char(10), ''), CHAR(13), ''), ''), '00000000'), len(isnull(@category,0))+2)  end
			,		(od_price*od_cnt) as total_price
			,		od_cnt 
			from dbo.tbl_orderdata_ord_mobile
			where od_date>=@sdate and od_date <@edate+1
			and shop_vcode = isnull(@shop_code, shop_vcode)
			and isnull(@device,'m') = 'm'
	) a
	group by modelno, category

	-- ------------------------------
	-- 현시점 분류코드 입력
	-- ------------------------------
	-- 가격상품 현시점 분류코드 입력
	update #result
	set category = left(g_category, len(isnull(@category,0))+2) 
	from #result inner join analstore.dbo.goods on modelno = g_modelno 
	where modelno > 0


	-- 일반상품 현시점 분류코드 입력 - 분류변경 이력 조회
	select old_category, new_category
	into #change_cate
	from tbl_cate_change_history 
	where change_date >= @sdate
	order by change_date asc, len(new_category) desc

	declare @old_category varchar(12)	
	declare @new_category varchar(12)

	declare chg_category_cursor cursor for (
		select old_category, new_category from #change_cate 
	)
	
	open chg_category_cursor
	fetch next from chg_category_cursor into @old_category, @new_category

	while (@@fetch_status=0) begin

		update #result
		set category =  left(@new_category, len(isnull(@category,0))+2) 
		where category like @old_category+'%'
		and  modelno = 0

		fetch next from chg_category_cursor into @old_category, @new_category

	end

	close chg_category_cursor
	deallocate chg_category_cursor

	-- 분류코드 예외 처리 // 공백도 00 분류처리
	update #result
	set category = 	left(isnull(nullif(replace(replace(replace(category,' ',''), char(10), ''), CHAR(13), ''), ''), '00000000'), len(isnull(@category,0))+2)

	-- 최종 결과
	select @sdate, @edate, isnull(b.cate_full_name, a.category) as cate_full_name, a.category, a.total_price, a.amount, a.cnt
	from 
	(
		select category	, sum(total_price) total_price, sum(amount)  amount, count(*) cnt
		from #result 
		where category like @category + '%'
		group by category
	) a left outer join simpledb.dbo.cate2 b on a.category = b.ca_code
	order by category



