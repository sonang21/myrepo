/* *************************************************************************
 * NAME : dbo.udp_factory_partnershop_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-15 10:36:53.423
 *        Modify: 2018-05-03 17:23:34.907
 *        Backup: 20180521_1737
 ************************************************************************* */

/*------------------------
exec sp_helptext udp_factory_partnershop_sel
exec sp_helptext udp_factory_partnershop_del                           
exec sp_helptext udp_factory_partnershop_ins                      
exec sp_helptext udp_factory_partnershop_mod   
------------------------*/
--go
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc udp_factory_partnershop_sel
	@page_number int = 10
,	@page_size int = 20
,	@filter varchar(4000) = ''
,	@all_rows int = 0 output
,	@ord_col char(1) = '0'
,	@ord_by varchar(4) = 'desc'
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-08-19
	-- 설  명 : 제조사  제휴 조회
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
		when '0' then 'rdate'
		when '1' then 'sdate'
		when '2' then 'edate'
		when '3' then 'udate'
		else 'rdate'
	end
	declare @start_row int
	declare @sort_column_last_value datetime, @id_last_value int
	set @start_row = ((@page_number-1) * @page_size)+1
	
	declare @qry nvarchar(4000)
	set @qry = N'
		select @all_rows=count(*) 
		from tbl_factory_partnership where 0=0 '+ @filter + '
		'

	exec sp_executesql @qry
	, N'@all_rows as int output'
	, @all_rows = @all_rows output

	if @ord_by = 'desc'	begin
		set @qry = N'
			set rowcount @start_row;
			select @sort_column_last_value=isnull('+@ord_col_name+',''1900-01-01''), @id_last_value = seqno 
			from tbl_factory_partnership with(readuncommitted) where 0=0 '+ @filter + '
			order by '+@ord_col_name+' desc, seqno desc'
	end else begin
		set @qry = N'
			set rowcount @start_row;
			select @sort_column_last_value=isnull('+@ord_col_name+',''2069-01-01''), @id_last_value = seqno 
			from tbl_factory_partnership with(readuncommitted) where 0=0 '+ @filter + '
			order by '+@ord_col_name+' asc, seqno desc'
	end

	--print @qry

	exec sp_executesql @qry
	, N'@start_row as int, @sort_column_last_value as datetime output, @id_last_value as int output'
	, @start_row = @start_row
	, @sort_column_last_value = @sort_column_last_value output
	, @id_last_value = @id_last_value output

	--select @start_row, @sort_column_last_value, @id_last_value

	if @ord_by = 'desc' begin
		set @qry = N'
			set rowcount @page_size;
			select seqno,factory,contents,url,ins_way,auto_renewal,sdate,edate,rdate,status,udate, monitor_memo, writer, is_img, is_catal
			from tbl_factory_partnership with (readuncommitted)
			where ((isnull('+@ord_col_name+',''1900-01-01'') = @sort_column_last_value and seqno <= @id_last_value) 
			or (isnull('+@ord_col_name+',''1900-01-01'') <@sort_column_last_value))  '+ @filter + '
			order by  '+@ord_col_name+' desc, seqno desc'
	end else begin
		set @qry = N'
			set rowcount @page_size;
			select seqno,factory,contents,url,ins_way,auto_renewal,sdate,edate,rdate,status,udate, monitor_memo, writer, is_img, is_catal
			from tbl_factory_partnership with (readuncommitted)
			where ((isnull('+@ord_col_name+',''2069-01-01'') = @sort_column_last_value and seqno <= @id_last_value) 
			or (isnull('+@ord_col_name+',''2069-01-01'') >@sort_column_last_value))  '+ @filter + '
			order by  '+@ord_col_name+' asc, seqno desc'
	end

	exec sp_executesql @qry
	, N'@page_size as int, @sort_column_last_value as datetime, @id_last_value int'
	, @page_size = @page_size
	, @id_last_value = @id_last_value
	, @sort_column_last_value = @sort_column_last_value
	set rowcount 0


