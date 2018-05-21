/* *************************************************************************
 * NAME : dbo.udp_jca_ex_keyword_mcate_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-05-03 09:47:41.38
 *        Modify: 2015-05-15 03:31:33.393
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE PROC udp_jca_ex_keyword_mcate_sel
	@cate char(4)
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

	select cs_lcode+cs_mcode+cs_scode, cs_name, use_flag,
	group_ex_flag, first_flag, ex_flag, pattern_flag,shop_code,price_range,
	first_group_cnt, ex_group_cnt, first_cnt, data_sel_opt, data_sel_sdate, data_sel_edate	
	from c_scate with (readuncommitted) 
			left outer join 
		tbl_ex_keyword_cate
			on cs_lcode+cs_mcode+cs_scode = category
	where cs_lcode = left(@cate,2) and cs_mcode = right(@cate, 2)
	and cs_seqno > 0
	order by cs_lcode, cs_mcode, cs_scode
