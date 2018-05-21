/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_INSERT_SD_DEAL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-05-26 15:18:44.017
 *        Modify: 2018-05-03 17:23:34.82
 *        Backup: 20180521_1739
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_INSERT_SD_DEAL]

@strVcode char(4)
 , @BASE_DATE CHAR(8)


AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	--분할처리 변수
	DECLARE @MultiInt int
	DECLARE @MultiCnt int
	DECLARE @MultiStart int 
	DECLARE @MultiEnd int
	DECLARE @AddCnt int
	DECLARE @DutyCode int
	DECLARE @SzQry VARCHAR(3000)

	
	If(@strVcode = '7863')--쿠팡2
		Begin
		
			DECLARE @I TABLE
			(
				IDX INT IDENTITY(1,1) PRIMARY KEY,
				IGOODSCODE VARCHAR(50)
			)
			insert into @I (IGOODSCODE)
			select ENR_SHPML_GOODS_CD 
			from ANALSDW.dbo.G_SHPDRY_EPMTCH_BSC  A with(readuncommitted)
				left outer join eloc2001.dbo.pricelist b with(readuncommitted)
					ON CAST(A.ENR_SHPML_GOODS_CD AS VARCHAR(50)) = b.pl_goodscode
					AND CHECKSUM(CAST(A.ENR_SHPML_GOODS_CD AS VARCHAR(50))) = b.pl_goodscode_cs
					AND B.PL_VCODE = 7863
			where ENR_SHPML_CD = 7863 
				AND b.pl_goodscode IS NULL



			set @AddCnt = @@rowcount
			
			If( not exists (SELECT TOP 1 IDX FROM @I))	Begin	return	end
							
			Set @MultiInt = 1
			Set @MultiCnt = (@AddCnt / 300) + 2 
			set @MultiStart = 0
			set @MultiEnd = 300
			WHILE @MultiInt < @MultiCnt
				BEGIN
					insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_URL, PL_PRICE, PL_SRVFLAG, PL_STATUS, PL_GOODSCODE, PL_AUTHDATE, PL_DATE)
					select 0, 7863, '00', (case when len(SHPML_GOODS_NM_OPTN_VLU) > 200 then left(SHPML_GOODS_NM_OPTN_VLU,200) else SHPML_GOODS_NM_OPTN_VLU end), SHPML_GOODS_URL_VLU, SHPML_GOODS_REP_PRICE, '4', '4', ENR_SHPML_GOODS_CD, getdate(), SHPDRY_BUY_DATE
					from @I Inner join ANALSDW.dbo.G_SHPDRY_EPMTCH_BSC with(readuncommitted) 
					On IGOODSCODE = ENR_SHPML_GOODS_CD and IDX >= @MultiStart and IDX < @MultiEnd
					where ENR_SHPML_CD = 7863
																
					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300
				END

				
			--@@@ 앞 모델명
			DECLARE @C1 TABLE
			(
				IDX INT IDENTITY(1,1) PRIMARY KEY,
				NO bigINT,
				cate varchar(8) 
			)

			insert into @C1(NO, cate)
			select  a.pl_no as no, b.pl_category as pl_cate
			--, a.pl_goodsnm, b.pl_goodsnm, a.pl_category
			from 
			(select pl_no, replace(replace(left(pl_goodsnm, CHARINDEX('@@@',pl_goodsnm)-1),' ',''),'#','') as pl_goodsnm, pl_category 
			from pricelist with(readuncommitted) 
			where pl_vcode = 7863 and pl_status = '4' and (pl_category = '00' or pl_category = '' or pl_category is null) and pl_authdate > CONVERT(NVARCHAR, GETDATE(), 23)) as a
			left outer join 
			(select replace(replace(pl_goodsnm,' ',''),'#','') as pl_goodsnm, pl_category
			from pricelist with(readuncommitted) 
			where pl_vcode = 7861) as b
			on a.pl_goodsnm = b.pl_goodsnm
			where  b.pl_goodsnm is not null and b.pl_category <> ''

			Set @AddCnt = @@rowcount

			Set @MultiInt = 1
			Set @MultiCnt = (@AddCnt / 300) + 2 
			set @MultiStart = 0
			set @MultiEnd = 300
			WHILE @MultiInt < @MultiCnt
				BEGIN
					update pricelist set pl_category = cate
					from pricelist with(readuncommitted) inner join @C1
					on pl_no = NO where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
		
					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300
					print @MultiInt
				END
			
			--@@@뒤 중복제거, 모델명+옵션
			DECLARE @C2 TABLE
			(
				IDX INT IDENTITY(1,1) PRIMARY KEY,
				NO bigINT,
				cate varchar(8) 
			)
			
			insert into @C2(NO, cate)
			select a.pl_no as no, b.pl_category as pl_cate
			--, a.pl_goodsnm, b.pl_goodsnm, a.pl_category
			from 
			(select pl_no, replace(replace(replace(replace(pl_goodsnm, '@@@' + left(pl_goodsnm, +CHARINDEX('@@@',pl_goodsnm)-1),''),' ',''),'#',''),'@@@','') as pl_goodsnm, pl_category
			from pricelist with(readuncommitted) 
			where pl_vcode = 7863 and pl_status = '4' and (pl_category = '00' or pl_category = '' or pl_category is null) and pl_authdate > CONVERT(NVARCHAR, GETDATE(), 23)) as a
			left outer join 
			(select replace(replace(pl_goodsnm, ' ',''),'#','') as pl_goodsnm, pl_category
			from pricelist with(readuncommitted) 
			where pl_vcode = 7861 ) as b
			on a.pl_goodsnm = b.pl_goodsnm
			where  b.pl_goodsnm is not null
			
			Set @AddCnt = @@rowcount

			Set @MultiInt = 1
			Set @MultiCnt = (@AddCnt / 300) + 2 
			set @MultiStart = 0
			set @MultiEnd = 300
			WHILE @MultiInt < @MultiCnt
				BEGIN
					update pricelist set pl_category = cate
					from pricelist with(readuncommitted) inner join @C2
					on pl_no = NO where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
		
					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300
					print @MultiInt
				END	
			
			--키워드 처리
			DECLARE @C3 TABLE
			(
				IDX INT IDENTITY(1,1) PRIMARY KEY,
				NO bigINT,
				cate varchar(8) 
			)
			Set @AddCnt = 0
			Set @DutyCode = 0
					
			While @DutyCode < 10
				Begin
					insert into @C3(NO, cate)
					select pl_no, category
					from (
						select 
						pl_no, pl_goodsnm, t2.keyword, t2.category
						--, t3.keyword, t3.category 
						,(select top 1 'X' from tbl_sd_category_keyword as t3 with(readuncommitted)  where keyword_flag = '2' and t2.category like t3.category + '%' and t1.pl_goodsnm like '%' + t3.keyword + '%') as chk
						,rank () over(partition by pl_goodsnm order by pl_goodsnm, len(t2.keyword) desc) as rank
						from 
						(
							select pl_no, replace(pl_goodsnm,' ','') as pl_goodsnm, pl_category
							from pricelist with(readuncommitted) 
							where pl_vcode = 7863 and pl_status = '4' and (pl_category = '00' or pl_category = '' or pl_category is null) and pl_authdate > CONVERT(NVARCHAR, GETDATE(), 23) and pl_dutycode = @DutyCode
						) as t1
						inner join
						(
							select category, replace(keyword,' ','') as keyword
							from tbl_sd_category_keyword with(readuncommitted)
							where keyword_flag = '1'
						) as t2
						on t1.pl_goodsnm like '%' + t2.keyword + '%'
						where (select top 1 'X' from tbl_sd_category_keyword as t3 with(readuncommitted)  where keyword_flag = '2' and t2.category like t3.category + '%' and t1.pl_goodsnm like '%' + t3.keyword + '%') is null
					) as T4
					where rank = 1

					Set @AddCnt = @AddCnt + @@rowcount
					set @DutyCode = @DutyCode + 1
				End

			Set @MultiInt = 1
			Set @MultiCnt = (@AddCnt / 300) + 2 
			set @MultiStart = 0
			set @MultiEnd = 300
			WHILE @MultiInt < @MultiCnt
				BEGIN
					update pricelist set pl_category = cate
					from pricelist with(readuncommitted) inner join @C3
					on pl_no = NO where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
		
					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300
					print @MultiInt
				END	

			--매월 첫쨰 주월요일 (중지 부하)
			If(DATEPART(dd, getdate()) < 8 and DATEPART(weekday, getdate()) = 12)
				Begin
					DECLARE @C4 TABLE
					(
						IDX INT IDENTITY(1,1) PRIMARY KEY,
						NO bigINT,
						cate varchar(8) 
					)
					Set @AddCnt = 0
					Set @DutyCode = 0
					
					While @DutyCode < 10
						Begin
							insert into @C4(NO, cate)
							select pl_no, category
							from (
								select 
								pl_no, pl_goodsnm, t2.keyword, t2.category
								--, t3.keyword, t3.category 
								,(select top 1 'X' from tbl_sd_category_keyword as t3 with(readuncommitted)  where keyword_flag = '2' and t2.category like t3.category + '%' and t1.pl_goodsnm like '%' + t3.keyword + '%') as chk
								,rank () over(partition by pl_goodsnm order by pl_goodsnm, len(t2.keyword) desc) as rank
								from 
								(
									select pl_no, replace(pl_goodsnm,' ','') as pl_goodsnm, pl_category
									from pricelist with(readuncommitted) 
									where pl_vcode = 7863 and pl_status = '4' and (pl_category = '00' or pl_category = '' or pl_category is null) and pl_dutycode = @DutyCode
								) as t1
								inner join
								(
									select category, replace(keyword,' ','') as keyword
									from tbl_sd_category_keyword with(readuncommitted)
									where keyword_flag = '1'
								) as t2
								on t1.pl_goodsnm like '%' + t2.keyword + '%'
								where (select top 1 'X' from tbl_sd_category_keyword as t3 with(readuncommitted)  where keyword_flag = '2' and t2.category like t3.category + '%' and t1.pl_goodsnm like '%' + t3.keyword + '%') is null
							) as T4
							where rank = 1

							Set @AddCnt = @AddCnt + @@rowcount
							set @DutyCode = @DutyCode + 1
						End

					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist set pl_category = cate
							from pricelist with(readuncommitted) inner join @C4
							on pl_no = NO where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
		
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
							print @MultiInt
						END	
				End
		End
	else	-- 7876,7878,7884,7877,7879,7880,7882,7881,7883 --7913,1914,7915,7917,7918,7920,7921,7922,7923,7924,7925,7926,7927
		Begin
			DECLARE @I_ETC TABLE
			(
				IDX INT IDENTITY(1,1) PRIMARY KEY,
				IGOODSCODE VARCHAR(50)
			)
			insert into @I_ETC (IGOODSCODE)
			select ENR_SHPML_GOODS_CD 
			from ANALSDW.dbo.G_SHPDRY_EPMTCH_BSC  A with(readuncommitted)
				left outer join eloc2001.dbo.pricelist b with(readuncommitted)
					ON CAST(A.ENR_SHPML_GOODS_CD AS VARCHAR(50)) = b.pl_goodscode
					AND CHECKSUM(CAST(A.ENR_SHPML_GOODS_CD AS VARCHAR(50))) = b.pl_goodscode_cs
					AND B.PL_VCODE = @strVcode
			where ENR_SHPML_CD = @strVcode 
				AND b.pl_goodscode IS NULL

			set @AddCnt = @@rowcount
			
			If( not exists (SELECT TOP 1 IDX FROM @I_ETC))	Begin	return	end
							
			Set @MultiInt = 1
			Set @MultiCnt = (@AddCnt / 300) + 2 
			set @MultiStart = 0
			set @MultiEnd = 300
			WHILE @MultiInt < @MultiCnt
				BEGIN
					insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_URL, PL_PRICE, PL_SRVFLAG, PL_STATUS, PL_GOODSCODE, PL_AUTHDATE, PL_DATE)
					select 0, @strVcode, '1642', (case when len(SHPML_GOODS_NM_OPTN_VLU) > 200 then left(SHPML_GOODS_NM_OPTN_VLU,200) else SHPML_GOODS_NM_OPTN_VLU end), SHPML_GOODS_URL_VLU, SHPML_GOODS_REP_PRICE, '4', '4', ENR_SHPML_GOODS_CD, getdate(), SHPDRY_BUY_DATE
					from @I_ETC Inner join ANALSDW.dbo.G_SHPDRY_EPMTCH_BSC with(readuncommitted) 
					On IGOODSCODE = ENR_SHPML_GOODS_CD and IDX >= @MultiStart and IDX < @MultiEnd
					where ENR_SHPML_CD = @strVcode
																
					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300
				END
		End
END
















































































































