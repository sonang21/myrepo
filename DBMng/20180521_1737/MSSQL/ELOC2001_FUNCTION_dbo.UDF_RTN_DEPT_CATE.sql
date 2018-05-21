/* *************************************************************************
 * NAME : dbo.UDF_RTN_DEPT_CATE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2014-12-17 13:19:21.363
 *        Modify: 2018-05-03 17:23:35.053
 *        Backup: 20180521_1737
 ************************************************************************* */








-- 백화점 상품 분류
CREATE FUNCTION [dbo].[UDF_RTN_DEPT_CATE] (@vcode int, @modelno int, @p_goodsnm nvarchar(200), @n_goodsnm nvarchar(200), @storeflag char(1), @deptcate varchar(12))

RETURNS varchar(12)

AS
BEGIN

	DECLARE  @return varchar(12)

	set @return = @deptcate	
	
	If (@vcode = 47 or @vcode = 49 or @vcode = 57 or @vcode = 75 or @vcode = 90 or @vcode = 663 or @vcode = 806 or @vcode = 974 or @vcode = 1878 or @vcode = 6361 or @vcode = 6547 or @vcode = 6588 or @vcode = 6620 or @vcode = 5910 or @vcode = 536 or @vcode = 4027 or @vcode = 7851)
		Begin
			If (@storeflag = '1' and @modelno = 0 and @p_goodsnm <> @n_goodsnm)
				Begin
					If (@deptcate = '860401')
						Begin
							If (charindex('가방',@n_goodsnm) > 0)
								Begin
									set @return = '860203'	
								End
							Else If (charindex('블라우스',@n_goodsnm) > 0)
								Begin
									set @return = '860402'	
								End
							Else If (charindex('가디건',@n_goodsnm) > 0)
								Begin
									set @return = '860404'	
								End
							Else If (charindex('원피스',@n_goodsnm) > 0)
								Begin
									set @return = '860405'	
								End
							Else If (charindex('팬츠',@n_goodsnm) > 0 or charindex('바지',@n_goodsnm) > 0)
								Begin
									set @return = '860406'	
								End
							Else If (charindex('스커트',@n_goodsnm) > 0)
								Begin
									set @return = '860407'	
								End
							Else If (charindex('점퍼',@n_goodsnm) > 0)
								Begin
									set @return = '860408'	
								End
							Else If (charindex('자켓',@n_goodsnm) > 0)
								Begin
									set @return = '860409'	
								End
							Else If (charindex('코트',@n_goodsnm) > 0)
								Begin
									set @return = '860410'	
								End
							Else If (charindex('스카프',@n_goodsnm) > 0 or charindex('목도리',@n_goodsnm) > 0 or charindex('머플러',@n_goodsnm) > 0)
								Begin
									set @return = '86021502'	
								End
							Else If (charindex('모자',@n_goodsnm) > 0 or charindex('비니',@n_goodsnm) > 0)
								Begin
									set @return = '86021503'	
								End
							Else If (charindex('레깅스',@n_goodsnm) > 0 or charindex('양말',@n_goodsnm) > 0)
								Begin
									set @return = '86021505'	
								End
							Else If (charindex('장갑',@n_goodsnm) > 0)
								Begin
									set @return = '86021506'	
								End
							Else If (charindex('베스트',@n_goodsnm) > 0 or charindex('조끼',@n_goodsnm) > 0)
								Begin
									set @return = '86040402'	
								End
							Else If (charindex('패딩',@n_goodsnm) > 0)
								Begin
									set @return = '86040802'	
								End
							Else If (charindex('무스탕',@n_goodsnm) > 0)
								Begin
									set @return = '86041001'	
								End
							Else If (charindex('헤어밴드',@n_goodsnm) > 0)
								Begin
									set @return = '86140701'	
								End
						End
					Else If (@deptcate = '860601')
						Begin
							If (charindex('가방',@n_goodsnm) > 0)
								Begin
									set @return = '860203'	
								End
							Else If (charindex('블라우스',@n_goodsnm) > 0)
								Begin
									set @return = '860602'	
								End
							Else If (charindex('스웨터',@n_goodsnm) > 0)
								Begin
									set @return = '860603'	
								End
							Else If (charindex('팬츠',@n_goodsnm) > 0 or charindex('바지',@n_goodsnm) > 0)
								Begin
									set @return = '860606'	
								End
							Else If (charindex('점퍼',@n_goodsnm) > 0)
								Begin
									set @return = '860609'	
								End
							Else If (charindex('자켓',@n_goodsnm) > 0)
								Begin
									set @return = '860610'	
								End
							Else If (charindex('무스탕',@n_goodsnm) > 0 or charindex('코트',@n_goodsnm) > 0)
								Begin
									set @return = '860611'	
								End
							Else If (charindex('스카프',@n_goodsnm) > 0 or charindex('목도리',@n_goodsnm) > 0 or charindex('머플러',@n_goodsnm) > 0)
								Begin
									set @return = '86021502'	
								End
							Else If (charindex('비니',@n_goodsnm) > 0 or charindex('모자',@n_goodsnm) > 0 or charindex('스냅백',@n_goodsnm) > 0)
								Begin
									set @return = '86021503'	
								End
							Else If (charindex('양말',@n_goodsnm) > 0 or charindex('레깅스',@n_goodsnm) > 0)
								Begin
									set @return = '86021505'	
								End
							Else If (charindex('장갑',@n_goodsnm) > 0)
								Begin
									set @return = '86021506'	
								End
							Else If (charindex('가디건',@n_goodsnm) > 0)
								Begin
									set @return = '86060401'	
								End
							Else If (charindex('베스트',@n_goodsnm) > 0 or charindex('조끼',@n_goodsnm) > 0)
								Begin
									set @return = '86060405'	
								End
							Else If (charindex('원피스',@n_goodsnm) > 0)
								Begin
									set @return = '86060501'	
								End
							Else If (charindex('스키니',@n_goodsnm) > 0)
								Begin
									set @return = '86060602'	
								End
							Else If (charindex('스커트',@n_goodsnm) > 0)
								Begin
									set @return = '86060801'	
								End
							Else If (charindex('패딩',@n_goodsnm) > 0)
								Begin
									set @return = '86060905'	
								End
						End
					Else If (@deptcate = '860701' or @deptcate = '86070101')
						Begin
							If (charindex('트렁크',@n_goodsnm) > 0 or charindex('드로즈',@n_goodsnm) > 0)
								Begin
									set @return = '86070201'	
								End
							Else If (charindex('커플속옷',@n_goodsnm) > 0)
								Begin
									set @return = '86070301'	
								End
						End
					Else If (@deptcate = '860901')
						Begin
							If (charindex('니트',@n_goodsnm) > 0 or charindex('스웨터',@n_goodsnm) > 0)
								Begin
									set @return = '860903'	
								End
							Else If (charindex('점퍼',@n_goodsnm) > 0)
								Begin
									set @return = '860905'	
								End
							Else If (charindex('바지',@n_goodsnm) > 0 or charindex('팬츠',@n_goodsnm) > 0)
								Begin
									set @return = '860908'	
								End
							Else If (charindex('벨트',@n_goodsnm) > 0)
								Begin
									set @return = '86020604'	
								End
							Else If (charindex('머플러',@n_goodsnm) > 0)
								Begin
									set @return = '86021502'	
								End
							Else If (charindex('양말',@n_goodsnm) > 0)
								Begin
									set @return = '86021505'	
								End
							Else If (charindex('넥타이',@n_goodsnm) > 0)
								Begin
									set @return = '86021508'	
								End
							Else If (charindex('남방',@n_goodsnm) > 0)
								Begin
									set @return = '86090202'	
								End
							Else If (charindex('패딩',@n_goodsnm) > 0)
								Begin
									set @return = '86090503'	
								End
							Else If (charindex('자켓',@n_goodsnm) > 0)
								Begin
									set @return = '86090601'	
								End
							Else If (charindex('코트',@n_goodsnm) > 0)
								Begin
									set @return = '86090701'	
								End
						End
					Else If (@deptcate = '860902')
						Begin
							If (charindex('벨트',@n_goodsnm) > 0)
								Begin
									set @return = '86020604'	
								End
							Else If (charindex('손수건',@n_goodsnm) > 0)
								Begin
									set @return = '86021504'	
								End
							Else If (charindex('양말',@n_goodsnm) > 0)
								Begin
									set @return = '86021505'	
								End
							Else If (charindex('넥타이',@n_goodsnm) > 0)
								Begin
									set @return = '86021508'	
								End
						End
					Else If (@deptcate = '8602')
						Begin
							If (charindex('갤럭시노트',@n_goodsnm) > 0 or charindex('갤럭시 노트',@n_goodsnm) > 0 or charindex('스마트폰 케이스',@n_goodsnm) > 0 or charindex('갤럭시S',@n_goodsnm) > 0 or charindex('GALAXY NOTE',@n_goodsnm) > 0 or charindex('GALAXY S',@n_goodsnm) > 0 or charindex('갤럭시노트',@n_goodsnm) > 0 or charindex('갤럭시노트',@n_goodsnm) > 0) 
								Begin
									set @return = '86120107'	
								End
						End
				End
		End
	
	RETURN @return 

END







































