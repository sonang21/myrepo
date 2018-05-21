/* *************************************************************************
 * NAME : dbo.UP_MIG_JOB_RUNS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-18 09:47:29.327
 *        Modify: 2018-04-18 11:58:38.673
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[UP_MIG_JOB_RUNS] @job_group varchar(100), @log_group varchar(20)
AS
/* *****************************************************************************
-- PROCEDURE : UP_MIG_JOB_RUNS
-- 설  명 : TB_MIG_JOBS에서 RUN_STAT='READY'인 JOB을 추출하여 (RUN_STAT='START')로 변경하고
--          UP_MIG_JOB_RUN에 해당 JOB을 전달하여 수행하고, 대상 JOB이 없을 때까지 반복 수행
-- Params : @job_id : 실행할 JOB의 ID
--          @log_group : 로그 테이블에 적용할 로그그룹
--------------------------------------------------------------------------------
-- 작성자 : 송정훈
-- 작성일 : 2018.04.181
-- ----------------------------------------------------------------------------
***************************************************************************** */
BEGIN
    --declare @log_group  varchar(20) = '0418_TEST'  
    --declare @job_group  varchar(20) = 'ST101';
    ------------------------------------------------------------------------
    declare @job_id     varchar(20);  
    declare @job_nm     varchar(100);
    declare @job_type   varchar(20);
    declare @target_tbl varchar(100);
    -- declare @cmd_sql    nvarchar(max);
    ------------------------------------------- 
    --declare @log_id     bigint;
    --declare @err_cod    int;
    --declare @err_sta    smallint;        -- error state
    --declare @err_msg    varchar(4000);   -- error message
    --declare @err_svr    smallint;        -- error serverity
    --declare @err_lin    int;             -- error line
    declare @fetchStat   integer = 0;

    declare mig_cur cursor for 
            select top 1 
                   job_id, job_nm, job_type, target_tbl
              from dbadm.dbo.tb_mig_jobs
             where job_group like @job_group 
               and run_stat = 'READY'
             order by priority
             for update of run_stat, log_id;

    while @fetchStat = 0 
    begin
        open mig_cur;
        fetch next from mig_cur into @job_id, @job_nm, @job_type, @target_tbl
        set @fetchStat = @@FETCH_STATUS;
        -- print 'DEBUG: @fetchStat = ' + convert(varchar, @fetchStat);
        if @fetchStat = 0
        begin
            ----------------------------------------------------------------------------
            update tb_mig_jobs set run_stat = 'START', log_id=0 where current of mig_cur;
            ----------------------------------------------------------------------------
            execute DBADM.dbo.UP_MIG_JOB_RUN @job_id = @job_id, @log_group=@log_group;
            ----------------------------------------------------------------------------
            -- print 'DEBUG: ID: ' + @job_id + ', JOB: ' + @job_nm + ', TBL: '+ @target_tbl;
            -- print @cmd_sql;
        end;
        close mig_cur;
    end;

    deallocate mig_cur;
END;
