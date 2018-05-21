/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step2_ins_real_option
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-03-02 17:42:56.793
 *        Modify: 2018-05-03 17:23:35.797
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_step2_ins_real_option
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2016.03.02
	-- ��  �� : ����͸� ������ ����.CTU & MINIBot �ɼ�
	-- ----------------------------------------------
	-- ��  ��
	-- ----------------------------------------------
	--	2016.08.17		wookki25		����1�� ����͸� ������� ó��	
	-- ----------------------------------------------


	declare @qry varchar(8000)

	-- ������ ������ �ð� ����
		declare @sdate varchar(16)
		declare @edate varchar(16)
		set @edate = convert(varchar(15), getdate(), 120)+'0'
		set @sdate = convert(varchar(16), dateadd(mi , -10, cast(@edate as smalldatetime)), 120)

	-- ����ó�� / 8�� ùŸ���� ���� 23�ú���~���� 08�ñ��� �����ͷ� ó��		
	--	if right(@edate, 5) = '08:00' begin
	--		set @sdate = convert(varchar(16), dateadd(hh, -9, cast(@edate as smalldatetime)), 120)
	--	end
		

	-- ���� ���� / �ɼǸ��� ���� ����
		set @qry = 'select pl_no, replace(option_name,'''' '''','''''''') as option_name, replace(option_sub_name, '''' '''','''''''') as option_sub_name, option_price, modelno from tbl_pricelist_option tm 
		where  modelno is not null and regdate >= to_date('''''+ @sdate +''''', ''''YYYY-MM-DD HH24:MI'''') 
			and regdate < to_date('''''+ replace(replace(replace(@edate,'-',''), ':', ''), ' ','') +''''', ''''YYYY-MM-DD HH24:MI'''')'



	-- ����Ŭ���� ������ ����
		create table #target_pl_no(
			pl_no bigint
			, modelno int
			, option_name varchar(120)
			, option_sub_name varchar(200)
			, option_price money
			, assign_mm_id varchar(12)
			, target_flag tinyint default(0) not null
			, mcate char(4)
			, comp_order smallint
			, monitor_no smallint
		)

		insert into #target_pl_no(pl_no, option_name, option_sub_name, option_price, modelno)
		exec ('select pl_no, option_name, option_sub_name, option_price, modelno from openquery(oradb, '''+@qry+''')')



		-- ����1�� ����͸� ������� ó�� : http://58.234.199.100/redmine/issues/17499
		delete a from #target_pl_no a inner join goods b on a.modelno = b.g_modelno where g_constrain <> '1'




	-- �ߺз��� n�� �� // 2015.12.08 ����߰� // �ߺз� 1~60�� �� �����͸� ���
	/*
		delete from #target_pl_no where modelno not in (
			select modelno from tbl_mcate_popular_rank where mcate_group_rank between 1 and 60
		)
	*/

	-- �ߺз��ڵ�
		update a set mcate = left(g_category, 4) from #target_pl_no a inner join goods b on a.modelno = b.g_modelno


	-- �ߺз�.��������
		select category mcate, isnull(ex_option1,'') ex_option1, isnull(ex_option2, '') ex_option2
		into #exp_option
		from tbl_cate_monitoring_guide where category like '____' and isnull(ex_option1, '') <> ''

		 
				
		-- and ����
		update a
		set target_flag=2
		from  #target_pl_no a 
			inner join (select * from #exp_option where ex_option1 <> '' and ex_option2 <> '') b on a.mcate = b.mcate
		and charindex(b.ex_option1, a.option_sub_name) > 0 
		and a.option_price >= cast(b.ex_option2 as money)
		and target_flag = 0

		-- single ����
		update a
		set target_flag=1
		from  #target_pl_no a 
			inner join (select * from #exp_option where ex_option1 <> '' and ex_option2 = '') b on a.mcate = b.mcate
		and charindex(b.ex_option1, a.option_sub_name)  > 0
		and target_flag = 0
		

		-- ���� ����� ����
		--delete from #target_pl_no where target_flag = 0

		-- pl_no distinct ó�� / 2016.03.18
		select distinct pl_no, modelno, assign_mm_id, mcate, comp_order, monitor_no, getdate() today_first_date
		into #target_pl_no_distinct 
		from #target_pl_no
		where target_flag = 1


					


		-- �켱���� ����
		update a
		set comp_order = b.comp_order
		, monitor_no = b.monitor_no 
		from #target_pl_no_distinct a cross join (select comp_order, monitor_no from tbl_monitoring_team_agg_name where monitor_no=24) b 

		-- ���� ���� �Է½��� ����
		update a -- tbl_monitoring_target_raw_new
		set today_first_date = b.today_first_date
		from #target_pl_no_distinct a inner join tbl_monitoring_target b on a.pl_no = b.pl_no 
		where b.today_first_date >= cast(cast(getdate() as date) as datetime)
		and b.p_status = 'i'

		-- ���� ó������ �����Ͱ� ����� �����ͺ��� �켱 ������ ������ ó������ ������ ����
		delete a -- tbl_monitoring_target_raw_new
		from #target_pl_no_distinct a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order > b.comp_order
		where b.p_status = 'i'

		-- ���� ó������ �����Ͱ� ����� �����ͺ��� �켱 ������ ������ ����� ������ ����
		delete b --tbl_monitoring_target
		from #target_pl_no_distinct a inner join tbl_monitoring_target b on a.pl_no = b.pl_no  and a.comp_order <= b.comp_order
		where b.p_status = 'i'

		-- �Է����� pl_no distinct�ϰ� ó�� .. 2015.02.13
		delete b --tbl_monitoring_target
		from #target_pl_no_distinct a inner join tbl_monitoring_target b on a.pl_no = b.pl_no
		where b.p_status in ('u', 'd')


		-- �й�(= �Ҵ�)
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

		declare @id_cnt int
		select @id_cnt = count(*) from #mm_id

		update x
		set assign_mm_id = y.mm_id
		from #target_pl_no_distinct x
				inner join
			(
				select pl_no, mm_id
				from (
					select pl_no, rank() over(order by pl_no) nrank
					from #target_pl_no_distinct
					where assign_mm_id is null
				) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
			) y on x.pl_no = y.pl_no
		option (maxdop 1)



		-- �ű� ������ �Է�
		insert into tbl_monitoring_target(pl_no, pl_vcode, pl_category, pl_goodsnm, comp_order, chg_type, assign_mm_id, today_first_date)
		select b.pl_no, b.pl_vcode, b.pl_category, b.pl_goodsnm, comp_order, monitor_no, assign_mm_id, today_first_date
		from #target_pl_no_distinct a 
			inner join pricelist b on a.pl_no = b.pl_no
			inner join tbl_monitoring_inc_cate c on left(isnull(b.pl_category,''), 4) = c.ca_code		


		-- -----------------------------
		-- �ӽ�// 2016-05-16~2016-05-20
		-- -----------------------------
		--insert into tmp_20160516_20160520_wookki25(pl_no, chg_type)
		--select b.pl_no, monitor_no
		--from #target_pl_no_distinct a inner join pricelist b on a.pl_no = b.pl_no



	-- �켱���� ����
	--	update a set a.comp_order = b.comp_order from tbl_monitoring_target a inner join tbl_monitoring_team_agg_name b  on a.chg_type = b.monitor_no










