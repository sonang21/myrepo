/* *************************************************************************
 * NAME : dbo.vw_sessions
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2018-04-02 14:37:13.177
 *        Modify: 2018-04-19 13:13:22.327
 *        Backup: 20180521_1737
 ************************************************************************* */



----------------------------------------------------------------------------------------------------

CREATE view [dbo].[vw_sessions]
as
select
       a.session_id                                                     as spid  -- session_id
     , a.blocking_session_id                                            as block -- blocking_session_id
     , a.wait_type
     , case when a.statement_end_offset = -1 then d.text 
            else substring(
                     d.text
                   , a.statement_start_offset / 2 + 1
                   , (a.statement_end_offset - statement_start_offset) / 2 + 1
			     )
       end                                                              as query_text
     , b.program_name
     , b.host_name
     , c.client_net_address
     , right('0' + cast(a.total_elapsed_time/1000/60/60              as varchar), 2)
       + ':' + right('0' + cast((a.total_elapsed_time/1000/60) % 60  as varchar), 2)
       + ':' + right('0' + cast((a.total_elapsed_time/1000)    % 60  as varchar), 2) as elapsed_hms
     , a.total_elapsed_time
     , a.cpu_time
     , a.logical_reads
     , a.reads                                                          as physical_reads
     , a.writes
     , d.text                                                           as sql_full_text
     , a.status
     , a.start_time
--   , 'exec sp_plan ' + cast(a.session_id as varchar(10))              as show_plan
     , a.plan_handle
     , getdate()                                                        as log_dt
     , a.percent_complete
     , right('0' + cast(a.estimated_completion_time/1000/60/60              as varchar), 2)
       + ':' + right('0' + cast((a.estimated_completion_time/1000/60) % 60  as varchar), 2)
       + ':' + right('0' + cast((a.estimated_completion_time/1000)    % 60  as varchar), 2) as estimated_completion_time
  from sys.dm_exec_requests                 a
       inner join sys.dm_exec_sessions      b on (a.session_id = b.session_id)
       inner join sys.dm_exec_connections   c on (a.session_id = c.session_id)
       cross apply sys.dm_exec_sql_text(a.sql_handle) as d
 where a.session_id > 50
 --order by a.session_id
;

