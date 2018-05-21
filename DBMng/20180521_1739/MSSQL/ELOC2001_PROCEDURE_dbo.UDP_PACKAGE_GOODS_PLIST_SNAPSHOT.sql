/* *************************************************************************
 * NAME : dbo.UDP_PACKAGE_GOODS_PLIST_SNAPSHOT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-12-08 14:34:31.687
 *        Modify: 2015-05-15 03:31:33.85
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE PROC UDP_PACKAGE_GOODS_PLIST_SNAPSHOT
AS
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 / 2008.12.08
	-- ��  �� : ��Ű����ǰ ����/�𵨸� ���� üũ�ϱ� ���� PLIST ������ó��
	--          196���� ȣ�� ����
	-- ��  �� : EXE CUDP_PACKAGE_GOODS_PLIST_SNAPSHOT
	-- ��  �� :
	/*
	������:		������:		��������:
	----------	-----------	-----------------------------------------------------

	*/
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED


	-- ��Ű�� �α��ǰ
	SELECT	*
	INTO	#TBL_PACKAGE_GOODS_POPULAR
	FROM	OLTPLOG_196.OLTPLOG.DBO.TBL_PACKAGE_GOODS_POPULAR



	-- ����ġ ����, �𵨸� ������!
	/*
	-- ���̺� ����
	CREATE TABLE PRICELIST_PACKAGE_GOODS_SNAPSHOT
	(
		SNAPSHOT_DATE SMALLDATETIME
	,	PL_MODELNO INT
	,	PL_NO INT
	,	PL_PRICE MONEY
	,	PL_GOODSNM NVARCHAR(200)
	)
	*/

	-- ���� ������ ����
	DELETE FROM PRICELIST_PACKAGE_GOODS_SNAPSHOT WHERE SNAPSHOT_DATE < CONVERT(VARCHAR(10), GETDATE()-1, 120)

	-- ���� ������ ����
	INSERT INTO PRICELIST_PACKAGE_GOODS_SNAPSHOT
	(SNAPSHOT_DATE, PL_MODELNO, PL_NO, PL_PRICE, PL_GOODSNM)
	SELECT	CONVERT(VARCHAR(10),GETDATE(), 120)
	,		B.PL_MODELNO
	,		A.PL_NO
	,		PL_PRICE
	,		PL_GOODSNM
	FROM	#TBL_PACKAGE_GOODS_POPULAR A
				INNER JOIN
			PRICELIST B
				ON A.PL_NO = B.PL_NO
	ORDER BY A.PL_NO


	-- ���̳ʽ� ��ŷ �Է�
	INSERT INTO OLTPLOG_196.OLTPLOG.DBO.TBL_PACKAGE_GOODS_POPULAR_PENALTY
	SELECT C.PL_NO, CONVERT(VARCHAR(10), (D.NUM+GETDATE()), 120) AS APP_DATE, C.MINUS_RANK
	FROM
		(
		SELECT
			A.PL_NO
		,	CASE WHEN A.PL_PRICE <> B.PL_PRICE THEN 1 ELSE 0 END
			+ CASE WHEN A.PL_GOODSNM <> B.PL_GOODSNM THEN 1 ELSE 0 END AS MINUS_RANK
		FROM
			PRICELIST_PACKAGE_GOODS_SNAPSHOT A
				INNER JOIN
			PRICELIST_PACKAGE_GOODS_SNAPSHOT B
				ON A.PL_NO =  B.PL_NO
		WHERE (A.PL_PRICE < B.PL_PRICE OR A.PL_GOODSNM <> B.PL_GOODSNM)
		AND		A.SNAPSHOT_DATE = CONVERT(VARCHAR(10), GETDATE()-1, 120)
		AND		B.SNAPSHOT_DATE = CONVERT(VARCHAR(10), GETDATE(), 120)
		) C
		CROSS JOIN
		( SELECT 0 AS NUM UNION ALL SELECT 1 UNION ALL SELECT 2 ) D


