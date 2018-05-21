/* *************************************************************************
 * NAME : dbo.udp_pricelist_option_diff_detail_clean
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-10-10 14:12:09.95
 *        Modify: 2018-05-03 17:23:34.52
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_pricelist_option_diff_detail_clean
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-10-10
	-- 설  명 : 옵션변경 데이터중 필요없는 데이터 삭제
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	-- 색상/색성
	create table #del_option(del_option varchar(10) primary key)	
	insert into #del_option(del_option) select '빨강' union all select '주황' union all select '노랑'
	insert into #del_option(del_option) select '초록' union all select '파랑' union all select '남색'
	insert into #del_option(del_option) select '보라' union all select '빨간' union all select '노란'
	insert into #del_option(del_option) select '파란' union all select '레드' union all select '브라운'
	insert into #del_option(del_option) select '바이올렛' union all select '바이올릿' union all select '핑크'
	insert into #del_option(del_option) select '오렌지' union all select '퍼플' union all select '베이지'
	insert into #del_option(del_option) select '로즈' union all select '화이트' union all select '블랙'
	insert into #del_option(del_option) select '블루' union all select '체리' union all select '옥'
	insert into #del_option(del_option) select '비취' union all select '청록' union all select '터키즈'
	insert into #del_option(del_option) select '그레이' union all select '실버' union all select '골드'
	insert into #del_option(del_option) select '망고' union all select '서울' union all select '경기'
	insert into #del_option(del_option) select '경남' union all select '전남' union all select '강원'
	insert into #del_option(del_option) select '경북' union all select '전북' union all select '인천'
	insert into #del_option(del_option) select '목포' union all select '충청' union all select '충남'
	insert into #del_option(del_option) select '전주' union all select '광주' union all select '충북'

	create table #del_plno(pl_no bigint)

	-- 모든 옵션가격이 0인 pl_no는 삭제	
	insert into #del_plno(pl_no)
	select pl_no
	from tbl_pricelist_option_diff_detail 
	where regdate>= cast(convert(varchar(10), getdate(), 120) as datetime)		
	group by pl_no
	having sum(t_option_price) = 0

	-- 색상,지역 : 옵션2에 색상표기 or 지역표기가 있고, 가격 0이 1개 이상이면 해당 pl_no 모두 삭제
	insert into #del_plno(pl_no)
	select distinct pl_no
	from tbl_pricelist_option_diff_detail where t_option_price=0 and exists(select 1 from #del_option where t_option_sub_name = del_option)

	-- 사이즈// 09분류만. 옵션선택이 사이즈인 경우 삭제
	insert into #del_plno(pl_no)
	select pl_no 
	from tbl_pricelist_option_diff_detail 
	where lcate = '09'
	group by pl_no
	having count(*) = sum(isnumeric(replace(t_option_sub_name,'호',''))) and sum(t_option_price) = 0


	delete a from tbl_pricelist_option_diff_detail a inner join #del_plno b on a.pl_no = b.pl_no

