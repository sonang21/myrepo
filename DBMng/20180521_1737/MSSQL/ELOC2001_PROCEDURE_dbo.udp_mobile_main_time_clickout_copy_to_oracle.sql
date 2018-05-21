/* *************************************************************************
 * NAME : dbo.udp_mobile_main_time_clickout_copy_to_oracle
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-01-04 11:07:48.84
 *        Modify: 2018-05-03 17:23:35.393
 *        Backup: 20180521_1737
 ************************************************************************* */

create proc udp_mobile_main_time_clickout_copy_to_oracle
as
	set nocount on 
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2018.01.03
	-- 설  명 : 모바일메인.노출상품.클릭아웃.오라클에 이전
	-- ----------------------------------------------
	--	part not in ('t','d','c') - modelno
	--	part = 'n' - pl_no
	--	3시간마다
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------

									
	*/

	-- 대상모델
	-- drop table #target
	select modelno, pl_no, part into #target 
	from openquery(ORADB, 'select modelno, pl_no, part from mobile_main where part in (''T'',''D'',''C'',''N'')')


	declare @mct  int
	declare @modelno int
	declare @pl_no bigint

	-- 가격비교 모델 : 커서로 건별로 주문액 입력
	declare curs1 cursor for 

	select b.modelno, sum(case when a.modelno>0 then 1 else 0 end) mct
	from tbl_move_log_mobile a right outer join #target b 
	on a.modelno = b.modelno and regdate >= dateadd(hh, -3, regdate)
	where referer_url =  '' -- mobile 메인상품 (= referer_url이 없다.)
	AND part in ('T','D','C')
	group by b.modelno	

	open curs1 
		fetch curs1 into @modelno,  @mct
		while @@fetch_status <> -1 
		begin 

			update openquery(ORADB, 'select modelno, click_cnt from mobile_main')
			set click_cnt = @mct
			where modelno =@modelno
			
		
			fetch curs1 into @modelno,  @mct
		end 
	close curs1 
	deallocate curs1 


	-- 일반상품 커서로 건별로 주문액 입력
	declare curs1 cursor for 
	select b.pl_no, sum(case when a.pl_no>0 then 1 else 0 end) mct
	from tbl_move_log_mobile a right join #target b 
	on a.pl_no = b.pl_no and regdate >= dateadd(hh, -3, regdate)
	where referer_url =  '' -- mobile 메인상품 (= referer_url이 없다.)
	AND part in ('N')
	group by b.pl_no
	open curs1 
		fetch curs1 into @pl_no,  @mct
		while @@fetch_status <> -1 
		begin 

			update openquery(ORADB, 'select pl_no, click_cnt from mobile_main')
			set click_cnt = @mct
			where pl_no =@pl_no
			
		
			fetch curs1 into @pl_no,  @mct
		end 
	close curs1 
	deallocate curs1 




