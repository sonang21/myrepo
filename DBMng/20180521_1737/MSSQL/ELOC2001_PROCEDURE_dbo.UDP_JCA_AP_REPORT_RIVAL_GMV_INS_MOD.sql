/* *************************************************************************
 * NAME : dbo.UDP_JCA_AP_REPORT_RIVAL_GMV_INS_MOD
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-10-15 15:16:46.15
 *        Modify: 2018-05-03 17:23:34.56
 *        Backup: 20180521_1737
 ************************************************************************* */


-- �Է�/���� ���ν���
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROC [dbo].[UDP_JCA_AP_REPORT_RIVAL_GMV_INS_MOD]
	@YYYYMM		CHAR(6)
,	@ENURI_GMV	DECIMAL(5,1)
,	@NAVER_GMV	DECIMAL(5,1)
,	@DANAWA_GMV	DECIMAL(5,1)
AS
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2008.10.15
	-- ��  �� : ����� GMV �Է� - ����� ���� �ľ�
	-- ��  �� : UDP_JCA_AP_DATA_INS_FEE 536, 2008, 11, 6, 8900
	-- ----------------------------------------------------------------------------------
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	*/
	IF EXISTS(SELECT TOP 1 * FROM TBL_JCA_RIVAL_GMV WHERE YYYYMM = @YYYYMM)
	BEGIN
		UPDATE	TBL_JCA_RIVAL_GMV
		SET		ENURI_GMV = @ENURI_GMV
		,		NAVER_GMV = @NAVER_GMV
		,		DANAWA_GMV = @DANAWA_GMV
		WHERE	YYYYMM = @YYYYMM
	END
	ELSE
	BEGIN
		INSERT INTO TBL_JCA_RIVAL_GMV (YYYYMM, ENURI_GMV, NAVER_GMV, DANAWA_GMV)
		VALUES (@YYYYMM, @ENURI_GMV, @NAVER_GMV, @DANAWA_GMV)		
	END
