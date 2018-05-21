/* *************************************************************************
 * NAME : dbo.USP_JOB_PRICELIST_INS_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-03-28 09:05:34.817
 *        Modify: 2015-10-20 17:51:02.27
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[USP_JOB_PRICELIST_INS_1]
	@JP_PLISTNO  BIGINT,
	@JP_MODELNO INT,
	@JP_VCODE INT,
	@JP_ID VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	INSERT INTO JOB_PRICELIST 
	(JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG)
	VALUES
	(@JP_PLISTNO,@JP_MODELNO,@JP_VCODE,@JP_ID,'0' )	

END
