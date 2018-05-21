/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_daily_enuri_pre_sales_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-14 11:21:35.157
 *        Modify: 2018-05-03 17:23:35.13
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_daily_enuri_pre_sales_v3]
	@YEAR	SMALLINT
,	@MONTH	SMALLINT
,	@sale_flag char(1)
as
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2011.02.08
	-- 설  명 : 월예상 합계액 : 계산일 기준 이전 28일(=4주)의 평균 * 날짜
	-- 실  행 : UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI 2008, 3
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/

	declare @sdate datetime
	declare @max_date datetime
	set @sdate = cast(@year as varchar(4)) +'-'+ cast(@month as varchar(2)) + '-01'

	select @max_date = max(sale_date) from tbl_ap_sales where sale_date>=@sdate and sale_date < dateadd(m, 1, @sdate) and sale_flag = @sale_flag


	select	(CASE WHEN h.NUM = 1 THEN '예상합계' ELSE '예상합계(순)' END) AS SHOP_NAME,
			(sum(sum_sales)/28)* datediff(d, @sdate, dateadd(m, 1, @sdate))
	from
	(
			select e.*, f.num
			from
			(
				select	shop_vcode
				,		sum(sales) as sum_sales
				from
				(
					select	*
					from	tbl_ap_sales
					where	sale_date >=dateadd(d, -27, @max_date)
					and		sale_date < @max_date +1
					--and		shop_vcode in (49,47,55,57,75,90,536,663,806,1289,1675,1878,3539,4027,5893,5217,974,5610,5910,1733,1719,6052,6547,6361,374,6588,6508, 6620)
					and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
					and		sale_flag = @sale_flag
				) d
				group by shop_vcode
			) e
				cross join
			(SELECT 1 AS NUM UNION ALL SELECT 2) f

		) h
		where shop_vcode NOT IN
			(
				CASE WHEN h.NUM = 1 THEN 5893 ELSE 4027 END,
				CASE WHEN h.NUM = 1 THEN 1733 ELSE 536 END,
				CASE WHEN h.NUM = 1 THEN 1719 ELSE 55 END,
				CASE WHEN h.NUM = 1 THEN 6052 ELSE 5910 END
			)
		GROUP BY h.NUM
		ORDER BY h.NUM
