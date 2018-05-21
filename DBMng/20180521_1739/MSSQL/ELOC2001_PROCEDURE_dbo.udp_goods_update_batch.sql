/* *************************************************************************
 * NAME : dbo.udp_goods_update_batch
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-03-07 14:40:39.117
 *        Modify: 2018-05-03 17:23:35.643
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc [dbo].[udp_goods_update_batch]
as
begin
	set nocount on;
	set transaction isolation level read uncommitted;

	create table #target_goods(batch_type varchar(20), modelno int)

	set rowcount 500;
	delete from goods_update_target
	output deleted.batch_type, deleted.g_modelno into #target_goods
	option (maxdop 1)
	set rowcount 0;

	select batch_type, modelno, isnull(g_category, '00000000') category, isnull(g_modelnm, '¸ðµ¨»èÁ¦') modelnm
	  from #target_goods
		left join goods on g_modelno = modelno
	option (maxdop 1)
end
