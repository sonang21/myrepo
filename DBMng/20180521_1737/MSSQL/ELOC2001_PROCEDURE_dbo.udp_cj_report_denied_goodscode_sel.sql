/* *************************************************************************
 * NAME : dbo.udp_cj_report_denied_goodscode_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-23 16:44:58.207
 *        Modify: 2018-05-03 17:23:34.527
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_report_denied_goodscode_sel
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.23
	-- 설   명 : cj 속성 컨설팅.매칭불가 리스트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/
	select p_date 	
	, b.cj_ca_name1, b.cj_ca_name2, b.cj_ca_name3, b.cj_ca_name4
	, goodscode, factory, brand, goodsnm, p_memo
	, c.cj_ca_name1, c.cj_ca_name2, c.cj_ca_name3, c.cj_ca_name4
	from tbl_cj_goods a 
		inner join tbl_cj_cate b on a.cj_ca_code4 = b.cj_ca_code4
		inner join tbl_cj_cate c on a.cj_ca_code4_job = c.cj_ca_code4
	where p_status = '2' -- 불가
end