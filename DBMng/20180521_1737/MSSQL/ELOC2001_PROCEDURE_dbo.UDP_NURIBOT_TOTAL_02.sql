/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_02
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-08-04 15:53:47.327
 *        Modify: 2018-05-03 17:23:34.037
 *        Backup: 20180521_1737
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_02]

@strVcode char(4),
@strChkNo int,
@strDutyCode int


AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @SzQry VARCHAR(3000)	
	DECLARE @NowCnt int
	DECLARE @AllCnt int

	DECLARE @ModCnt int
	set @ModCnt = -1

	DECLARE @DelCnt int
	set @DelCnt = -1
	DECLARE @AddCnt int
	set @AddCnt = -1
		
	--카테분할 변수
	DECLARE @CateInt int
	DECLARE @CateCnt int
	DECLARE @CATENAME NVARCHAR(100)
	
	--분할처리 변수
	DECLARE @MultiInt int
	DECLARE @MultiCnt int
	DECLARE @MultiStart int 
	DECLARE @MultiEnd int

	--로그번호 
	DECLARE @SDate smalldatetime
	select @SDate = sdate from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where no = @strChkNo
	
	DECLARE @SLMAX VARCHAR(20)
	set @SLMAX = '0'

	DECLARE @CATE TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		CATE NVARCHAR(100)
	)

	DECLARE @U TABLE
	(
		IDX INT PRIMARY KEY,
		PLNO BIGINT,
		--GOODSCODE VARCHAR(50),
		GOODSNM NVARCHAR(200),
		PRICE MONEY,
		URL VARCHAR(500),
		IMGURL VARCHAR(250),
		ACCOUNT_YN char(1),
		DELIVERYINFO NVARCHAR(100),
		FACTORY NVARCHAR(50),
		FREEINTEREST NVARCHAR(50),
		CATE NVARCHAR(100),
		PRICE_CARD MONEY,
		COUPON TINYINT,
		INSTANCE_PRICE MONEY,

		TAG_PRICE MONEY,
		CALL_PLAN VARCHAR(3),
		IN_FEE_YN char(1),
		SHIP_FEE_YN char(1),	
		BOND_FEE MONEY,
		PENALITY_FEE MONEY,

		DELIVERY_LEV NVARCHAR(100),
		SET_YN char(1)
	)

	--삭제처리 
	DECLARE @D TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		PLNO BIGINT
	)

	--추가처리
	DECLARE @I TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		IGOODSCODE VARCHAR(50)
	)
	




	If @strVcode = '6508'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_6508 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 6508 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
	Else If @strVcode = '6665'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 6665 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '75'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 75 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '663'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 663 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '806'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 806 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '47'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 47 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '57'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 57 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '49'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 49 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '7692'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 7692 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '6644'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 6644 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '90'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 90 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '374'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 374 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '6641'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 6641 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '6603'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_6603 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 6603 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    Else If @strVcode = '6389'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_6389 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 6389 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End
	Else If @strVcode = '7941'
		Begin
			--카테수집
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from (select cate from NB01.dbo.TBL_DATA_TOTAL_7941 with(readuncommitted) group by cate) as t1
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)
			on vcode = 7941 and cate = catename 
			group by category, cate
			order by (case category when '' then '99' else category end), cate
			
			Set @CateCnt = @@rowcount

			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
				End
		End 
    	
END



