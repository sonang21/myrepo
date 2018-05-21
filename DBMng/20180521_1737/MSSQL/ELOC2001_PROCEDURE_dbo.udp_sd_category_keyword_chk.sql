/* *************************************************************************
 * NAME : dbo.udp_sd_category_keyword_chk
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-08-10 15:03:34.267
 *        Modify: 2018-05-03 17:23:34.86
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_sd_category_keyword_chk
	@seqno			int
,	@category		varchar(12)
,	@keyword		varchar(50)
,	@keyword_flag	char(1)
as
	-- ---------------------------------------------------
	-- wookki25 / 2016.08.09
	-- ���� �����̾ 00 �з� ��Ī�� �����ϴ� Ű����
	-- ---------------------------------------------------
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED


	-- �߰�
	if @seqno is null begin 

		-- �Ѱ� Ű���尡 ������ �з��� ��Ī, ���ܿ� ������ �� ����
		-- �Ѱ� Ű���尡 ���� �з��� ��ĪŰ���忡 ������ �� ����.
		select top 1 seqno 
		from tbl_sd_category_keyword 
		where  keyword = @keyword and category = @category 
		union all
		select top 1 seqno 
		from tbl_sd_category_keyword 
		where  keyword = @keyword and category <> @category 
		 and @keyword_flag='1' and keyword_flag = '1'

	-- ����
	end else begin

		-- �Ѱ� Ű���尡 ������ �з��� ��Ī, ���ܿ� ������ �� ����
		-- �Ѱ� Ű���尡 ���� �з��� ��ĪŰ���忡 ������ �� ����.
--		select top 1 seqno 
		--from tbl_sd_category_keyword 
		--where  keyword = @keyword and (category = @category or ( category <> @category and keyword_flag = '1' and @keyword='1'))
		--and seqno <> @seqno

		select top 1 seqno 
		from tbl_sd_category_keyword 
		where  keyword = @keyword and category = @category 
		and seqno <> @seqno
		union all
		select top 1 seqno 
		from tbl_sd_category_keyword 
		where  keyword = @keyword and category <> @category 
		 and @keyword_flag='1' and keyword_flag = '1'
		 and seqno <> @seqno

	end

