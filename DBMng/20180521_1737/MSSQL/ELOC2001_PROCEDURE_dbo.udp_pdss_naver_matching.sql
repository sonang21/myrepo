/* *************************************************************************
 * NAME : dbo.udp_pdss_naver_matching
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-11-08 15:04:38.263
 *        Modify: 2018-05-04 14:44:00.323
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_pdss_naver_matching
as 
begin 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.11.08
	-- 설  명 : 네이버 매칭 데이터 생성
	-- ----------------------------------------------
	truncate table tbl_pdss_naver_modelno

	insert into tbl_pdss_naver_modelno(modelno, regdate)
	select modelno, regdate from openquery(oradb, 'select modelno, regdate from TBL_PDSS_NAVER_MODELNO')

	select shop_code, shop_name, url_for_naver, mall_company_number
	into #tbl_pdss_naver_shoplist
	from openquery(oradb, '	
		select a.shop_code, a.shop_name, c.url_for_naver, b.mall_company_number
		from tbl_shoplist a 
		inner join tbl_shop_detail b on a.shop_code = b.shop_code
		inner join tbl_pdss_naver_shoplist c on a.shop_code = c.shop_code and b.shop_code = c.shop_code
		where service = ''0''
	')
		
	if object_id('tbl_pdss_naver_matching_old') is not null begin
		drop table tbl_pdss_naver_matching_old
	end
	if object_id('tbl_pdss_naver_matching') is not null begin
		exec sp_rename tbl_pdss_naver_matching, tbl_pdss_naver_matching_old
	end
	if object_id('tbl_pdss_naver_matching_diff_old') is not null begin
		drop table tbl_pdss_naver_matching_diff_old
	end
	if object_id('tbl_pdss_naver_matching_diff') is not null begin
		exec sp_rename tbl_pdss_naver_matching_diff, tbl_pdss_naver_matching_diff_old
	end

	create table tbl_pdss_naver_matching(
		pl_no bigint
	,	pl_vcode int
	,	pl_goodscode varchar(50)
	,	pl_modelno int
	,	option_flag2 char(1)
	,	pl_copyplno bigint
	,	pl_modelno_csv varchar(1000)
	,	chg_class varchar(1) default('')
	,	regdate datetime not null default(getdate())
	)

	insert into tbl_pdss_naver_matching(pl_no, pl_vcode, pl_goodscode, pl_modelno, option_flag2, pl_copyplno, pl_modelno_csv)
	select a.pl_no, a.pl_vcode+0 pl_vcode, a.pl_goodscode, a.pl_modelno, (case when a.option_flag2 = '1' then 'Y' else '' end) option_flag2, a.pl_copyplno, '' pl_modelno_csv
	from pricelist a with (readuncommitted)  
	inner join tbl_pdss_naver_modelno b with (readuncommitted) on a.pl_modelno = b.modelno
	inner join #tbl_pdss_naver_shoplist c with (readuncommitted) on a.pl_vcode = c.shop_code	
	where pl_goodsnm <> '' -- 강제추가 제외
	and pl_goodscode <> ''
	and pl_srvflag in ('0', 'B')
	--and pl_vcode in (select shop_vcode+0 from tbl_pdss_naver_shoplist c with (readuncommitted))
	--and pl_vcode not in (7871) -- 설정되지 않은 업체
	--and regdate between '2017-11-06 14:00' and '2017-11-06 15:00' 
	option (maxdop 1)


	-- ---------------------------------
	-- 분할상품 모델 CSV 전환
	-- ---------------------------------

	-- 1. 분할상품 추출
	--drop table #copyplno
	select distinct pl_modelno, pl_copyplno 
	into #copyplno 
	from tbl_pdss_naver_matching where pl_copyplno > 0

	-- 2. 분할상품의 모델번호 CSV 처리
	-- drop table #pl_modelno_csv
	select pl_copyplno, pl_modelno_csv
	into #pl_modelno_csv
	from 
	(
		select pl_copyplno
		, (
			select substring(
			(select '^' + cast(pl_modelno as varchar(1000))
			from #copyplno s
			where s.pl_copyplno = a.pl_copyplno
			order by pl_modelno
			for xml path('')),2,200000) as pl_modelno_csv
		) pl_modelno_csv
		from 
		(
			select distinct pl_copyplno from #copyplno
		) a
	) a
	where charindex('^', pl_modelno_csv) > 0 -- 모델번호 1개만 있는 제외한다
	option (maxdop 1)

	-- 3. 기본 테이블에 CSV 입력
	update a
	set pl_modelno_csv = b.pl_modelno_csv
	from tbl_pdss_naver_matching a inner join #pl_modelno_csv b on a.pl_copyplno = b.pl_copyplno
	option (maxdop 1)


	-- 4. 증분 테이블에 CSV 입력
	select 
		chg_class = cast(case 
			when a.pl_no is null then 'D' -- 삭제
			when b.pl_no is null then 'U' -- 추가
			when a.pl_modelno <> b.pl_modelno then 'U'
		end as char(1)) 
	, pl_no = isnull(a.pl_no, b.pl_no) 
	, pl_vcode = isnull(a.pl_vcode, b.pl_vcode)
	, pl_goodscode = isnull(a.pl_goodscode, b.pl_goodscode)
	, pl_modelno = isnull(a.pl_modelno, b.pl_modelno)
	, option_flag2 = isnull(a.option_flag2, b.option_flag2)
	, pl_copyplno = isnull(a.pl_copyplno, b.pl_copyplno)
	, pl_modelno_csv = isnull((case when a.pl_no is null and b.pl_copyplno > 0 then (select pl_modelno_csv from #pl_modelno_csv c where c.pl_copyplno = b.pl_copyplno) else a.pl_modelno_csv end), '') 		
	, getdate() as regdate
	into tbl_pdss_naver_matching_diff
	from tbl_pdss_naver_matching a with (readuncommitted)
	full outer join tbl_pdss_naver_matching_old b  with (readuncommitted)
	on a.pl_no = b.pl_no
	where a.pl_no is null
	or b.pl_no is null
	or a.pl_modelno <> b.pl_modelno
	option (maxdop 1)

end


