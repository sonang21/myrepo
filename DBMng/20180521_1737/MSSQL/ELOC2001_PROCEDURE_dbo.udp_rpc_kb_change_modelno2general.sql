/* *************************************************************************
 * NAME : dbo.udp_rpc_kb_change_modelno2general
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-01-08 13:05:47.303
 *        Modify: 2018-05-03 17:23:34.903
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE   proc [dbo].[udp_rpc_kb_change_modelno2general]
	@g_modelno	int
as
begin
	set nocount on
	set transaction isolation level read uncommitted

	-- ���ȶ����� 164������ 50�� ��
	exec mpdb02.knowboxdb2.dbo.udp_kb_change_modelno2general @g_modelno
end