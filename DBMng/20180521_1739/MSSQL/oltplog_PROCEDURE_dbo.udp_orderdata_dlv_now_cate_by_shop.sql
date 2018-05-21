/* *************************************************************************
 * NAME : dbo.udp_orderdata_dlv_now_cate_by_shop
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-14 16:32:04.623
 *        Modify: 2018-05-14 16:32:04.623
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_orderdata_dlv_now_cate_by_shop
	@sdate smalldatetime
,	@edate smalldatetime
,	@category varchar(12)
,	@shop_code int
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-12-03
	-- 설  명 : 저장시점 쇼핑몰별 체결 데이터
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
	--and od_category like @category + '%'
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




	select shop_vcode,
		count(*) as cnt,
		sum(od_cnt),
		sum(od_price*od_cnt) sum_price,
		(select top 1 shop_name from simpledb.dbo.shoplist ts with (readuncommitted) where ts.shop_vcode = r.shop_vcode) shop_name
	from #result r
	where od_category like @category + '%'
	group by shop_vcode
	order by sum_price desc





