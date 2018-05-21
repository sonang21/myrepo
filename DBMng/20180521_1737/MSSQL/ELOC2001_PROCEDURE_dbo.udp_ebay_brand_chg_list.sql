/* *************************************************************************
 * NAME : dbo.udp_ebay_brand_chg_list
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-28 14:48:08.6
 *        Modify: 2018-05-03 17:23:36.057
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_ebay_brand_chg_list
	@sdate datetime
,	@edate datetime
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- ÀÛ¼ºÀÚ : wookki25 / 2014-04-28
	-- ¼³  ¸í : jca.ºê·£µå º¯°æ ¸®½ºÆ®
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
	, a.brand_id, a.brand_nm, b.enuri_brand_id, c.brand_nm
	, b.del_yn as matching_del_yn
	from tbl_ebay_brand	a 
		left outer join tbl_ebay_matching_brand b on  a.brand_id = b.ebay_brand_id 
		left outer join	tbl_enuri_brand c on b.enuri_brand_id = c.brand_id-- and c.del_yn = 'N'
	where ((a.upd_date >= @sdate and  a.upd_date < @edate + 1) or (a.ins_date >= @sdate and  a.ins_date < @edate + 1))
	and a.del_yn = 'N'
	order by a.del_yn, a.brand_id



