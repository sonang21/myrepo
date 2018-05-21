/* *************************************************************************
 * NAME : dbo.udp_homeshop_goods_sel_seqno
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-03-04 14:46:15.587
 *        Modify: 2018-05-03 17:23:34.903
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[udp_homeshop_goods_sel_seqno]
	@seqnos	varchar(300)
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
select	isnull(a.mcate, left(b.pl_category,4)) as mcate
,		a.pl_vcode
,		b.pl_no
,		a.pl_goodscode
,		isnull(b.pl_modelno,0)
,		g_modelnm
,		isnull(b.pl_url, d.move_url+a.pl_goodscode)
,		seqno
from	(
			select * from pricelist_special_goods where seqno in 
			(
				select   distinct cast(substring(vals, s, e-s) as int) inlist
				from (  
					select   min(number)s, charindex (',',vals+',',number) e, max(vals) vals  
					from    (select @seqnos vals) a  
								inner join tbl_number b 
							on len(a.vals) >= b.number  
					group by charindex (',',vals+',',number)
				) a
			)

		)  a 
		left outer join pricelist b	on a.pl_vcode = b.pl_vcode and a.pl_no = b.pl_no
		left outer join goods c on b.pl_modelno = c.g_modelno	
		left outer join tbl_homeshop_goods_shop d on a.pl_vcode = d.shop_vcode
