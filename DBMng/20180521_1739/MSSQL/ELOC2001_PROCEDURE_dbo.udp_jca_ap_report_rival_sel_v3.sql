/* *************************************************************************
 * NAME : dbo.udp_jca_ap_report_rival_sel_v3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-04-14 11:04:15.567
 *        Modify: 2018-05-03 17:23:35.017
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc [dbo].[udp_jca_ap_report_rival_sel_v3]
	@yyyy		char(4)
,	@sale_flag char(1)
as
	set nocount on
	set transaction isolation level  read uncommitted
	-- ----------------------------------------------------------------------------------
	-- 작성자 : WOOKKI25 / 2008.10.15
	-- 설  명 : 경쟁사 GMV 입력 - 경쟁사 동향 파악
	-- 실  행 : UDP_JCA_AP_DATA_INS_FEE 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- 수정내역
	-- ----------------------------------------------------------------------------------
	/*
	수정일:			수정자:			수정내용:
	----------		-----------		-----------------------------------------------------		
	*/
	select	yyyymm
	,		enuri_gmv
	,		naver_gmv
	,		danawa_gmv
	,		100/(enuri_gmv) as gmv_ratio
	from	tbl_jca_rival_gmv
	where	yyyymm like @yyyy+'%'	
	and		sale_flag = @sale_flag
	order by 1

