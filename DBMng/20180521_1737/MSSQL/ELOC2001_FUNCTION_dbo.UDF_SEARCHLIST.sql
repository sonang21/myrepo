/* *************************************************************************
 * NAME : dbo.UDF_SEARCHLIST
 * TYPE : FUNCTION (SQL_INLINE_TABLE_VALUED_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.653
 *        Modify: 2015-05-15 03:31:34.033
 *        Backup: 20180521_1737
 ************************************************************************* */




/****** ��ü:  ����� ���� �Լ� dbo.SearchList    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:15:55 ******/
--OR Ű���� ���°��
CREATE  FUNCTION UDF_SEARCHLIST (@strKey varchar(50))
RETURNS TABLE AS 
RETURN(
	SELECT ktg_modelno FROM SEARCHKEY..KEYTABLE_GOODS  WITH (ReadUncommitted)
		WHERE ktg_searchkey like @strKey + '%'
)



