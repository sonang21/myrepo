/* *************************************************************************
 * NAME : dbo.udp_job_goods_info
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:50:23.467
 *        Modify: 2018-05-13 19:50:23.467
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_job_goods_info
	@id	varchar(12)	= ''
,	@sdate	smalldatetime
,	@edate	smalldatetime
,	@job_flag char(1)	= '-1' -- 1:�ű�, 4:�ӽ�
as
begin
	------------------------------------------------------------------
	-- made by	: wookki25 2007-05-08
	-- desc		: �ű�/�ӽ� īŻ�α� �۾�����
	-- ex		: udp_job_cnt_goods 'nskim1', '2007-05-01','2007-05-8','4'
	------------------------------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted

	select modelno, g_modelnm, g_factory
	from 
	(
		select	jg_modelno as modelno
		from 	job_goods with (readuncommitted)
		where	jg_id = @id
		and		jg_date >= @sdate
		and		jg_date < @edate
		and		jg_flag = @job_flag
		union
		select	jg_modelno as modelno
		from	eloc188.logdb.dbo.job_goods 
		where	jg_id = @id
		and		jg_date >= @sdate
		and		jg_date < @edate
		and		jg_flag = @job_flag
	) a
	left join analstore.dbo.goods
	on modelno = g_modelno
end


