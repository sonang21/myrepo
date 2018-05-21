/* *************************************************************************
 * NAME : dbo.udp_mss_srv_normal_apply
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-03-13 11:15:21.68
 *        Modify: 2018-05-03 17:23:34.92
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_mss_srv_normal_apply
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �� �� ��: wookki25 / 20180313
	-- ��   �� : ���������� 0 - >3 ó���� pl_no �ٽ�  3->0 ó��
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/

	--create table #target_plno(pl_no bigint)
	create table #apply_plno(pl_no bigint)

	-- 0. �����ͻ��̾������� ������ 3->0 ��� ��������
	--update mss_srv_normal_list
	--   set result = 1
	--output deleted.pl_no
	select pl_no 
	  into #target_plno
	  from mss_srv_normal_list 
	 where result = 0
	   and regdate > cast(getdate() as date)
	option (maxdop 1)
	--(11117�� ���� ������ ����)

	-- 1. pricelist �ݿ�
	update a 
	   set pl_status = (case when pl_status < '3' then '1' else pl_status end)
		 , pl_date = (case when pl_status < '3' then pl_date else getdate() end)
		 , pl_srvflag = '0'
	output deleted.pl_no
	  into #apply_plno(pl_no)
	  -- select count(*)
	  from pricelist a inner join #target_plno b on a.pl_no = b.pl_no
	 where pl_srvflag = '3'
	option (maxdop 1)
	-- (11017�� ���� ������ ����)
	
	-- 2. ���� ������ ����
	insert into pricelist_dml_log (pl_no, pl_category, pl_modelno, p_status, mm_id, log_flag, p_date)
	select a.pl_no
	     , pl_category
		 , pl_modelno
		 , 'I'
		 , 'SCI_BATCH'
		 , '2'
		 , getdate()
	  from pricelist a inner join #apply_plno b on a.pl_no = b.pl_no

	-- 3. �۾��α� ����
	-- exec USP_JOB_PRICELIST_INS_2 ����
	insert into logdb.dbo.job_pricelist (jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price, jp_category, jp_price_mobile, jp_note)
	select a.pl_no, pl_modelno, pl_vcode, 'SCI_REAL0_BATCH', '1', getdate(), pl_goodsnm, pl_price, pl_category, pl_instance_price, pl_note
	  from pricelist a 
	       inner join 
		   #apply_plno b 
		   on a.pl_no = b.pl_no

	-- 4. �۾��α� ���
	-- exec USP_JOB_PRICELIST_INS_2 ����
	update a
	   set result = 1
	  from mss_srv_normal_list  a 
	       inner join #apply_plno b on a.pl_no = b.pl_no
	 where result = 0
	   and regdate > cast(getdate() as date)
	option (maxdop 1)



	-- 5. oracle ���� �����Ϳ� �ݿ� ǥ��	
	set transaction isolation level read committed
	declare @qry varchar(8000)
	declare @pl_no bigint
	declare fetch_cursor cursor for
	select pl_no
	  from #apply_plno
	order by pl_no
	
	open fetch_cursor	
	fetch next from fetch_cursor into @pl_no
	while @@fetch_status = 0
	begin
		set @qry = '
			UPDATE OPENQUERY(ORADB, ''
				SELECT PL_NO, PRICE_CHECK, DEL_FLAG
				  FROM TBL_MINI_NURIBOT_LOG
				 WHERE PL_NO = ' + cast(@pl_no as varchar(100)) + ' AND PRICE_CHECK = ''''2'''' AND DEL_FLAG <> ''''Y''''''
			)
			SET DEL_FLAG = ''Y''
			'
		exec (@qry)

		insert into tmp_wookki25_20180321(pl_no) select @pl_no

		fetch next from fetch_cursor into @pl_no
	end
	close fetch_cursor
	deallocate fetch_cursor
end

