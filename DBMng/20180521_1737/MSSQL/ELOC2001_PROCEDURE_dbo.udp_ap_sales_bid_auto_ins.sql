/* *************************************************************************
 * NAME : dbo.udp_ap_sales_bid_auto_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-21 16:55:09.07
 *        Modify: 2018-05-03 17:23:36.023
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_ap_sales_bid_auto_ins
	@sdate datetime
as
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-08-21
	-- 설  명 : tbl_ap_sales_bid 데이터 자동입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	delete from tbl_ap_sales_bid where sale_date = @sdate

	declare @sql nvarchar(4000)
	set @sql =  '
	insert into tbl_ap_sales_bid(data_opt, sales, sale_cnt, exp_cnt, hit_cnt, sale_date)
	select *
	from openquery(oradb, ''
		select
		case
							when SUBSTR(CA_CODE, 0,2) = ''''04'''' then ''''1''''
							when SUBSTR(CA_CODE, 0,2) = ''''07'''' then ''''2''''
							when SUBSTR(CA_CODE, 0,2) = ''''05'''' then ''''3''''
							when SUBSTR(CA_CODE, 0,2) = ''''06'''' then ''''4''''
							when SUBSTR(CA_CODE, 0,2) = ''''03'''' then ''''5''''
				  when SUBSTR(CA_CODE, 0,2) = ''''02'''' then ''''6''''
							else ''''7''''
							end   as ca_code
		,	sum(bid_possess_money)
		, count(DISTINCT MODELNO)
		, NVL(SUM(bid_valid_view),0) sum_bid_valid_view
		, NVL(SUM(bid_valid_click),0) sum_bid_valid_click
		, to_date(max(bid_date), ''''yyyy-mm-dd'''') as yyyymmdd
		FROM TBL_BID_DAILY
		WHERE 	BID_DATE = '''''+convert(nchar(8), @sdate, 112)+'''''
		group by
		case
							when SUBSTR(CA_CODE, 0,2) = ''''04'''' then ''''1''''
							when SUBSTR(CA_CODE, 0,2) = ''''07'''' then ''''2''''
							when SUBSTR(CA_CODE, 0,2) = ''''05'''' then ''''3''''
							when SUBSTR(CA_CODE, 0,2) = ''''06'''' then ''''4''''
							when SUBSTR(CA_CODE, 0,2) = ''''03'''' then ''''5''''
				  when SUBSTR(CA_CODE, 0,2) = ''''02'''' then ''''6''''
							else ''''7''''
							end
		order by ca_code
	'')'

	exec sp_executesql @sql
