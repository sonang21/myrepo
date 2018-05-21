/* *************************************************************************
 * NAME : dbo.UDP_MODELNO_COPY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:55.437
 *        Modify: 2018-05-03 17:23:35.363
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.uspModelnoCopy    스크립트 날짜: 2004-10-21 오후 3:27:05 ******/
CREATE           PROC UDP_MODELNO_COPY 
	@VCODE_IN INT
	,@VCODE_OUT INT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE  @tmpPRICE TABLE
	(
		tmp_modelno	INT,
		tmp_goodsnm	NVARCHAR(200)
	)
	
	INSERT INTO @tmpPRICE
		SELECT DISTINCT pl_modelno, pl_goodsnm FROM PRICELIST (nolock)  WHERE pl_vcode = @VCODE_IN and pl_modelno > 0
	--SELECT TOP 10 tmp_modelno FROM @tmpPRICE 
	
	UPDATE PRICELIST SET pl_modelno = 
		(SELECT tmp_modelno 
			FROM @tmpPRICE 
		WHERE 
			pl_goodsnm = tmp_goodsnm 
			AND pl_vcode = @VCODE_OUT )
	WHERE pl_vcode = @VCODE_OUT and (pl_modelno is NULL or pl_modelno = -100)
	
	UPDATE PRICELIST SET pl_status = '5' where pl_vcode = @VCODE_IN
	
	--usage : EXEC uspModelnoCopy '1714','0075'
END



