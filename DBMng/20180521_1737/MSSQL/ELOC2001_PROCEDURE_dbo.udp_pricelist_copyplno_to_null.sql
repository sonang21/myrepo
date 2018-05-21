/* *************************************************************************
 * NAME : dbo.udp_pricelist_copyplno_to_null
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-07-27 08:48:28.67
 *        Modify: 2018-05-03 17:23:36.127
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_pricelist_copyplno_to_null
as  
begin  
	/***********************************************
	-- �� �� �� : wookki25
	-- �� �� �� : 2012.07.26
	-- ��    �� : ���һ�ǰ�� 1���� ���� �ִ� ��� �Ϲ� ��ǰ���� ��ȯ
	***********************************************/
	set nocount on  
	set transaction isolation level read uncommitted  

	declare @s_seq int, @mod_cnt int
	set @s_seq = 1
	set @mod_cnt = 1000
	declare @pricelist_copyplno table(seq int identity(1,1) primary key, pl_copyplno bigint)
	insert into @pricelist_copyplno
	select pl_copyplno from pricelist group by pl_copyplno having count(*) = 1 option (maxdop 1)

	update	pricelist 
	set pl_copyplno = null
	where	pl_copyplno in (select pl_copyplno from @pricelist_copyplno where seq >= @s_seq and seq < @s_seq+@mod_cnt)
	while @@rowcount = @mod_cnt
	begin
		set @s_seq = @s_seq + @mod_cnt

		update	pricelist 
		set pl_copyplno = null
		where	pl_copyplno in (select pl_copyplno from @pricelist_copyplno where seq >= @s_seq and seq < @s_seq+@mod_cnt)	
	end
end


