/* *************************************************************************
 * NAME : dbo.udp_cate_chg_log_sel_list
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-03-14 17:30:36.417
 *        Modify: 2013-03-18 11:20:57.36
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cate_chg_log_sel_list
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(1) = '0'
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2013-03-14
	-- 설  명 : MP분류변경 로그
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	declare @start_row int
	declare @sort_column_last_value datetime, @id_last_value datetime
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_cate_chg_log where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	set @qry = N'
		set rowcount @start_row;
		select @sort_column_last_value=regdate, @id_last_value = regdate 
		from tbl_cate_chg_log with (readuncommitted) where 0=0 '+ @filter + '
		order by regdate desc'

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as datetime output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value
	set @qry = N'
		set rowcount @page_size;
		select chg_flag, del_cate, new_cate, mm_nm, regdate, mm_id
		from tbl_cate_chg_log with (readuncommitted)
		where ((regdate = @sort_column_last_value and regdate >= @id_last_value) 
		or (regdate <@sort_column_last_value))  '+ @filter + '
		order by  regdate desc'

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as datetime, @id_last_value datetime'
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0





