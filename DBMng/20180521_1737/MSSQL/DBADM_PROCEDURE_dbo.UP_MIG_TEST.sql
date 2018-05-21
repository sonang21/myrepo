/* *************************************************************************
 * NAME : dbo.UP_MIG_TEST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-04-04 10:05:37.863
 *        Modify: 2018-04-18 09:24:38.59
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROCEDURE [dbo].[UP_MIG_TEST]  @partition_no int = 1, @log_group varchar(50) = null
-- =============================================================================
-- 대상테이블 : GOODS_SUM (MIG_GOODS_SUM)
-- 소스테이블 : GOODS (OLD)
-- 설  명 : 
--------------------------------------------------------------------------------
-- 작성자 : 송정훈
-- 작성일 : 2018.03.21
-- ----------------------------------------------------------------------------
-- [이슈] : 파티션번호 대용량 순으로 실행 : 
--         (8,16,14,19,3,9,10,5,18,1,4,2,6,7,11,15,17,13,12)
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
    set @job_name = OBJECT_NAME(@@PROCID) + '(' + format(@partition_no, '0#') + ')';
    execute @log_id = UP_MIG_LOG_CREATE @job_name       = @job_name
                                      , @target_table   = 'MIG_TEST'
                                      , @source_table   = 'PRICELIST(OLD)'
                                      , @log_group      = @log_group
   
    -------------------------------------------------------------------------------
    -- 02. SOURCE_COUNT & TARGET_COUNT -- SKIP FOR PERF
    -------------------------------------------------------------------------------   
    -- SELECT @source_count = COUNT(*)                                                 
    --   FROM ELOC2001.dbo.ASIS_PRICELIST
    -- OPTION (MAXDOP 4);
    
    select -- a.id, a.indid, OBJECT_NAME(a.id, DB_ID('ELOC2001')) table_name, a.name index_name, a.rowcnt, a.rows
           @source_count = a.rowcnt 
      from ELOC2001.sys.sysindexes a
           join ELOC2001.sys.indexes   b on (b.object_id = id and b.index_id = a.indid)
     where a.id = OBJECT_ID('ELOC2001.dbo.ASIS_PRICELIST')
       and b.type <= 1
;
    
    -- IF (@target_count IS NULL) 
    --     set @target_count = @source_count;\
    select @target_count = count(*)
      from ELOC2001.dbo.asis_pricelist WITH (NOLOCK)
     where 1 = 1
       and ELOC2001.$PARTITION.PFN_PRICELIST(pl_vcode) = @partition_no
            -- and pl_vcode = @pl_vcode 
    option(recompile)  
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

        insert into ELOC2001.dbo.MIG_TEST
               ( pl_no
				 , pl_modelno
				 , pl_vcode
				 , pl_category
				 , pl_goodsnm
				 , pl_price
				 , pl_url
				 , pl_note
				 , pl_srvflag
				 , pl_status
				 , pl_authdate
				 , pl_soldoutflag
				 , pl_soldoutdate
				 , pl_date
				 , pl_rightnleft
				 , pl_multicomment
				 , pl_imgurl
				 , pl_coupon
				 , pl_airconfeetype
				 , pl_account_yn
				 , pl_esstockflag
				 , pl_instance_price
				 , pl_finalusedflag
				 , pl_goodsfactory
				 , pl_goodscode
				 , pl_dutycode
				 , pl_goodsnm_cs
				 , pl_url_cs
				 , pl_imgurlflag
				 , pl_deliveryinfo
				 , pl_freeinterest
				 , pl_nochange
				 , pl_goodscode_cs
				 , pl_agree_month
				 , pl_homeflag
				 , pl_price_card
				 , option_flag2
				 , catalog_flag
				 , pl_cashback
				 , pl_tag_price
				 , pl_call_plan
				 , pl_in_fee_yn
				 , pl_ship_fee_yn
				 , pl_bond_fee
				 , pl_penality_fee
				 --, PRICE_FLAG
				 , pl_delivery_lev
				 , pl_set_yn
				 , pl_store_flag
				 , pl_ca_code_dept
				 , pl_mobile_flag
				 , pl_deliveryinfo2
				 , pl_deliverytype2
				 , pl_copyplno
				 , pl_mobile_url
				 )
        select    pl_no
				 , pl_modelno
				 , pl_vcode
				 , pl_category
				 , pl_goodsnm
				 , pl_price
				 , pl_url
				 , pl_note
				 , pl_srvflag
				 , pl_status
				 , pl_authdate
				 , pl_soldoutflag
				 , pl_soldoutdate
				 , pl_date
				 , pl_rightnleft
				 , pl_multicomment
				 , pl_imgurl
				 , pl_coupon
				 , pl_airconfeetype
				 , pl_account_yn
				 , pl_esstockflag
				 , pl_instance_price
				 , pl_finalusedflag
				 , pl_goodsfactory
				 , pl_goodscode
				 , pl_dutycode
				 , pl_goodsnm_cs
				 , pl_url_cs
				 , pl_imgurlflag
				 , pl_deliveryinfo
				 , pl_freeinterest
				 , pl_nochange
				 , pl_goodscode_cs
				 , pl_agree_month
				 , pl_homeflag
				 , pl_price_card
				 , option_flag2
				 , catalog_flag
				 , pl_cashback
				 , pl_tag_price
				 , pl_call_plan
				 , pl_in_fee_yn
				 , pl_ship_fee_yn
				 , pl_bond_fee
				 , pl_penality_fee
				 --, PRICE_FLAG
				 , pl_delivery_lev
				 , pl_set_yn
				 , pl_store_flag
				 , pl_ca_code_dept
				 , pl_mobile_flag
				 , pl_deliveryinfo2
				 , pl_deliverytype2
				 , pl_copyplno
				 , pl_mobile_url
          from ELOC2001.dbo.asis_pricelist WITH (NOLOCK)
          where 1 = 1
            and ELOC2001.$PARTITION.PFN_PRICELIST(pl_vcode) = @partition_no
            -- and pl_vcode = @pl_vcode 
          option(recompile) 
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

