/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_daily_enuri_sliding_limit
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-05-18 10:41:34.3
 *        Modify: 2018-05-03 17:23:35.203
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_jca_ap_report_ord_list_daily_enuri_sliding_limit
	@sdate datetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-05-18
	-- 설  명 : 에누리 매출 수수료 슬라이딩 제한금액
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	/*
	지마켓 예외처리 2012.05.17 정재웅
	정산 기간이 전월 26일 ~ 당월 25일 이라서.
	정산 기간의 예상수수료로 계산.
	*/
	-- gshop(75), cjmall(806) 예외처리 2012.07.10
	-- gmarket 2013.03.01부터 정산일 1일~말일로 변경 적용. 정재웅 요청
	declare @sdate_ex datetime
	set @sdate_ex = dateadd(d, 25, dateadd(m, -1, @sdate)) -- 전월 26일

	create table #tmp_ex_shop_sales(shop_vcode int, ex_sales money)
	if @sdate <= cast('2013-02-28' as datetime) begin
		-- 해당월의 슬라이딩 금액에서 정산일이 전월말부터 시작이기때문에 
		-- 마이너스 처리해야하는 매출액을 구한다.
		insert #tmp_ex_shop_sales
		select shop_vcode, sum(sales) as ex_sales
		from tbl_ap_sales 		
		where	sale_date >=@sdate_ex
		and		sale_date < @sdate
		and		shop_vcode in (1733, 536, 75, 806) 
		group by shop_vcode

	end else begin
		insert #tmp_ex_shop_sales
		select shop_vcode, sum(sales) as ex_sales
		from tbl_ap_sales 		
		where	sale_date >=@sdate_ex
		and		sale_date < @sdate
		and		shop_vcode in (75, 806) 
		group by shop_vcode
	end

	select case when a.shop_vcode = 1733 then 'G마켓(순)' else a.shop_name end shop_name, a.sum_limit - isnull(b.ex_sales, 0), b.ex_sales
	from
	(
		--  해당월 슬라이딩 금액 가져오기
		select d.shop_name, d.shop_vcode, sum_limit 
		from tbl_ap_sales_fee_rate_sliding c inner join shoplist d on c.shop_vcode = d.shop_vcode
		where @sdate between s_date and e_date
	) a 
		left outer join 
	(

		-- 정산일이 매월 1일 이전(=전월 하반기)인 경우 
		-- 정산일~1일까지 매출액을 가져온다.
		select * from #tmp_ex_shop_sales
	) b
		on a.shop_vcode = b.shop_vcode


