/* *************************************************************************
 * NAME : dbo.upd_ebay_ad_ins_ref
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-11-01 14:33:57.8
 *        Modify: 2018-05-03 17:23:35.85
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc upd_ebay_ad_ins_ref
	@sdate smalldatetime
AS 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-08-19
	-- 설  명 : 이베이광고 관련 수치 확인 - jca에서 이베이 매출 입력시 참조.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	--drop table #org
	create table #org(
		shop_code int
	,	ep_date char(8)
	,	ep_type char(1)
	,	ca_code varchar(12)
	,	modelno int
	,	goodscode varchar(50)
	,	cate_exp int
	,	ep_keyword varchar(50)
	)
	
	if datediff(d, getdate(), @sdate) = -1 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods			
			where ep_type = ''3'' and ep_date = to_char(sysdate-1, ''yyyymmdd'')
		')
	end else if datediff(d, getdate(), @sdate) = -2 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods
			where ep_type = ''3'' and ep_date = to_char(sysdate-2, ''yyyymmdd'')
		')
	end else if datediff(d, getdate(), @sdate) = -3 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods
			where ep_type = ''3'' and ep_date = to_char(sysdate-3, ''yyyymmdd'')
		')
	end else if datediff(d, getdate(), @sdate) = -4 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods
			where ep_type = ''3'' and ep_date = to_char(sysdate-4, ''yyyymmdd'')
		')
	end else if datediff(d, getdate(), @sdate) = -5 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods
			where ep_type = ''3'' and ep_date = to_char(sysdate-5, ''yyyymmdd'')
		')
	end else if datediff(d, getdate(), @sdate) = -6 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods
			where ep_type = ''3'' and ep_date = to_char(sysdate-6, ''yyyymmdd'')
		')
	end else if datediff(d, getdate(), @sdate) = -7 begin
		insert into #org(shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword)
		select * from
		openquery(ORADB,'
			select shop_code, ep_date, ep_type, ca_code, modelno, goodscode, ep_keyword
			from tbl_ep_goods
			where ep_type = ''3'' and ep_date = to_char(sysdate-7, ''yyyymmdd'')
		')
	end


	if (datediff(d, getdate(), @sdate) between -7 and -1) begin

		select distinct ep_keyword, cast(0 as int) cate_exp
		into #org_distinct
		from  #org
		where ep_type='3'
		

		-- 키워드 노출수..
		update #org_distinct
		set cate_exp = (select count(*) 
						from	disearchdb.dbo.di_search_log
						WHERE	regdate >=@sdate
						AND		regdate < @sdate+1
						AND		keyword = ep_keyword
						AND		ISNULL(category,'') = ''
						)
		


		-- 최종결과
		select shop_code, sum(b.cate_exp)  cate_exp
		from #org a inner join #org_distinct b on a.ep_keyword = b.ep_keyword
		group by shop_code, ep_date, ep_type
	--end else begin
	--	select '범위오류'
	end

