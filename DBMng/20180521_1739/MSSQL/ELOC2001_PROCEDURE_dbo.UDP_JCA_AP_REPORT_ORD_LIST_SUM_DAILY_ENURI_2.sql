/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI_2
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-01-31 13:56:03.997
 *        Modify: 2018-05-03 17:23:34.26
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI_2]
	@YEAR	SMALLINT
,	@MONTH	SMALLINT
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.11
	-- 설  명 : AP 일별 주문액 리스트 합계
	-- 실  행 : UDP_JCA_AP_REPORT_ORD_LIST_SUM_DAILY_ENURI 2008, 3
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	*/
	select	(CASE WHEN h.NUM = 1 THEN '합계' ELSE '합계(순)' END) AS SHOP_NAME,
			sum(sum_sales), sum(sum_sales)/max(avg_cnt) as avg_sales, cast(sum(pre_fee) as int),
			sum(day1),sum(day2),sum(day3),sum(day4),sum(day5),
			sum(day6),sum(day7),sum(day8),sum(day9),sum(day10),
			sum(day11),sum(day12),sum(day13),sum(day14),sum(day15),
			sum(day16),sum(day17),sum(day18),sum(day19),sum(day20),
			sum(day21),sum(day22),sum(day23),sum(day24),sum(day25),
			sum(day26),sum(day27),sum(day28),sum(day29),sum(day30),
			sum(day31)
	from
	(
			select e.*, f.num
			from
			(
				select	shop_vcode
				,		sum(sales) sum_sales
				,		count(*) avg_cnt
				,		sum(pre_fee) as pre_fee
				,		sum(case when day(sale_date) = 1 then sales end) as day1
				,		sum(case when day(sale_date) = 2 then sales end) as day2
				,		sum(case when day(sale_date) = 3 then sales end) as day3
				,		sum(case when day(sale_date) = 4 then sales end) as day4
				,		sum(case when day(sale_date) = 5 then sales end) as day5
				,		sum(case when day(sale_date) = 6 then sales end) as day6
				,		sum(case when day(sale_date) = 7 then sales end) as day7
				,		sum(case when day(sale_date) = 8 then sales end) as day8
				,		sum(case when day(sale_date) = 9 then sales end) as day9
				,		sum(case when day(sale_date) = 10 then sales end) as day10
				,		sum(case when day(sale_date) = 11 then sales end) as day11
				,		sum(case when day(sale_date) = 12 then sales end) as day12
				,		sum(case when day(sale_date) = 13 then sales end) as day13
				,		sum(case when day(sale_date) = 14 then sales end) as day14
				,		sum(case when day(sale_date) = 15 then sales end) as day15
				,		sum(case when day(sale_date) = 16 then sales end) as day16
				,		sum(case when day(sale_date) = 17 then sales end) as day17
				,		sum(case when day(sale_date) = 18 then sales end) as day18
				,		sum(case when day(sale_date) = 19 then sales end) as day19
				,		sum(case when day(sale_date) = 20 then sales end) as day20
				,		sum(case when day(sale_date) = 21 then sales end) as day21
				,		sum(case when day(sale_date) = 22 then sales end) as day22
				,		sum(case when day(sale_date) = 23 then sales end) as day23
				,		sum(case when day(sale_date) = 24 then sales end) as day24
				,		sum(case when day(sale_date) = 25 then sales end) as day25
				,		sum(case when day(sale_date) = 26 then sales end) as day26
				,		sum(case when day(sale_date) = 27 then sales end) as day27
				,		sum(case when day(sale_date) = 28 then sales end) as day28
				,		sum(case when day(sale_date) = 29 then sales end) as day29
				,		sum(case when day(sale_date) = 30 then sales end) as day30
				,		sum(case when day(sale_date) = 31 then sales end) as day31
				from
				(
					select a.*, isnull(isnull(c.rate, b.rate), 0.02/1.1)*sales as pre_fee from
					(
						select	*
						from	tbl_ap_sales
						where	sale_date >=cast(cast(@year as varchar(4))+'-'+cast(@MONTH as varchar(2))+'-01' as datetime)
						and		sale_date<dateadd(mm, 1, cast(cast(@year as varchar(4))+'-'+cast(@MONTH as varchar(2))+'-01' as datetime))
						--and		shop_vcode in (49,47,55,57,75,90,536,663,806,1289,1675,1878,3539,4027,5893,5217,974,5610,5910,1733,1719,6052,6588)
						and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop)
					) a
					left outer join tbl_ap_sales_fee_rate_default b on a.shop_vcode=b.shop_vcode and a.sale_date between s_date and e_date
					left outer join tbl_ap_sales_fee_rate_promotion c on a.shop_vcode = c.shop_vcode and a.sale_date = promotion_date
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
		HAVING SUM(sum_sales) IS NOT NULL
		ORDER BY h.NUM

