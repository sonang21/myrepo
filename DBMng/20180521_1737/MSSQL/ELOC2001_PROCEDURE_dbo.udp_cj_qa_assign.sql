/* *************************************************************************
 * NAME : dbo.udp_cj_qa_assign
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-23 14:35:00.05
 *        Modify: 2018-02-01 14:43:08.817
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cj_qa_assign
as
begin	
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 22017.03.23
	-- 설  명 :  cj작업 할당
	-- ----------------------------------------------
	-- 수  정
	-- ----------------------------------------------

	-- 분배(= 할당)	
	-- drop table #mm_id 
	select identity(int, 1, 1) seqno, mm_id 
	into #mm_id 
	from openquery(mpdb02, 'select mm_id from member.dbo.mm_enuri where mm_flag = ''1'' and mm_partcode like ''%463''')
	order by NEWID()


	declare @id_cnt int
	select @id_cnt = count(*) from #mm_id
/*
	update x
	set qa_assign_mm_id = y.mm_id
	from tbl_cj_goods  x
			inner join
		(
			select goodscode, mm_id
			from (
				select goodscode, rank() over(order by goodscode) nrank
				from tbl_cj_goods
				where p_status = '1'	-- 작업완료만
				and qa_assign_mm_id is null -- 할당 안된 녀석
				and dev_tag is null
			) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
		) y on x.goodscode = y.goodscode
	option (maxdop 1)
*/

	update x
	set qa_assign_mm_id = y.mm_id
	from tbl_cj_goods  x
			inner join
		(
			select goodscode, mm_id
			from (
				select goodscode, rank() over(order by goodscode) nrank
				from (
				
					select top 600 goodscode
					from tbl_cj_goods
					where p_status = '1'	-- 작업완료만
					and qa_assign_mm_id is null -- 할당 안된 녀석
					and p_date>= cast(getdate()-1 as date)
					and p_date<  cast(getdate()-0 as date)
					order by NEWID()
				) a

			) a inner join #mm_id b on ( (nrank - 1) % @id_cnt ) = seqno-1
		) y on x.goodscode = y.goodscode
	option (maxdop 1)

End





