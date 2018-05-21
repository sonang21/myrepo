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
	-- 작성자 : wookki25 / 2015.09.14
	-- 설  명 : 웹검색 기준 설정
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	
	set @return = '00' -- 가능

	-- 이미지매칭
	if @data_kind = 'i' begin
		-- 중분류만 입력 가능
		if len(@category) = 4  begin 
			if @cmd = 'ins' begin
				if exists(select top 1 category from tbl_web_search_config where category = @category and search_group = @search_group) begin
					set @return = '02' -- 불가능:이미 있음
				end else if exists(select top 1 category from tbl_web_search_config where category like @category+'_%') begin
					set @return = '03' -- 불가능:하위 분류 있음
				end
			end else if @cmd = 'mod' begin
				if exists(select top 1 category from tbl_web_search_config where category like @category+'_%' and search_group = @search_group) begin
					set @return = '03' -- 불가능:하위 분류 있음
				end
			end
		end else begin
			set @return = '01' -- 불가능:중분류 아님
		end
	-- 그룹매칭
	end else if @data_kind = 'g' begin
		if @cmd = 'ins' begin
			if exists(select top 1 category from tbl_web_search_config where category = @category and search_group = @search_group) begin
				set @return = '02' -- 불가능:이미 있음
			end
		end
	end

