/* *************************************************************************
 * NAME : dbo.UDP_ORDERDATA_SET_GOODS_INFO
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-12-24 15:32:47.5
 *        Modify: 2018-05-03 17:23:34.24
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [DBO].[UDP_ORDERDATA_SET_GOODS_INFO]
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.04.25
	-- 설  명 : 주문 Raw 데이터에 상품정보 입력	
	-- ----------------------------------------------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2013.08.20		wookki25		유사상품 여부 체크.. is_auto_modelno
									이난아 요청. 8월 20일 데이터부터 적용될 예정
	*/
	
	declare @shop_vcode int
	select top 1 @shop_vcode = shop_vcode from tbl_orderdata_worker 

	create table #tmp_search_target_shop(
		shop_vcode int 
	)

--print @shop_vcode

	-- 데이터 삭제
	--delete tbl_orderdata_worker 
	--from tbl_orderdata_worker 
	--where od_cnt <= 0 or od_price <= 0 or od_id is null 
	--or od_comment like '%취소%' or od_comment like '%반품%' 
	--or od_comment like '%클레임%' or od_comment like '%실패%'
	--or od_comment like '%cancel%' or od_comment like '%실패%'


	--if @shop_vcode = 4027
	--begin
	--	delete tbl_orderdata_worker from tbl_orderdata_worker where od_goodscode like 'bn%'
	--end



	-- 업체공통사항 : 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
	-- 주문 진행상태가 달라도 1개 상품으로 처리
	--select od_id, od_goodscode, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
	--into #tmp_worker
	--from tbl_orderdata_worker 
	--group by od_id, od_goodscode, convert(varchar(10), od_regdate, 112) having count(*) > 1

	--update	tbl_orderdata_worker
	--set		od_cnt = b.sum_cnt
	--,		od_price = b.sum_price
	--from	tbl_orderdata_worker a inner join #tmp_worker b 
	--on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	--and		a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd

	--delete	tbl_orderdata_worker 
	--from	tbl_orderdata_worker a inner join #tmp_worker b 
	--on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	--and		a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd

	-- 단가계산
	--update tbl_orderdata_worker
	--set od_unit_price = od_price/od_cnt


	-- 상품명 기준
	declare @is_goodsnm bit
	set @is_goodsnm = 0
	if @shop_vcode in (49, 1506, 6547, 90, 6665, 6252) begin
		--(1506:아싸컴, 49:롯데닷컴, 6547:엘롯데, 90:akmall,6252:하이마트)
		set @is_goodsnm = 1
	end	else if @shop_vcode in (6361) and not exists(select 1 from tbl_orderdata_worker where od_goodscode is not null) begin
		-- 홈플러스 비식품:상품명 기준
		set @is_goodsnm = 1
	end
	
	
	
	-- pricelist 데이터 입력
	if @is_goodsnm = 1
	begin
		-- 상품명 기준 
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- 초단위 삭제/ 23:59초가 다음날로 인식되기때문에..
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodsnm) = b.pl_goodsnm_cs
					and pl_goodsnm = od_goodsnm
					and pl_vcode = a.SHOP_VCODE
		option (maxdop 1)



		-- 분할상품에 대한 추가처리
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- 초단위 삭제/ 23:59초가 다음날로 인식되기때문에..
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodsnm) = b.pl_goodsnm_cs
					and pl_goodsnm = od_goodsnm
					and pl_vcode = a.SHOP_VCODE
		where	a.g_modelno<=0 and b.pl_modelno>0
		option (maxdop 1)


		update tbl_orderdata_worker
		set od_id_no = isnull(od_id_no, '')
		,	od_goodscode = isnull(od_goodscode, '')

	end
	else if @shop_vcode in (5993)
	begin
		-- 상품명 기준 (팝콘피씨)
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- 초단위 삭제/ 23:59초가 다음날로 인식되기때문에..
		,		od_unit_price =od_unit_price
		,		od_cnt = od_cnt
		,		od_goodscode = od_goodscode
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on pl_url = 'http://popcornpc.co.kr/shopuser/goods/productview.html?code='+od_goodscode
					and pl_vcode = a.shop_vcode
		option (maxdop 1)

		-- 분할상품에 대한 추가처리
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- 초단위 삭제/ 23:59초가 다음날로 인식되기때문에..
		,		od_unit_price =od_unit_price
		,		od_cnt = od_cnt
		,		od_goodscode = od_goodscode
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on pl_url = 'http://popcornpc.co.kr/shopuser/goods/productview.html?code='+od_goodscode
					and pl_vcode = a.shop_vcode
		where	a.g_modelno<=0 and b.pl_modelno>0
		option (maxdop 1)


	end	 	else 	begin


		if @shop_vcode in ( 6508, 6641, 5910) begin -- 위메프/티몬/11번가.소셜상품때문에 예외처리

			-- 딜번호로 pl_no 찾기
			update a 
			set pl_no = isnull((
					select top 1 pl_no 
					from pricelist_make_goodscode  with (readuncommitted) 
					where pl_url_goodscode  = a.od_goodscode and pl_url_goodscode_cs = checksum(a.od_goodscode) 
					and pl_vcode = a.shop_vcode
					order by pl_no desc
			), 0)
			from tbl_orderdata_worker a

			update	tbl_orderdata_worker
			set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
			,		g_modelno = isnull(b.pl_modelno,0)
			,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
			,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- 초단위 삭제/ 23:59초가 다음날로 인식되기때문에..
			,		pl_price = b.pl_price
			from	tbl_orderdata_worker a
						inner join
					pricelist b
						on a.pl_no= b.pl_no
			option (maxdop 1)


		end


		-- 계열사 검색
		if @shop_vcode in ( 7938 ) begin -- 옥션 올킬은 옥션(4027)에서 검색

			insert into #tmp_search_target_shop (shop_vcode)
			values (7938),(4027)

		end else if @shop_vcode in ( 47, 374, 6665 ) begin -- (47)신세계몰 vs (374)이마트 vs (6665)SSG.COM


			insert into #tmp_search_target_shop (shop_vcode)
			values (47),(374),(6665)

		end else if @shop_vcode in ( 55, 6780 ) begin -- (55)인터파크 vs (6780)인터파크 아이토이즈

			insert into #tmp_search_target_shop (shop_vcode)
			values (55),(6780)

		end else if @shop_vcode in ( 57, 7851 ) begin --(57)H몰 vs (7851)더현대닷컴

			insert into #tmp_search_target_shop (shop_vcode)
			values (57),(7851)

		end else if @shop_vcode in ( 536, 7692 ) begin --(536)G마켓 vs (7692)G9

			insert into #tmp_search_target_shop (shop_vcode)
			values (536),(7692)

		end else if @shop_vcode in ( 7455, 7695 ) begin -- (7455)롯데마트 vs (7695)토이저러스 온라인

			insert into #tmp_search_target_shop (shop_vcode)
			values (7455),(7695)

		end else begin

			insert into #tmp_search_target_shop (shop_vcode)
			select @shop_vcode

		end

		-- 상품코드 기준
		update	a
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		,		od_regdate = dateadd(ss,-datepart(ss,od_regdate),od_regdate) -- 초단위 삭제/ 23:59초가 다음날로 인식되기때문에..
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodscode) = b.pl_goodscode_cs
					and pl_goodscode = od_goodscode
--						and pl_vcode =  a.shop_vcode
		where (a.pl_no = 0 or a.g_category like '00%')
		and b.pl_vcode in (
			select SHOP_VCODE from #tmp_search_target_shop
		)
		option (maxdop 1)


		-- 분할상품에 대한 추가처리
		update	tbl_orderdata_worker
		set		pl_no = isnull(isnull(nullif(b.pl_copyplno,0), b.pl_no),0)
		,		g_modelno = isnull(b.pl_modelno,0)
		,		g_category = isnull(case when isnull(len(rtrim(ltrim(pl_category))),0)>=2 then rtrim(ltrim(pl_category)) else '00' end, '00')
		,		pl_price = b.pl_price
		from	tbl_orderdata_worker a
					inner join
				pricelist b
					on checksum(od_goodscode) = b.pl_goodscode_cs
					and pl_goodscode = od_goodscode
--					and pl_vcode = a.shop_vcode
		where	 a.g_modelno<=0 and b.pl_modelno>0
		and b.pl_vcode in (
			select SHOP_VCODE from #tmp_search_target_shop
		)
		option (maxdop 1)



	end

	-- goods 데이터 입력 
	update	tbl_orderdata_worker
	set		g_modelno = b.g_modelno
	,		g_category =  b.g_category
	--		수량 입력(374:이마트, 47:신세계, 58:전자랜드쇼핑몰,6641:티몬)
	/* 2015.12.02 삭제. pricelist.pl_price 사용하도록 수정
	,		od_cnt = case when shop_vcode in (374,47,58,6641) and isnull(g_minprice,0) > 1001  and od_price > 1000 then 
						case when round((od_price*1.0)/(g_minprice*1.0),0) > 0 then
							round((od_price*1.0)/(g_minprice*1.0),0) 
						else
							isnull(od_cnt,1)
						end 
					else isnull(od_cnt,1) end
	*/
	,		od_cnt = case when shop_vcode in (58,6641, 6665) and isnull(pl_price,0) > 1001  and od_price > 1000 then 
						case when round((od_price*1.0)/(pl_price*1.0),0) > 0 then
							round((od_price*1.0)/(pl_price*1.0),0) 
						else
							isnull(od_cnt,1)
						end 
					else isnull(od_cnt,1) end
	--		단가 계산(374:이마트, 47:신세계, 58:전자랜드쇼핑몰,6641:티몬)
	/* 2015.12.02 삭제. pricelist.pl_price 사용하도록 수정
	,		od_unit_price = 
					case when shop_vcode in (374,47,58,6641) and isnull(g_minprice,0) > 1001 and od_price > 1000 then 
						case when round((od_price*1.0)/(g_minprice*1.0),0) > 0 then
							od_price/(round((od_price*1.0)/(g_minprice*1.0),0))
						else
							od_unit_price 
						end
					else 
						od_unit_price 
					end					
	*/
	,		od_unit_price = 
					case when shop_vcode in (58,6641, 6665) and isnull(pl_price,0) > 1001 and od_price > 1000 then 
						case when round((od_price*1.0)/(pl_price*1.0),0) > 0 then
							od_price/(round((od_price*1.0)/(pl_price*1.0),0))
						else
							od_unit_price 
						end
					else 
						od_unit_price 
					end	
	,		g_factory = b.g_factory
	,		is_auto_modelno = case when g_constrain = '5' then 1  end
	from	tbl_orderdata_worker a
				inner join
			eloc2001.dbo.goods b
				on a.g_modelno = b.g_modelno
	where b.g_modelno > 0
			
	-- 196 proc 호출 - ssis package에서 실행하도록 처리
	-- exec oltplog_196.oltplog.dbo.udp_orderdata_ins_dlv
	-- exec oltplog_196.oltplog.dbo.udp_orderdata_ins_ord
	-- 

	if @shop_vcode in (5910) begin
		-- 11번가 옵션상품에 메인 상품의 분류코드 입력
		update a
		set	a.g_category = b.g_category
		--select a.g_category , b.g_category
		from tbl_orderdata_worker a inner join (
			select od_id, max(g_category) as g_category 
			from tbl_orderdata_worker 
			group by od_id
			having count(*) > 1
		) b on a.od_id = b.od_id
		where a.g_category = '00'
	end

