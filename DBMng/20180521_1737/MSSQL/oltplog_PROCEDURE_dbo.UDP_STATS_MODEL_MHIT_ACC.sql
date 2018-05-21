/* *************************************************************************
 * NAME : dbo.UDP_STATS_MODEL_MHIT_ACC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-15 15:12:38.36
 *        Modify: 2018-05-15 15:12:38.36
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE	PROC [dbo].[UDP_STATS_MODEL_MHIT_ACC]
	@DTE_IN SMALLDATETIME=''
AS
BEGIN
	SET NOCOUNT ON	
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- --------------------------------------------
	-- �ۼ��� : WOOKKI25
	-- �ۼ��� : 2007-08-07
	-- ��  �� : JCA���� ���� ī�װ��� ��ǰâ Ŭ���� ��ȸ
	--          http://jca.enuri.com/ecrm/popular/CategoryList.asp
	-- ��  �� : EXEC UDP_STATS_MODEL_MHIT_ACC '20080515'	-- 5�� ���
	-- --------------------------------------------	
	
	-- ----------------------------------------------------------------------------------
	-- ��������
	-- ----------------------------------------------------------------------------------
	/*
	������:			������:			��������:
	----------		-----------		-----------------------------------------------------		
	2008.05.15		wookki25		�ֹ����� ���迡�� AND PL_MODELNO > 0 ���� ����
	*/
	
	DECLARE @DTECHKDAY AS SMALLDATETIME
	IF @DTE_IN = ''
		SET @DTECHKDAY = DATEADD(D, -1, GETDATE())
	ELSE
		SET @DTECHKDAY = @DTE_IN
	SET @DTECHKDAY = CONVERT(VARCHAR(8), @DTECHKDAY, 112)



	DECLARE @SDATE AS SMALLDATETIME
	DECLARE @EDATE AS SMALLDATETIME
	SET @SDATE = DATEADD(D, -DAY(@DTECHKDAY)+1, @DTECHKDAY)
	SET @EDATE = DATEADD(M, 1, @SDATE)
		

	-- ����
	DELETE TBL_ENURI_WEB_LOG_ACC WHERE EWLA_YYMM = CONVERT(CHAR(6), @SDATE ,112)
	
	-- ����
	INSERT INTO TBL_ENURI_WEB_LOG_ACC
	( EWLA_YYMM, G_CATEGORY, EWLA_MODEL_UHIT, EWLA_MODEL_HIT, EWLA_OD_CNT, EWLA_PRICE )
	SELECT
		EWLA_YYMM,
	--	E.G_MODELNO AS G_MODELNO,
		ISNULL(LEFT(G.G_CATEGORY,4),'0000') AS G_CATEGORY,
		SUM(EWLA_MODEL_UHIT)	AS EWLA_MODEL_UHIT,
		SUM(EWLA_MODEL_HIT)		AS EWLA_MODEL_HIT,
		SUM(EWLA_OD_CNT)		AS EWLA_OD_CNT,
		SUM(EWLA_PRICE)			AS EWLA_PRICE
	FROM (	
		SELECT 
			EWLA_YYMM,
			D.G_MODELNO,
			SUM(MD_DUP_HIT) AS EWLA_MODEL_UHIT,
			SUM(MD_HIT) AS EWLA_MODEL_HIT,
			SUM(OD_CNT) AS EWLA_OD_CNT,
			SUM(OD_PRICE*OD_CNT) AS EWLA_PRICE -- wookki25 2007.05.22 �ܰ�*���� ����ó��
		FROM (
			--��ǰâ �α�
			SELECT 
				G_MODELNO,
				MD_DUP_HIT, 
				MD_HIT,
				0 AS MH_UHIT,
				0 AS MH_HIT,
				0 AS OD_CNT,
				0 AS OD_PRICE,
				LEFT(MD_DD,6) AS EWLA_YYMM
			FROM TBL_MODEL_DHIT
			WHERE MD_DD >= CONVERT(CHAR(8), @SDATE ,112) and MD_DD < CONVERT(CHAR(8), @EDATE ,112)
			

			--�ֹ�����
			UNION ALL
			SELECT
				PL_MODELNO AS G_MODELNO,
				0 AS MD_DUP_HIT,
				0 AS MD_HIT,
				0 AS MH_UHIT,
				0 AS MH_HIT,
				OD_CNT AS OD_CNT,
				OD_PRICE AS OD_PRICE,
				CONVERT(VARCHAR(6), OD_DATE, 112) AS EWLA_YYMM
			FROM TBL_ORDERDATA
			WHERE  OD_DATE >= @SDATE AND OD_DATE < @EDATE
			-- AND PL_MODELNO > 0 -- wookki25 2008.05.15 ���ǻ��� // �ֹ��� ������ ��� ������� ��!
		) D
		GROUP BY D.EWLA_YYMM, D.G_MODELNO
	) E
	LEFT JOIN analstore.DBO.GOODS G
	ON E.G_MODELNO=G.G_MODELNO
	GROUP BY EWLA_YYMM, ISNULL(LEFT(G.G_CATEGORY,4),'0000')
END




