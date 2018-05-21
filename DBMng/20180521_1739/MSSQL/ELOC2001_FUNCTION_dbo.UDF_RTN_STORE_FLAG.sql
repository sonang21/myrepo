/* *************************************************************************
 * NAME : dbo.UDF_RTN_STORE_FLAG
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2014-08-28 20:39:02.313
 *        Modify: 2018-05-03 17:23:34.96
 *        Backup: 20180521_1739
 ************************************************************************* */







-- 백화점 상품
CREATE FUNCTION [dbo].[UDF_RTN_STORE_FLAG] (@vcode int, @modelno int, @p_goodsnm nvarchar(200), @n_goodsnm nvarchar(200), @storeflag char(1), @n_cate nvarchar(50), @n_url nvarchar(500))

RETURNS char(1)

AS
BEGIN

	DECLARE  @return char(1)

	set @return = '0'	
	
	If (@vcode = 47 or @vcode = 49 or @vcode = 57 or @vcode = 75 or @vcode = 90 or @vcode = 663 or @vcode = 806 or @vcode = 974 or @vcode = 1878 or @vcode = 6361 or @vcode = 6547 or @vcode = 6588 or @vcode = 6620 or @vcode = 5910 or @vcode = 536 or @vcode = 4027 or @vcode = 7851)
		Begin
			If (@storeflag <> '1' and @storeflag <> '2')
				Begin
					set @storeflag = '2'
				End

			If (@vcode = 47 and charindex('department.ssg.com',@n_url) > 0)
				Begin
					set @return = @storeflag	
				End
			Else If (@vcode = 49 and charindex('롯데백화점',@n_goodsnm) > 0)
				Begin
					set @return = @storeflag
				End		
			Else If (@vcode = 57 and charindex('현대백화점',@n_goodsnm) > 0)
				Begin
					set @return = @storeflag	
				End			
			Else If (@vcode = 75 and (charindex('롯데백화점',@n_goodsnm) > 0 or charindex('현대백화점',@n_goodsnm) > 0 or charindex('롯데백화점',@n_cate) > 0 or charindex('현대백화점',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End
			Else If (@vcode = 90 and (charindex('명품화장품',@n_cate) > 0 or charindex('백화점',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End	
			Else If (@vcode = 663 and (charindex('_백화점_',@n_cate) > 0 or charindex('명품화장품',@n_cate) > 0 or charindex('롯데백화점',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End	
			Else If (@vcode = 806 and (charindex('현대백화점',@n_goodsnm) > 0 or charindex('현대백화점',@n_cate) > 0 or charindex('AK백화점',@n_cate) > 0 or charindex('백화점쇼핑',@n_cate) > 0 or charindex('롯데백화점',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End	
			Else If (@vcode = 974 and (charindex('AK백화점',@n_cate) > 0 or charindex('갤러리아',@n_cate) > 0 or charindex('AK PLAZA',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End
			Else If (@vcode = 1878 and (charindex('AK플라자',@n_cate) > 0 or charindex('AK백화점',@n_cate) > 0 or charindex('백화점 명품화장품',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End	
			Else If (@vcode = 6361 and charindex('AKPLAZA',@n_cate) > 0)
				Begin
					set @return = @storeflag
				End	
			Else If (@vcode = 6547)
				Begin
					set @return = @storeflag
				End	
			Else If (@vcode = 6588 and charindex('AK PLAZA',@n_cate) > 0)
				Begin
					set @return = @storeflag	
				End	
			Else If (@vcode = 6620 and (charindex('백화점',@n_cate) > 0))
				Begin
					set @return = @storeflag
				End
			Else If (@vcode = 5910 and charindex('현대백화점',@n_goodsnm) > 0)
				Begin
					set @return = @storeflag
				End
			Else If (@vcode = 536 and (charindex('AK플라자',@n_goodsnm) > 0 or charindex('롯데백화점',@n_goodsnm) > 0))
				Begin
					set @return = @storeflag
				End
			Else If (@vcode = 4027 and (charindex('AK플라자',@n_goodsnm) > 0 or charindex('롯데백화점',@n_goodsnm) > 0))
				Begin
					set @return = @storeflag
				End
			Else If (@vcode = 7851)
				Begin
					set @return = @storeflag
				End					
			Else
				Begin
					set @return = '0'	
				End	
		End
	
	RETURN @return 

END


































