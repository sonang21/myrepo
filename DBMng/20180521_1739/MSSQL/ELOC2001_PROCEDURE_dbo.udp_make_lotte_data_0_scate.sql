/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_0_scate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-24 09:57:10.993
 *        Modify: 2018-05-03 17:23:36.133
 *        Backup: 20180521_1739
 ************************************************************************* */

create  proc udp_make_lotte_data_0_scate
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2011-06-21
	-- 설  명 : 롯데닷컴 제공 데이터 만들기
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	-- 중분류 처리시 생성된 테이블 사용
	delete from tmp_shop_agg_base where mcate not in ('1481','1459')

	create index tmp_shop_agg_base_mcate on tmp_shop_agg_base(mcate)
	create index tmp_shop_agg_base_scate on tmp_shop_agg_base(scate)

	-- 예외처리
	-- select * from c_scate where cs_lcode = '14' and cs_mcode in ('81', '59') and cs_seqno > 0
	update tmp_shop_agg_base  set scate = '148101' where scate = '148105' -- 기타 분류 통합처리
	update tmp_shop_agg_base  set scate = '148102' where scate = '148106' -- 기타 분류 통합처리
	update tmp_shop_agg_base  set scate = '148103' where scate = '148107' -- 기타 분류 통합처리
	update tmp_shop_agg_base  set scate = '148104' where scate = '148108' -- 기타 분류 통합처리
