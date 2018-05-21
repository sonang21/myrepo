/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_cate_ins_multi
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-04-28 15:37:25.383
 *        Modify: 2018-05-03 17:23:34.257
 *        Backup: 20180521_1737
 ************************************************************************* */

create PROC udp_jca_ex_keyword_cate_ins_multi
	@cate_multi varchar(8000)
,	@use_flag bit
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-04-28
	-- 설  명 : 자동그룹핑 카테고리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	select   distinct cast(substring(vals, s, e-s) as varchar(12)) as cate
	into #multi_cate
	from (  
		select   min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
		from    (select @cate_multi vals) a  
		inner join dbo.tbl_number b 
		on len(a.vals) >= b.number  
		group by charindex (',',vals+',',number)
	) a	

	delete tbl_ex_keyword_cate where category in (select cate from #multi_cate)

	insert into tbl_ex_keyword_cate(category, use_flag) 
	select cate, @use_flag as use_flag from #multi_cate
