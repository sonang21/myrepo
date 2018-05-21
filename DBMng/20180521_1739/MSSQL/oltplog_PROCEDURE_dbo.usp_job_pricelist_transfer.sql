/* *************************************************************************
 * NAME : dbo.usp_job_pricelist_transfer
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:20:01.947
 *        Modify: 2018-05-15 15:20:01.947
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc usp_job_pricelist_transfer
as
begin
	set nocount on
	set transaction isolation level read uncommitted

	insert into job_pricelist
	(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price,jp_category,jp_price_mobile, jp_note, jp_minprice)
	select 	jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_date, jp_goodsnm, jp_price,jp_category,jp_price_mobile, jp_note, jp_minprice
	from eloc188.logdb.dbo.job_pricelist_old

	-- 분류코드 없는 경우 보정해주도록 처리 // wookki25 2017.01.09
	update a 
	set jp_category = b.g_category
	-- select *
	from job_pricelist a with (readuncommitted) 
        inner join analstore.dbo.goods b with (readuncommitted)  on a.jp_modelno = g_modelno
	where jp_date>= cast(cast(getdate() -1 as date) as datetime)
	and jp_modelno>0 
	and jp_category is null
end

