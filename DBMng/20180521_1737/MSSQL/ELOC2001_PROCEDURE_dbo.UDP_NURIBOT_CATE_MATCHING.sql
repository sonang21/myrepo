/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_CATE_MATCHING
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-06-14 19:30:20.96
 *        Modify: 2018-05-03 17:23:34.48
 *        Backup: 20180521_1737
 ************************************************************************* */



CREATE   PROCEDURE [dbo].[UDP_NURIBOT_CATE_MATCHING]

@strTableName char(21),
@strVcode char(4)

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
		DECLARE @SzQry VARCHAR(3000)
		DECLARE @NowCnt int
		DECLARE @DelCnt int
		DECLARE @ModCnt int
		DECLARE @AddCnt int
		set @NowCnt = -1
 		set @DelCnt = -1
		set @ModCnt = -1
		set @AddCnt = -1
					
		--중복자료 삭제(전업체 설정)
		DECLARE @ChkDuty int
		set @ChkDuty = -1

		set @SzQry = N' select top 1 goodscode'
		set @SzQry = @SzQry + N' from NB02.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' group by goodscode'
		set @SzQry = @SzQry + N' having count(*) > 1' 
		exec(@SzQry)
		
		set @ChkDuty = @@rowcount

		If ( @ChkDuty > 0 )
			Begin
				set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' FROM NB02.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select goodscode as goodscode, min(no) as no from NB02.dbo.' + @strTableName + ' with(readuncommitted) group by goodscode having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.goodscode = B.goodscode WHERE A.no <> B.no'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		
		--카테입력
		--INSERT INTO NURIBOTDB.dbo.TBL_NB_CATEGORY_CATE (VCODE, SHOP_CATENAME) 
		--select distinct 75, CATE 
		--From NB02.dbo.TBL_DATA_CATE_75 with(readuncommitted) 
		--left outer join NURIBOTDB.dbo.TBL_NB_CATEGORY_CATE 
		--on CATE = SHOP_CATENAME and Vcode = 75 
		--where SHOP_CATENAME is null
						
		--전체개수 체크
		select @NowCnt = count(distinct pl_goodscode) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'B' option(maxdop 1)
				
		--분할처리 변수
		DECLARE @MultiInt int
		DECLARE @MultiCnt int
		DECLARE @MultiStart int 
		DECLARE @MultiEnd int

		DECLARE @SzQryMulti VARCHAR(2000)
		DECLARE @DutyChar char(1)
		DECLARE @DutyInt int
				
		--추가처리
		DECLARE @I TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			I_GOODSCODE VARCHAR(50),
			I_GOODSNM VARCHAR(500),
			I_URL VARCHAR(500),
			I_IMGURL VARCHAR(250),
			I_ENURICATEGORY VARCHAR(8),
			I_SHOPCATEGORY VARCHAR(50),
			I_MODELNO INT,
			I_CATEGORY CHAR(8),
			I_SPEC2 NVARCHAR(2000),
			I_STATUS VARCHAR(1),
			I_NOTE VARCHAR(500)
		)
								
		insert into @I (I_GOODSCODE, I_GOODSNM, I_URL, I_IMGURL, I_ENURICATEGORY, I_SHOPCATEGORY, I_MODELNO, I_CATEGORY, I_SPEC2, I_STATUS, I_NOTE)
		select B.GOODSCODE, B.GOODSNM, B.URL, B.IMGURL, F.ENURI_CATEGORY, E.SHOP_CATEGORY, D.g_modelno, D.g_category, d.g_spec2, B.STATUS, B.NOTE
		from dbo.PRICELIST_CATEGORY_MATCHING AS A with(readuncommitted) 
		right outer join NB02.dbo.TBL_DATA_CATE_75 AS B with(readuncommitted)
		on A.goodscode = B.goodscode and A.SHOP_CODE = 75
		inner join pricelist AS C with(readuncommitted)
		on B.GOODSCODE = c.pl_goodscode and B.GOODSCODE_CS = c.pl_goodscode_cs and c.pl_vcode = 75
		inner join goods AS D with(readuncommitted) 
		on c.pl_modelno = d.g_modelno

		inner join NURIBOTDB.dbo.TBL_NB_CATEGORY_CATE AS E with(readuncommitted) 
		on B.CATE = E.SHOP_CATENAME
		inner join PRICELIST_CATEGORY_CATE AS F with(readuncommitted) 
		on E.SHOP_CATEGORY = F.SHOP_CATEGORY
		where A.GOODSNM is null option(maxdop 1)
								
		set @AddCnt = @@rowcount
							
		Set @MultiInt = 1
		Set @MultiCnt = (@AddCnt / 300) + 2 
		set @MultiStart = 0
		set @MultiEnd = 300

		WHILE @MultiInt < @MultiCnt
			BEGIN
				insert into PRICELIST_CATEGORY_MATCHING (SHOP_CODE, GOODSCODE, GOODSNM, URL, IMGURL, ENURI_CATEGORY, SHOP_CATEGORY, G_MODELNO, G_CATEGORY, G_SPEC2, STATUS, NOTE)
				select 75, I_GOODSCODE, I_GOODSNM, I_URL, I_IMGURL, I_ENURICATEGORY, I_SHOPCATEGORY, I_MODELNO, I_CATEGORY, I_SPEC2, I_STATUS, I_NOTE 
				from @I 
				WHERE IDX >= @MultiStart and IDX < @MultiEnd
										
				set @MultiInt = @MultiInt + 1
				set @MultiStart = @MultiEnd
				set @MultiEnd = @MultiInt * 300
			END
					

		--수정처리		
		DECLARE @U TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			I_GOODSCODE VARCHAR(50),
			I_GOODSNM VARCHAR(500),
			I_URL VARCHAR(500),
			I_IMGURL VARCHAR(250),
			I_ENURICATEGORY VARCHAR(8),
			I_SHOPCATEGORY VARCHAR(50),
			I_MODELNO INT,
			I_CATEGORY CHAR(8),
			I_SPEC2 NVARCHAR(2000),
			I_STATUS VARCHAR(1),
			I_NOTE VARCHAR(500)
		)						
						
		insert into @U (I_GOODSCODE, I_GOODSNM, I_URL, I_IMGURL, I_ENURICATEGORY, I_SHOPCATEGORY, I_MODELNO, I_CATEGORY, I_SPEC2, I_STATUS, I_NOTE)
		select B.GOODSCODE, B.GOODSNM, B.URL, B.IMGURL, F.ENURI_CATEGORY, E.SHOP_CATEGORY, D.g_modelno, D.g_category, d.g_spec2, B.STATUS, B.NOTE
		from dbo.PRICELIST_CATEGORY_MATCHING as a with(readuncommitted) 
		inner join NB02.dbo.TBL_DATA_CATE_75 as b with(readuncommitted)
		on a.goodscode = b.goodscode AND SHOP_CODE = 75
		inner join pricelist AS C with(readuncommitted)
		on B.GOODSCODE = c.pl_goodscode and B.GOODSCODE_CS = c.pl_goodscode_cs and c.pl_vcode = 75
		inner join goods AS D with(readuncommitted) 
		on c.pl_modelno = d.g_modelno
		inner join NURIBOTDB.dbo.TBL_NB_CATEGORY_CATE AS E with(readuncommitted) 
		on B.CATE = E.SHOP_CATENAME
		inner join PRICELIST_CATEGORY_CATE AS F with(readuncommitted) 
		on E.SHOP_CATEGORY = F.SHOP_CATEGORY
		option(maxdop 1)
								
		set @ModCnt = @@rowcount
									
		Set @MultiInt = 1
		Set @MultiCnt = (@ModCnt / 300) + 2 
		set @MultiStart = 0
		set @MultiEnd = 300

		WHILE @MultiInt < @MultiCnt
			BEGIN
				update PRICELIST_CATEGORY_MATCHING 
				set GOODSNM = I_GOODSNM, URL = I_URL, IMGURL = I_IMGURL, ENURI_CATEGORY = I_ENURICATEGORY, SHOP_CATEGORY = I_SHOPCATEGORY, G_MODELNO = I_MODELNO, G_CATEGORY = I_CATEGORY, G_SPEC2 = I_SPEC2, STATUS = I_STATUS, NOTE = I_NOTE 
				--select count(*)
				from PRICELIST_CATEGORY_MATCHING with(readuncommitted) inner join @U
				on GOODSCODE = I_GOODSCODE AND SHOP_CODE = 75
				where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
										
				set @MultiInt = @MultiInt + 1
				set @MultiStart = @MultiEnd
				set @MultiEnd = @MultiInt * 300
			END
		
END





























































































