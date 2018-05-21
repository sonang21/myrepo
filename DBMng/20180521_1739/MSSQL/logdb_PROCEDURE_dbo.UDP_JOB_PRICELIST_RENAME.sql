/* *************************************************************************
 * NAME : dbo.UDP_JOB_PRICELIST_RENAME
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-04-18 14:01:49.18
 *        Modify: 2017-09-19 09:28:11.637
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[UDP_JOB_PRICELIST_RENAME]

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    SET LOCK_TIMEOUT 5000

	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[JOB_PRICELIST_OLD]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[JOB_PRICELIST_OLD]
	
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[JOB_PRICELIST_NEW]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[JOB_PRICELIST_NEW]
	
	-- 변경되면 196서버 테이블도 변경해야 함.
	CREATE TABLE [JOB_PRICELIST_NEW] (
		[jp_plistno] [bigint] NOT NULL ,
		[jp_modelno] [int] NULL ,
		[jp_vcode] int NOT NULL ,
		[jp_id] [varchar] (15) NOT NULL ,
		[jp_flag] [char] (1) NOT NULL ,
		[jp_date] [datetime] NOT NULL DEFAULT (getdate()),
		[jp_goodsnm] varchar(400) null,
		[jp_price] money null,
		[jp_category] varchar(12) null,
		[jp_price_mobile] numeric(15,0) null,
		jp_note nvarchar(200) null,
		jp_minprice numeric(15,0) null,
		jp_goodsnm_old varchar(400) null
	) ON [PRIMARY]

	CREATE NONCLUSTERED INDEX NCL_JOB_PRICELIST_01 ON JOB_PRICELIST_NEW(JP_MODELNO)
	CREATE NONCLUSTERED INDEX NCL_JOB_PRICELIST_02 ON JOB_PRICELIST_NEW(JP_ID, JP_CATEGORY) -- 인덱스 생성 / wookki25/2017.08.02
	
	EXEC SP_RENAME 'JOB_PRICELIST', 'JOB_PRICELIST_OLD'
	EXEC SP_RENAME 'JOB_PRICELIST_NEW', 'JOB_PRICELIST'


	
END


