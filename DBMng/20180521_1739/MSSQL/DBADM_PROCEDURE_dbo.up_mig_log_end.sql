/* *************************************************************************
 * NAME : dbo.up_mig_log_end
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-02 14:37:13.263
 *        Modify: 2018-04-02 14:37:13.263
 *        Backup: 20180521_1739
 ************************************************************************* */



----------------------------------------------------------------------------------------------------

create procedure [dbo].[up_mig_log_end] 
      @log_id       bigint
    , @result_cnt   bigint           = null
    , @res_code     varchar(10)      = null
    , @error_code   varchar(10)      = null
    , @error_msg    varchar(500)     = null
as
    declare @err_sta   smallint;
    declare @err_msg   varchar(4000);
begin 
    set nocount on;
    
    begin try
        update dbo.tb_mig_log
           set res_code     = case when @res_code is null then 
                                        case when target_cnt = @result_cnt then 'SUCCESS'
                                             else 'FAIL'
                                        end
                                   else @res_code
                              end
             , result_cnt   = @result_cnt
             , error_code   = @error_code
             , error_msg    = @error_msg
             , status       = 'END'
             , end_time     = getdate()
             , log_time     = getdate()
         where log_id = @log_id
           and status = 'RUNNING';
         
         if (@@ROWCOUNT < 1) 
         begin
            set @err_msg = 'ERROR(' + OBJECT_NAME(@@PROCID) + '): LOG_ID(' + convert(varchar, @log_id) + ') is not RUNNING'
            raiserror (@err_msg, 16, 1) with nowait
         end;
    end try
    begin catch
        select @err_msg = ERROR_MESSAGE()
             , @err_sta = ERROR_STATE()
             -- , @err_svr = ERROR_SERVERITY()
        ;
        
        throw 50001, @err_msg, @err_sta
    end catch
end;

