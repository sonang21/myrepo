/* *************************************************************************
 * NAME : dbo.udp_web_search_config_merge_chk
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-10-22 17:03:17.407
 *        Modify: 2018-05-03 17:23:34.333
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_web_search_config_merge_chk
	@category varchar(8)
,	@data_kind	char(1)
,	@cmd char(3)
,	@search_group int

,	@return char(2) output
as 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2015.09.14
	-- ��  �� : ���˻� ���� ����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/	
	
	set @return = '00' -- ����

	-- �̹�����Ī
	if @data_kind = 'i' begin
		-- �ߺз��� �Է� ����
		if len(@category) = 4  begin 
			if @cmd = 'ins' begin
				if exists(select top 1 category from tbl_web_search_config where category = @category and search_group = @search_group) begin
					set @return = '02' -- �Ұ���:�̹� ����
				end else if exists(select top 1 category from tbl_web_search_config where category like @category+'_%') begin
					set @return = '03' -- �Ұ���:���� �з� ����
				end
			end else if @cmd = 'mod' begin
				if exists(select top 1 category from tbl_web_search_config where category like @category+'_%' and search_group = @search_group) begin
					set @return = '03' -- �Ұ���:���� �з� ����
				end
			end
		end else begin
			set @return = '01' -- �Ұ���:�ߺз� �ƴ�
		end
	-- �׷��Ī
	end else if @data_kind = 'g' begin
		if @cmd = 'ins' begin
			if exists(select top 1 category from tbl_web_search_config where category = @category and search_group = @search_group) begin
				set @return = '02' -- �Ұ���:�̹� ����
			end
		end
	end

