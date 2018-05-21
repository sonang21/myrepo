/* *************************************************************************
 * NAME : dbo.UP_MIG_GOODS_SUM
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-02 14:38:33.29
 *        Modify: 2018-04-18 09:22:54.33
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[UP_MIG_GOODS_SUM]  @log_group varchar(50) = null
-- =============================================================================
-- 대상테이블 : GOODS_SUM (MIG_GOODS_SUM)
-- 소스테이블 : GOODS (OLD)
-- 설  명 : 
--------------------------------------------------------------------------------
-- 작성자 : 송정훈
-- 작성일 : 2018.03.21
-- ----------------------------------------------------------------------------
-- [이슈] : 
-- 
-- COUNT:
-- =============================================================================
AS 
BEGIN
    set nocount on
    set transaction isolation level read uncommitted;
    -----------------------------------------------------------------------------
    declare @source_count  bigint ;
    declare @target_count  bigint ;
    declare @result_count  bigint = 0;
    declare @work_count    bigint = 0;
    declare @work_unit     bigint = 1000000;
    declare @log_id        bigint;
    declare @job_name      varchar(50);
    declare @err_cod   int;
    declare @err_sta   smallint;        -- error state
    declare @err_msg   varchar(4000);   -- error message
    declare @err_svr   smallint;        -- error serverity
    declare @err_lin   int;             -- error line
    -----------------------------------------------------------------------------
    -- 01. UP_MIG_LOG_CREATE 
    -----------------------------------------------------------------------------
    set @job_name = OBJECT_NAME(@@PROCID);
    execute @log_id = UP_MIG_LOG_CREATE @job_name       = @job_name
                                      , @target_table   = 'MIG_GOODS_SUM'
                                      , @source_table   = 'GOODS(OLD)'
                                      , @log_group      = @log_group
   
    -------------------------------------------------------------------------------
    -- 02. SOURCE_COUNT & TARGET_COUNT -- SKIP FOR PERF
    -------------------------------------------------------------------------------   
    SELECT @source_count = COUNT(*)                                                 
      FROM ELOC2001.dbo.ASIS_GOODS 
    OPTION (MAXDOP 4);
    
    IF (@target_count IS NULL) 
        set @target_count = @source_count;
    -------------------------------------------------------------------------------
    --03. UP_MIG_LOG_START
    -------------------------------------------------------------------------------    
    execute UP_MIG_LOG_START @log_id        = @log_id
                           , @source_cnt    = @source_count
                           , @target_cnt    = @target_count 
    ;
  
    /* *******************************************************************************
    -- 05. MIG SQL
    ---------------------------------------------------------------------------------
    WHILE V_WORK_COUNT <= V_TARGET_COUNT
    LOOP
        -- DO SOMETHING
        V_WORK_COUNT := V_WORK_COUNT + V_WORK_UNIT;
    END;    
    ******************************************************************************* */  
    BEGIN TRY 
    ----------------------------------------------------------------------------
        -- execute sp_executesql N'select * from tab where id=@id', N'@id int', @id=100;
        -- truncate table ELOC2001.dbo.mig_goods_sum;
        -- RAISERROR('Test Error Injeced', 16, 1); 

        insert into ELOC2001.dbo.mig_goods_sum
             ( g_modelno
             , g_minprice
             , g_avgprice
             , g_maxprice
             , g_mallcnt
             , g_popular
             , g_sale_cnt
             , g_info_point1
             , g_info_point2
             , g_info_point3
             , g_minprice3
             )
        select 
               g_modelno
             , g_minprice
             , g_avgprice
             , g_maxprice
             , g_mallcnt
             , g_popular
             , g_sale_cnt
             , g_info_point1
             , g_info_point2
             , g_info_point3
             , g_minprice3
          from ELOC2001.dbo.asis_goods with(nolock)
        ;
    
    ----------------------------------------------------------------------------
        set @result_count = @result_count + @@ROWCOUNT;
        -- COMMIT;
    -------------------------------------------------------------------------------
    --06. UP_MIG_LOG_END
    -------------------------------------------------------------------------------
        execute UP_MIG_LOG_END @log_id       = @log_id 
                             , @result_cnt   = @result_count
        ;

    END TRY 
    BEGIN CATCH
    -------------------------------------------------------------------------------
    --07. UP_MIG_LOG_END : ERROR
    -------------------------------------------------------------------------------
        select @err_cod = @@ERROR 
             , @err_msg = ERROR_MESSAGE() + ' (Line:' + CONVERT(nvarchar, ERROR_LINE()) +')'
             , @err_sta = ERROR_STATE()
             , @err_svr = ERROR_SEVERITY()
             , @err_lin = ERROR_LINE()
        ;
        
        execute UP_MIG_LOG_END @log_id    
                             , @result_cnt  = @result_count
                             , @res_code    = 'ERROR'
                             , @error_code  = @err_cod
                             , @error_msg   = @err_msg
        ;
        
    END CATCH 
END;

