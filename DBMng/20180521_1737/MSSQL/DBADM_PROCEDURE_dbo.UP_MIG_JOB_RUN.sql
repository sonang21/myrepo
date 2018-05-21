/* *************************************************************************
 * NAME : dbo.UP_MIG_JOB_RUN
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-18 09:28:56.71
 *        Modify: 2018-04-19 13:53:55.473
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[UP_MIG_JOB_RUN] @job_id varchar(10), @log_group varchar(20)
/* *****************************************************************************
-- PROCEDURE : UP_MIG_JOB_RUN
-- 설  명 : TB_MIG_jOBS에 정의된 JOB을 JOB_ID로 선택하여 실행
-- Params : @job_id : 실행할 JOB의 ID
--          @log_group : 로그 테이블에 적용할 로그그룹
--------------------------------------------------------------------------------
-- 작성자 : 송정훈
-- 작성일 : 2018.04.181
-- ----------------------------------------------------------------------------
***************************************************************************** */
AS 
BEGIN
    set nocount on;
    -- declare @log_group  varchar(20) = '0417_X01p9'  
    -- declare @job_id     varchar(20);  
    declare @job_nm     varchar(100);
    declare @job_group  varchar(20);
    declare @job_type   varchar(20);
    declare @target_db  varchar(100);
    declare @target_tbl varchar(100);
    declare @source_tbl varchar(100);
    declare @cmd_sql    nvarchar(max);

    declare @log_id     bigint;
    declare @err_cod    int;
    declare @err_sta    smallint;        -- error state
    declare @err_msg    varchar(4000);   -- error message
    declare @err_svr    smallint;        -- error serverity
    declare @err_lin    int;             -- error line
    declare @newline    varchar(4) = char(13) + char(10);

    select @job_nm     = job_nm
         , @job_group  = job_group
         , @job_type   = job_type
         , @target_db  = target_db 
         , @target_tbl = target_tbl
         , @source_tbl = source_tbl
         , @cmd_sql    = cmd_sql 
      from dbadm.dbo.tb_mig_jobs
     where job_id = @job_id
       --and run_stat = 'START'
    ;

    print '---------------------------------------------------------------------------';
    print '## ID: ' + @job_id + ', JOB: ' + @job_nm + ', DB: ' + @target_db + ', TBL: ' + @target_tbl;
    print '---------------------------------------------------------------------------';
    set @log_group = @log_group + '(' + convert(varchar, @@spid) + ')';

    execute @log_id = DBADM.dbo.UP_MIG_LOG_CREATE @job_name       = @job_nm
                                                , @job_id         = @job_id
                                                , @target_table   = @target_tbl
                                                , @source_table   = @source_tbl
                                                , @log_group      = @log_group;
    execute DBADM.dbo.UP_MIG_LOG_START @log_id = @log_id, @source_cnt=1, @target_cnt=1;   
    
	BEGIN TRY
        update TB_MIG_JOBS set run_stat = 'RUNNING', log_id = @log_id where job_id = @job_id;

        set @cmd_sql = 'USE [' + @target_db + '];' + @newline
                       + '' + @newline 
                       + @cmd_sql;         
		-- print @cmd_sql;
        execute sp_executesql @cmd_sql;

        execute DBADM.dbo.UP_MIG_LOG_END @log_id = @log_id, @result_cnt=1;
        update TB_MIG_JOBS set run_stat = 'SUCCESS' where job_id = @job_id;

	END TRY
    BEGIN CATCH
        select @err_cod = @@ERROR 
             , @err_msg = ERROR_MESSAGE() + ' (Line:' + CONVERT(nvarchar, ERROR_LINE()) +')'
             , @err_sta = ERROR_STATE()
             , @err_svr = ERROR_SEVERITY()
             , @err_lin = ERROR_LINE()
        ;
        
        execute UP_MIG_LOG_END @log_id    
                             , @result_cnt  = -1
                             , @res_code    = 'ERROR'
                             , @error_code  = @err_cod
                             , @error_msg   = @err_msg
        ;
        update TB_MIG_JOBS set run_stat = 'ERROR' where job_id = @job_id;
        
        print @err_msg;
    END CATCH;
    
END;

