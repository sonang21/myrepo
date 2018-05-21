/* *************************************************************************
 * NAME : dbo.udp_factory_partnershop_mod
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-15 10:36:53.84
 *        Modify: 2018-05-03 17:23:34.963
 *        Backup: 20180521_1739
 ************************************************************************* */

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE proc udp_factory_partnershop_mod
	@seqno int
,	@factory varchar(50)
,	@contents varchar(1000)
,	@url varchar(500)
,	@ins_way char(1)
,	@auto_renewal bit
,	@sdate smalldatetime
,	@edate smalldatetime
,	@status varchar(1)
,	@udate smalldatetime = null
,	@monitor_memo varchar(100)
,	@writer nvarchar(5)
,	@is_img bit
,	@is_catal bit
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-08-19
	-- 설  명 : 제조사  제휴 수정
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	update tbl_factory_partnership
	set factory = @factory 
		,contents = @contents
		,url = @url
		,ins_way = @ins_way
		,auto_renewal = @auto_renewal
		,sdate = @sdate
		,edate = @edate
		,status = @status
		,udate = @udate
		,monitor_memo = @monitor_memo
		,writer = @writer
		,is_img=@is_img
		,is_catal=@is_catal
	where seqno = @seqno

