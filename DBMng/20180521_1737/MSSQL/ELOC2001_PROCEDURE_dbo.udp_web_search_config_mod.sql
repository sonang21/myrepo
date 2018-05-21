/* *************************************************************************
 * NAME : dbo.udp_web_search_config_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-09-15 10:30:56.597
 *        Modify: 2018-05-03 17:23:35.12
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_web_search_config_mod
	@category varchar(8)
,	@is_bracket bit
,	@is_condition	bit
,	@is_brand	bit
,	@is_factory	bit
,	@is_bracket_in bit
,	@data_kind char(1)
,	@is_auto_match bit
,	@is_serial_no bit
,	@pop_max_rank	smallint
,	@price_min_ratio	numeric(4,1)
,	@price_max_ratio	numeric(4,1)
,	@search_order	int
,	@search_group	int
,	@exclude_category_csv varchar(200)
,	@week_day_mon varchar(1)
,	@week_day_tuh varchar(1)
,	@week_day_wed varchar(1)
,	@week_day_thu varchar(1)
,	@week_day_fri varchar(1)
,	@week_day_sat varchar(1)
,	@week_day_sun varchar(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.09.14
	-- 설  명 : 웹검색 기준 설정
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	update tbl_web_search_config
	set is_bracket = @is_bracket
	,	is_condition = @is_condition
	,	is_brand = @is_brand
	,	is_factory = @is_factory
	,	is_bracket_in = @is_bracket_in
	,	mod_date = getdate()
	,	data_kind = @data_kind
	,	is_auto_match = @is_auto_match
	,	is_serial_no = @is_serial_no
	,	pop_max_rank = @pop_max_rank
	,	price_min_ratio = @price_min_ratio
	,	price_max_ratio = @price_max_ratio
	,	search_order = @search_order
	,	exclude_category_csv = @exclude_category_csv
	,	week_day_mon = @week_day_mon
	,	week_day_tuh = @week_day_tuh
	,	week_day_wed = @week_day_wed
	,	week_day_thu = @week_day_thu
	,	week_day_fri = @week_day_fri
	,	week_day_sat = @week_day_sat
	,	week_day_sun = @week_day_sun
	where category = @category
	and search_group = @search_group








