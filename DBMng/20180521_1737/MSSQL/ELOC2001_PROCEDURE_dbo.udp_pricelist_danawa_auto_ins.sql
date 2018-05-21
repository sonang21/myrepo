/* *************************************************************************
 * NAME : dbo.udp_pricelist_danawa_auto_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-03-26 17:46:35.48
 *        Modify: 2018-05-03 17:23:35.71
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[udp_pricelist_danawa_auto_ins]
AS 
	SET NOCOUNT ON 
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2012.03.26
	-- 설  명 : 한정상품(=pricelist.pl_srvflag='m') : 단종코드
	-- (= ep로 넘어오지 않은 상품을 담당자가 강제로 추가한다.)
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	2012.04.03		wookki25		pl_stauts='5' 처리
	*/
	--	-------------------
	-- oracle 처리 : pl_status = '5'인 데이터 삭제
	--	-------------------
	-- delete openquery(oradb, 'select * from tbl_pricelist_danawa a where exists (select 1 from tbl_pricelist b where a.shop_code=b.shop_code and a.goodscode = b.goodscode group by b.shop_code having max(status) = ''5'')')

	-- -------------------
	-- eloc 처리
	-- -------------------
	/*
		-- 기능삭제 : http://58.234.199.100/redmine/issues/26410
		-- 초기화
		truncate table pricelist_danawa

		-- 오라클 데이터 이전
		insert into pricelist_danawa(pl_vcode, pl_goodscode)
		select shop_code, goodscode
		from openquery(ORADB,'select to_char(shop_code) shop_code, goodscode from tbl_pricelist_danawa where flag in (''0'',''1'')')
		-- flag : 0 - 한정상품 or jca 입력한 데이터
		--        1 - 미니봇,ctu 15회 이상 수정한 데이터
		--		  2 - 품절 데이터
		
		-- 누적시킬 데이터 select
		select pl_vcode, pl_goodscode
		into #tmp_work
		from pricelist a with (Readuncommitted)
		where pl_srvflag = 'm' and pl_status <> '5' -- 보관(pl_status='5' == 삭제된데이터)
		and not exists (select pl_vcode from pricelist_danawa b where b.pl_vcode = a.pl_vcode and b.pl_goodscode = a.pl_goodscode and b.pl_goodscode_cs = a.pl_goodscode_cs)
		and pl_goodscode is not null

		-- 누적 데이터 입력
		insert into pricelist_danawa(pl_vcode, pl_goodscode)
		select pl_vcode, pl_goodscode from #tmp_work
	*/
	--	-------------------
	-- oracle 처리
	--	-------------------
	/*
		-- 누적데이터 입력
		-- 기능삭제 : http://58.234.199.100/redmine/issues/26410
		insert openquery (oradb, 'select shop_code, goodscode from tbl_pricelist_danawa')
		select pl_vcode, pl_goodscode from #tmp_work
	*/

		--강제추가 상품 입력 (상품코드 없음, pl_no 입력)
		--작업자 : 김성호 // 소셜 강제 추가된 상품 오라클로 복사 & 미니봇에서 해당 상품 크롤링
		select T2.PL_VCODE as VCODE, T2.PL_NO as PLNO
		into #tmp_PD
		FROM PRICELIST_COMPULSION AS T1 WITH(READUNCOMMITTED)
		LEFT OUTER JOIN PRICELIST AS T2 WITH(READUNCOMMITTED)
		ON T1.PL_NO = T2.PL_NO
		WHERE PL_VCODE = 6641 AND PL_MODELNO > 0 AND PL_STATUS = '0'
		--AND T1.PL_NO NOT IN (SELECT PL_GOODSCODE FROM PRICELIST_DANAWA WHERE PL_VCODE = 6641)
		AND T1.PL_NO NOT IN (select GOODSCODE from OPENQUERY (ORADB, 'SELECT GOODSCODE FROM TBL_PRICELIST_DANAWA where shop_code = 6641'))
	
		INSERT OPENQUERY (ORADB, 'SELECT SHOP_CODE, GOODSCODE, FLAG FROM TBL_PRICELIST_DANAWA')
		SELECT VCODE, PLNO, '4' FROM #tmp_PD  
