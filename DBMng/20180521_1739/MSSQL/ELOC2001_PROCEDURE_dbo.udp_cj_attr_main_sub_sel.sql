/* *************************************************************************
 * NAME : dbo.udp_cj_attr_main_sub_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-14 16:56:48.413
 *        Modify: 2018-05-03 17:23:35.177
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE proc udp_cj_attr_main_sub_sel
	@attr_main_code char(6)
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.14
	-- 설   명 : cj 속성 컨설팅.소분류 상세속성
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	select b.attr_sub_code, b.attr_sub_name 
	from tbl_cj_attr_main_sub a 
		inner join tbl_cj_attr_sub b on a.attr_sub_code = b.attr_sub_code
	where a.attr_main_code = @attr_main_code
	order by a.attr_sort
end