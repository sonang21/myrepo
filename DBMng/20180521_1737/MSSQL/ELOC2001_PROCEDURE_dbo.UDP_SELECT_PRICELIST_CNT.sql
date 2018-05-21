/* *************************************************************************
 * NAME : dbo.UDP_SELECT_PRICELIST_CNT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:56.857
 *        Modify: 2018-05-03 17:23:35.707
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_SELECT_PRICELIST_CNT
	@strVcode INT
	,@intOpt tinyint
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	/*	
	@intOpt : 0 - ���� ��ǰ�� (������ �𵨼�)
	@intOpt : 1 - �� ���� ��ǰ�� (���θ� ��ǰ��)
	@intOpt : 2 - ��ü ��ǰ�� (���θ� ��ǰ��)
	@intOpt : 3 - ��Ͽ�û ��ǰ�� (���θ� ��ǰ��)
	@intOpt : 4 - ������ ���� ��ǰ��	 (������ �𵨼�)
	*/
	DECLARE @strQry nvarchar(300)
	IF (@intOpt = 0)
		BEGIN
			SET @strQry = 'SELECT COUNT(distinct g_modelno) as cnt'
			SET @strQry = @strQry + ' FROM GOODS (nolock)'
			SET @strQry = @strQry + ' INNER JOIN PRICELIST (nolock)'
			SET @strQry = @strQry + ' ON g_modelno = pl_modelno'
			SET @strQry = @strQry + ' WHERE'
				SET @strQry = @strQry + ' pl_vcode = '+ CAST( @strVcode AS VARCHAR(10)) 
				SET @strQry = @strQry + ' and g_jobcode = ''1'''
				SET @strQry = @strQry + ' and g_mallcnt > 0'
				SET @strQry = @strQry + ' and g_constrain = ''1'''
				SET @strQry = @strQry + ' and pl_status < ''3'''
				SET @strQry = @strQry + ' and pl_srvflag = ''0'''
				--SET @strQry = @strQry + ' and pl_flag =''0'''
		END
	ELSE IF (@intOpt = 1)
		BEGIN
			SET @strQry = 'SELECT count(*) as cnt'
			SET @strQry = @strQry + ' FROM  PRICELIST (nolock)'
			SET @strQry = @strQry + ' WHERE'
				SET @strQry = @strQry + ' pl_vcode = '+ CAST( @strVcode AS VARCHAR(10)) 
				SET @strQry = @strQry + ' and pl_modelno > 0'
				SET @strQry = @strQry + ' and pl_status < ''3'''
				SET @strQry = @strQry + ' and pl_srvflag = ''0'''
		END
	ELSE IF (@intOpt = 2)
		BEGIN
			SET @strQry = 'SELECT count(*) as cnt'
			SET @strQry = @strQry + ' FROM  PRICELIST (nolock)'
			SET @strQry = @strQry + ' WHERE'
				SET @strQry = @strQry + ' pl_vcode = '+ CAST( @strVcode AS VARCHAR(10)) 
				SET @strQry = @strQry + ' and pl_status < ''3'''
				SET @strQry = @strQry + ' and pl_srvflag = ''0'''
		END
	ELSE IF (@intOpt = 3)
		BEGIN
			SET @strQry = 'SELECT count(*) as cnt'
			SET @strQry = @strQry + ' FROM  PRICELIST (nolock)'
			SET @strQry = @strQry + ' WHERE'
				SET @strQry = @strQry + ' pl_vcode = '+ CAST( @strVcode AS VARCHAR(10)) 
				SET @strQry = @strQry + ' and pl_modelno <=0'
				SET @strQry = @strQry + ' and pl_status < ''3'''
				SET @strQry = @strQry + ' and pl_srvflag = ''0'''
				--SET @strQry = @strQry + ' and pl_flag = ''0'''
		END
	ELSE IF (@intOpt = 4)
		BEGIN
			SET @strQry = 'SELECT COUNT(distinct g_modelno) as cnt'
			SET @strQry = @strQry + ' FROM GOODS (nolock)'
			SET @strQry = @strQry + ' INNER JOIN PRICELIST (nolock)'
			SET @strQry = @strQry + ' ON g_modelno = pl_modelno'
			SET @strQry = @strQry + ' WHERE'
				SET @strQry = @strQry + ' pl_vcode = '+ CAST( @strVcode AS VARCHAR(10)) 
				SET @strQry = @strQry + ' and g_jobcode = ''1'''
				SET @strQry = @strQry + ' and g_mallcnt > 0'
				SET @strQry = @strQry + ' and g_constrain = ''1'''
				SET @strQry = @strQry + ' and pl_status < ''3'''
				SET @strQry = @strQry + ' and pl_srvflag = ''0'''
				--SET @strQry = @strQry + ' and pl_flag =''0'''
				SET @strQry = @strQry + ' and g_minprice = pl_price'
		END
--print @strQry
EXEC sp_executesql @strQry
END





