/* *************************************************************************
 * NAME : dbo.UDF_RTN_MAX_DATE_DETAIL
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.263
 *        Modify: 2018-05-03 17:23:35.787
 *        Backup: 20180521_1737
 ************************************************************************* */





/****** ��ü:  ����� ���� �Լ� dbo.ufRtnMaxDateDetail    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:17:49 ******/
CREATE   FUNCTION UDF_RTN_MAX_DATE_DETAIL  (@modelno int )
RETURNS varchar(30)
AS
BEGIN
	DECLARE  @return varchar(30)
		SELECT @return =  max(jg_date) FROM LOGDB..JOB_GOODS WITH (ReadUncommitted)  WHERE jg_modelno = @modelno and jg_flag = '1'
	RETURN @return 
END




