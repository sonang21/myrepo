/* *************************************************************************
 * NAME : dbo.udp_enuri_keyword_log_rename
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-20 13:15:18.4
 *        Modify: 2013-09-03 15:54:08.483
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_enuri_keyword_log_rename]
as
begin
	set nocount on
	set transaction isolation level read uncommitted
    set lock_timeout 5000

	if exists (select * from dbo.sysobjects where id = object_id(N'[tbl_enuri_keyword_log_old]') and objectproperty(id, N'isusertable') = 1)
		drop table [tbl_enuri_keyword_log_old]
	
	if exists (select * from dbo.sysobjects where id = object_id(N'[tbl_enuri_keyword_log_new]') and objectproperty(id, N'isusertable') = 1)
		drop table [tbl_enuri_keyword_log_new]

	create table [tbl_enuri_keyword_log_new](
		[ek_no] [int] not null,
		[enuri_keyword] [varchar](100)  not null,
		[ca_code] [varchar](12) not null,
		[mm_id] [varchar](12) not null,
		[regdate] [datetime] not null default (getdate()),
		[is_del] bit not null
	) on [primary]
	
	exec sp_rename 'tbl_enuri_keyword_log', 'tbl_enuri_keyword_log_old'
	exec sp_rename 'tbl_enuri_keyword_log_new', 'tbl_enuri_keyword_log'
end




