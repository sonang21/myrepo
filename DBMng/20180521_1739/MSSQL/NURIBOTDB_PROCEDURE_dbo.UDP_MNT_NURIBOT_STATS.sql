/* *************************************************************************
 * NAME : dbo.UDP_MNT_NURIBOT_STATS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-11-30 14:16:23.877
 *        Modify: 2015-05-15 00:52:25.97
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc [dbo].[udp_mnt_nuribot_stats]
	@vcode	int = 0
,	@sdate	smalldatetime
,	@edate	smalldatetime
,	@statusflag char(1) = null
as
	set nocount on
	set transaction isolation level read uncommitted
	-- ------------------------
	-- 작성자 : wookki25
	-- 작성일 : 2007-11-30
	-- 설  명 : 업체별 통계정보
	-- ------------------------

	-- ssis
	if(exists(select * from tbl_nb_shoplist where vcode = @vcode and srvflag = 0))
		select
				vcode
		,		convert(varchar(16), sdate, 120) as sdate
		,		convert(varchar(16), date, 120) as edate
		,		allcnt
		,		case when addcnt < 0 then 0 else addcnt end as addcnt
		,		case when modcnt < 0 then 0 else modcnt end as modcnt
		,		case when delcnt < 0 then 0 else delcnt end as delcnt
		,		datediff(mi, sdate, date)/60 as duration_hh
		,		datediff(mi, sdate, date)%60 as duration_mi
		,		statusflag
		from	tbl_nb_shopstatics
		where	date >= @sdate
		and		date < dateadd(dd, 1, @edate)
		and		vcode = @vcode
		and		statusflag = isnull(@statusflag, statusflag)
		order by [no] desc

	-- vb
	else
		select	nbst_vcode
		,		convert(varchar(16), nbst_date, 120)	as sdate
		,		convert(varchar(16), getdate(), 120) as edate
		,		nbst_allcnt as allcnt
		,		case when nbst_addcnt < 0 then 0 else nbst_addcnt end as addcnt
		,		case when nbst_modcnt < 0 then 0 else nbst_modcnt end as modcnt
		,		case when nbst_delcnt < 0 then 0 else nbst_delcnt end as delcnt
		,		0 as duration_mi
		,		0 as duration_hh
		,		'T' as statusflag
		from	tbl_nb_statics
		where	nbst_date >= @sdate
		and		nbst_date < dateadd(dd, 1, @edate)
		and		nbst_vcode = @vcode
		order by nbst_no desc
