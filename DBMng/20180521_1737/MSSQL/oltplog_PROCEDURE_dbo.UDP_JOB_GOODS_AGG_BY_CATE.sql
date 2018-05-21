/* *************************************************************************
 * NAME : dbo.UDP_JOB_GOODS_AGG_BY_CATE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-13 19:49:05.303
 *        Modify: 2018-05-13 19:49:05.303
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_JOB_GOODS_AGG_BY_CATE
	@SDATE DATETIME
AS 
BEGIN
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2010.01.25
	-- ��  �� : ī�װ� �۾���Ȳ ����
    -- ��  �� : UDP_JOB_GOODS_AGG_SEL
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ������:		������:		��������:
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	-- ����Ŭ ������ ��������
	-- ����Ŭ���� �������� 4:30�п� ����
	CREATE TABLE #TBL_GOODS_SRV_CNT_AT_ORACLE (CA_CODE CHAR(4), SRVCNT INT)
	DECLARE @STR VARCHAR(8000)
	SET @STR = '''SELECT YYYYMMDD, CA_CODE, CA_COUNT FROM TBL_GOODS_CA_COUNT WHERE YYYYMMDD ='''''+ CONVERT(VARCHAR(8),@SDATE, 112) +''''''''

	INSERT INTO #TBL_GOODS_SRV_CNT_AT_ORACLE
	EXEC ('SELECT CA_CODE, CA_COUNT FROM OPENQUERY(ORADB_144, '+@STR+')')

	-- ������ ����
	DELETE JOB_GOODS_AGG_BY_CATE WHERE REGDATE >= @SDATE AND REGDATE < @SDATE + 1

	-- ������ �Է�
	INSERT INTO JOB_GOODS_AGG_BY_CATE(REGDATE, MCATE, GOODS_SRV_CNT, MIS_CATAL_CNT, ADD_MODEL_CNT, NEW_CATAL_CNT, TMP_CATAL_CNT,TMP_SRV_CNT)
	-- ������(���ݺ�)
	-- ���з��� �Ϻ�/�ߺз���
	SELECT 
		@SDATE
	,	MCATE
	,	SUM(GOODS_SRV_CNT)
	,	SUM(MIS_CATA_CNT)
	,	SUM(ADD_MODEL_CNT)
	,	SUM(NEW_CATAL_CNT)
	,	SUM(TMP_CATAL_CNT)
	,	SUM(TMP_SRV_CNT)
	FROM
	(
		SELECT  MCATE = CA_CODE
		,		GOODS_SRV_CNT = SRVCNT
		,		MIS_CATA_CNT = 0
		,		ADD_MODEL_CNT = 0
		,		NEW_CATAL_CNT = 0
		,		TMP_CATAL_CNT = 0
		,		TMP_SRV_CNT = 0
		FROM	#TBL_GOODS_SRV_CNT_AT_ORACLE
		UNION ALL
		-- �۾�����(=���۾� īŻ�α�)
		-- G_WORK = 9
		SELECT  MCATE = LEFT(G_CATEGORY, 4)
		,		GOODS_SRV_CNT = 0
		,		MIS_CATA_CNT = COUNT(*)
		,		ADD_MODEL_CNT = 0
		,		NEW_CATAL_CNT = 0
		,		TMP_CATAL_CNT = 0
		,		TMP_SRV_CNT = 0
		FROM ELOC188.ELOC2001.DBO.GOODS 
		WHERE G_WORK = '9'
		GROUP BY LEFT(G_CATEGORY, 4)
		UNION ALL
		-- �űԸ� �߰�/ �ű�īŻ�α� / �ӽ�īŻ�α� / ��ü���
		SELECT  MCATE = LEFT(G_CATEGORY, 4)
		,		GOODS_SRV_CNT = 0
		,		MIS_CATA_CNT = 0
		,		ADD_MODEL_CNT = SUM(T1)
		,		NEW_CATAL_CNT = SUM(T2)
		,		TMP_CATAL_CNT = SUM(T3)
		,		TMP_SRV_CNT = SUM(T4)
		FROM
		(
			SELECT 
				JG_MODELNO
			,	ISNULL(SUM(CASE WHEN JG_FLAG='0' THEN 1 ELSE 0 END),0) AS T1	-- �űԸ�
			,	ISNULL(SUM(CASE WHEN JG_FLAG='1' THEN 1 ELSE 0 END),0) AS T2	-- �ű�īŻ�α�
			,	ISNULL(SUM(CASE WHEN JG_FLAG='4' THEN 1 ELSE 0 END),0) AS T3	-- �ӽ�īŻ�α�		
			,	ISNULL(SUM(CASE WHEN JG_FLAG='7' THEN 1 ELSE 0 END),0) AS T4	-- ��ü���
			FROM 
			(	
				SELECT	DISTINCT JG_MODELNO, JG_FLAG, JG_ID
				FROM	JOB_GOODS			
				WHERE	JG_DATE >= @SDATE
				AND		JG_DATE < @SDATE+1
			) TBL_TMP_JOB_GOODS
			GROUP BY JG_MODELNO
		) TBL_TMP_LOG INNER JOIN analstore.DBO.GOODS on JG_MODELNO = G_MODELNO
		GROUP BY LEFT(G_CATEGORY,4)
	) TBL_TMP_RESULT
	GROUP BY MCATE
END


