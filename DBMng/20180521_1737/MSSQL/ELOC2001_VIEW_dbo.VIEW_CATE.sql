/* *************************************************************************
 * NAME : dbo.VIEW_CATE
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2005-08-31 13:37:08.623
 *        Modify: 2018-05-02 15:22:22.853
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE VIEW VIEW_CATE 
AS
	SELECT
	CL_LCODE + ISNULL(CM_MCODE,'00') + ISNULL(CS_SCODE,'00') + ISNULL(CD_DCODE,'00') AS CATEGORY
	, replace(CL_NAME, '&nbsp;', '') cl_name
	, replace(CM_NAME, '&nbsp;', '') cm_name
	, replace(CS_NAME, '&nbsp;', '') cs_name
	, replace(CD_NAME, '&nbsp;', '') cd_name,
	ISNULL(CD_FLAG, CS_FLAG) AS FLAG
	FROM C_LCATE WITH (READUNCOMMITTED)
	LEFT JOIN C_MCATE WITH (READUNCOMMITTED) ON C_LCATE.CL_LCODE = C_MCATE.CM_LCODE
	LEFT JOIN C_SCATE WITH (READUNCOMMITTED)
	ON C_LCATE.CL_LCODE = C_SCATE.CS_LCODE AND C_MCATE.CM_MCODE = C_SCATE.CS_MCODE
	LEFT JOIN C_DCATE WITH (READUNCOMMITTED)
	ON C_LCATE.CL_LCODE = C_DCATE.CD_LCODE AND C_MCATE.CM_MCODE = C_DCATE.CD_MCODE AND C_SCATE.CS_SCODE = C_DCATE.CD_SCODE
	WHERE CL_LCODE < '98' AND CL_SEQNO > 0

