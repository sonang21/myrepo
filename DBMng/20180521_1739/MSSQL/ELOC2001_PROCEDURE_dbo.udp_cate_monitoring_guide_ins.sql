/* *************************************************************************
 * NAME : dbo.udp_cate_monitoring_guide_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-11-21 15:13:46.21
 *        Modify: 2018-05-03 17:23:34.827
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC udp_cate_monitoring_guide_ins
	@category varchar(12)
,	@guide_title char(100)
,	@guide_desc varchar(500)
,	@guide_attri_desc varchar(500)
,	@ex_option1 varchar(100)
,	@ex_option2 varchar(100)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014.11.20
	-- 설  명 : 분류별 서비스 가이드
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	insert into tbl_cate_monitoring_guide(category, guide_title, guide_desc, guide_attri_desc, ex_option1, ex_option2) 
	values(@category, @guide_title, @guide_desc, @guide_attri_desc, @ex_option1, @ex_option2)




