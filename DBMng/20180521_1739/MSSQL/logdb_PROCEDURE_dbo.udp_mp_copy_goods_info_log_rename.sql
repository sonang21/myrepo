/* *************************************************************************
 * NAME : dbo.udp_mp_copy_goods_info_log_rename
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-10 15:47:57.48
 *        Modify: 2014-04-10 15:47:57.48
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc [dbo].[udp_mp_copy_goods_info_log_rename]
as
begin
	set nocount on
	set transaction isolation level read uncommitted
    set lock_timeout 5000

	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbl_mp_copy_goods_info_log_old]') and objectproperty(id, N'isusertable') = 1)
	drop table [dbo].[tbl_mp_copy_goods_info_log_old]
	
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbl_mp_copy_goods_info_log_new]') and objectproperty(id, N'isusertable') = 1)
	drop table [dbo].[tbl_mp_copy_goods_info_log_new]
	
	CREATE TABLE [dbo].[tbl_mp_copy_goods_info_log_new](
		[seqno] [int] IDENTITY(1,1) NOT NULL,
		[copy_desc] [varchar](3000) COLLATE Korean_Wansung_CI_AS NOT NULL,
		[mm_id] [varchar](12) COLLATE Korean_Wansung_CI_AS NOT NULL,
		[regdate] [datetime] NOT NULL DEFAULT (getdate())
	) on [primary]
	
	exec sp_rename 'tbl_mp_copy_goods_info_log', 'tbl_mp_copy_goods_info_log_old'
	exec sp_rename 'tbl_mp_copy_goods_info_log_new', 'tbl_mp_copy_goods_info_log'
end








