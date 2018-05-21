/* *************************************************************************
 * NAME : dbo.udp_danawa_goods_list_on_db_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-12 17:27:04.56
 *        Modify: 2018-05-03 17:23:35.11
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_danawa_goods_list_on_db_ins
	@category	varchar(8)
,	@goodsnm	nvarchar(200)
,	@goodscode	varchar(50)
,	@url		varchar(500)
,	@modelno	int
,	@memo		varchar(1000)
,	@dbdate		datetime
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013.05.21
	-- 설  명 : 다나와 상품 리스트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

	*/
	if @modelno > 0 begin
		select @category = g_category from goods where g_modelno = @modelno
	end else begin
		set @modelno = null
	end

	if not exists(select 1 from tbl_danawa_goods_on_db where goodscode = @goodscode) begin
		insert into tbl_danawa_goods_on_db(category, goodsnm, goodscode, url, indate, dbdate, modelno, memo, memodate, is_user_add) 
		values(@category, @goodsnm, @goodscode, @url, getdate(), @dbdate, @modelno, @memo, case when isnull(@memo, '') = '' then null else getdate() end, 1)
	end
