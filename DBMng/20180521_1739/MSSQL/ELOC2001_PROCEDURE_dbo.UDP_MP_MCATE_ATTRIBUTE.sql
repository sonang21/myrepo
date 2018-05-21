/* *************************************************************************
 * NAME : dbo.UDP_MP_MCATE_ATTRIBUTE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-04-05 20:34:11.31
 *        Modify: 2018-05-03 17:23:35.707
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE PROC [DBO].[UDP_MP_MCATE_ATTRIBUTE]
	@CATEGORY VARCHAR(12)
AS
BEGIN
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	
	SELECT [盒幅内靛]		=	ISNULL(CATEGORY, '')
		 , [加己ID]		=	ISNULL(A.ATTRIBUTE_ID, '')
		 , [包府加己疙]	=	ISNULL(MANAGE_ATTRIBUTE_NM, '')
		 , [傈矫加己疙]	=	ISNULL(GALLERY_ATTRIBUTE_NM, '')
		 , [加己畴免]		=	ISNULL(IS_GALLERY_DISPLAY, '')
		 , [备盒]		=	ISNULL(USE_CLASS_CODE, '')
		 , [措钎ID]		=	ISNULL(GROUP_ATTRIBUTE_ID, '')
		 , [措钎扁龋]		=	ISNULL(GROUP_CHAR, '')
		 , [加己盔扁龋]	=	ISNULL(ELEMENT_CHAR, '')
		 , [加己B]		=	ISNULL(A.IS_BOLD, '')
		 , [加己盔ID]		=	ISNULL(ATTRIBUTE_ELEMENT_ID, '')
		 , [加己盔鉴辑]	=	ISNULL(DISPLAY_ORDER, '')
		 , [加己盔疙]		=	ISNULL(ATTRIBUTE_ELEMENT, '')
		 , [加己盔B]		=	ISNULL(B.IS_BOLD, '')
		 , [荤剧]		=	ISNULL(SPECNO, '')
	FROM GOODS_ATTRIBUTE A
		INNER JOIN GOODS_ATTRIBUTE_ELEMENT B ON A.ATTRIBUTE_ID = B.ATTRIBUTE_ID
	WHERE A.DEL_YN = 'N' AND B.DEL_YN = 'N' AND CATEGORY = LEFT(@CATEGORY, 4)
	ORDER BY [盒幅内靛], [加己ID], [加己盔ID]
END
