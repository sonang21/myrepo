/* *************************************************************************
 * NAME : dbo.sp_help_info
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-03-28 11:38:15.757
 *        Modify: 2012-03-28 11:40:12.457
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc sp_help_info
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-03-28
	-- 설  명 : 서버 정보
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
select 
	DATEADD(s,((-1)*([ms_ticks]/1000)),GETDATE()) AS time_of_last_restart
,	CAST([ms_ticks]/1000/60/60/24.0 AS DECIMAL(15,2)) AS days_since_restart
,	cpu_count as total_logical_cpu_in_server
--,	hyperthread_ratio
--,	cpu_count/hyperthread_ratio as physical_cpu_in_server
--converting bytes of physical memory to mb
,	round((physical_memory_in_bytes/1024)/1024/1024.0, 0) as total_memory_of_server_in_gb
--,	round((virtual_memory_in_bytes/1024)/1024/1024.0, 0) as current_usage_of_memory_sqlserver_in_gb
--	following fields will work only in sql server 2008+
--	if you are using sql server 2005, comment following field.
--,	sqlserver_start_time      
from sys.dm_os_sys_info 
