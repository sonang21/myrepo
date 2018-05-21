/* *************************************************************************
 * NAME : dbo.UDF_SEARCHLIST2
 * TYPE : FUNCTION (SQL_INLINE_TABLE_VALUED_FUNCTION)
 * TIME : Create: 2004-11-02 03:31:57.81
 *        Modify: 2015-05-15 03:31:34.04
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체:  사용자 정의 함수 dbo.SearchList2    스크립트 날짜: 2004-10-21 오후 3:16:42 ******/
--OR 키워드 2개인 경우
CREATE  FUNCTION UDF_SEARCHLIST2  (@strKey varchar(50)
	,@strKeyOr1 varchar(50)
	,@strKeyOr2 varchar(50)
)
RETURNS TABLE AS 
RETURN(
	SELECT ktg_modelno FROM SEARCHKEY..KEYTABLE_GOODS  WITH (ReadUncommitted)
		WHERE ktg_searchkey like @strKey + '%'
			or ktg_searchkey like @strKeyOr1 + '%'
			or ktg_searchkey like @strKeyOr2 + '%'
)



