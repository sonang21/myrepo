/* *************************************************************************
 * NAME : dbo.UDF_SEARCHLIST4
 * TYPE : FUNCTION (SQL_INLINE_TABLE_VALUED_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:58.09
 *        Modify: 2015-05-15 03:31:34.067
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** ��ü:  ����� ���� �Լ� dbo.SearchList4    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:17:28 ******/
--OR Ű���� 4���� ���
CREATE  FUNCTION UDF_SEARCHLIST4(@strKey varchar(50)
	,@strKeyOr1 varchar(50)
	,@strKeyOr2 varchar(50)
	,@strKeyOr3 varchar(50)
	,@strKeyOr4 varchar(50)
)
RETURNS TABLE AS 
RETURN(
	SELECT ktg_modelno FROM SEARCHKEY..KEYTABLE_GOODS  WITH (ReadUncommitted)
		WHERE ktg_searchkey like @strKey + '%'
			or ktg_searchkey like @strKeyOr1 + '%'
			or ktg_searchkey like @strKeyOr2 + '%'
			or ktg_searchkey like @strKeyOr3 + '%'
			or ktg_searchkey like @strKeyOr4 + '%'
)



