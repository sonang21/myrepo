/* *************************************************************************
 * NAME : dbo.udp_reward_raw_order_set_cate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-05-17 16:48:57.96
 *        Modify: 2018-05-03 17:23:34.523
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_reward_raw_order_set_cate
	@shop_vcode int
as
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2017.05.17
	-- 설  명 :  분류정보 입력
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted


	create table #tmp_search_target_shop(
		shop_vcode int 
	)



	-- 위메프 예외처리
	if @shop_vcode in ( 6508, 6641, 5910) begin -- 위메프/티몬/11번가.소셜상품때문에 예외처리

		-- 딜번호로 pl_no 찾기
		update a 
		set pl_no = isnull((
				select top 1 pl_no 
				from PRICELIST_MAKE_GOODSCODE  with (readuncommitted) 
				where pl_url_goodscode  = a.goodscode and pl_url_goodscode_cs = checksum(a.goodscode) 
				and pl_vcode = a.shop_code
				order by pl_no desc
		), 0)
		from tbl_reward_raw_order_worker a

		-- 분류코드 입히기
		update a set ca_code = isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
		from tbl_reward_raw_order_worker a inner join pricelist b on a.pl_no= b.pl_no	

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


	update a 
	set ca_code =  isnull(case when isnull(len(pl_category),0)>=2 then pl_category else '00' end,'00')
	, pl_no = b.pl_no
	from tbl_reward_raw_order_worker a inner join pricelist b 
	on checksum(a.goodscode) = pl_goodscode_cs
	and a.goodscode = pl_goodscode 
	--and a.shop_code = b.pl_vcode 
	--where b.pl_vcode = @shop_vcode
	--and	a.shop_code = @shop_vcode
	where (isnull(a.pl_no,0) = 0 or a.ca_code like '00%')
	and b.pl_vcode in (
		select SHOP_VCODE from #tmp_search_target_shop
	)
	option (maxdop 1)




