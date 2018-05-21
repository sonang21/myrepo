/* *************************************************************************
 * NAME : dbo.udp_group_matching_goods_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-07-19 10:42:00.363
 *        Modify: 2018-05-07 16:57:30.417
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_group_matching_goods_ins
 	@g_category			char(8)
,	@g_modelnm			nvarchar(140)
, 	@g_modelnm_new	    nvarchar(140)
, 	@g_spec				nvarchar(700)
, 	@g_date				smalldatetime
,	@g_imgchk			char(1)
,	@g_constrain		char(1)
,	@g_popular			int
, 	@g_jobcode			varchar(3)
,	@g_mallcnt			int
, 	@g_minprice			money
, 	@g_keyword			nvarchar(600)
,	@brand_id			int
,	@maker_id			int
, 	@g_brand			nvarchar(100)
, 	@g_factory			nvarchar(100)
,	@g_brand_new		nvarchar(100)
,	@g_factory_new		nvarchar(100)

,	@return_modelno		int output
as
begin
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 그룹매칭.모델추가 / 2017.07.19
	-- 설  명 : wookki25 
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	Declare @tmp table(g_modelno int)

	begin try
		insert 
          into goods
		       ( g_category
               , g_modelno
               , g_modelnm
               , g_modelnm_new
               , g_spec
               , g_date
               , g_imgchk
               , g_constrain
               --, g_popular
               , g_jobcode
               --, g_mallcnt
               , g_openexpectflag
               , g_flag
               --, g_minprice
               , g_keyword
               , brand_id
               , maker_id
               , g_brand
               , g_factory
               , g_brand_new
               , g_factory_new )
		       output inserted.g_modelno 
                 into @tmp
		 select 
                @g_category
              , MAX(a.g_modelno)+1
              , @g_modelnm
              , @g_modelnm_new
              , @g_spec
              , @g_date
              , @g_imgchk
              , @g_constrain
              --, @g_popular
              , @g_jobcode
              --, @g_mallcnt
              , '0'
              , '2'
              --, @g_minprice
              , @g_keyword
              , @brand_id
              , @maker_id
              , @g_brand
              , @g_factory
              , @g_brand_new
              , @g_factory_new
		 from goods a inner join goods_sum b on a.g_modelno = b.g_modelno


         insert 
           into tb_model_chg_hst
                ( modelno
                , pgm_id
                , dat_chg_dcd
                , wrk_yn
                , chg_dtm )
         select modelno
              , '그룹매칭'
              , 'C'
              , 'N'
              , getdate()
           from #tmp

		select 
               @return_modelno = g_modelno 
          from @tmp

	end try
	begin catch
		select @return_modelno = -1
	end catch
	
end


