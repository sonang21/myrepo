/* *************************************************************************
 * NAME : dbo.TRACE_LCATE_NAME
 * TYPE : TRIGGER (SQL_TRIGGER)
 * TIME : Create: 2009-09-15 17:23:50.57
 *        Modify: 2018-05-02 15:22:19.443
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE TRIGGER DBO.TRACE_LCATE_NAME
ON C_LCATE
AFTER UPDATE
AS 
	-- 작성자 : wookki25
	-- 작성일 : 2009.09.15
	-- 설  명 : 05 카테고리명이 삭제되는 경우가 있다하여, 원인을 알아내기 위해
	--		    임시로 만든 트리거.. 원인 알아낸 후에는 삭제할 예정..
	--          대략 2주 예정합니다. ^^
	DECLARE @HOSTNAME NCHAR(128)
	DECLARE @PROGRAM_NAME NCHAR(128)
	DECLARE @CL_NAME NVARCHAR(30)
	DECLARE @CL_LCODE CHAR(2)
	SELECT @CL_LCODE=CL_LCODE, @CL_NAME = CL_NAME FROM INSERTED 
	IF RTRIM(LTRIM(ISNULL(@CL_NAME,''))) = ''
	BEGIN
		SELECT @HOSTNAME = HOSTNAME, @PROGRAM_NAME = PROGRAM_NAME FROM MASTER.DBO.SYSPROCESSES WHERE SPID = @@SPID	
		INSERT INTO TMP_20090915_TRACE_LCATE_NAME
		SELECT @CL_LCODE, @CL_NAME, @HOSTNAME, @PROGRAM_NAME, GETDATE() 
		
		SELECT @CL_LCODE=CL_LCODE, @CL_NAME = CL_NAME FROM DELETED
		UPDATE C_LCATE SET CL_NAME = @CL_NAME WHERE CL_LCODE = @CL_LCODE
	
	END
