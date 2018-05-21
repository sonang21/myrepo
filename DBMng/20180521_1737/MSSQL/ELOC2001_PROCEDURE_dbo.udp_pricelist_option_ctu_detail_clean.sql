/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_ctu_detail_clean
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-07-18 13:47:15.097
 *        Modify: 2018-05-03 17:23:35.693
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_pricelist_option_ctu_detail_clean
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-07-18
	-- 설  명 : 옵션품절 데이터중 필요없는 데이터 삭제
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

return

--	create table #del_plno(pl_no int)
--
--	-- 옵션명에 품절이 있는 pl_no만 
--	insert into #del_plno(pl_no)
--	select distinct pl_no
--	from tbl_pricelist_option_ctu_detail 
--	where regdate>= cast(convert(varchar(10), getdate(), 120) as datetime)		
--	and	t_option_name like '%품절%' or t_option_sub_name like '%품절%'
--
--	delete from tbl_pricelist_option_ctu_detail 
--	where pl_no not in (
--		select pl_no from #del_plno
--	)
