/* *************************************************************************
 * NAME : dbo.udp_pricelist_special_goods_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-21 17:12:05.117
 *        Modify: 2018-05-03 17:23:35.193
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_pricelist_special_goods_sel
	@sdate datetime
,	@group_flag char(1)
,	@mcate varchar(4) = null
,	@pl_vcode int = null
,	@filter	char(1) = null
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013.11.20
	-- 설  명 : 쇼핑몰 특가 상품 관리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2012.07.17		wookki25		pricelist join 조건 변경
									goodscode ---> pl_no
	2012.07.17		wookki25		worker, worker_memo, pl_goodsnm 필드 참조 삭제.. 사용안함
	*/
	
	select	seqno
	,		left(b.pl_category,4) as mcate
	,		a.pl_goodscode
	,		'' del_col1
	,		b.pl_price
	,		a.pl_vcode
	,		b.pl_modelno
	,		'' del_col2
	,		a.work_status
	,		b.pl_status
	,		a.regdate
	,		'' del_col3
	,		(case when isnull(b.pl_modelno,0) <=0 then 1 else g_flag end) as g_flag
	,		pl_url
	,		a.pl_no
	,		a.mm_id
	,		g_modelnm
	,		pl_note
	from pricelist_special_goods a inner join pricelist b
	on a.pl_vcode = b.pl_vcode and a.pl_no = b.pl_no
	left outer join goods c on b.pl_modelno = c.g_modelno
	where a.regdate >= @sdate 
	and a.regdate < @sdate+1
	and a.group_flag = @group_flag
	and a.pl_vcode = isnull(@pl_vcode, a.pl_vcode)
	and isnull(a.work_status, 1) = case when @filter = '2' then  1 else isnull(a.work_status, 1) end
	and b.pl_modelno = case when @filter = '3' then  0 else b.pl_modelno end
	and b.pl_category like isnull(@mcate, '')+'%'
	order by mcate





