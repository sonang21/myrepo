/* *************************************************************************
 * NAME : dbo.UDF_RTN_MCATE_NAME
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.34
 *        Modify: 2018-05-03 17:23:35.803
 *        Backup: 20180521_1739
 ************************************************************************* */





/****** 개체:  사용자 정의 함수 dbo.ufRtnMCateName    스크립트 날짜: 2004-10-21 오후 3:18:15 ******/
CREATE   FUNCTION UDF_RTN_MCATE_NAME (@cate char(4))
RETURNS varchar(30)
AS
BEGIN
	DECLARE  @return varchar(30)
		SELECT
			@return = max(cm_name)
		FROM C_LCATE WITH (ReadUncommitted) 
		INNER JOIN C_MCATE WITH (ReadUncommitted) 
		ON cl_lcode = cm_lcode
		WHERE
			cl_lcode = left(@cate, 2)
			and cm_mcode = right(@cate, 2)
	RETURN @return 
END




