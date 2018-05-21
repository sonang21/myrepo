/* *************************************************************************
 * NAME : dbo.udp_cj_cate_monitoring_guide_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-28 14:30:04.483
 *        Modify: 2018-05-03 17:23:34.773
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cj_cate_monitoring_guide_sel
	@cj_ca_code2 char(6)
,	@cj_ca_code3 char(6)
,	@cj_ca_code4 char(6)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.28
	-- 설  명 : 분류별 서비스 가이드
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	select seqno
	, b.cj_ca_code4
	, guide_title, guide_desc, moddate
	, b.cj_ca_code2+' > '+ b.cj_ca_code3+' > '+ b.cj_ca_code4
	,cj_ca_name2+' > '+ 
	cj_ca_name3+' > '+ 
	cj_ca_name4
	from tbl_cj_cate_monitoring_guide  a inner join tbl_cj_cate b on a.cj_ca_code4 = b.cj_ca_code4
	where a.cj_ca_code2 = @cj_ca_code2
	and a.cj_ca_code3 = iif(@cj_ca_code3='      ', a.cj_ca_code3, @cj_ca_code3)
	and a.cj_ca_code4 = iif(@cj_ca_code4='      ', a.cj_ca_code4, @cj_ca_code4)
	order by b.cj_ca_code1, b.cj_ca_code2, b.cj_ca_code3, b.cj_ca_code4, guide_title

