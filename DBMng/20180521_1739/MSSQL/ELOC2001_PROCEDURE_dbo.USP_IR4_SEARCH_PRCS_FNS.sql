/* *************************************************************************
 * NAME : dbo.USP_IR4_SEARCH_PRCS_FNS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-11-25 17:30:05.13
 *        Modify: 2018-05-03 17:23:34.717
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROCEDURE USP_IR4_SEARCH_PRCS_FNS
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    UPDATE SYS_SEARCH_PRCS_LOG
	SET PRCS_FNS_DT = PRCS_SRT_DT, PRCS_STTS_VLU = 'C'
	WHERE COLLECTION_NM = 'MP_GOODS'
END

