/* *************************************************************************
 * NAME : dbo.UDP_CATENAME
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-02-09 13:37:45.107
 *        Modify: 2018-05-03 17:23:34.977
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE PROC UDP_CATENAME
	@CATE VARCHAR(8)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @CATENAME VARCHAR(255)

	SELECT L.CL_NAME AS CATENAME
	FROM C_LCATE L
	WHERE L.CL_LCODE=LEFT(@CATE,2) AND 2 = LEN(@CATE)
	UNION ALL
	SELECT L.CL_NAME + ' ' + M.CM_NAME AS CATENAME
	FROM C_MCATE M
	INNER JOIN C_LCATE L
	ON M.CM_LCODE = L.CL_LCODE
	WHERE M.CM_LCODE=LEFT(@CATE,2) AND M.CM_MCODE=SUBSTRING(@CATE,3,2) AND 4 = LEN(@CATE)
	UNION ALL
	SELECT L.CL_NAME + ' ' + M.CM_NAME + ' ' + S.CS_NAME AS CATENAME
	FROM C_SCATE S
	INNER JOIN C_MCATE M
	ON S.CS_MCODE = M.CM_MCODE AND S.CS_LCODE=M.CM_LCODE
	INNER JOIN C_LCATE L
	ON S.CS_LCODE = L.CL_LCODE
	WHERE S.CS_LCODE=LEFT(@CATE,2) AND S.CS_MCODE=SUBSTRING(@CATE,3,2) AND S.CS_SCODE=SUBSTRING(@CATE,5,2) AND 6 = LEN(@CATE)
	UNION ALL
	SELECT L.CL_NAME + ' ' + M.CM_NAME + ' ' + S.CS_NAME + ' ' + D.CD_NAME AS CATENAME
	FROM C_DCATE D
	INNER JOIN C_SCATE S
	ON D.CD_SCODE=S.CS_SCODE AND D.CD_MCODE=S.CS_MCODE AND D.CD_LCODE=S.CS_LCODE
	INNER JOIN C_MCATE M
	ON D.CD_MCODE = M.CM_MCODE AND D.CD_LCODE=M.CM_LCODE
	INNER JOIN C_LCATE L
	ON D.CD_LCODE = L.CL_LCODE
	WHERE D.CD_LCODE=LEFT(@CATE,2) AND D.CD_MCODE=SUBSTRING(@CATE,3,2) AND D.CD_SCODE=SUBSTRING(@CATE,5,2) AND D.CD_DCODE= SUBSTRING(@CATE,7,2) AND 8 = LEN(@CATE)





END
