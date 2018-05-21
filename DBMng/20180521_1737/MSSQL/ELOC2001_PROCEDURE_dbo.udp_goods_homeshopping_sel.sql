/* *************************************************************************
 * NAME : dbo.udp_goods_homeshopping_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-12-02 11:11:12.263
 *        Modify: 2018-05-03 17:23:35.06
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_goods_homeshopping_sel
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(1) = '0'
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookkii25 / 2010-12-02
	-- 설  명 : 홈쇼핑 상품 리스트
	-- ----------------------------------------------
	/* 
	-- 테스트 실행
	declare @ret int
	exec udp_goods_homeshopping_sel 1, 20, ' and category like ''02%''', @ret output, '0'
	select @ret

	*/
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	declare @ord_col_name nvarchar(50)
	set @ord_col_name = case @ord_col 
		when '0' then 'regdate'
		else 'regdate'
	end
	declare @start_row int
	declare @sort_column_last_value datetime, @id_last_value int
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_goods_homeshopping where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	set @qry = N'
		set rowcount @start_row;
		select @sort_column_last_value=isnull('+@ord_col_name+',''1900-01-01''), @id_last_value = modelno
		from tbl_goods_homeshopping where 0=0 '+ @filter + '
		order by '+@ord_col_name+' desc, modelno desc'

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as int output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value

	set @qry = N'
		set rowcount @page_size;
		select modelno, category, modelnm, regdate, is_exception, shotdate, g_imgchk
		from tbl_goods_homeshopping
		where ((isnull('+@ord_col_name+',''1900-01-01'') = @sort_column_last_value and modelno <= @id_last_value) 
		or (isnull('+@ord_col_name+',''1900-01-01'') <@sort_column_last_value))  '+ @filter + '
		order by  '+@ord_col_name+' desc, modelno desc'

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as datetime, @id_last_value int'
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0