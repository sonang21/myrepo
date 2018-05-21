/* *************************************************************************
 * NAME : dbo.udp_cj_goods_list_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-14 09:40:55.55
 *        Modify: 2018-05-03 17:23:34.86
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_goods_list_sel
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
	-- 참   조 : udp_cj_goods_list_sel_ord : 텍스트 컬럼으로 정렬
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/
	declare @ord_col_name nvarchar(50)
		set @ord_col_name = case @ord_col
		when '00' then ' regdate '
		else ' regdate '
	end

	declare @start_row int
	declare @sort_column_last_value datetime, @id_last_value varchar(10)
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
		order by '+@ord_col_name+' desc, goodscode desc'

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as varchar(10) output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value
	
	set @qry = N'
		set rowcount @page_size;
		select  factory, brand, goodsnm, img_url, p_status, p_memo
		, p_date, regdate, sale_url, goodscode, qa_status
		, qa_date, qa_err_code, qa_assign_mm_id, a.cj_ca_code1_job,a.cj_ca_code2_job
		, a.cj_ca_code3_job,a.cj_ca_code4_job, cj_ca_name2 +'' > ''+ cj_ca_name3 +'' > ''+ cj_ca_name4
		, isnull(qa_memo,'''')
		from tbl_cj_goods a inner join tbl_cj_cate b on a.cj_ca_code4_job=b.cj_ca_code4
		where (('+@ord_col_name+' = @sort_column_last_value and goodscode <= @id_last_value) 
		or ('+@ord_col_name+' <@sort_column_last_value))  '+ @filter + '
		order by  '+@ord_col_name+' desc , goodscode desc'
	-- print @qry

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as datetime, @id_last_value  varchar(10) '
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0

	--select @page_size, @id_last_value, @sort_column_last_value

end


