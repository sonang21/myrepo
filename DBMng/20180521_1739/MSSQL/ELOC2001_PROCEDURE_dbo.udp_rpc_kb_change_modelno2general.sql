/* *************************************************************************
 * NAME : dbo.udp_rpc_kb_change_modelno2general
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-01-08 13:05:47.303
 *        Modify: 2018-05-03 17:23:34.903
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE   proc [dbo].[udp_rpc_kb_change_modelno2general]
	@g_modelno	int
as
begin
	set nocount on
	set transaction isolation level read uncommitted

	-- 보안때문에 164번에서 50번 콜
	exec mpdb02.knowboxdb2.dbo.udp_kb_change_modelno2general @g_modelno
end