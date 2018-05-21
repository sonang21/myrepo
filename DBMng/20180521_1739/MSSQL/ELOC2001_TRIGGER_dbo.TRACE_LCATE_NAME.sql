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
	-- �ۼ��� : wookki25
	-- �ۼ��� : 2009.09.15
	-- ��  �� : 05 ī�װ����� �����Ǵ� ��찡 �ִ��Ͽ�, ������ �˾Ƴ��� ����
	--		    �ӽ÷� ���� Ʈ����.. ���� �˾Ƴ� �Ŀ��� ������ ����..
	--          �뷫 2�� �����մϴ�. ^^
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
