/* *************************************************************************
 * NAME : dbo.udp_auto_matching_price_agg_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-07-25 14:15:05.473
 *        Modify: 2018-05-03 17:23:34.223
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE  PROC udp_auto_matching_price_agg_ins
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-07-25
	-- 설  명 : pricelist 동일상품명  일별 통계 집계
	--			처리그룹여부   : 그룹내에 있는 상품중 한상품이라도 처리 또는 제외한 그룹의 수
	--			미처리그룹여부 : 그룹내에 있는 모든 상품을 미처리한 경우 그룹의 수
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	-- 집계내역이 이미 있는 경우 먼저 삭제한다.
	-- delete from tbl_auto_matching_price_agg
	-- where aggdate>= cast(convert(varchar(10), getdate()-1, 120) as smalldatetime)
	-- and aggdate <  cast(convert(varchar(10), getdate(), 120) as smalldatetime)


	insert into tbl_auto_matching_price_agg
	select cast(convert(varchar(10), getdate()-1, 120) as smalldatetime)
	,	mcate
	,	sum([그룹별_총개수])
	,	sum([그룹별_모델추가_후_처리_여부])
	,	sum([그룹별_번호매칭_자동매칭_여부])
	,	sum([그룹별_번호매칭_수작업_여부])
	,	sum([그룹별_미처리_여부])
	,	sum([상품별_총상품수])
	,	sum([상품별_모델추가_후_처리_여부])
	,	sum([상품별_번호매칭_자동매칭_여부])
	,	sum([상품별_번호매칭_수작업_여부])
	,	sum([상품별_미처리_여부])

	,	sum(sign([상품별_총상품수_최저가여부]))
	,	sum([상품별_총상품수_최저가여부])

	,	sum(sign([상품별_번호매칭_수작업_최저가여부]))
	,	sum([상품별_번호매칭_수작업_최저가여부])
	,	min(s_regdate)
	,	max(e_regdate)		
	from
	(
		select	pl_no2,	left(max(model_ca_code),4) as mcate
				,	[그룹별_총개수] =  1
				,	[그룹별_모델추가_후_처리_여부] = (case when max(job_flag) = '3' then 1 else 0 end)
				,	[그룹별_번호매칭_자동매칭_여부] = (case when max(job_flag) = '6' then 1 else 0 end)
				,	[그룹별_번호매칭_수작업_여부] = (case when max(job_flag) = '4' then 1 else 0 end)
				,	[그룹별_미처리_여부] = (case when max(job_flag) = '0' then 1 else 0 end)

				-- 상품별 집계
				,	[상품별_총상품수] = count(*)
				,	[상품별_모델추가_후_처리_여부] = sum(case when job_flag = '3' then 1 else 0 end)
				,	[상품별_번호매칭_자동매칭_여부] = sum(case when job_flag = '6' then 1 else 0 end)
				,	[상품별_번호매칭_수작업_여부] = sum(case when job_flag = '4' then 1 else 0 end)
				,	[상품별_미처리_여부] = sum(case when job_flag in( '0', '1' ) then 1 else 0 end)

				-- 상품별 최저가 여부
				,	[상품별_총상품수_최저가여부] = sum(case when price <= minprice then 1 else 0 end)
				,	[상품별_번호매칭_수작업_최저가여부] = sum(case when job_flag = '4' and  price <= minprice then 1 else 0 end)

				,	min(regdate) s_regdate
				,	max(regdate) e_regdate
		from tbl_auto_matching_price
		group by	pl_no2
	) a
	group by mcate
	option (maxdop 1)


	if @@rowcount>0  begin
		-- 최근 6개월 데이터 유지한다.
		delete from tbl_auto_matching_price_agg 
		where aggdate < cast(convert(char(8), dateadd(m, -6, getdate()),112) as smalldatetime)
	end

	delete from tbl_auto_matching_price_back where regdate<getdate()-7
	
	insert into tbl_auto_matching_price_back(pl_no,price,goodsnm,ca_code,modelno,pl_no2,minprice,regdate,job_flag)
	select pl_no,price,goodsnm,ca_code,modelno,pl_no2,minprice,regdate,job_flag from tbl_auto_matching_price


