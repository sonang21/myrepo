/* *************************************************************************
 * NAME : dbo.udp_danawa_goods_list_on_web_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-13 08:55:32.83
 *        Modify: 2018-05-03 17:23:35.183
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_danawa_goods_list_on_web_ins
	@category	varchar(8)
,	@goodsnm	nvarchar(200)
,	@goodscode	varchar(50)
,	@url		varchar(500)
,	@modelno	int
,	@memo		varchar(1000)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2013.05.21
	-- ��  �� : �ٳ��� ��ǰ ����Ʈ
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------

	*/
	if @modelno > 0 begin
		select @category = g_category from goods where g_modelno = @modelno
	end else begin
		set @modelno = null
	end

	if not exists(select 1 from tbl_danawa_goods_on_web where goodscode = @goodscode) begin
		insert into tbl_danawa_goods_on_web(category, categorynm, goodsnm, goodscode, url, regdate, modelno, memo, memodate, is_user_add) 
		values(@category, '�����Է�', @goodsnm, @goodscode, @url, getdate(), @modelno, @memo, case when isnull(@memo, '') = '' then null else getdate() end, 1)
	end


