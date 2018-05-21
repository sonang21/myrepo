/* *************************************************************************
 * NAME : dbo.udp_web_search_config_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-09-15 10:32:29.01
 *        Modify: 2018-05-03 17:23:35.647
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_web_search_config_sel
	@category varchar(4)
,	@search_group int
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.05.12
	-- 설  명 : cm  재택근무
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select category, is_bracket, is_condition, is_factory, is_brand, is_bracket_in
	, data_kind,is_auto_match, is_serial_no	, pop_max_rank, price_min_ratio
	, price_max_ratio, search_order, search_group, exclude_category_csv, week_day
	, week_day_mon, week_day_tuh, week_day_wed, week_day_thu, week_day_fri, week_day_sat, week_day_sun 
	from tbl_web_search_config
	where category like @category +'%'
	and search_group between isnull(@search_group, 0) and isnull(@search_group, 99999999)
	order by category





