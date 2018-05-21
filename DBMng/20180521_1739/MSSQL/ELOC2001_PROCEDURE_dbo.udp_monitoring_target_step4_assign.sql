/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step4_assign
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-31 19:00:54.943
 *        Modify: 2018-05-03 17:23:35.247
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_monitoring_target_step4_assign
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-01-06
	-- 설  명 : 모니터링 데이터 수집
	-- 참  조 : [udp_monitoring_distribution_batch]
	-- ----------------------------------------------
	-- 할당 :	select assign_mm_id from tbl_mc_manager_set

--insert into tmp_20150326_runstep select getdate(), 41
	select identity(int, 1, 1) seqno, mm_id
	into #mm_id
	from
	(
		select distinct cast(substring(vals, s, e-s) as varchar(12)) as mm_id
		from 
		(  
			select  min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
			from  (select top 1 replace(assign_mm_id,' ','') vals from tbl_mc_manager_set) a  
			inner join master.dbo.spt_values b 
			on len(a.vals) >= b.number and type='p'
			group by charindex (',',vals+',',number)
		) a
	) b

--insert into tmp_20150326_runstep select getdate(), 42

	declare @id_cnt int
	select @id_cnt = count(*) from #mm_id

	-- 모집단 분배
	update x
	set assign_mm_id = y.mm_id
	from tbl_monitoring_target x
			inner join
		(
			select pl_no, mm_id
			from (
				select pl_no, chg_type, rank() over(order by chg_type, pl_no) nrank
				from tbl_monitoring_target a
					inner join tbl_monitoring_inc_cate b on left(a.pl_category, 4) = b.ca_code		
				where assign_mm_id is null and p_status = 'i'
			) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
		) y on x.pl_no = y.pl_no
	option (maxdop 1)




--insert into tmp_20150326_runstep select getdate(), 43


	-- ----------------------------------------------------------------------------------
	-- 최저가 경고창 분배 : 모집단에 들어가지는 않고, 별도 테이블에 할당만 한다.
	-- ----------------------------------------------------------------------------------	
	-- 중분류 인기상품 60위 상품만 분배한다.
	select modelno into #p_goods 
		from tbl_mcate_popular_rank a
			inner join tbl_monitoring_inc_cate b on left(a.category, 4) = b.ca_code
		where mcate_group_rank between 1 and 60


	update x
	set assign_mm_id = y.mm_id
	from pricelist_matching_alarm_srch x
			inner join
		(
			select pl_no, mm_id
			from (
				select pl_no, rank() over(order by pl_no) nrank
				from pricelist_matching_alarm_srch a inner join #p_goods b on a.g_modelno = b.modelno
				where alarm_flag = '2' and assign_mm_id is null and p_status = 'i'
			) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
		) y on x.pl_no = y.pl_no
	option (maxdop 1)
--insert into tmp_20150326_runstep select getdate(), 44


