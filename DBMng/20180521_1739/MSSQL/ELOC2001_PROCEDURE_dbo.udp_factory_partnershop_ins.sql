/* *************************************************************************
 * NAME : dbo.udp_factory_partnershop_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-15 10:36:53.74
 *        Modify: 2018-05-03 17:23:34.95
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_factory_partnershop_ins
	@factory varchar(50)
,	@contents varchar(1000)
,	@url varchar(500)
,	@ins_way char(1)
,	@auto_renewal bit
,	@sdate smalldatetime
,	@edate smalldatetime
,	@status varchar(1)
,	@udate smalldatetime
,	@monitor_memo varchar(100)
,	@writer nvarchar(5)
,	@is_img bit
,	@is_catal bit
,	@ecatal_group char(1)
AS 
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2010-08-19
	-- 설  명 : 제조사  제휴 입력
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/
	
	insert into tbl_factory_partnership(factory,contents,url,ins_way,auto_renewal,sdate,edate,status,udate,monitor_memo,writer, is_img, is_catal, ecatal_group)
	values(@factory,@contents,@url,@ins_way,@auto_renewal,@sdate,@edate,@status,@udate,@monitor_memo,@writer,@is_img,@is_catal, @ecatal_group)




