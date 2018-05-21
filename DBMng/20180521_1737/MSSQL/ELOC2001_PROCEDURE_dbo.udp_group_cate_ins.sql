/* *************************************************************************
 * NAME : dbo.udp_group_cate_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-04-26 16:35:27.42
 *        Modify: 2018-05-03 17:23:34.873
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_group_cate_ins
	@category		varchar(12)
,	@unit_price		varchar(20)		
,	@group_spec		varchar(10)		
,	@add_cate		char(1) = '0'
,	@exclude_cate		varchar(1000)
,	@unit_price_cmt	varchar(100)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : 그룹 적용 분류 ins / 2010-04-26
	-- 설  명 : wookki25
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2010.09.08		wookki25		unit_price_cmt 추가
									컬럼삭제
									list_title, help_img_file, combo_title, small_img
	*/
	insert into tbl_group_cate
	(category, unit_price, group_spec, add_cate, exclude_cate, unit_price_cmt)
	values
	(@category, @unit_price, @group_spec, @add_cate, @exclude_cate, @unit_price_cmt)
	
