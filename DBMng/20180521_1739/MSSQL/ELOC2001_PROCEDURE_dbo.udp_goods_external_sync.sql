/* *************************************************************************
 * NAME : dbo.udp_goods_external_sync
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-07 16:37:23.503
 *        Modify: 2018-05-03 17:23:35.403
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_goods_external_sync
as 
begin
	set nocount on 
	--set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.02.07
	-- ��  �� : �Ӽ�  �۾����� sync
	--		�ֱ�� 10������ ����. 5, 15, 25, 35, 45, 55 �� ó��
	--		������ sync ó�� �ؾ��Ѵ�. // 2017.02.14 // ������
	--		�۾��α� ���ܾ��Ѵ�.	
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	
	*/

	-- ----------------------------------
	-- sync �ֱ� ����
	-- ----------------------------------
	-- drop table #sync_target
	-- �ֱ� ����
	-- �ֱ� ������ ����Ǹ� agent �����층�� ����Ǿ�� �� : �����층�� (�ֱ�+1)�п� ���� �� �� �ֱ�� ���� �ݺ� ����ǵ��� ���� �ʿ�
	-- �ֱⰡ 10���� ��� �� 10�и��� 11��, 21��, 31��..�� ����, �ֱⰡ 15���� ��� �� 15�и��� 16��, 31��,  46��..�� ����
	-- ----------------------------------
	/*
	-- sync �����۾� Ȯ��
	create table tbl_gs_sync_history(
		job_date datetime
	,	sdate	datetime
	,	edate	datetime
	)
	insert into tbl_gs_sync_history
	select getdate(), @sdate, @edate

	select * from tbl_gs_sync_history order by 1
	*/

	declare @interval int = 10 -- �ֱ� 10��

	declare @edate datetime, @sdate datetime
	set @edate = cast(convert(char(14), getdate(), 25)+convert(char(2), (datepart(minute, getdate())/@interval)*@interval) as datetime)
	set @sdate = dateadd(mi, -@interval, @edate)
	-- select getdate(), @sdate, @edate
	-- ----------------------------------
	-- sync ��� ã��
	-- ----------------------------------


	-- ���� ������ : job_pricelist
	select * 
	into #target_job_log
	from logdb.dbo.job_pricelist a with (readuncommitted)
	where jp_vcode in (75, 7871)
	and jp_flag in ('0','5','6','M','N','P','S') -- 
	and jp_id <> 'nuribot_sync' -- ���������� ������ g2->g1 sync �۾��� ����. �������� g2->g1�� sync�۾��Ѵ�.
	and jp_id <> 'dbagent_sync' -- sync�۾����� ������ g2<->g1 sync �۾��� ����.
	and jp_date >= @sdate
	and jp_date <  @edate


	-- ���� ������ : job_pricelist_old
	If OBJECT_ID('logdb.dbo.job_pricelist_old') is not null  begin -- rename ������ ���̺� ���� ��� ���� ó��

		-- ������ ���̺�� rename�ϴ� ������ ������ �����ϴ� ���
		-- old ���̺� �����Ѵ�.
		if (cast(@sdate as date) <> cast(@edate as date) or @sdate < dateadd(mi, 10, cast(cast(@sdate as date) as datetime)) ) begin
			insert into #target_job_log
			select * 
			from logdb.dbo.job_pricelist_old a  with (readuncommitted)
			where jp_vcode in (75, 7871)
			and jp_flag in ('0','5','6','M','N','P','S') -- 
			and jp_id <> 'nuribot_sync' -- ���������� ������ g2->g1 sync �۾��� ����. �������� g2->g1�� sync�۾��Ѵ�.
			and jp_id <> 'dbagent_sync' -- sync�۾����� ������ g2<->g1 sync �۾��� ����.
			and jp_date >= @sdate
			and jp_date <  @edate
		end

	end 



	select jp_vcode, jp_modelno, pl_goodscode, pl_goodscode_cs, pl_note, pl_category
	into #sync_target
	from 
	(
		select jp_vcode, jp_modelno, jp_plistno, jp_date, b.pl_goodscode, b.pl_goodscode_cs, b.pl_note, b.pl_category
		, rank() over (partition by b.pl_goodscode order by jp_date desc) rnk_goodscode 
		from #target_job_log a inner join eloc2001.dbo.pricelist b  with (readuncommitted) on a.jp_plistno = b.pl_no

		--select jp_vcode, jp_modelno, jp_plistno, jp_date, b.pl_goodscode, b.pl_goodscode_cs, b.pl_note, b.pl_category
		--, rank() over (partition by b.pl_goodscode order by jp_date desc) rnk_goodscode 
		--from logdb.dbo.job_pricelist a inner join eloc2001.dbo.pricelist b on a.jp_plistno = b.pl_no
		--where jp_vcode in (75, 7871)
		--and jp_flag in ('0','5','6','M','N','P','S') -- 
		--and jp_id <> 'nuribot_sync' -- ���������� ������ g2->g1 sync �۾��� ����. �������� g2->g1�� sync�۾��Ѵ�.
		--and jp_id <> 'dbagent_sync' -- sync�۾����� ������ g2<->g1 sync �۾��� ����.
		--and jp_date >= @sdate
		--and jp_date <  @edate
	) a 
	where rnk_goodscode = 1 -- ��ǰ�ڵ庰 ������ �۾� ����

	 
	-- ----------------------------------
	-- GS1 --> GS2 Sync
	-- ----------------------------------
	-- ���һ�ǰ ���� // sr21705 // 2017.03.30 ���� �߰�
	delete from #sync_target
	where jp_vcode = 75 and pl_goodscode in 
	(
		select b.pl_goodscode
		from eloc2001.dbo.pricelist a  with (readuncommitted) inner join #sync_target b 
			on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
		where a.pl_vcode = 75 and b.jp_vcode = 75
		group by b.pl_goodscode
		having count(*) > 1
	)

	-- �𵨹�ȣ Sync
	update a
	set pl_modelno = b.jp_modelno
	,	pl_category = b.pl_category
		-- ���(pl_note)�� '���� �Һи�' �Է��� gs1���� gs2 �Է½ÿ��� �ش�
	,	pl_note = case when b.jp_modelno < 0 and isnull(replace(b.pl_note, ' ', ''), '')  = '' then '���� �Һи�' else b.pl_note end -- ������ ������ �� �ִ�. // 2017.02.01	
		-- �� ��ȣ�۾� �α� �����
		output deleted.pl_no, inserted.pl_modelno, deleted.pl_vcode, 'dbagent_sync', '0', getdate(), deleted.pl_goodsnm, deleted.pl_price, inserted.pl_category, deleted.pl_instance_price
		into logdb.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile)
	from eloc2001.dbo.pricelist a inner join #sync_target b 
		on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
	where a.pl_vcode = 7871 and b.jp_vcode = 75 and a.pl_modelno <> b.jp_modelno -- �𵨹�ȣ �ٸ� ���, �űԸ�Ī or ���Ī ó��
	and b.jp_modelno >= 0 -- sr21288 // 2017.03.09 ���� �߰�
	and b.pl_category not like '93%' -- sr21635 //2017.03.28 ���� �߰� 

	-- �𵨹�ȣ Sync
	update a
	set pl_modelno = 0
		-- �� ��ȣ�۾� �α� �����
		output deleted.pl_no, inserted.pl_modelno, deleted.pl_vcode, 'dbagent_sync', '0', getdate(), deleted.pl_goodsnm, deleted.pl_price, inserted.pl_category, deleted.pl_instance_price
		into logdb.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile)
	from eloc2001.dbo.pricelist a inner join #sync_target b 
		on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
	where a.pl_vcode = 7871 and b.jp_vcode = 75 and a.pl_modelno <> b.jp_modelno -- �𵨹�ȣ �ٸ� ���, �űԸ�Ī or ���Ī ó��
	and b.jp_modelno < 0 -- sr21705 // 2017.03.30 ���� �߰�
	and b.pl_category not like '93%' -- sr21635 //2017.03.28 ���� �߰� 

	-- ----------------------------------
	-- GS2 --> GS1 
	-- ----------------------------------
	-- ���һ�ǰ ����
	delete from #sync_target
	where jp_vcode = 7871 and pl_goodscode in 
	(
		select b.pl_goodscode
		from eloc2001.dbo.pricelist a  with (readuncommitted) inner join #sync_target b 
			on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
		where a.pl_vcode = 75 and b.jp_vcode = 7871
		group by b.pl_goodscode
		having count(*) > 1
	)

	-- �𵨹�ȣ Sync
	update a
	set pl_modelno = b.jp_modelno
	,	pl_category = b.pl_category
	,	a.pl_note = b.pl_note -- ��� 
	,	a.pl_status = case when a.pl_status = '0' then '1' else a.pl_status end  -- ����Ŭ�� upload �Ѵ�.

		-- �� ��ȣ�۾� �α� �����
		output deleted.pl_no, inserted.pl_modelno, deleted.pl_vcode, 'dbagent_sync', '0', getdate(), deleted.pl_goodsnm, deleted.pl_price, inserted.pl_category, deleted.pl_instance_price
		into logdb.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile)
	from eloc2001.dbo.pricelist a inner join #sync_target b 
		on a.pl_goodscode = b.pl_goodscode and a.pl_goodscode_cs = b.pl_goodscode_cs
	where a.pl_vcode = 75 and b.jp_vcode = 7871 and a.pl_modelno <> b.jp_modelno -- �𵨹�ȣ �ٸ� ���, �űԸ�Ī or ���Ī ó��

	-- ����Ŭ�� ������ �Է� : ���̹��� ������ // 2017.02.20	// @edate ���Ŀ� ��ũ ó���� ������
	insert openquery(ORADB, 'select modelno from TBL_GS_SYNC_MODELNO')
	select jp_modelno from logdb.dbo.job_pricelist  with (readuncommitted) where jp_date >= @edate and jp_vcode = 75 and jp_id  = 'dbagent_sync' and jp_flag='0' and jp_modelno > 0

end


