/* *************************************************************************
 * NAME : dbo.UDF_RTN_CATE_NAME
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.187
 *        Modify: 2018-05-03 17:23:35.777
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체:  사용자 정의 함수 dbo.ufRtnCateName    스크립트 날짜: 2004-10-23 오전 11:10:39 ******/
/****** bslee 개체:  사용자 정의 함수 dbo.ufRtnCateName    스크립트 날짜: 2004-05-17 오전 09:02:02 ******/
CREATE     FUNCTION UDF_RTN_CATE_NAME (@cate varchar(8), @kind varchar(5))
RETURNS varchar(50)
AS
BEGIN

	DECLARE  @return varchar(50)

	DECLARE @lcode char(2)
	DECLARE @mcode char(2)
	DECLARE @scode char(2)
	DECLARE @dcode char(2)

	SET @lcode = SUBSTRING(@cate, 1, 2)
	SET @mcode = SUBSTRING(@cate, 3, 2)
	SET @scode = SUBSTRING(@cate, 5, 2)
	SET @dcode = SUBSTRING(@cate, 7, 2)

	IF (@kind = 'lcate')
		SELECT @return = cl_name FROM C_LCATE WITH (ReadUncommitted) WHERE cl_lcode = @lcode
	ELSE IF (@kind = 'mcate')
		SELECT @return = cm_name FROM C_MCATE WITH (ReadUncommitted) WHERE cm_lcode = @lcode and cm_mcode = @mcode
	ELSE IF (@kind = 'scate')
		SELECT @return = cs_name FROM C_SCATE WITH (ReadUncommitted) WHERE cs_lcode = @lcode and cs_mcode = @mcode and cs_scode = @scode
	ELSE IF (@kind = 'dcate')
		SELECT @return = cd_name FROM C_DCATE WITH (ReadUncommitted) WHERE cd_lcode = @lcode and cd_mcode = @mcode and cd_scode = @scode and cd_dcode = @dcode

	IF (@return is NULL)
		SET @return = ''
	ELSE IF (@return = '★관리용')
		SET @return = ''

	RETURN @return 

	/* 사용예

	SELECT 
		ELOC2001.dbo.UDF_RTN_CATE_NAME('02010500','lcate')
		,ELOC2001.dbo.UDF_RTN_CATE_NAME('02010500','mcate')
		,ELOC2001.dbo.UDF_RTN_CATE_NAME('02010500','scate')
		,ELOC2001.dbo.UDF_RTN_CATE_NAME('02010500','dcate')
	*/
END



