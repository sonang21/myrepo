/* *************************************************************************
 * NAME : dbo.udp_cj_goods_list_sel_ord
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-16 20:05:57.547
 *        Modify: 2018-05-03 17:23:35.247
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_goods_list_sel_ord
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(2) = '00'
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.14
	-- 설   명 : cj 속성 컨설팅.상품리스트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/

	declare @ord_col_name nvarchar(50)
	set @ord_col_name = case right(@ord_col,1)
		when '1' then ' factory '
		when '2' then ' brand '
		when '3' then ' left(goodsnm,10)  '
		else 'regdate'
	end
	
	declare @ord_col_sort nvarchar(50)
	set @ord_col_sort = @ord_col_name + case left(@ord_col,1)
		when 'a' then  ' asc '
		when 'd' then ' desc '		
		else ' desc'
	end


	declare @start_row int	
	declare @sort_column_last_value varchar(50), @id_last_value varchar(10)
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_cj_goods where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	set @qry = N'
		set rowcount @start_row;
		select @sort_column_last_value='+@ord_col_name+', @id_last_value = goodscode
		from tbl_cj_goods where 0=0 '+ @filter + '
		order by '+@ord_col_sort+' , goodscode desc'

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as varchar(50) output, @id_last_value as varchar(10) output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value
	
	if left(@ord_col,1) = 'd' begin

		set @qry = N'
			set rowcount @page_size;
			select  factory, brand, goodsnm, img_url, p_status, p_memo
			, p_date, regdate, sale_url, goodscode, qa_status
			, qa_date, qa_err_code, qa_assign_mm_id, a.cj_ca_code1_job,a.cj_ca_code2_job
			, a.cj_ca_code3_job,a.cj_ca_code4_job, cj_ca_name2 +'' > ''+ cj_ca_name3 +'' > ''+ cj_ca_name4
			, qa_memo
			from tbl_cj_goods a inner join tbl_cj_cate b on a.cj_ca_code4_job=b.cj_ca_code4
			where (('+@ord_col_name+' = @sort_column_last_value and goodscode <= @id_last_value) 
			or ('+@ord_col_name+' <@sort_column_last_value))  '+ @filter + '
			order by  '+@ord_col_sort+' , goodscode desc'
		-- print @qry
	end else begin

		set @qry = N'
			set rowcount @page_size;
			select  factory, brand, goodsnm, img_url, p_status, p_memo
			, p_date, regdate, sale_url, goodscode, qa_status
			, qa_date, qa_err_code, qa_assign_mm_id, a.cj_ca_code1_job,a.cj_ca_code2_job
			, a.cj_ca_code3_job,a.cj_ca_code4_job, cj_ca_name2 +'' > ''+ cj_ca_name3 +'' > ''+ cj_ca_name4
			, isnull(qa_memo,'''')
			from tbl_cj_goods a inner join tbl_cj_cate b on a.cj_ca_code4_job=b.cj_ca_code4
			where (('+@ord_col_name+' = @sort_column_last_value and goodscode <= @id_last_value) 
			or ('+@ord_col_name+' > @sort_column_last_value))  '+ @filter + '
			order by  '+@ord_col_sort+' , goodscode desc'
		 --print @qry
		 --select @start_row, @sort_column_last_value, @id_last_value

	end

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as varchar(50), @id_last_value  varchar(10) '
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0

	--select @page_size, @id_last_value, @sort_column_last_value

end



















