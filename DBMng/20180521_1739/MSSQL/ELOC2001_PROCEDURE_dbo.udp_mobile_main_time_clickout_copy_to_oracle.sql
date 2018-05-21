/* *************************************************************************
 * NAME : dbo.udp_mobile_main_time_clickout_copy_to_oracle
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-01-04 11:07:48.84
 *        Modify: 2018-05-03 17:23:35.393
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_mobile_main_time_clickout_copy_to_oracle
as
	set nocount on 
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2018.01.03
	-- ��  �� : ����ϸ���.�����ǰ.Ŭ���ƿ�.����Ŭ�� ����
	-- ----------------------------------------------
	--	part not in ('t','d','c') - modelno
	--	part = 'n' - pl_no
	--	3�ð�����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

									
	*/

	-- ����
	-- drop table #target
	select modelno, pl_no, part into #target 
	from openquery(ORADB, 'select modelno, pl_no, part from mobile_main where part in (''T'',''D'',''C'',''N'')')


	declare @mct  int
	declare @modelno int
	declare @pl_no bigint

	-- ���ݺ� �� : Ŀ���� �Ǻ��� �ֹ��� �Է�
	declare curs1 cursor for 

	select b.modelno, sum(case when a.modelno>0 then 1 else 0 end) mct
	from tbl_move_log_mobile a right outer join #target b 
	on a.modelno = b.modelno and regdate >= dateadd(hh, -3, regdate)
	where referer_url =  '' -- mobile ���λ�ǰ (= referer_url�� ����.)
	AND part in ('T','D','C')
	group by b.modelno	

	open curs1 
		fetch curs1 into @modelno,  @mct
		while @@fetch_status <> -1 
		begin 

			update openquery(ORADB, 'select modelno, click_cnt from mobile_main')
			set click_cnt = @mct
			where modelno =@modelno
			
		
			fetch curs1 into @modelno,  @mct
		end 
	close curs1 
	deallocate curs1 


	-- �Ϲݻ�ǰ Ŀ���� �Ǻ��� �ֹ��� �Է�
	declare curs1 cursor for 
	select b.pl_no, sum(case when a.pl_no>0 then 1 else 0 end) mct
	from tbl_move_log_mobile a right join #target b 
	on a.pl_no = b.pl_no and regdate >= dateadd(hh, -3, regdate)
	where referer_url =  '' -- mobile ���λ�ǰ (= referer_url�� ����.)
	AND part in ('N')
	group by b.pl_no
	open curs1 
		fetch curs1 into @pl_no,  @mct
		while @@fetch_status <> -1 
		begin 

			update openquery(ORADB, 'select pl_no, click_cnt from mobile_main')
			set click_cnt = @mct
			where pl_no =@pl_no
			
		
			fetch curs1 into @pl_no,  @mct
		end 
	close curs1 
	deallocate curs1 




