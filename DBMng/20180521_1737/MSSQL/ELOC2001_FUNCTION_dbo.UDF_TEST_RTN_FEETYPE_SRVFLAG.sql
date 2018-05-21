/* *************************************************************************
 * NAME : dbo.UDF_TEST_RTN_FEETYPE_SRVFLAG
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2008-06-18 10:56:18.11
 *        Modify: 2018-05-03 17:23:34.44
 *        Backup: 20180521_1737
 ************************************************************************* */



-- 에어컨 설치비 관련
CREATE FUNCTION [dbo].[UDF_TEST_RTN_FEETYPE_SRVFLAG] (@vcode int, @modelno int, @cate varchar(8), @p_goodsnm nvarchar(200), @n_goodsnm nvarchar(200), @srvflag char(1))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)

	set @return = @srvflag
	
	-- 모델명 변경 유무
	If (@n_goodsnm <> @p_goodsnm and @modelno > 0)
		Begin 
			--예외지정업체  (47,49,57,75,90,241,374,663,806,974,1878)
			If (@vcode <> 47 and @vcode <> 49 and @vcode <> 57 and @vcode <> 75 and @vcode <> 90 and @vcode <> 241 and @vcode <> 374 and @vcode <> 663 and @vcode <> 806 and @vcode <> 974 and @vcode <> 1878)
				Begin
					--설치비 체크
					If (left(@cate ,4) = '0501' and left(@cate ,6) <> '050101' and left(@cate ,6) <> '050110')
						Begin			
							If (charindex('설치비무료',@n_goodsnm) > 0 or charindex('설치비 무료',@n_goodsnm) > 0 or charindex('설치비포함',@n_goodsnm) > 0 or charindex('설치비 포함',@n_goodsnm) > 0 or charindex('설치무료',@n_goodsnm) > 0 or charindex('무료설치',@n_goodsnm) > 0 or charindex('설치포함',@n_goodsnm) > 0)
								Begin
									set @return = '0'	
								End
							else If (charindex('설치비모두무료',@n_goodsnm) > 0 or charindex('설치비모두 무료',@n_goodsnm) > 0 or charindex('설치비 모두무료',@n_goodsnm) > 0 or charindex('설치비 모두 무료',@n_goodsnm) > 0 )
								Begin
									set @return = '0'	
								End
							else If (charindex('설치비모두포함',@n_goodsnm) > 0 or charindex('설치비모두 포함',@n_goodsnm) > 0 or charindex('설치비 모두포함',@n_goodsnm) > 0 or charindex('설치비 모두 포함',@n_goodsnm) > 0 )
								Begin
									set @return = '0'	
								End
							else If (charindex('설치모두무료',@n_goodsnm) > 0 or charindex('설치모두 무료',@n_goodsnm) > 0 or charindex('설치 모두무료',@n_goodsnm) > 0 or charindex('설치 모두 무료',@n_goodsnm) > 0 )
								Begin
									set @return = '0'	
								End
							else If (charindex('설치모두포함',@n_goodsnm) > 0 or charindex('설치모두 포함',@n_goodsnm) > 0 or charindex('설치 모두포함',@n_goodsnm) > 0 or charindex('설치 모두 포함',@n_goodsnm) > 0 )
								Begin
									set @return = '0'	
								End
							else
								Begin
									set @return = 'A'
								End
						End
				End
		End
	
	

	RETURN @return 

END



















