/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step2_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-31 19:00:54.203
 *        Modify: 2018-05-03 17:23:35.21
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_step2_ins
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-01-06
	-- 설  명 : 모니터링 데이터 수집
	-- ----------------------------------------------

--insert into tmp_20150326_runstep select getdate(), 20

	-- 당일 최초 입력시점 저장
	update a -- tbl_monitoring_target_raw_new
	set today_first_date = b.today_first_date
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no 
	where b.today_first_date >= cast(cast(getdate() as date) as datetime)
	and b.p_status = 'i'
	

	-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 낮으면 처리중인 데이터 삭제
	update a -- tbl_monitoring_target_raw_new
	set chg_type = 0
	,	comp_order = 0
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
	where b.p_status = 'i' and a.chg_type > 0

	-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 높으면 저장된 데이터 삭제
	delete b --tbl_monitoring_target
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
	where b.p_status = 'i' and a.chg_type > 0

	-- 입력전에 pl_no distinct하게 처리 .. 2015.02.13
	delete b --tbl_monitoring_target
	from tbl_monitoring_target_raw_new a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
	where b.p_status in ('u', 'd') and a.chg_type >0

	-- 데이터 입력
	insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, today_first_date)
	select pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, today_first_date
	from tbl_monitoring_target_raw_new where chg_type > 0


	-- 정규식 테스트 // 3일 후 삭제예정 // 2016.10.24
	--insert into tbl_monitoring_target_raw_new_test(pl_no, g_modelnm, pl_goodsnm_regexp)
	--select pl_no, g_modelnm, pl_goodsnm_regexp	from tbl_monitoring_target_raw_new where chg_type = 1



	-- -----------------------------
	-- 임시// 2016-05-16~2016-05-20
	-- -----------------------------
	--insert into tmp_20160516_20160520_wookki25(pl_no, chg_type)
	--select pl_no, chg_type	
	--from tbl_monitoring_target_raw_new where chg_type > 0


--insert into tmp_20150326_runstep select getdate(), 21

	-- 옵션 데이터 입력 : 하루 1회만
	declare @sdate smalldatetime
	set @sdate = cast(convert(varchar(10), getdate(), 120) as smalldatetime)
	if not exists (select top 1 1 from tbl_monitoring_target with (readuncommitted) where chg_type = 17 and regdate >= @sdate) begin
		select a.pl_no, (select top 1 comp_order from tbl_monitoring_team_agg_name where monitor_no = 17) comp_order, cast(17 as smallint) chg_type, pl_vcode, pl_category, pl_goodsnm
		, getdate() as today_first_date
		into #tbl_monitoring_target_option -- 입력할 데이터 임시 저장
		from 
		(
			select pl_no from tbl_pricelist_option_ctu_detail where regdate>=@sdate and regdate < @sdate+1
			union
			select pl_no from tbl_pricelist_option_diff_detail where regdate>=@sdate and regdate < @sdate+1
		) a inner join pricelist b with (readuncommitted)  on a.pl_no = b.pl_no
		where pl_srvflag not in ('O','Z','1') and option_flag2 <> '1'


		-- 당일 최초 입력시점 저장
		update a -- tbl_monitoring_target_raw_new
		set today_first_date = b.today_first_date
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no 
		where b.today_first_date >= cast(cast(getdate() as date) as datetime)
		and b.p_status = 'i'

		-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 낮으면 처리중인 데이터 삭제
		delete a -- tbl_monitoring_target_raw_new
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
		where b.p_status = 'i'

		-- 지금 처리중인 데이터가 저장된 데이터보다 우선 순위가 높으면 저장된 데이터 삭제
		delete b --tbl_monitoring_target
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
		where b.p_status = 'i'

		-- 입력전에 pl_no distinct하게 처리 .. 2015.02.13
		delete b --tbl_monitoring_target
		from #tbl_monitoring_target_option a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
		where b.p_status in ('u', 'd')


		-- 데이터 입력
		insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, today_first_date)
		select pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, today_first_date
		from #tbl_monitoring_target_option



		-- -----------------------------
		-- 임시// 2016-05-16~2016-05-20
		-- -----------------------------
		--insert into tmp_20160516_20160520_wookki25(pl_no, chg_type)
		--select pl_no, chg_type	
		--from #tbl_monitoring_target_option

	end

	-- 이상 최저/최고가 : 2016.10.07 // 데이터 수집 중지 // 이경국 요청 //http://58.234.199.100/redmine/issues/18444
	-- 이상 최저/최고가 : 2017.06.29 // 데이터 수집 재개 // 이경국 요청 //http://58.234.199.100/redmine/issues/22945
	if not exists (select top 1 1 from tbl_monitoring_target with (readuncommitted) where chg_type in (21,22) and regdate >= @sdate) and getdate() > cast('2017-06-30' as datetime) begin
		exec udp_monitoring_target_step1_raw_g4
	end