/* *************************************************************************
 * NAME : dbo.udp_goods_bbs_nomatch_ref_oracle
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-10-27 10:31:56.13
 *        Modify: 2018-05-03 17:23:34.263
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_goods_bbs_nomatch_ref_oracle
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 20151027
	-- 설  명 : 상품명 미매칭 상품 리스트 / 최근 1주일
	-- 참  고 : http://jca.enuri.com/board/redirect.asp?bt=1&bn=387&cn=504922	
	-- ----------------------------------------------------------------------------------

	delete from pricelist_special_goods 
	where regdate >= cast(getdate() - 1 as date) and  regdate < cast(getdate()  as date) 
	and group_flag = '5'

	--[쇼핑몰 상품평 - 대기]
	select * 
	into #result
	from openquery(oradb, '
	select shop_code, goodscode
	from tbl_goods_bbs_nomatch
	where regdate >=to_date(to_char(sysdate-7, ''yyyy/mm/dd'')) -- 등록일
	and regdate < to_date(to_char(sysdate, ''yyyy/mm/dd'')) -- 등록일
	group by shop_code, goodscode
	having count(*) >= 10')


	insert into pricelist_special_goods (pl_vcode, pl_goodscode, pl_no, group_flag )
	select shop_code, goodscode, pl_no, '5' group_flag  
	from #result a inner join pricelist b 
		on shop_code = pl_vcode and goodscode = pl_goodscode and checksum(goodscode) = pl_goodscode_cs
		and pl_modelno = 0
