/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_diff_copyplno_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-06 09:30:28.577
 *        Modify: 2018-05-03 17:23:34.57
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_pricelist_option_diff_copyplno_ins
AS
	set nocount on
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-08-06
	-- 설  명 : 옵션변경 상품중 분할 상품 골라내기
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	-- 데이터 이전
	select pl_no into #tmp_pricelist_option_diff from openquery(oradb, 'select pl_no from tbl_pricelist_option_diff')


	-- 분할여부 확인
	insert into tbl_pricelist_option_diff_copyplno(regdate, pl_vcode, pl_category, pl_goodscode)
	select convert(varchar(10),  getdate(), 120), max(pl_vcode), max(pl_category), pl_goodscode
	from #tmp_pricelist_option_diff a inner join pricelist b
	on a.pl_no = b.pl_no
	where b.pl_copyplno > 0
	group by pl_goodscode
	-- and b.pl_category like '1007%'


	-- 최근 3일 데이터만 유지
	delete from tbl_pricelist_option_diff_copyplno where regdate <= getdate()-3
