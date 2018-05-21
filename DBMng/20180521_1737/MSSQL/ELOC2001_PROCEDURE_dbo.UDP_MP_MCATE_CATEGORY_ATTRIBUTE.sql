/* *************************************************************************
 * NAME : dbo.UDP_MP_MCATE_CATEGORY_ATTRIBUTE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-05 20:22:38.41
 *        Modify: 2018-05-03 17:23:34.947
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC [DBO].[UDP_MP_MCATE_CATEGORY_ATTRIBUTE]
	@CATEGORY VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT [�з��ڵ�]		=	ISNULL(C.CATEGORY, '')
		 , [�Ӽ�����]		=	ISNULL(C.DISPLAY_ORDER, '')
		 , [��ǥ�Ӽ�����]	=   ISNULL(C.TAG_ORDER, '')
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
		 , [�Ӽ�������]	=	ISNULL(B.DISPLAY_ORDER, '')
		 , [�Ӽ�����]		=	ISNULL(ATTRIBUTE_ELEMENT, '')
		 , [�Ӽ���B]		=	ISNULL(B.IS_BOLD, '')
		 , [���]		=	ISNULL(SPECNO, '')
	FROM GOODS_ATTRIBUTE A
		INNER JOIN GOODS_ATTRIBUTE_ELEMENT B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
		INNER JOIN GOODS_CATEGORY_ATTRIBUTE C ON A.ATTRIBUTE_ID = C.ATTRIBUTE_ID
	WHERE A.DEL_YN = 'N' AND B.DEL_YN = 'N' AND C.CATEGORY LIKE @CATEGORY + '%'
	ORDER BY [�з��ڵ�], [�Ӽ�����], [�Ӽ�ID], [�Ӽ�������], [�Ӽ���ID]
END
