/* *************************************************************************
 * NAME : dbo.udp_rt_srv_off_set_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-15 13:58:52.763
 *        Modify: 2018-05-03 17:23:35.537
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_rt_srv_off_set_sel
	@category varchar(4)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015.05.12
	-- 설  명 : 실시간 단종 3처리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select category, limit_pct1, limit_pct2
	from tbl_rt_srv_off_set
	where category like @category +'%'
	order by category
