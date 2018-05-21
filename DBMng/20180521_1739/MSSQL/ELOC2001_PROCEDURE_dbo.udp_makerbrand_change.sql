/* *************************************************************************
 * NAME : dbo.udp_makerbrand_change
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 14:32:57.97
 *        Modify: 2018-05-16 10:58:39.76
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc [dbo].[udp_makerbrand_change]
as
begin
	set nocount on;
	set transaction isolation level read uncommitted;
	
	-- 처리이력은 1개월만 보관
	delete from tbl_makerbrand_change_log
	 where regdate <= dateadd(month, -1, cast(convert(varchar(10), getdate(), 120) as smalldatetime))
	option (maxdop 1)
	
	create table #log(
		modelno int,
		category varchar(12),
		maker_id int,
		brand_id int
	)
	
	create table #target(
		modelno int,
		factory varchar(500),
		brand varchar(500),
		chg_maker_id int,
		chg_brand_id int
	)
	
	declare @rowcount int
	set @rowcount = 500
	
	while @rowcount > 0
	begin
		truncate table #log
		truncate table #target
		
		set rowcount 500;
		delete from mss_bsc_atrib_list
		output deleted.modelno, deleted.g_factory, deleted.g_brand, deleted.mss_maker_id, deleted.mss_brand_id into #target
		set rowcount 0;
		
		update goods
		   set g_flag = '0'
		     , maker_id = chg_maker_id
			 , brand_id = chg_brand_id
			 , g_factory = (select maker_nm from tbl_enuri_maker where del_yn = 'n' and maker_id = chg_maker_id)
			 , g_brand   = (select brand_nm from tbl_enuri_brand where del_yn = 'n' and maker_id = chg_maker_id and brand_id = chg_brand_id)
		output deleted.g_modelno, deleted.g_category, deleted.maker_id, deleted.brand_id into #log
		  from goods a
				inner join #target b on b.modelno = a.g_modelno and g_factory = factory and g_brand = brand
		 where exists (select maker_id from tbl_enuri_maker where del_yn = 'n' and maker_id = chg_maker_id)
		   and exists (select brand_id from tbl_enuri_brand where del_yn = 'n' and maker_id = chg_maker_id and brand_id = chg_brand_id)
		option (maxdop 1)
		
		insert into tbl_makerbrand_change_log(modelno, category, maker_id, brand_id, flag)
		select modelno, category, maker_id, brand_id, '0'
		  from #log
		option (maxdop 1)
		
		-- 분산큐(goods)
		insert into?tb_model_chg_hst(model_no, pgm_id, dat_chg_dcd, frw_yn, orgn_dtm)
		select modelno, 'db_proc', 'U', 'N', getdate()
		  from #log
		
		set @rowcount = @@rowcount
	end
end