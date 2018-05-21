/* *************************************************************************
 * NAME : dbo.vw_sessions2
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2018-04-02 14:37:13.197
 *        Modify: 2018-04-17 12:46:49.75
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE view [dbo].[vw_sessions2]
as
select a.session_id                                                     as session_id
     , b.session_id                                                     as spid
     , c.blocking_session_id                                            as block_spid
     , c.wait_type
     , case when c.statement_end_offset = -1 then d.text 
            else substring(
                     d.text
                   , c.statement_start_offset / 2 + 1
                   , (c.statement_end_offset - statement_start_offset) / 2 + 1
			     )
       end                                                              as query_text
     , b.program_name
     , b.host_name
     , a.client_net_address
     , right('0' + cast(c.total_elapsed_time/1000/60/60              as varchar), 2)
       + ':' + right('0' + cast((c.total_elapsed_time/1000/60) % 60  as varchar), 2)
       + ':' + right('0' + cast((c.total_elapsed_time/1000)    % 60  as varchar), 2) as elapsed_hms
     , c.total_elapsed_time
     , c.cpu_time
     , c.logical_reads
     , c.reads                                                          as physical_reads
     , c.writes
     , d.text                                                           as sql_full_text
     -- , c.status
     , b.status
     , c.start_time
--   , 'exec sp_plan ' + cast(a.session_id as varchar(10))              as show_plan
     , c.plan_handle
     , getdate()                                                        as log_dt
     , c.percent_complete
     , right('0' + cast(c.estimated_completion_time/1000/60/60              as varchar), 2)
       + ':' + right('0' + cast((c.estimated_completion_time/1000/60) % 60  as varchar), 2)
       + ':' + right('0' + cast((c.estimated_completion_time/1000)    % 60  as varchar), 2) as estimated_completion_time
     , b.last_request_start_time                                        as last_start
     , b.last_request_end_time                                          as last_end
  from sys.dm_exec_connections             a 
       inner join sys.dm_exec_sessions      b on (b.session_id = a.session_id)
       left join sys.dm_exec_requests      c on (c.session_id = a.session_id) -- left join for all sessions
       -- cross apply sys.dm_exec_sql_text(c.sql_handle) as d
       outer apply sys.dm_exec_sql_text(c.sql_handle) as d
 -- where 1 = 1
 --  and a.session_id > 50 -- exclude background session
 --  and b.last_request_start_time >= convert(date, getdate())
 -- and c.session_id is not null
 -- order by a.session_id
;

