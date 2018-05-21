/* *************************************************************************
 * NAME : dbo.USP_PRICELIST_UP_9_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-05-16 09:54:59.147
 *        Modify: 2018-05-03 17:23:35.017
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC [dbo].[USP_PRICELIST_UP_9_1]
	@PL_MODELNO INT,
	@PL_STATUS CHAR(1),
	@PL_NO bigINT	
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE PRICELIST 
	SET PL_MODELNO = @PL_MODELNO, PL_STATUS = @PL_STATUS 
	WHERE PL_NO = @PL_NO 
END