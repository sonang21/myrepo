/* *************************************************************************
 * NAME : dbo.UDP_JCA_GET_EMPLOYEE_CATENAME
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-09-18 17:47:46.56
 *        Modify: 2018-05-03 17:23:34.84
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC UDP_JCA_GET_EMPLOYEE_CATENAME
	@CATEGORY VARCHAR(8)
AS
	-- ----------------------------------------------------------------------------------
	-- 작성자 : wookki25 / 2008.09.18
	-- 설  명 : 사원정보 담당 카테고리명
	-- ----------------------------------------------------------------------------------
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL  READ UNCOMMITTED
	SELECT 
		TOP 1 
		CASE LEN(@CATEGORY) 
			WHEN 2 THEN
				ISNULL(CL_NAME,'')
			WHEN 4 THEN
				ISNULL(CL_NAME,'') +'>'+ISNULL(CM_NAME,'')
			WHEN 6 THEN
				ISNULL(CL_NAME,'') +'>'+ISNULL(CM_NAME,'')+'>'+ISNULL(CS_NAME,'')
			WHEN 8 THEN
				ISNULL(CL_NAME,'') +'>'+ISNULL(CM_NAME,'')+'>'+ISNULL(CS_NAME,'')+'>'+ISNULL(CD_NAME,'') 
		END AS CATE_NAME
	FROM VIEW_CATE2 WHERE CATEGORY LIKE @CATEGORY+'%' 