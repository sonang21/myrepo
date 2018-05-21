/* *************************************************************************
 * NAME : dbo.udp_direct_match_log_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-10 15:38:04.783
 *        Modify: 2018-05-10 15:38:04.783
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_direct_match_log_sel
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(1) = '0'
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-07-19
	-- 설  명 : 다이렉트 상품매칭 로그 확인
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/	
	declare @ord_col_name nvarchar(50)
	set @ord_col_name = case @ord_col 
		when '0' then 'log_date'
		else 'log_date'
	end

	declare @start_row int
	declare @sort_column_last_value datetime, @id_last_value datetime
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_direct_match_log where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	set @qry = N'
		set rowcount @start_row;
		select @sort_column_last_value='+@ord_col_name+', @id_last_value = log_date
		from tbl_direct_match_log where 0=0 '+ @filter + '
		order by '+@ord_col_name+' desc'

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as datetime output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value

	set @qry = N'
		set rowcount @page_size;
		select shop_vcode, pl_no, g_modelno
		, (select top 1 cm_name from simpledb.dbo.cate sc where sc.category like left(g_category, 6) + ''%'') as g_category
		, (select top 1 g_modelnm from analstore.dbo.goods sg where g_modelno = dl.g_modelno) as g_modelnm
		, pl_goodscode, log_date, log_flag, log_cmt 
		from tbl_direct_match_log dl
		where ('+@ord_col_name+' <= @sort_column_last_value)  '+ @filter + '
		order by  '+@ord_col_name+' desc'

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as datetime'
	, @page_size = @page_size
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0

