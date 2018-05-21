/* *************************************************************************
 * NAME : dbo.udp_mp_copy_goods_info_log_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-08 18:18:50.807
 *        Modify: 2014-04-08 18:18:50.807
 *        Backup: 20180521_1737
 ************************************************************************* */


create proc udp_mp_copy_goods_info_log_sel
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(1) = '0'
AS 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-04-08
	-- 설  명 : MP제품정보 복사 이력 보관용 페이지 신설
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
		when '0' then 'regdate'
		else 'regdate'
	end

	declare @start_row int
	declare @sort_column_last_value datetime, @id_last_value int
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_mp_copy_goods_info_log where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	set @qry = N'
		set rowcount @start_row;
		select @sort_column_last_value='+@ord_col_name+', @id_last_value = seqno
		from tbl_mp_copy_goods_info_log where 0=0 '+ @filter + '
		order by '+@ord_col_name+' desc, seqno desc'

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as int output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value

	set @qry = N'
		set rowcount @page_size;
		select left(copy_desc,30) as copy_model, mm_id, convert(varchar(10), regdate, 120) as regdate, copy_desc
		from tbl_mp_copy_goods_info_log
		where (('+@ord_col_name+' = @sort_column_last_value and seqno <= @id_last_value) 
		or ('+@ord_col_name+' <@sort_column_last_value))  '+ @filter + '
		order by  '+@ord_col_name+' desc, seqno desc'

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as datetime, @id_last_value int'
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0
