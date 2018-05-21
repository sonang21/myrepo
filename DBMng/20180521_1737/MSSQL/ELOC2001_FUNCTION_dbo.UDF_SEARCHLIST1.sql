/* *************************************************************************
 * NAME : dbo.UDF_SEARCHLIST1
 * TYPE : FUNCTION (SQL_INLINE_TABLE_VALUED_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.73
 *        Modify: 2015-05-15 03:31:34.037
 *        Backup: 20180521_1737
 ************************************************************************* */




/****** ��ü:  ����� ���� �Լ� dbo.SearchList1    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:16:21 ******/
--OR Ű���� 2���� ���
CREATE  FUNCTION UDF_SEARCHLIST1 (@strKey varchar(50)
	,@strKeyOr1 varchar(50)
)
RETURNS TABLE AS 
RETURN(
	SELECT ktg_modelno FROM SEARCHKEY..KEYTABLE_GOODS  WITH (ReadUncommitted)
		WHERE ktg_searchkey like @strKey + '%'
			or ktg_searchkey like @strKeyOr1 + '%'
)



