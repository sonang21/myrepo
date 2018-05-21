/* *************************************************************************
 * NAME : dbo.udp_web_search_config_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-09-15 10:31:13.5
 *        Modify: 2018-05-03 17:23:35.193
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_web_search_config_ins
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
	insert into tbl_web_search_config(category, is_bracket, is_condition, is_brand, is_factory, is_bracket_in, data_kind
	, is_auto_match, is_serial_no, search_order, search_group, pop_max_rank, price_min_ratio, price_max_ratio 
	, exclude_category_csv
	, week_day_mon
	, week_day_tuh
	, week_day_wed
	, week_day_thu
	, week_day_fri
	, week_day_sat
	, week_day_sun

	) 
	values (@category, @is_bracket, @is_condition, @is_brand, @is_factory, @is_bracket_in, @data_kind
	, @is_auto_match, @is_serial_no, @search_order, @search_group, @pop_max_rank, @price_min_ratio, @price_max_ratio
	, @exclude_category_csv
	, @week_day_mon
	, @week_day_tuh
	, @week_day_wed
	, @week_day_thu
	, @week_day_fri
	, @week_day_sat
	, @week_day_sun
	)


