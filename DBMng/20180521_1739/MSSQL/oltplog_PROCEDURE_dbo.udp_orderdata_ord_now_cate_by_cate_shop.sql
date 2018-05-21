/* *************************************************************************
 * NAME : dbo.udp_orderdata_ord_now_cate_by_cate_shop
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:04:48.063
 *        Modify: 2018-05-15 15:04:48.063
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_orderdata_ord_now_cate_by_cate_shop
	@sdate smalldatetime
,	@edate smalldatetime
,	@category varchar(12)
,	@shop_code int
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2014-12-03
	-- ��  �� : ������ ü�� ������
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/*
	������:			������:			��������:
	-------------------------------------------------
	*/
	select cast(od_tid as bigint) od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
	od_price,od_cnt,pl_no,pl_modelno,od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
	into #result
	from dbo.tbl_orderdata with (readuncommitted) 
	where shop_vcode not in (55, 536, 5910, 4027)
	and od_date>=@sdate and od_date <@edate+1
	and shop_vcode = isnull(@shop_code, shop_vcode)


	insert into #result
	select cast(od_tid as bigint) od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
	od_price,od_cnt,pl_no,pl_modelno,od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
	from dbo.tbl_orderdata_gmarket_auction with (readuncommitted)
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
		sum(od_price*od_cnt) sum_price,
		shop_vcode, 
		(select top 1 shop_name from simpledb.dbo.shoplist ts with (readuncommitted) where ts.shop_vcode = r.shop_vcode) shop_name
	from #result r
	where od_category like @category + '%'
	group by left(od_category,  len(@category)+2), shop_vcode
	order by sum_price desc





