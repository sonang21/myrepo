/* *************************************************************************
 * NAME : dbo.udp_shoplist_ap_code_chk
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-09-26 15:29:32.57
 *        Modify: 2018-05-03 17:23:34.383
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_shoplist_ap_code_chk
	@shop_vcode int
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012-09-26
	-- 설  명 : ap 수익코드 관리 & db 스케쥴링으로 체크할 때 참조
	-- ap 코드 유무 & 한글포함 유무
	-- select 컬럼 변경시(추가,삭제) [shoplist_ap_code_chk_log],[udp_shoplist_ap_code_chk_log] 함께 수정해줘야한다.
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	declare @apcode1 varchar(100)
	declare @apcode2 varchar(100)

	select @apcode1 = isnull(shop_apcode1,''), @apcode2 = isnull(shop_apcode2,'') from shoplist_ap_code where shop_vcode = @shop_vcode

	if @apcode1 <> '' and @apcode2 <> '' begin
		select top 1 pl_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, '가격+도서' as kind
		from pricelist tablesample(2000 rows)
		where pl_vcode=@shop_vcode
		and ((charindex(@apcode2, pl_url)+charindex(@apcode1, pl_url)=0) or len(pl_url) <> datalength(pl_url)) 		
		and pl_status not in ('3','5')
	end else if @apcode1 <> '' begin
		select top 1 pl_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, '가격' as kind
		from pricelist tablesample(2000 rows)
		where pl_vcode=@shop_vcode
		and ((charindex(@apcode1, pl_url)=0)  or len(pl_url) <> datalength(pl_url)) 
		and pl_status not in ('3','5')
	end else if @apcode2 <> '' begin
		select top 1 pl_vcode, pl_url, pl_no, pl_status, pl_goodscode, pl_goodsnm, '도서' as kind
		from pricelist tablesample(2000 rows)
		where pl_vcode=@shop_vcode
		and ((charindex(@apcode2, pl_url)=0)  or len(pl_url) <> datalength(pl_url)) 
		and pl_status not in ('3','5')
	end else begin
		select @shop_vcode, 'ap코드 오류입니다.', 0, '','',''
	end

