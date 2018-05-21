/* *************************************************************************
 * NAME : dbo.udp_goods_reference_monitor_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-10-08 18:02:08.537
 *        Modify: 2018-05-03 17:23:35.5
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC udp_goods_reference_monitor_mod
	@cate varchar(6)
,	@factory nvarchar(50)
,	@refid int 
,	@group_flag1 char(1)
,	@group_flag2 char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012.10.08
	-- 설  명 : 상세문의 모니터링
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	update goods_reference_monitor
	set group_flag1 = isnull(@group_flag1, group_flag1)
	,	group_flag2 = isnull(@group_flag2, group_flag2)
	where g_factory = @factory
	and g_category like @cate+'%'
	and g_refid = @refid