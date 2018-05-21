/* *************************************************************************
 * NAME : dbo.udp_ebay_maker_chg_list
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-28 14:55:21.283
 *        Modify: 2018-05-03 17:23:36.12
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_ebay_maker_chg_list
	@sdate datetime
,	@edate datetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-04-28
	-- 설  명 : jca.제조사 변경 리스트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	select case when a.ins_date >= @sdate and a.ins_date < @edate+1 then '추가' else '변경' end as '구분'
	, a.del_yn
	, a.maker_id, a.maker_nm, b.enuri_maker_id, c.maker_nm
	, b.del_yn as matching_del_yn
	from tbl_ebay_maker	a left outer join
		tbl_ebay_matching_maker b on  a.maker_id = b.ebay_maker_id left outer join
		tbl_enuri_maker c on b.enuri_maker_id = c.maker_id
	where ((a.upd_date >= @sdate and  a.upd_date < @edate + 1) or (a.ins_date >= @sdate and  a.ins_date < @edate + 1))
	and a.del_yn ='N'
	order by a.del_yn, a.maker_id


