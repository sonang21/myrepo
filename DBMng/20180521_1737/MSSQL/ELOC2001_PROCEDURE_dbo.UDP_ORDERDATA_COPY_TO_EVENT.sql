/* *************************************************************************
 * NAME : dbo.UDP_ORDERDATA_COPY_TO_EVENT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-12-14 14:27:00.21
 *        Modify: 2018-05-03 17:23:36.147
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [DBO].[UDP_ORDERDATA_COPY_TO_EVENT]
	@FLAG	VARCHAR(5)
AS
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : WOOKKI25 / 2009.12.14
	-- ��  �� : �̺�Ʈ ������ �Է�
	-- ��  �� : UDP_MAKE_SHOP_ORDERDATA
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	--return -- 2010.04.07 �̺�Ʈ ����� ���� ���Ѵ�.

	-- ��ü����
	DECLARE @SHOP_VCODE INT
	SELECT TOP 1 @SHOP_VCODE = SHOP_VCODE FROM TBL_ORDERDATA_WORKER

	IF @FLAG = 'ORD' AND @SHOP_VCODE IN (55, 4027, 5910, 536)--����, ����, 11����, ������
	BEGIN
		-- ��۱��� �ֹ� ������ �ִ� ��ü�� ü�ᵥ���� ������� �ʴ´�.
		RETURN
	END

	-- ���� �����Ϳ� �ߺ� ������ ����
	DELETE	KNOWBOXDB2.DBO.TBL_EVENT_USERORDER_DATA
	FROM	KNOWBOXDB2.DBO.TBL_EVENT_USERORDER_DATA A INNER JOIN TBL_ORDERDATA_WORKER B
			ON A.OD_ID = B.OD_ID AND A.OD_GOODSCODE = B.OD_GOODSCODE
	WHERE	A.SHOP_VCODE = @SHOP_VCODE

	-- ������ ����
	INSERT INTO KNOWBOXDB2.DBO.TBL_EVENT_USERORDER_DATA
	(SHOP_VCODE,OD_DATE,OD_ID,OD_ID_NO,OD_GOODSCODE,OD_GOODSNM,OD_PRICE,OD_CNT,PL_NO,G_MODELNO,G_CATEGORY,OD_JUMIN,KEYWORD_AD_INFO,OD_REGDATE,OD_COMMENT,OD_UNIT_PRICE)
	SELECT SHOP_VCODE,OD_DATE,OD_ID,OD_ID_NO,OD_GOODSCODE,OD_GOODSNM,OD_PRICE,OD_CNT,PL_NO,G_MODELNO,G_CATEGORY,OD_JUMIN,KEYWORD_AD_INFO,OD_REGDATE,OD_COMMENT,OD_UNIT_PRICE
	FROM TBL_ORDERDATA_WORKER

