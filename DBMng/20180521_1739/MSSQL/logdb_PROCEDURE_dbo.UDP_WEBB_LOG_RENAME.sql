/* *************************************************************************
 * NAME : dbo.UDP_WEBB_LOG_RENAME
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-15 19:17:22.81
 *        Modify: 2007-03-15 19:17:22.81
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_WEBB_LOG_RENAME
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET LOCK_TIMEOUT 5000

	BEGIN TRAN

		if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TBL_WEBB_LOG_OLD]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		drop table [dbo].[TBL_WEBB_LOG_OLD]
		
		
		if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TBL_WEBB_LOG_NEW]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		drop table [dbo].[TBL_WEBB_LOG_NEW]
		
		
		CREATE TABLE [dbo].[TBL_WEBB_LOG_NEW] (
			[WL_TID] [int] IDENTITY (1, 1) NOT NULL ,
			[WL_VCODE] [int] NOT NULL ,
			[WL_GOODSNM] [nvarchar] (200) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_GOODSURL] [varchar] (500) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_PRICE] [money] NULL ,
			[WL_SOLDOUT_FLAG] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_DELIVERY] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_DELIVERYINFO] [varchar] (100) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_WEBIMGURL] [varchar] (250) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_COUPON] [tinyint] NULL ,
			[WL_TAXINVOICE_YN] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_GOODSFACTORY] [nvarchar] (50) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_GOODSCODE] [varchar] (20) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_APPLY_BASIS] [char] (1) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_MODTYPE] [varchar] (10) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_MODELNO] [int] NULL ,
			[WL_MAINCATE] [varchar] (12) COLLATE Korean_Wansung_CI_AS NULL ,
			[WL_DATE] [smalldatetime] NOT NULL DEFAULT (getdate()),
			[WL_FLAG] [tinyint] NOT NULL DEFAULT (0),
			[WL_FREEINTEREST] [varchar] (50) COLLATE Korean_Wansung_CI_AS NULL 
			
		) ON [PRIMARY]
	
		
		
	
		EXEC SP_RENAME 'TBL_WEBB_LOG', 'TBL_WEBB_LOG_OLD'
		EXEC SP_RENAME 'TBL_WEBB_LOG_NEW', 'TBL_WEBB_LOG'

	COMMIT TRAN
END

