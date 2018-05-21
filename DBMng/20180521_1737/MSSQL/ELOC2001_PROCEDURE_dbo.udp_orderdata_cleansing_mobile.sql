/* *************************************************************************
 * NAME : dbo.udp_orderdata_cleansing_mobile
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-07-12 17:44:42.72
 *        Modify: 2018-05-03 17:23:35.31
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc [dbo].[udp_orderdata_cleansing_mobile]
	@flag	varchar(5)
as
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2009.12.14
	-- 설  명 : 주문 raw 데이터에 중복제거
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level read uncommitted
	
	-- 업체구분
	declare @shop_vcode int
	select top 1 @shop_vcode = shop_vcode from tbl_orderdata_worker_mobile

	-- 주문번호 강제 생성 : 주문일+####(시퀀스 일련번호
	update tbl_orderdata_worker_mobile set od_id = convert(varchar(8), od_regdate, 112) +'_'+ right('0000'+cast(seq as varchar(10)), 4) where od_id is null


	-- 당일 취소,반품,클레임, 취소 상품 삭제
	IF @SHOP_VCODE = 55 	begin
		delete tbl_orderdata_worker_mobile 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker_mobile a inner join tbl_orderdata_worker_mobile b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode
					and a.od_price = b.od_price -- 인팍의 경우 부분 취소가능하므로 가격까지 같은 경우만 삭제
			where	a.od_comment <> b.od_comment
			and		(b.od_comment like '%취소%' 
							or b.od_comment like '%반품%' 
							or b.od_comment like '%클레임%' 
							or b.od_comment like '%실패%' 
							or b.od_comment like '%회수%' 
							or b.od_comment like '%cancel%'
							or b.od_comment like '%환불%'
							or b.od_comment like '%수거%'
							or b.od_comment like '%품절%'
							)
		)
	end else begin
		delete tbl_orderdata_worker_mobile 
		where seq in 
		(
			select	a.seq
			from	tbl_orderdata_worker_mobile a inner join tbl_orderdata_worker_mobile b
					on a.od_id = b.od_id and a.od_goodscode = b.od_goodscode
			where	a.od_comment <> b.od_comment
			and		(b.od_comment like '%취소%' 
							or b.od_comment like '%반품%' 
							or b.od_comment like '%클레임%' 
							or b.od_comment like '%실패%' 
							or b.od_comment like '%회수%' 
							or b.od_comment like '%cancel%'
							or b.od_comment like '%환불%'
							or b.od_comment like '%수거%'
							or b.od_comment like '%품절%'
							)
		)

	end

	delete tbl_orderdata_worker_mobile where (od_comment like '%취소%' 
												or od_comment like '%반품%' 
												or od_comment like '%클레임%' 
												or od_comment like '%실패%' 
												or od_comment like '%회수%'
												or od_comment like '%cancel%'
												or od_comment like '%환불%'
												or od_comment like '%수거%'
												or od_comment like '%품절%'
												)
											and od_comment not like '%철회%'


	-- 신세계몰 , 이마트
	if @shop_vcode in ( 47, 374 ) begin
		delete b from tbl_orderdata_worker_mobile b where	b.od_comment = '입금대기'
	end

	delete tbl_orderdata_worker_mobile where  od_price <=0  
	

	-- 잘못된 정보 삭제
	delete tbl_orderdata_worker_mobile where od_id is null

	-- 업체별 주문데이터 제외 처리
	-- gsshop
	if @shop_vcode = 75 begin
		-- 배송비 삭제
		delete	tbl_orderdata_worker_mobile where	od_goodsnm  like '배송비'
	end else if @shop_vcode = 4027 begin
		delete tbl_orderdata_worker_mobile from tbl_orderdata_worker_mobile where od_goodscode like 'bn%'
	end else if @shop_vcode = 7857 begin -- Qoo10
		-- $를 원화로 환산 // http://58.234.199.100/redmine/issues/18007
		update tbl_orderdata_worker_mobile set od_price = od_price * 1100
	end

	-- 누리봇에서 변환시키는 모델명 처리
	update tbl_orderdata_worker_mobile
	set od_goodsnm =replace(replace(replace(replace(replace(replace(replace(replace(replace(
replace(replace(replace(replace(replace(replace(replace(
replace(replace(od_goodsnm,'★','-'),'●','-'),'◆','-'),'■','-'),'▲','-'),'▼','-'),'◀','-'),'▶','-'),'♠','-'),'♥
','-'),'♣','-'),'◈','-'),'▣','-'),'⊙','-'),'◐','-'),'◑','-'),'<b>','-'),'　','-')


	-- 업체공통사항 : 기준일별 옵션상품/동일상품 중복 주문 그룹처리로 1개 상품으로 만들기
	-- 주문 진행상태가 달라도 1개 상품으로 처리
	select od_id, od_goodscode, shop_vcode, convert(varchar(10), od_regdate, 112) yyyymmdd, min(seq) min_seq, sum(od_cnt) sum_cnt, sum(od_price) sum_price, count(*) cnt
	into #tmp_worker
	from tbl_orderdata_worker_mobile 
	group by od_id, od_goodscode, convert(varchar(10), od_regdate, 112), shop_vcode
	having count(*) > 1

	update	tbl_orderdata_worker_mobile
	set		od_cnt = b.sum_cnt
	,		od_price = b.sum_price
	from	tbl_orderdata_worker_mobile a inner join #tmp_worker b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq = b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.shop_vcode = b.shop_vcode

	delete	tbl_orderdata_worker_mobile 
	from	tbl_orderdata_worker_mobile a inner join #tmp_worker b 
	on		a.od_id = b.od_id and a.od_goodscode = b.od_goodscode 
	and		a.seq > b.min_seq and convert(varchar(10), a.od_regdate, 112) = b.yyyymmdd
	and		a.shop_vcode = b.shop_vcode


	-- 단가계산
	update tbl_orderdata_worker_mobile	set od_unit_price = od_price/od_cnt











 