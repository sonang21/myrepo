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
	
	SELECT [분류코드]		=	ISNULL(C.CATEGORY, '')
		 , [속성순서]		=	ISNULL(C.DISPLAY_ORDER, '')
		 , [대표속성순서]	=   ISNULL(C.TAG_ORDER, '')
		 , [속성ID]		=	ISNULL(A.ATTRIBUTE_ID, '')
		 , [관리속성명]	=	ISNULL(MANAGE_ATTRIBUTE_NM, '')
		 , [전시속성명]	=	ISNULL(GALLERY_ATTRIBUTE_NM, '')
		 , [속성노출]		=	ISNULL(IS_GALLERY_DISPLAY, '')
		 , [구분]		=	ISNULL(USE_CLASS_CODE, '')
		 , [대표ID]		=	ISNULL(GROUP_ATTRIBUTE_ID, '')
		 , [대표기호]		=	ISNULL(GROUP_CHAR, '')
		 , [속성원기호]	=	ISNULL(ELEMENT_CHAR, '')
		 , [속성B]		=	ISNULL(A.IS_BOLD, '')
		 , [속성원ID]		=	ISNULL(ATTRIBUTE_ELEMENT_ID, '')
		 , [속성원순서]	=	ISNULL(B.DISPLAY_ORDER, '')
		 , [속성원명]		=	ISNULL(ATTRIBUTE_ELEMENT, '')
		 , [속성원B]		=	ISNULL(B.IS_BOLD, '')
		 , [사양]		=	ISNULL(SPECNO, '')
	FROM GOODS_ATTRIBUTE A
		INNER JOIN GOODS_ATTRIBUTE_ELEMENT B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
		INNER JOIN GOODS_CATEGORY_ATTRIBUTE C ON A.ATTRIBUTE_ID = C.ATTRIBUTE_ID
	WHERE A.DEL_YN = 'N' AND B.DEL_YN = 'N' AND C.CATEGORY LIKE @CATEGORY + '%'
	ORDER BY [분류코드], [속성순서], [속성ID], [속성원순서], [속성원ID]
END
