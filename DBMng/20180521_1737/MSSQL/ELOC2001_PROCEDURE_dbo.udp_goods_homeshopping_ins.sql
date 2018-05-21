/* *************************************************************************
 * NAME : dbo.udp_goods_homeshopping_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-12-02 11:11:27.05
 *        Modify: 2018-05-03 17:23:35.123
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC udp_goods_homeshopping_ins
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookkii25 / 2010-12-02
	-- 설  명 : 홈쇼핑 상품 / agent에서 예약작업으로 1일 1회 실행
	/*
	* 작업자 : wookki25 / 2010.12.02
	* 요청자 : 박윤숙
	* 내   용 : 누리봇에서 pricelist에 저장한 홈쇼핑 상품 중 
				  사이트에서 서비스 하지 않는 상품만 저장하도록 처리
				  jca에서 담당자가 해당 상품 확인하고 오라클에 있는 
				  홈쇼핑 상품 서비스 테이블에 등록하도록 처리하는데 사용
	*/
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2015.11.06		wookki25		and g_imgchk in ('1','4','5','6','7','9') 조건삭제
									delete from tbl_goods_homeshopping where category like '1[45]%' and g_imgchk = '4' 삭제
									and g_date >= dateadd(m, -1, getdate()) -- 최근 1개월만 조건 추가
									< 3. 이미 등록된 모델 제외 > 기능 삭제
									http://jca.enuri.com/board/redirect.asp?bt=1&bn=387&cn=507280
	*/

	-- 0. 기존 자료 처리
	select modelno
	into #exception_modelno
	from tbl_goods_homeshopping where is_exception = '1'

	truncate table tbl_goods_homeshopping
	

	-- 1. 오라클에서 이미 등록된 홈쇼핑 상품 가져오기
	/*
	select cast(modelno as int) as pre_reg_modelno
	into #tmp_pre_reg_modelno
	from openquery(oradb, 'select to_char(modelno) as modelno from tbl_home_shop')
	*/

	-- 2. 누리봇에서 가져온 홈쇼핑 상품 선택
	select distinct pl_modelno as target_modelno, '0' as is_exception
	into #tmp_target_modelno
	from pricelist
	where pl_vcode in (57,75,663,806,974,6588)
	and pl_homeflag = 'y'
	and pl_status in ('0', '1','2')
	and pl_modelno > 0


	-- select top 10 pl_homeflag * from pricelist where pl_vcode = 2285


	-- 3. 이미 등록된 모델 제외
	/*
	delete #tmp_target_modelno 
	from #tmp_target_modelno inner join #tmp_pre_reg_modelno on pre_reg_modelno = target_modelno
	*/


	-- 4. goods 정보	
	insert into tbl_goods_homeshopping(modelno, category, modelnm, regdate, g_imgchk)
	select g_modelno, g_category, g_modelnm, g_date, g_imgchk
	from goods inner join  #tmp_target_modelno on g_modelno = target_modelno
	where g_jobcode >'0' --and g_imgchk in ('1','4','5','6','7','9')
	and g_date >= dateadd(m, -1, getdate()) -- 최근 1개월만



	-- 식품. 패션 대분류 이미지코드 4 제외
	--delete from tbl_goods_homeshopping where category like '1[45]%' and g_imgchk = '4'

	-- 패션 대분류는 최근 7일
	delete from tbl_goods_homeshopping where category like '14%' and regdate < dateadd(d, -7, getdate()) -- 최근 일치만

	-- 5. 기존 제외처리 적용
	update tbl_goods_homeshopping
	set is_exception = '1'
	from tbl_goods_homeshopping a inner join #exception_modelno b on a.modelno = b.modelno	


