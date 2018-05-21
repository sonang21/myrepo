/* *************************************************************************
 * NAME : dbo.UDP_JOB_GOODS_RENAME
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-04-18 14:01:02.383
 *        Modify: 2017-08-02 09:58:20.57
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE  PROC [dbo].[UDP_JOB_GOODS_RENAME]

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    SET LOCK_TIMEOUT 5000

	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[JOB_GOODS_OLD]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[JOB_GOODS_OLD]
	
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[JOB_GOODS_NEW]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	drop table [dbo].[JOB_GOODS_NEW]

	CREATE TABLE [JOB_GOODS_NEW] (
		[jg_modelno] [int] NOT NULL ,
		[jg_id] [varchar] (15) NOT NULL ,
		[jg_flag] [char] (1) NOT NULL ,
		[jg_date] [datetime] NOT NULL DEFAULT (getdate()),
		[jg_category] varchar(12) null
	) ON [PRIMARY]

	-- ÀÎµ¦½º »ý¼º / wookki25/2017.08.02
	CREATE NONCLUSTERED INDEX NCL_JOB_GOODS_01 ON [JOB_GOODS_NEW]  (JG_ID, JG_CATEGORY)

	
	
	EXEC SP_RENAME 'JOB_GOODS', 'JOB_GOODS_OLD'
	EXEC SP_RENAME 'JOB_GOODS_NEW', 'JOB_GOODS'
END



