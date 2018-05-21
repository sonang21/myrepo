/* *************************************************************************
 * NAME : dbo.usp_move_acc_suggest_goods
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:22:52.107
 *        Modify: 2018-05-15 15:22:52.107
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc usp_move_acc_suggest_goods
	@dte_in smalldatetime=''
as
begin
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25
	-- ��  �� : ��õ��ǰ
	-- ��  �� : 
		/*
		�����,
		��õ��ǰ ���� ������ �Ʒ��� ���� ���� ��Ź �帳�ϴ�~

		1. �Һз� Ŭ���ƿ�
		2. �Һз� �α⵵
		3. �ߺз� Ŭ���ƿ�
		4. �ߺз� �α⵵
		*/
    -- ----------------------------------------------------------------------------------	
	set nocount on
	set transaction isolation level read uncommitted

	declare @dtechkday as smalldatetime
	if @dte_in = ''
		set @dtechkday = dateadd(d, -1, getdate())
	else
		set @dtechkday = @dte_in

	set @dtechkday = convert(varchar(8), @dtechkday, 112)

	truncate table tbl_move_suggest_goods_raw
	truncate table tbl_move_suggest_goods


	--�Ϻ� �����̵�(�Ϲݻ�ǰ=��ȣ�۾���ǰ)
	insert into tbl_move_suggest_goods_raw(regdate, g_modelno, g_category, uhit)
	select @dtechkday, pl_modelno, left(max(g_category),6) as g_category, count(*) as uhit
	from
		(
		select
			pl_modelno, max(g_category) as g_category
		from
			(
			-- ip�ߺ� ����
			select	pl_modelno, max(g_category) as g_category, max(mem_id) as mem_id
			from	tbl_move_normal_log
			where	mnl_date >= @dtechkday and mnl_date < dateadd(d, 1,  @dtechkday)
			and  referer_url is not null
			group by  pl_modelno, mnl_ip
			union all
			-- ip�ߺ� ���
			select	pl_modelno, g_category, mem_id
			from	tbl_move_normal_log
			where	mnl_date >= @dtechkday and mnl_date < dateadd(d, 1,  @dtechkday) and mnl_ip in(select userip from tbl_model_log_filterip)
			and  referer_url is not null
			) a
		group by pl_modelno, mem_id
		) c
	group by pl_modelno

	--�Ϻ� �����̵�(ȥ��)
	insert into tbl_move_suggest_goods_raw(regdate, pl_no, g_category, uhit)
	select @dtechkday, pl_no, left(max(pl_category),6) as pl_category, count(*) as uhit
	from
		(
		select
			pl_no, max(pl_category) as pl_category
		from(
			--ip�ߺ� ����
			select  pl_no, max(pl_category) as pl_category, max(mem_id) as mem_id
			from	tbl_move_single_log
			where	msl_date >= @dtechkday and msl_date < dateadd(d, 1,  @dtechkday)
			and  referer_url is not null and (pl_category like '1[456]__%' or pl_category like '9[15]__%')
			group by  pl_no, msl_ip
			union all
			--ip�ߺ� ���
			select	pl_no, pl_category, mem_id
			from	tbl_move_single_log
			where	msl_date >=@dtechkday and msl_date < dateadd(d, 1,  @dtechkday) and msl_ip in(select userip from tbl_model_log_filterip)
			and  referer_url is not null and (pl_category like '1[456]__%' or pl_category like '9[15]__%')
		) a
		group by pl_no, mem_id
	) b
	group by pl_no

	--�Ϻ� �����̵�(�̵��)
	insert into tbl_move_suggest_goods_raw(regdate, pl_no, g_category, uhit)
	select @dtechkday, pl_no, left(max(pl_category),6) as pl_category, count(*) as uhit
	from
		(
		select
			pl_no, max(pl_category) as pl_category
		from
			(
			-- ip�ߺ� ����
			select  pl_no, max(pl_category) as pl_category, max(mem_id) as mem_id
			from	tbl_move_regnon_log
			where	mrl_date >= @dtechkday and mrl_date < dateadd(d, 1,  @dtechkday)
			and  referer_url is not null and (pl_category like '1[456]__%' or pl_category like '9[15]__%')
			group by  pl_no, mrl_ip
			union all
			-- ip�ߺ� ���
			select	pl_no, pl_category, mem_id
			from	tbl_move_regnon_log
			where	mrl_date >=@dtechkday and mrl_date < dateadd(d, 1,  @dtechkday) and mrl_ip in(select userip from tbl_model_log_filterip)
			and  referer_url is not null and (pl_category like '1[456]__%' or pl_category like '9[15]__%')
			) a
		group by pl_no, mem_id
		) b
	group by pl_no


	-- ----------------------------
	-- ������� �Һз� ���� ������
	-- ----------------------------
	update a 
	set g_category = left(isnull(b.g_category, a.g_category), 6)
	,	g_mallcnt = c.g_mallcnt
	--select top 1 *, a.g_category, b.g_category
	from tbl_move_suggest_goods_raw a 
            left outer join analstore.dbo.goods b on a.g_modelno = b.g_modelno
            left outer join analstore.dbo.goods_sum c on a.g_modelno = c.g_modelno

	-- ǰ������
	delete tbl_move_suggest_goods_raw where g_modelno > 0 and  g_mallcnt=0




	-- ------------------------------------------------
	--	�з� ����Ʈ : goods ���� // ���� ���� �ִ� �Һз�
	-- ------------------------------------------------
	--	select scode
	--	into #scate
	--	from openquery(eloc188, 'select cs_lcode+cs_mcode+cs_scode scode from eloc2001.dbo.c_scate where cs_seqno > 0')
	-- drop table #scate

	-- �Һз� ����Ʈ
	select distinct rtrim(ltrim(cast(left(g_category, 6) as varchar(6)))) g_category, cast(0 as int) as target_cnt
	into #scate
	from analstore.dbo.goods with (readuncommitted)
	where g_category like '[0-9][0-9][0-9][0-9][0-9][0-9]%'
	and g_category not like '00%'

	
	-- ����ó�� : http://58.234.199.100/redmine/issues/7727
	-- ����ó�� : http://58.234.199.100/redmine/issues/9468
	-- �Ϲݻ�ǰ�� �ִ� ī�װ�
	insert into #scate(g_category, target_cnt)
	select category, 0  from openquery(ELOC188, 'select cs_lcode+cs_mcode+cs_scode as category from c_scate where cs_lcode=''14'' and cs_mcode like ''7[123]''')

	insert into #scate(g_category, target_cnt)
	select category, 0  from openquery(ELOC188, 'select cs_lcode+cs_mcode+cs_scode as category from c_scate where cs_lcode=''91'' and cs_mcode like ''01''')

	insert into #scate(g_category, target_cnt)
	select category, 0  from openquery(ELOC188, 'select cm_lcode+cm_mcode as category from c_mcate where cm_lcode=''95'' and cm_mcode like ''01''')

	-- ------------------------------------------------
	--	Ŭ���ƿ� �� ���� �Է�
	-- ------------------------------------------------
	-- �Һз�.Ŭ���ƿ� ����
	update a
	set target_cnt = clickout_cnt
	from #scate a inner join (
		select g_category, count(*) clickout_cnt 
		from tbl_move_suggest_goods_raw 
		group by g_category
	) b on a.g_category = b.g_category



	-- ------------------------------------------------
	--	������ �Է�.��ü�з� Ŭ���ƿ� TOP 50
	-- ------------------------------------------------
	--insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
	--select top 50 '000000' g_category, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate, 's_clickout', uhit as point
	--from tbl_move_suggest_goods_raw 
	--order by uhit desc

	-- �ߺз��� 2������ ������ ó��..
	select top 1 * into #mcate_top_50 from tbl_move_suggest_goods where 1=0
	declare @seed_no int
	set @seed_no = 1
	while @seed_no <= 50 begin

		insert into #mcate_top_50(g_category, g_modelno, pl_no, regdate, data_desc, point)
		select top 1 left(g_category,4) mcate, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate, 's_clickout', uhit as point
		from tbl_move_suggest_goods_raw 
		where g_modelno not in (select isnull(g_modelno,0) from #mcate_top_50)
		and left(g_category,4) not in (
			select g_category from #mcate_top_50 group by g_category having count(*) = 2
		)
		and g_modelno > 0
		order by uhit desc
	
		set @seed_no = @seed_no + 1
	end


	insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
	select '000000' g_category, g_modelno, pl_no, regdate, data_desc, point from #mcate_top_50



	-- ------------------------------------------------
	--	������ �Է�.�Һз� Ŭ���ƿ�
	-- ------------------------------------------------		
		-- Ŭ���ƿ� 50�� ����
		insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
		select g_category, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate, 's_clickout',  uhit as point
		from tbl_move_suggest_goods_raw 
		where g_category in (
			select g_category from #scate where target_cnt<=50	
		)	

		-- Ŭ���ƿ� 50�� �ʰ�
		declare @category1 varchar(6)
		declare target_category cursor for 
		select g_category
		from #scate
		where target_cnt > 50
		order by g_category

		open target_category
		fetch next from target_category 
		into @category1

		while @@fetch_status = 0
		begin
			insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
			select top 50 g_category, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate, 's_clickout',  uhit as point
			from tbl_move_suggest_goods_raw 
			where g_category = @category1
			order by uhit desc

			-- get the next category.
			fetch next from target_category 
			into @category1
		end 
		close target_category
		deallocate target_category






	declare @sql nvarchar(4000)
	declare @cnt int

	-- ------------------------------------------------
	--	������ �Է�.�α��ǰ TOP_N �Է�
	--	����ġ ����� �α⵵ ��� ( goods_popular )
	-- ------------------------------------------------
		declare @category2 varchar(6)

		-- �Һз�
		declare target_category cursor for 
		select g_category, 50-target_cnt 
		from #scate
		where target_cnt < 50
		order by g_category

		open target_category
		fetch next from target_category 
		into @category2, @cnt

		while @@fetch_status = 0
		begin
			
			set @sql = N'select top '+ cast(@cnt as nvarchar(2)) +' ltrim(rtrim(left(gp_category,6))) g_category, gp_modelno, convert(char(8), getdate(), 112) regdate, ''s_popular'' data_desc, gp_sum_point
					from goods_popular with (readuncommitted)
					where gp_category like '''+ @category2 +'%''
					and isnull(gp_modelno,'''') not in (
							select g_modelno from tbl_move_suggest_goods with (readuncommitted) where g_category = '''+@category2+''' and g_modelno is not null
					)
					order by gp_sum_point desc'

			insert into tbl_move_suggest_goods(g_category, g_modelno, regdate, data_desc, point)
			exec (@sql)

			update #scate
			set target_cnt = target_cnt+ @@rowcount
			where g_category = @category2

			-- get the next category.
			fetch next from target_category 
			into @category2, @cnt
		end 
		close target_category
		deallocate target_category


	-- ------------------------------------------
	--	������ �Է�.�ߺз� Ŭ���ƿ�
	--- -----------------------------------------
		declare @category3 varchar(6)


		declare target_category cursor for 
		select g_category, 50-target_cnt 
		from #scate
		where target_cnt < 50
		order by g_category

		open target_category
		fetch next from target_category 
		into @category3, @cnt

		while @@fetch_status = 0
		begin
			
			set @sql = N'select top '+ cast(@cnt as nvarchar(2)) +' '''+@category3+''' g_category, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate, ''m_clickout'' data_desc, uhit
					from tbl_move_suggest_goods_raw with (readuncommitted)
					where g_category like '''+ left(@category3,4) +'%''
					and isnull(g_modelno,'''') not in (
							select g_modelno from tbl_move_suggest_goods with (readuncommitted) where g_category = '''+@category3+''' and g_modelno is not null
					)
					and isnull(pl_no,'''') not in (
							select pl_no from tbl_move_suggest_goods with (readuncommitted) where g_category = '''+@category3+''' and pl_no is not null
					)
					order by uhit desc'

			insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
			exec (@sql)

			update #scate
			set target_cnt = target_cnt+ @@rowcount
			where g_category = @category3

			-- get the next category.
			fetch next from target_category 
			into @category3, @cnt
		end 
		close target_category
		deallocate target_category;


	-- ------------------------------------------------
	--	������ �Է�.�ߺз� �α��ǰ TOP_N �Է�
	--	����ġ ����� �α⵵ ��� ( goods_popular )
	-- ------------------------------------------------
		declare @category4 varchar(6)
		declare target_category cursor for 
		select g_category, 50-target_cnt 
		from #scate
		where target_cnt < 50
		order by g_category

		open target_category
		fetch next from target_category 
		into @category4, @cnt

		while @@fetch_status = 0
		begin

			
			set @sql = N'select top '+ cast(@cnt as nvarchar(2)) +' '''+@category4+''' g_category, gp_modelno, convert(char(8), getdate(), 112) regdate, ''m_popular'' data_desc, gp_sum_point
					from goods_popular with (readuncommitted)
					where gp_category like '''+ Left(@category4,4) +'%''
					and isnull(gp_modelno,'''') not in (
							select g_modelno from tbl_move_suggest_goods with (readuncommitted) where g_category = '''+@category4+'''  and g_modelno is not null
					)
					order by gp_sum_point desc'

			insert into tbl_move_suggest_goods(g_category, g_modelno, regdate, data_desc, point)
			exec (@sql)

			update #scate
			set target_cnt = target_cnt+ @@rowcount
			where g_category = @category4

			-- get the next category.
			fetch next from target_category 
			into @category4, @cnt
		end 
		close target_category
		deallocate target_category

	-- ------------------------------------------------
	--	��з�/�ߺз� ������
	-- ------------------------------------------------
		-- �ߺз� ����Ʈ
		declare @category5 varchar(6)
		declare target_category cursor for 
		select distinct(left(g_category,4)) as g_category from #scate where g_category <> '9501' --9501�� �ߺз��� �ִ� �з��� ��ܿ��� �̹� ó���� ������. �ߺ� ó������ �ʵ��� ����ó��
		order by 1

		open target_category
		fetch next from target_category 
		into @category5

		while @@fetch_status = 0
		begin

			insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
			select category, g_modelno, pl_no, regdate, 
					case
						when point between 100000000000000	and 999999999999999 then 'm_clickout'	
						when point between 10000000000000	and 99999999999999	then 'm_popular'	
					end,

					case	
						when point between 100000000000000	and 999999999999999 then point - 100000000000000
						when point between 10000000000000	and 99999999999999	then point - 10000000000000
					end 
				
			from (
				select top 50 Left(g_category, 4) category, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate,
					max(
						case data_desc 
							when 's_clickout'	then point + 100000000000000
							when 'm_clickout'	then point + 100000000000000
							when 's_popular'	then point + 10000000000000
							when 'm_popular'	then point + 10000000000000
						end 
					) as point
				from tbl_move_suggest_goods where g_category like @category5+'%'
				group by Left(g_category, 4), g_modelno, pl_no
				order by point desc
			) a


			-- get the next category.
			fetch next from target_category 
			into @category5
		end 
		close target_category
		deallocate target_category


		-- ��з� ����Ʈ
		declare @category6 varchar(6)
		declare target_category cursor for 
		select distinct(left(g_category,2)) as g_category from #scate
		order by 1

		open target_category
		fetch next from target_category 
		into @category6

		while @@fetch_status = 0
		begin
			insert into tbl_move_suggest_goods(g_category, g_modelno, pl_no, regdate, data_desc, point)
			select category, g_modelno, pl_no, regdate, 
					case
						when point between 100000000000000	and 999999999999999 then 'l_clickout'	
						when point between 10000000000000	and 99999999999999	then 'l_popular'	
					end,

					case	
						when point between 100000000000000	and 999999999999999 then point - 100000000000000
						when point between 10000000000000	and 99999999999999	then point - 10000000000000
					end 
				
			from (
				select top 50 Left(g_category, 2) category, g_modelno, pl_no, convert(char(8), getdate(), 112) regdate,
					max(
						case data_desc 
							when 's_clickout'	then point + 100000000000000
							when 'm_clickout'	then point + 100000000000000
							when 's_popular'	then point + 10000000000000
							when 'm_popular'	then point + 10000000000000
						end 
					) as point
				from tbl_move_suggest_goods where g_category like @category6+'%'
				group by Left(g_category, 2), g_modelno, pl_no
				order by point desc
			) a
			-- get the next category.
			fetch next from target_category 
			into @category6
		end 
		close target_category
		deallocate target_category


		update tbl_move_suggest_goods set g_category = ltrim(rtrim(g_category))

end



