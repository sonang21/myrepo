/* *************************************************************************
 * NAME : dbo.udp_orderdata_dlv_now_cate_by_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 13:56:57.153
 *        Modify: 2018-05-14 13:56:57.153
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_orderdata_dlv_now_cate_by_cate
	@sdate smalldatetime
,	@edate smalldatetime
,	@category varchar(12)
,	@shop_code int
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-12-03
	-- 설  명 : 현시점 체결 데이터
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select cast(od_tid as bigint) od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
	od_price,od_cnt,pl_no,pl_modelno,od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
	into #result
	from dbo.tbl_orderdata with (readuncommitted) 
	where od_date>=@sdate and od_date <@edate+1
	and shop_vcode = isnull(@shop_code, shop_vcode)


	update #result
	set od_category = g_category
	from #result inner join analstore.dbo.goods on pl_modelno = g_modelno

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
		set od_category = @new_category
		where od_category like @old_category+'%'

		fetch next from chg_category_cursor into @old_category, @new_category

	end

	close chg_category_cursor
	deallocate chg_category_cursor


	select left(od_category,  len(@category)+2) as cate,
		count(*) as cnt,
		sum(od_cnt),
		sum(od_price*od_cnt) sum_price
	from #result
	where od_category like @category + '%'
	group by left(od_category,  len(@category)+2)
	order by sum_price desc





