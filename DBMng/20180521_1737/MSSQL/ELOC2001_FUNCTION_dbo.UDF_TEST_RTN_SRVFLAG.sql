/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_SRVFLAG
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2008-04-03 16:45:12.65
 *        Modify: 2018-05-03 17:23:36.05
 *        Backup: 20180521_1737
 ************************************************************************* */








-- 성인 키워드 관련

CREATE     FUNCTION [dbo].[UDF_TEST_RTN_SRVFLAG] (@n_goodsnm nvarchar(200))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)
	
	-- 성인용품 체크
	If (charindex('성인용품',@n_goodsnm) > 0 or charindex('자위',@n_goodsnm) > 0 or charindex('콘돔',@n_goodsnm) > 0 or charindex('성인사이트',@n_goodsnm) > 0 or charindex('오르가즘',@n_goodsnm) > 0 or charindex('클리토리스',@n_goodsnm) > 0 or charindex('애무',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('여자성기',@n_goodsnm) > 0 or charindex('흥분제',@n_goodsnm) > 0 or charindex('딜도',@n_goodsnm) > 0 or charindex('애널',@n_goodsnm) > 0 or charindex('러브젤',@n_goodsnm) > 0 or charindex('펠라치오',@n_goodsnm) > 0 or charindex('칙칙이',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('마스터베이션',@n_goodsnm) > 0 or charindex('낙타눈썹',@n_goodsnm) > 0 or charindex('커닐링구스',@n_goodsnm) > 0 or charindex('성기구',@n_goodsnm) > 0 or charindex('성생활',@n_goodsnm) > 0 or charindex('아스트로글라이드',@n_goodsnm) > 0 or charindex('SM용품',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('사정지연',@n_goodsnm) > 0 or charindex('펠라티오',@n_goodsnm) > 0 or charindex('러브링',@n_goodsnm) > 0 or charindex('롱타임젤',@n_goodsnm) > 0 or charindex('성보조기구',@n_goodsnm) > 0 or charindex('성인상품',@n_goodsnm) > 0 or charindex('성인용인형',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else If (charindex('성인젤',@n_goodsnm) > 0 or charindex('옥링',@n_goodsnm) > 0 or charindex('흥분젤',@n_goodsnm) > 0 or charindex('페페젤',@n_goodsnm) > 0 or charindex('에그진동기',@n_goodsnm) > 0  or charindex('자무스틱',@n_goodsnm) > 0)
		Begin
			set @return = 'S'	
		End
	else if (charindex('SA급',@n_goodsnm) > 0)
		Begin
			set @return = '9'	
		End
	else if (charindex('나트라케어',@n_goodsnm) > 0 and (charindex('기저귀',@n_goodsnm) > 0 or charindex('유아',@n_goodsnm) > 0 or charindex('드라이핏',@n_goodsnm) > 0))
		Begin
			set @return = '9'	
		End
	else
		Begin
			set @return = '0'
		End

	RETURN @return 

END
























