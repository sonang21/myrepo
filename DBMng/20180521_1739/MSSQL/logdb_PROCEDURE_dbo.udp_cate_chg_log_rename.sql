/* *************************************************************************
 * NAME : dbo.udp_cate_chg_log_rename
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-03-18 17:49:51.673
 *        Modify: 2013-03-19 09:01:13.847
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_cate_chg_log_rename]
as
begin
	set nocount on
	set transaction isolation level read uncommitted
    set lock_timeout 5000

	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbl_cate_chg_log_old]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[tbl_cate_chg_log_old]
	
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbl_cate_chg_log_new]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[tbl_cate_chg_log_new]

	CREATE TABLE [dbo].[tbl_cate_chg_log_new](
		[del_cate] [varchar](12)
	,	[new_cate] [varchar](12)
	,	[mm_id] [varchar](12)
	,	[mm_nm] [varchar](12)
	,	[chg_flag] [char](1)
	,	[regdate] [datetime] NOT NULL DEFAULT (getdate())
	)
	
	
	EXEC SP_RENAME 'tbl_cate_chg_log', 'tbl_cate_chg_log_old'
	EXEC SP_RENAME 'tbl_cate_chg_log_new', 'tbl_cate_chg_log'
END