/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_INS_FEE_PMPINSIDE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-03-19 10:27:45.767
 *        Modify: 2018-05-03 17:23:35.837
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [dbo].[UDP_JCA_AP_REPORT_INS_FEE_PMPINSIDE]
	@SHOPCODE	INT,
	@YEAR		INT,
	@MONTH		INT,
	@DAY		INT,
	@MONEY		MONEY
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2008.03.18
	-- ��  �� : AP ��ü ������ ������ �Է�
	-- ��  �� : UDP_JCA_AP_REPORT_INS_FEE_PMPINSIDE 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	IF NOT EXISTS(SELECT TOP 1 * FROM TBL_AP_SHOP_PMPINSIDE WHERE AS_SHOP=@SHOPCODE AND AS_DATE_YEAR=@YEAR AND AS_DATE_MONTH=@MONTH)
	BEGIN
		INSERT INTO TBL_AP_SHOP_PMPINSIDE (AS_SHOP, AS_DATE_YEAR, AS_DATE_MONTH)
		VALUES (@SHOPCODE, @YEAR, @MONTH)		
	END

	-- ������ ������ ������Ʈ
	UPDATE	TBL_AP_SHOP_PMPINSIDE
	SET		AS_MONTH = @MONEY
	WHERE	AS_SHOP = @SHOPCODE AND
			AS_DATE_YEAR = @YEAR AND
			AS_DATE_MONTH = @MONTH
