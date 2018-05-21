/* *************************************************************************
 * NAME : dbo.udp_homeshop_goods_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-02-28 10:58:22.653
 *        Modify: 2018-05-03 17:23:34.683
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[udp_homeshop_goods_sel]
	@sdate datetime
,	@group_flag char(1)
,	@mcate varchar(4) = null
,	@pl_vcode int = null
,	@filter	char(1) = null
AS 
SET NOCOUNT ON 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
-- ----------------------------------------------
-- 작성자 : wookki25 / 2013.03.01
-- 설  명 : 쇼핑몰 홈쇼핑 상품 관리
-- ----------------------------------------------
-- ----------------------------------------------
-- 수정내역
-- ----------------------------------------------
/* 
수정일:			수정자:			수정내용:
-------------------------------------------------
*/

select	seqno
,		isnull(left(b.pl_category,4), a.mcate) as mcate
,		a.pl_vcode
,		b.pl_no
,		pl_url
,		a.pl_goodscode
,		isnull(b.pl_price,0)
,		isnull(b.pl_modelno,0)
,		g_modelnm
,		a.regdate
,		a.work_status
,		a.mm_id
,		pl_status
,		pl_note
from pricelist_special_goods a 
		inner join pricelist b	on a.pl_vcode = b.pl_vcode and a.pl_no = b.pl_no
		left outer join goods c on b.pl_modelno = c.g_modelno			
where a.regdate >= @sdate and a.regdate < @sdate+1
and a.group_flag = @group_flag
and a.pl_vcode = isnull(@pl_vcode, a.pl_vcode)
and a.work_status like case when @filter = '2' then  '0' else '%' end
and b.pl_modelno = case when @filter = '3' then  0 else b.pl_modelno end
and isnull(isnull(b.pl_category, a.mcate),'00') like isnull(@mcate, '')+'%'
order by mcate

