/* *************************************************************************
 * NAME : dbo.udp_danawa_goods_list_on_db
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-08-12 16:26:17.69
 *        Modify: 2018-05-03 17:23:35.057
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_danawa_goods_list_on_db
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(1) = '0'
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
	declare @ord_col_name nvarchar(50)
	set @ord_col_name = 'dbdate'
	declare @start_row int
	declare @sort_column_last_value smalldatetime, @id_last_value varchar(50)
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_danawa_goods_on_db where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	set @qry = N'
		set rowcount @start_row;
		select @sort_column_last_value=isnull('+@ord_col_name+',''1900-01-01''), @id_last_value = goodscode 
		from tbl_danawa_goods_on_db where 0=0 '+ @filter + '
		order by '+@ord_col_name+' desc, goodscode desc'
--print @qry
	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as varchar(50) output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value

	set @qry = N'
		set rowcount @page_size;
		select category, goodsnm, goodscode, url, dbdate, indate, modelno, isnull(memo,''''), memodate, p_status, is_user_add
		from tbl_danawa_goods_on_db
		where ((isnull('+@ord_col_name+',''1900-01-01'') = @sort_column_last_value and goodscode <= @id_last_value) 
		or (isnull('+@ord_col_name+',''1900-01-01'') <@sort_column_last_value))  '+ @filter + '
		order by  '+@ord_col_name+' desc, goodscode desc'

--print @qry

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as smalldatetime, @id_last_value varchar(50)'
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0



