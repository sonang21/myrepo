/* *************************************************************************
 * NAME : dbo.up_mig_log_create
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-02 14:37:13.217
 *        Modify: 2018-04-18 09:20:37.137
 *        Backup: 20180521_1739
 ************************************************************************* */





----------------------------------------------------------------------------------------------------

CREATE procedure [dbo].[up_mig_log_create] 
      @job_name      varchar(100)
    , @job_id        varchar(30)    = null
    , @target_table  varchar(100)   = null
    , @source_table  varchar(1000)  = null
    , @log_group     varchar(50)    = null
as 
    declare @log_id bigint;
begin 
    set nocount on;
    select @log_id = next value for sq_mig_log;
    
    insert into tb_mig_log (log_id, log_group, job_name, job_id, target_table, source_table, status, log_time )
    values(@log_id, @log_group, @job_name, @job_id, @target_table, @source_table, 'READY', getdate());
    return(@log_id);
end;

