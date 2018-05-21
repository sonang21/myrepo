/* *************************************************************************
 * NAME : dbo.udp_monitoring_target_step5_strangelist
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-03-31 19:00:55.287
 *        Modify: 2018-05-03 17:23:35.297
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_monitoring_target_step5_strangelist
as
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2015-01-06
	-- 설  명 : 모니터링 데이터 수집
	-- ----------------------------------------------
--insert into tmp_20150326_runstep select getdate(), 51
	-- 모델명 변경인 경우 strangelist 입력
	insert into tbl_strange_list (sl_plno, sl_vcode, sl_modelno, sl_goodsnm, sl_price, sl_category, sl_goodscode) --, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode
	select pl_no, pl_vcode, pl_modelno, pl_goodsnm_old, pl_price, pl_category, '' sl_goodscode
	from tbl_monitoring_target_raw_new
	where is_strangelist = 1
	option (maxdop 1)
--insert into tmp_20150326_runstep select getdate(), 52

