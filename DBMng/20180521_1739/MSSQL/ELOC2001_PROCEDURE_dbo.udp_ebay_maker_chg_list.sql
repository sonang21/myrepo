/* *************************************************************************
 * NAME : dbo.udp_ebay_maker_chg_list
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-28 14:55:21.283
 *        Modify: 2018-05-03 17:23:36.12
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_ebay_maker_chg_list
	@sdate datetime
,	@edate datetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- ÀÛ¼ºÀÚ : wookki25 / 2014-04-28
	-- ¼³  ¸í : jca.Á¦Á¶»ç º¯°æ ¸®½ºÆ®
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ¼öÁ¤³»¿ª
	-- ----------------------------------------------
	/* 
	¼öÁ¤ÀÏ:			¼öÁ¤ÀÚ:			¼öÁ¤³»¿ë:
	-------------------------------------------------
	*/
	select case when a.ins_date >= @sdate and a.ins_date < @edate+1 then 'Ãß°¡' else 'º¯°æ' end as '±¸ºĞ'
	, a.del_yn
	, a.maker_id, a.maker_nm, b.enuri_maker_id, c.maker_nm
	, b.del_yn as matching_del_yn
	from tbl_ebay_maker	a left outer join
		tbl_ebay_matching_maker b on  a.maker_id = b.ebay_maker_id left outer join
		tbl_enuri_maker c on b.enuri_maker_id = c.maker_id
	where ((a.upd_date >= @sdate and  a.upd_date < @edate + 1) or (a.ins_date >= @sdate and  a.ins_date < @edate + 1))
	and a.del_yn ='N'
	order by a.del_yn, a.maker_id


