/* *************************************************************************
 * NAME : dbo.udp_goods_chk_unit_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-20 15:19:08.683
 *        Modify: 2018-05-20 15:27:05.37
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_goods_chk_unit_ins
as begin
	set nocount on
	set transaction isolation level  read uncommitted

    -- 매월 15일에만 입력
    if day(getdate()) = 15 begin
	    truncate table goods_chk_unit_value

	    insert into goods_chk_unit_value(g_category, g_u_nit)
	    select distinct left(g_category,4) mcate, g_u_nit 
          from goods with (readuncommitted)	
	     where g_category not like '93%' 
           and g_u_nit is not null
	     option (maxdop 1)
    end
End
