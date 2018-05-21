/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_ord_list_weekly_enuri_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-11 18:09:56.78
 *        Modify: 2018-05-03 17:23:34.81
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_jca_ap_report_ord_list_weekly_enuri_v3]
	@year smallint
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.03.28
	-- 설  명 : ap 주별 주문액 리스트
	-- 실  행 : udp_jca_ap_report_ord_list_weekly_enuri 2008
	-- ----------------------------------------------------------------------------------

	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------
	2009.04.02		wookki25		select datepart(ww, getdate()) 추가
									요청: 정재웅 // 그래프에 전주까지만 보여줘라~
	*/
	select	shop_vcode,
			datepart(ww, sale_date) as weekofyear,
			sum(sales) as sum_sales
	into	#tbl_groupby_weekofyear_2
	from	tbl_ap_sales
	where	sale_date >=cast(cast(@year as varchar(4))+'-01-01' as datetime)
	and		sale_date<dateadd(yy, 1, cast(cast(@year as varchar(4))+'-01-01' as datetime))
	and		shop_vcode in (select shop_vcode from tbl_ap_sales_shop) --,5610,1289
	--and		shop_vcode in (1733,5893,49,47,55,57,75,90,536,663,806,1878,3539,4027,5217,974,5910,6052,1719,6547,6361,374,6588, 6508, 6620) --,5610,1289
	and		sale_flag = @sale_flag
	group by shop_vcode, datepart(ww, sale_date)
	having sum(sales) is not null


	IF @YEAR = 2010 -- 2010년 1주차 데이터가 이틀치라서 제외처리한다.
		delete from #TBL_GROUPBY_WEEKOFYEAR_2 where weekofyear = 1

	If @year = year(getdate()) -- 금년을 확인하는 경우, 금주 제외처리
		delete from #TBL_GROUPBY_WEEKOFYEAR_2 where weekofyear > datepart(ww, getdate())-1


	select	shop_vcode,
			sum(case when weekofyear = 1 then sum_sales end) as	weekofyear1,
			sum(case when weekofyear = 2 then sum_sales end) as	weekofyear2,
			sum(case when weekofyear = 3 then sum_sales end) as	weekofyear3,
			sum(case when weekofyear = 4 then sum_sales end) as	weekofyear4,
			sum(case when weekofyear = 5 then sum_sales end) as	weekofyear5,
			sum(case when weekofyear = 6 then sum_sales end) as	weekofyear6,
			sum(case when weekofyear = 7 then sum_sales end) as	weekofyear7,
			sum(case when weekofyear = 8 then sum_sales end) as	weekofyear8,
			sum(case when weekofyear = 9 then sum_sales end) as	weekofyear9,
			sum(case when weekofyear = 10 then sum_sales end) as	weekofyear10,
			sum(case when weekofyear = 11 then sum_sales end) as	weekofyear11,
			sum(case when weekofyear = 12 then sum_sales end) as	weekofyear12,
			sum(case when weekofyear = 13 then sum_sales end) as	weekofyear13,
			sum(case when weekofyear = 14 then sum_sales end) as	weekofyear14,
			sum(case when weekofyear = 15 then sum_sales end) as	weekofyear15,
			sum(case when weekofyear = 16 then sum_sales end) as	weekofyear16,
			sum(case when weekofyear = 17 then sum_sales end) as	weekofyear17,
			sum(case when weekofyear = 18 then sum_sales end) as	weekofyear18,
			sum(case when weekofyear = 19 then sum_sales end) as	weekofyear19,
			sum(case when weekofyear = 20 then sum_sales end) as	weekofyear20,
			sum(case when weekofyear = 21 then sum_sales end) as	weekofyear21,
			sum(case when weekofyear = 22 then sum_sales end) as	weekofyear22,
			sum(case when weekofyear = 23 then sum_sales end) as	weekofyear23,
			sum(case when weekofyear = 24 then sum_sales end) as	weekofyear24,
			sum(case when weekofyear = 25 then sum_sales end) as	weekofyear25,
			sum(case when weekofyear = 26 then sum_sales end) as	weekofyear26,
			sum(case when weekofyear = 27 then sum_sales end) as	weekofyear27,
			sum(case when weekofyear = 28 then sum_sales end) as	weekofyear28,
			sum(case when weekofyear = 29 then sum_sales end) as	weekofyear29,
			sum(case when weekofyear = 30 then sum_sales end) as	weekofyear30,
			sum(case when weekofyear = 31 then sum_sales end) as	weekofyear31,
			sum(case when weekofyear = 32 then sum_sales end) as	weekofyear32,
			sum(case when weekofyear = 33 then sum_sales end) as	weekofyear33,
			sum(case when weekofyear = 34 then sum_sales end) as	weekofyear34,
			sum(case when weekofyear = 35 then sum_sales end) as	weekofyear35,
			sum(case when weekofyear = 36 then sum_sales end) as	weekofyear36,
			sum(case when weekofyear = 37 then sum_sales end) as	weekofyear37,
			sum(case when weekofyear = 38 then sum_sales end) as	weekofyear38,
			sum(case when weekofyear = 39 then sum_sales end) as	weekofyear39,
			sum(case when weekofyear = 40 then sum_sales end) as	weekofyear40,
			sum(case when weekofyear = 41 then sum_sales end) as	weekofyear41,
			sum(case when weekofyear = 42 then sum_sales end) as	weekofyear42,
			sum(case when weekofyear = 43 then sum_sales end) as	weekofyear43,
			sum(case when weekofyear = 44 then sum_sales end) as	weekofyear44,
			sum(case when weekofyear = 45 then sum_sales end) as	weekofyear45,
			sum(case when weekofyear = 46 then sum_sales end) as	weekofyear46,
			sum(case when weekofyear = 47 then sum_sales end) as	weekofyear47,
			sum(case when weekofyear = 48 then sum_sales end) as	weekofyear48,
			sum(case when weekofyear = 49 then sum_sales end) as	weekofyear49,
			sum(case when weekofyear = 50 then sum_sales end) as	weekofyear50,
			sum(case when weekofyear = 51 then sum_sales end) as	weekofyear51,
			sum(case when weekofyear = 52 then sum_sales end) as	weekofyear52,
			sum(case when weekofyear = 53 then sum_sales end) as	weekofyear53,
			sum(sum_sales) as week_sum,
			avg(sum_sales) as week_avg,
			count(*) as week_cnt
	into #tbl_groupby_weekofyear
	from #tbl_groupby_weekofyear_2
	group by shop_vcode


	-- 리스트
	select
		case b.shop_vcode
			when 1733 then 'G마켓(순)'
			when 5893 then '옥션(순)'
			when 1719 then '인터파크(순)'
			when 6052 then '11번가(순)'
			else a.shop_name
		end as shop_name,
		weekofyear1,weekofyear2,weekofyear3,weekofyear4,weekofyear5,
		weekofyear6,weekofyear7,weekofyear8,weekofyear9,weekofyear10,
		weekofyear11,weekofyear12,weekofyear13,weekofyear14,weekofyear15
		,weekofyear16,weekofyear17,weekofyear18,weekofyear19,weekofyear20,
		weekofyear21,weekofyear22,weekofyear23,weekofyear24,weekofyear25,
		weekofyear26,weekofyear27,weekofyear28,weekofyear29,weekofyear30,
		weekofyear31,weekofyear32,weekofyear33,weekofyear34,weekofyear35,
		weekofyear36,weekofyear37,weekofyear38,weekofyear39,weekofyear40,
		weekofyear41,weekofyear42,weekofyear43,weekofyear44,weekofyear45,
		weekofyear46,weekofyear47,weekofyear48,weekofyear49,weekofyear50,
		weekofyear51,weekofyear52,weekofyear53,
		week_sum, week_avg
		, a.display_order
	from	( select a.shop_name, a.shop_vcode, isnull(b.display_order, 99)  display_order from shoplist a left outer join tbl_ap_sales_shop b on a.shop_vcode = b.shop_vcode) a
				inner join
			(
			select c.*, isnull(d.as_week_sum_order,c.week_sum) as as_week_sum_order
			from	#tbl_groupby_weekofyear c
						left outer join
					(
					select
						case shop_vcode
						when 536 then 1733
						when 4027 then 5893
						when 5910 then 6052
						when 55 then 1719
						end as shop_vcode, week_sum as as_week_sum_order
					from	#tbl_groupby_weekofyear
					where	shop_vcode in (536, 4027, 55, 5910)
					) d
						on c.shop_vcode = d.shop_vcode
			) b
				on a.shop_vcode = b.shop_vcode
	order by a.display_order, b.as_week_sum_order desc, b.shop_vcode asc





	select	(case when num = 1 then '합계' else '합계(순)' end) as shop_name,
		sum(weekofyear1	)	as 	weekofyear1	,sum(weekofyear2)	as 	weekofyear2	,
		sum(weekofyear3	)	as 	weekofyear3	,sum(weekofyear4)	as 	weekofyear4	,
		sum(weekofyear5	)	as 	weekofyear5	,sum(weekofyear6)	as 	weekofyear6	,
		sum(weekofyear7	)	as 	weekofyear7	,sum(weekofyear8)	as 	weekofyear8	,
		sum(weekofyear9	)	as 	weekofyear9	,sum(weekofyear10)	as 	weekofyear10,
		sum(weekofyear11)	as 	weekofyear11,sum(weekofyear12)	as 	weekofyear12,
		sum(weekofyear13)	as 	weekofyear13,sum(weekofyear14)	as 	weekofyear14,
		sum(weekofyear15)	as 	weekofyear15,sum(weekofyear16)	as 	weekofyear16,
		sum(weekofyear17)	as 	weekofyear17,sum(weekofyear18)	as 	weekofyear18,
		sum(weekofyear19)	as 	weekofyear19,sum(weekofyear20)	as 	weekofyear20,
		sum(weekofyear21)	as 	weekofyear21,sum(weekofyear22)	as 	weekofyear22,
		sum(weekofyear23)	as 	weekofyear23,sum(weekofyear24)	as 	weekofyear24,
		sum(weekofyear25)	as 	weekofyear25,sum(weekofyear26)	as 	weekofyear26,
		sum(weekofyear27)	as 	weekofyear27,sum(weekofyear28)	as 	weekofyear28,
		sum(weekofyear29)	as 	weekofyear29,sum(weekofyear30)	as 	weekofyear30,
		sum(weekofyear31)	as 	weekofyear31,sum(weekofyear32)	as 	weekofyear32,
		sum(weekofyear33)	as 	weekofyear33,sum(weekofyear34)	as 	weekofyear34,
		sum(weekofyear35)	as 	weekofyear35,sum(weekofyear36)	as 	weekofyear36,
		sum(weekofyear37)	as 	weekofyear37,sum(weekofyear38)	as 	weekofyear38,
		sum(weekofyear39)	as 	weekofyear39,sum(weekofyear40)	as 	weekofyear40,
		sum(weekofyear41)	as 	weekofyear41,sum(weekofyear42)	as 	weekofyear42,
		sum(weekofyear43)	as 	weekofyear43,sum(weekofyear44)	as 	weekofyear44,
		sum(weekofyear45)	as 	weekofyear45,sum(weekofyear46)	as 	weekofyear46,
		sum(weekofyear47)	as 	weekofyear47,sum(weekofyear48)	as 	weekofyear48,
		sum(weekofyear49)	as 	weekofyear49,sum(weekofyear50)	as 	weekofyear50,
		sum(weekofyear51)	as 	weekofyear51,sum(weekofyear52)	as 	weekofyear52,
		sum(weekofyear53)	as 	weekofyear53,
		sum(week_sum)		as week_sum, sum(week_sum)/max(week_cnt) as week_avg
	from
	(
		select copy_t.num, c.*
		from
				#tbl_groupby_weekofyear c
				cross join
				(select 1 as num union select 2) copy_t
		where	c.shop_vcode not in (
				case when copy_t.num = 1 then 5893 else 4027 end,
				case when copy_t.num = 1 then 1733 else 536 end,
				case when copy_t.num = 1 then 6052 else 5910 end,
				case when copy_t.num = 1 then 1719 else 55 end
			)
	) d
	group by num
	having sum(week_sum) is not null
	order by num



    select datepart(ww, getdate())


