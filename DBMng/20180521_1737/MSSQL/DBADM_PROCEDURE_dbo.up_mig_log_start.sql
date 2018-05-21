/* *************************************************************************
 * NAME : dbo.up_mig_log_start
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-02 14:37:13.247
 *        Modify: 2018-04-02 14:37:13.247
 *        Backup: 20180521_1737
 ************************************************************************* */


----------------------------------------------------------------------------------------------------

create procedure [dbo].[up_mig_log_start] 
      @log_id       bigint 
    , @source_cnt   bigint
    , @target_cnt   bigint
as 
    declare @err_sta   smallint;
    declare @err_msg   varchar(4000);
begin
    set nocount on;
    update dbo.tb_mig_log
       set source_cnt   = @source_cnt
         , target_cnt   = @target_cnt
         , status       = 'RUNNING'
         , start_time   = getdate()
         , log_time     = getdate()
     where log_id = @log_id
       and status = 'READY';

     if (@@ROWCOUNT < 1) 
     begin
        set @err_msg = 'ERROR(' + OBJECT_NAME(@@PROCID) + '): LOG_ID(' + convert(varchar, @log_id) + ') is not READY'
        raiserror (@err_msg, 16, 1) with nowait
     end
end;

