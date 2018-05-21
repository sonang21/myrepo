/* *************************************************************************
 * NAME : dbo.UDP_MP_MCATE_ATTRIBUTE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-05 20:34:11.31
 *        Modify: 2018-05-03 17:23:35.707
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [DBO].[UDP_MP_MCATE_ATTRIBUTE]
	@CATEGORY VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT [�з��ڵ�]		=	ISNULL(CATEGORY, '')
		 , [�Ӽ�ID]		=	ISNULL(A.ATTRIBUTE_ID, '')
		 , [�����Ӽ���]	=	ISNULL(MANAGE_ATTRIBUTE_NM, '')
		 , [���üӼ���]	=	ISNULL(GALLERY_ATTRIBUTE_NM, '')
		 , [�Ӽ�����]		=	ISNULL(IS_GALLERY_DISPLAY, '')
		 , [����]		=	ISNULL(USE_CLASS_CODE, '')
		 , [��ǥID]		=	ISNULL(GROUP_ATTRIBUTE_ID, '')
		 , [��ǥ��ȣ]		=	ISNULL(GROUP_CHAR, '')
		 , [�Ӽ�����ȣ]	=	ISNULL(ELEMENT_CHAR, '')
		 , [�Ӽ�B]		=	ISNULL(A.IS_BOLD, '')
		 , [�Ӽ���ID]		=	ISNULL(ATTRIBUTE_ELEMENT_ID, '')
		 , [�Ӽ�������]	=	ISNULL(DISPLAY_ORDER, '')
		 , [�Ӽ�����]		=	ISNULL(ATTRIBUTE_ELEMENT, '')
		 , [�Ӽ���B]		=	ISNULL(B.IS_BOLD, '')
		 , [���]		=	ISNULL(SPECNO, '')
	FROM GOODS_ATTRIBUTE A
		INNER JOIN GOODS_ATTRIBUTE_ELEMENT B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
	WHERE A.DEL_YN = 'N' AND B.DEL_YN = 'N' AND CATEGORY = LEFT(@CATEGORY, 4)
	ORDER BY [�з��ڵ�], [�Ӽ�ID], [�Ӽ���ID]
END
