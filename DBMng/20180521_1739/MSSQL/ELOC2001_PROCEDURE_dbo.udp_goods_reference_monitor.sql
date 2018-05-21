/* *************************************************************************
 * NAME : dbo.udp_goods_reference_monitor
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-20 15:29:32.747
 *        Modify: 2018-05-20 15:29:32.747
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_goods_reference_monitor
as begin
	set nocount on
	set transaction isolation level  read uncommitted


    truncate table goods_reference_monitor

    insert into goods_reference_monitor(g_refid, g_factory, g_category, goods_cnt)
    select g_refid, g_factory, left(g_category, 6) as g_category, count(*) as goods_cnt
      from goods a with (readuncommitted) 
           inner join goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
     where g_jobcode >= '1' 
       and g_constrain = '1' 
       and g_mallcnt > 0 
       and g_minprice > 0 
       and g_refid >0
     group by g_refid, g_factory, left(g_category, 6)
end 