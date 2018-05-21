/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOP
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-09-19 09:54:15.123
 *        Modify: 2018-05-03 17:23:35.457
 *        Backup: 20180521_1739
 ************************************************************************* */







CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOP]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : sung35 / 2011-09-19
	-- 설  명 : 쇼핑몰 인기상품 수집
	-- ----------------------------------------------	
		DECLARE @SzQry VARCHAR(2000)
		DECLARE @UpdateChk Char(1)
		DECLARE @NowCnt int
		DECLARE @DelCnt int
		DECLARE @ModCnt int
		DECLARE @AddCnt int
		DECLARE @SDate smalldatetime
		set @UpdateChk = '1'
		set @NowCnt = -1
 		set @DelCnt = -1
		set @ModCnt = -1
		set @AddCnt = -1
		set @SDate = getdate()	
		
		--분할처리 변수
		DECLARE @MultiInt int
		DECLARE @MultiCnt int
		DECLARE @MultiStart int 
		DECLARE @MultiEnd int

		DECLARE @SzQryMulti VARCHAR(2000)
		DECLARE @DutyChar char(1)
		DECLARE @DutyInt int
		
		--중복제거
		DECLARE @ChkDuty int
		set @ChkDuty = -1

		set @SzQry = N' select top 1 goodscode'
		set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' group by goodscode'
		set @SzQry = @SzQry + N' having count(*) > 1' 
		exec(@SzQry)
		
		set @ChkDuty = @@rowcount

		If ( @ChkDuty > 0 )
			Begin
				set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' FROM NB01.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select goodscode as goodscode, min(no) as no from NB01.dbo.' + @strTableName + ' with(readuncommitted) group by goodscode having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.goodscode = B.goodscode WHERE A.no <> B.no'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)

				set @strAllCnt = @strAllCnt - @@rowcount
			End
		
	
		--카테고리 설정
		If @strVcode = '4027'
			begin
				set @SzQry = N' DELETE NB01.dbo.' + @strTableName 
				set @SzQry = @SzQry + N' WHERE (cate1rank is null or cate1rank = '''')'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
			end
		else
			begin		
				set @SzQry = N' DELETE NB01.dbo.' + @strTableName 
				set @SzQry = @SzQry + N' WHERE (cate1rank is null or cate1rank = '''') and (cate2rank is null or cate2rank = '''')'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
			end

		set @strAllCnt = @strAllCnt - @@rowcount

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
--
--		--삭제
--		set @SzQry = N'delete tbl_price_shop_popular_v2 ' 
--		--set @SzQry = N'select count(*)' 
--		set @SzQry = @SzQry + N' from tbl_price_shop_popular_v2 A with(readuncommitted) left outer join NB01.dbo.' + @strTableName + ' B'
--		set @SzQry = @SzQry + N' on A.goodscode = B.goodscode'
--		set @SzQry = @SzQry + N' where shop_code = '+@strVcode+' and B.goodscode is null option(maxdop 1)'
--
--		exec(@SzQry)
--		set @DelCnt = @@rowcount
--
--		--추가
--		set @SzQry = N'insert into tbl_price_shop_popular_v2 (shop_code, goodscode, cate1_rank, cate2_rank, cate3_rank, cate4_rank, pl_modelno, pl_category)'
--		set @SzQry = @SzQry + N' select' 
--		set @SzQry = @SzQry + N' '+@strVcode+','
--		set @SzQry = @SzQry + N' B.goodscode,'
--		set @SzQry = @SzQry + N' B.cate1rank,'
--		set @SzQry = @SzQry + N' B.cate2rank,'
--		set @SzQry = @SzQry + N' B.cate3rank,'
--		set @SzQry = @SzQry + N' B.cate4rank,'
--		set @SzQry = @SzQry + N' (case when C.pl_modelno < 1 then 0 else C.pl_modelno end),'
--		set @SzQry = @SzQry + N' C.pl_category'
--		set @SzQry = @SzQry + N' from dbo.tbl_price_shop_popular_v2 A with(readuncommitted) right outer join NB01.dbo.' + @strTableName + ' B'
--		set @SzQry = @SzQry + N' on A.goodscode = B.goodscode and shop_code = '+@strVcode  
--		set @SzQry = @SzQry + N' inner join dbo.pricelist C with(readuncommitted)'
--		set @SzQry = @SzQry + N' on B.goodscode = C.pl_goodscode and pl_vcode = '+@strVcode  
--		set @SzQry = @SzQry + N' where A.shop_code is null option(maxdop 1)'
--		
--		exec(@SzQry)
--		set @AddCnt = @@rowcount	
--
--		--수정
--		set @SzQry = N'update tbl_price_shop_popular_v2 '
--		set @SzQry = @SzQry + N' set cate1_rank = cate1rank, cate2_rank = cate2rank, cate3_rank = cate3rank, cate4_rank = cate4rank,'
--		set @SzQry = @SzQry + N' pl_modelno = (case when C.pl_modelno < 1 then 0 else C.pl_modelno end), pl_category = c.pl_category, regdate = getdate()' 
--		set @SzQry = @SzQry + N' from dbo.tbl_price_shop_popular_v2 A with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' B'
--		set @SzQry = @SzQry + N' on A.goodscode = B.goodscode and shop_code = '+@strVcode
--		set @SzQry = @SzQry + N' inner join dbo.pricelist C with(readuncommitted)'
--		set @SzQry = @SzQry + N' on B.goodscode = C.pl_goodscode and pl_vcode = '+@strVcode 
--		set @SzQry = @SzQry + N' where pl_goodsnm_cs <> checksum('''')' 
--		set @SzQry = @SzQry + N' and (cate1_rank <> cate1rank or cate2_rank <> cate2rank or cate3_rank <> cate3rank or cate4_rank = cate4rank or A.pl_modelno <> (case when C.pl_modelno < 1 then 0 else C.pl_modelno end) or A.pl_category <> C.pl_category)'
--		set @SzQry = @SzQry + N' option(maxdop 1)'
--			
--		exec(@SzQry)
--		set @ModCnt = @@rowcount
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

		--삭제
		set @SzQry = N'delete tbl_price_shop_popular_v2 ' 
		set @SzQry = @SzQry + N' where shop_code = '+@strVcode+' option(maxdop 1)'
		exec(@SzQry)

		--추가
		set @SzQry = N'insert into tbl_price_shop_popular_v2 (shop_code, goodscode, cate1_rank, cate2_rank, cate3_rank, cate4_rank, pl_modelno, pl_category)'
		set @SzQry = @SzQry + N' select' 
		set @SzQry = @SzQry + N' '+@strVcode+','
		set @SzQry = @SzQry + N' goodscode,'
		set @SzQry = @SzQry + N' cate1rank,'
		set @SzQry = @SzQry + N' cate2rank,'
		set @SzQry = @SzQry + N' cate3rank,'
		set @SzQry = @SzQry + N' cate4rank,'
		set @SzQry = @SzQry + N' (case when isnull(pl_modelno,0) < 1 then 0 else pl_modelno end),'
		set @SzQry = @SzQry + N' pl_category'
		set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName +' with(readuncommitted)'
		set @SzQry = @SzQry + N' inner join dbo.pricelist with(readuncommitted)'
		set @SzQry = @SzQry + N' on goodscode = pl_goodscode and pl_vcode = '+@strVcode+' option(maxdop 1)'
		
		exec(@SzQry)
		set @AddCnt = @@rowcount	

		--통계처리(전체,추가,수정,삭제)	
		insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
		--values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'P')
		values(@strVcode, @AddCnt, -1, -1, -1, @SDate, 'P')
END







































































