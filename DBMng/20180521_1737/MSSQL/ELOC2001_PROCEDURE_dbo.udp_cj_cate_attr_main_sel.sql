/* *************************************************************************
 * NAME : dbo.udp_cj_cate_attr_main_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-14 16:56:48.4
 *        Modify: 2018-05-03 17:23:35.167
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_cate_attr_main_sel
	@cj_ca_code char(6)
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.14
	-- 설   명 : cj 속성 컨설팅.소분류 대표속성
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/
	select b.attr_main_code, b.attr_main_name 
	from tbl_cj_cate_attr_main a inner join tbl_cj_attr_main  b on a.attr_main_code = b.attr_main_code
	where a.cj_ca_code = @cj_ca_code
	order by 1 asc
end