/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_BAK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-16 11:18:42.747
 *        Modify: 2015-05-15 03:31:33.667
 *        Backup: 20180521_1737
 ************************************************************************* */







CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_BAK]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1)

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
		DECLARE @SzQry VARCHAR(3000)
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

		DECLARE @ModCntChk int
		set @ModCntChk = -1
			
		--중복자료 삭제(전업체 설정)
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
		
		-- '품절'상품삭제
		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE = 1 WHERE PRICE = 0 and CATE in (SELECT CATENAME FROM NURIBOTDB.dbo.TBL_NB_SHOPCATE WITH(READUNCOMMITTED) WHERE  VCODE = '+@strVcode+' and CATEGORY LIKE ''0304%'') OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE PRICE < 1 OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = ''null'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = '''' OPTION (MAXDOP 1)'
		exec(@SzQry)

		--55 삭제
		If (@strVcode = '55')
			Begin
				delete pricelist where pl_vcode = 55 and pl_goodscode = '814643800' and pl_goodscode_cs = checksum('814643800')
			End	

		-- 핸드폰CPA(75,5910)
		If @strVcode = '75'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''11'' WHERE factory = ''휴대폰1'' OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''12'' WHERE factory = ''휴대폰2'' OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''13'' WHERE factory = ''휴대폰3'' OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		--Else If @strVcode = '5910'
		--	Begin
		--		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''21'' WHERE factory = ''휴대폰1'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--	End
			
		--전체개수 체크
		select @NowCnt = count(distinct pl_goodscode) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'B' option(maxdop 1)
		
		--DECLARE @BeforCnt int
		--DECLARE @PriceModCnt int
		--set @BeforCnt = -1
		--set @PriceModCnt = -1

		--이전 통계 수집
		--select top 1 @BeforCnt = ALLCNT 
		--from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted)
		--where VCODE = @strVcode 
		--order by NO desc
		
		--If (@strChkData = '1' and @BeforCnt > -1)
		--	Begin
		--		--가격변경 개수 수집
		--		--set @SzQry = N'select @count = count(pl_no)'
		--		--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
		--		--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		--		--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_nochange <> ''1'' and pl_price <> price option(maxdop 1)'
		--		--
		--		--EXEC sp_ExecuteSQL @SzQry, N'@count INT OUTPUT', @count=@PriceModCnt OUTPUT
		--		
		--		--가격변경 개수 수집
		--		set @SzQry = N'select pl_no'
		--			set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
		--			set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		--			set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_nochange <> ''1'' and pl_price <> price option(maxdop 1)'
		--		exec(@SzQry)
		--		set @PriceModCnt = @@rowcount				
		--
		--		If(@PriceModCnt > @NowCnt/2)
		--			Set @UpdateChk = '0'	
		--	End
		


		If (@UpdateChk = '1')
			Begin
				--분할처리 변수
				DECLARE @MultiInt int
				DECLARE @MultiCnt int
				DECLARE @MultiStart int 
				DECLARE @MultiEnd int

				DECLARE @SzQryMulti VARCHAR(2000)
				DECLARE @DutyChar char(1)
				DECLARE @DutyInt int

				--삭제처리 
				DECLARE @D TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					PLNO INT
				)

				--536,4027,5910,55,1878,806,663,47,75,90,49,57,6361,974,6389
				If (@strAllCnt >= @NowCnt * 0.9)
					Begin
						If (@strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '55' or @strVcode = '1878' or @strVcode = '806' or @strVcode = '663' or @strVcode = '47' or @strVcode = '75' or @strVcode = '90' or @strVcode = '49' or @strVcode = '57' or @strVcode = '6361' or @strVcode = '974' or @strVcode = '6389')
							Begin
								If @strVcode = '536'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_536
										on pl_goodscode = goodscode
										where pl_vcode  = 536 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '4027'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_4027
										on pl_goodscode = goodscode
										where pl_vcode  = 4027 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '5910'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_5910
										on pl_goodscode = goodscode
										where pl_vcode  = 5910 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '55'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_55
										on pl_goodscode = goodscode
										where pl_vcode  = 55 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '1878'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_1878
										on pl_goodscode = goodscode
										where pl_vcode  = 1878 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								---
								else If @strVcode = '806'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_806
										on pl_goodscode = goodscode
										where pl_vcode  = 806 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '663'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_663
										on pl_goodscode = goodscode
										where pl_vcode  = 663 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '47'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_47
										on pl_goodscode = goodscode
										where pl_vcode  = 47 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '75'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_75
										on pl_goodscode = goodscode
										where pl_vcode  = 75 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '90'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_90
										on pl_goodscode = goodscode
										where pl_vcode  = 90 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '49'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_49
										on pl_goodscode = goodscode
										where pl_vcode  = 49 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '57'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_57
										on pl_goodscode = goodscode
										where pl_vcode  = 57 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6361'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6361
										on pl_goodscode = goodscode
										where pl_vcode  = 6361 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '974'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_974
										on pl_goodscode = goodscode
										where pl_vcode  = 974 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6389'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6389
										on pl_goodscode = goodscode
										where pl_vcode  = 6389 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								--삭제전 한번더 체크
								If (@DelCnt <= @NowCnt * 0.1)
									Begin
										Set @MultiInt = 1
										Set @MultiCnt = (@DelCnt / 300) + 2 
										set @MultiStart = 0
										set @MultiEnd = 300
										
										WHILE @MultiInt < @MultiCnt
											Begin
												update pricelist set pl_date = getdate(), pl_status = '3'
												from dbo.pricelist with(readuncommitted) inner join @D
												on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
												
												set @MultiInt = @MultiInt + 1
												set @MultiStart = @MultiEnd
												set @MultiEnd = @MultiInt * 300
											End
									End
							End
						else				
							Begin 
								set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
								--set @SzQry = N'select count(*)' 
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
								set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' and pl_srvflag <> ''M'' and goodscode is null option(maxdop 1)'
						
								exec(@SzQry)
								set @DelCnt = @@rowcount
							End
					End
				Else
					Begin
						set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
						exec(@SzQry)
					End 

				--삭제처리 
				--If (@strAllCnt >= @NowCnt * 0.8)
				--	Begin
						--DECLARE @CNT INT
						--DECLARE @CATEGORY CHAR(4)
						--DECLARE @D TABLE
						--(
						--	IDX INT IDENTITY(1,1),
						--	CATEGORY CHAR(4)
						--)

						--If ( @strVcode = '55' or @strVcode = '536' or @strVcode = '4027' )
						--	Begin
						--		set @SzQry = N'INSERT INTO @D(CATEGORY)'
						--		set @SzQry = @SzQry + N' select left(pl_category, 4)'
						--		set @SzQry = @SzQry + N' from pricelist a with(readuncommitted)'
						--		set @SzQry = @SzQry + N' where pl_vcode = '+ @strVcode +' and pl_modelno > 0 and pl_status = ''0'''
						--		set @SzQry = @SzQry + N' and (pl_category like ''0201%'' or pl_category like ''0209%'' or pl_category like ''0211%'' or'
						--		set @SzQry = @SzQry + N' pl_category like ''0212%'' or pl_category like ''0218%'' or pl_category like ''0301%'' or'
						--		set @SzQry = @SzQry + N' pl_category like ''0304%'' or pl_category like ''0401%'' or pl_category like ''0404%'' or'
						--		set @SzQry = @SzQry + N' pl_category like ''0405%'' or pl_category like ''0501%'' or pl_category like ''0502%'' or'
						--		set @SzQry = @SzQry + N' pl_category like ''0503%'' or pl_category like ''0504%'' or pl_category like ''0602%'' or'
						--		set @SzQry = @SzQry + N' pl_category like ''0609%'' or pl_category like ''2113%'')'
						--		set @SzQry = @SzQry + N' group by left(pl_category, 4)'
						--		set @SzQry = @SzQry + N' having count(pl_no)/2 <' 
						--		set @SzQry = @SzQry + N' (select count(pl_no) from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.'+ @strTableName +' on pl_goodscode = goodscode'
						--		set @SzQry = @SzQry + N' where pl_vcode = '+ @strVcode +' and pl_modelno > 0 and pl_goodsnm_cs <> checksum('''') and pl_status <> ''5'' and pl_status <> ''3'' and goodscode is null and pl_category like '''+ left(a.pl_category ,4) +'%'')'
						--		set @SzQry = @SzQry + N' option (maxdop 1)'

						--		set @CNT = @@ROWCOUNT
						--	End

						--set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
						--set @SzQry = N'select count(*)' 
						--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.'+ @strTableName
						--set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--set @SzQry = @SzQry + N' where pl_vcode  = '+ @strVcode +' and pl_goodsnm_cs <> checksum('''') and pl_status <> ''5'' and pl_status <> ''3'' and goodscode is null'
						
						--WHILE @CNT<>0
						--	Begin
						--		SELECT @CATEGORY = CATEGORY FROM @D WHERE IDX=@CNT

						--		set @SzQry = @SzQry + N' and pl_category not like '''+ @CATEGORY +'%'''
						--		set @CNT = @CNT-1
						--	End
						
						--set @SzQry = @SzQry + N' option(maxdop 1)'
						
						--exec(@SzQry)
						--set @DelCnt = @@rowcount	
					--End 


				--추가처리
				DECLARE @I TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					IGOODSCODE VARCHAR(50)
				)
				
				DECLARE @IChk int
				select @IChk = max(pl_no) 
				from dbo.pricelist with(readuncommitted)
				where pl_vcode = @strVcode

				If (@strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '55')
					Begin
						If (@strVcode = '536')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_536
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 536
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
								
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, pl_authdate)
										select 0, 536, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(536 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, (case when freeinterest <> '' then '1' else '' end), dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), getdate()
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_536 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '4027')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_4027
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 4027
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate)
										select 0, 4027, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(4027 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, (case when freeinterest <> '' then '1' else '' end), dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate()
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_4027 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '5910')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_5910
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 5910
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, pl_authdate)
										select 0, 5910, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(5910 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), getdate()
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_5910 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						If (@strVcode = '55')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_55
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 55
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
								
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, pl_authdate)
										select 0, 55, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(55 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), getdate()
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_55 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
					End
				Else
					Begin
						set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD,'
						--핸드폰판매가격
						If (@strVcode = '47' or @strVcode = '57' or @strVcode = '806' or @strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516')
							begin
								set @SzQry = @SzQry + N' PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE,' 	
							end
						set @SzQry = @SzQry + N' pl_authdate)'
						set @SzQry = @SzQry + N' select' 
						set @SzQry = @SzQry + N' 0,'--dbo.UDF_TEST_RTN_MODELNO('+@strVcode+', goodsnm, goodscode),'		--GOODSNM
						set @SzQry = @SzQry + N' '+@strVcode+','
						set @SzQry = @SzQry + N' NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate),'	--CATE
						set @SzQry = @SzQry + N' goodsnm,'
						set @SzQry = @SzQry + N' price,'
						set @SzQry = @SzQry + N' url,'
						set @SzQry = @SzQry + N' dbo.UDF_TEST_RTN_SRVFLAG(goodsnm),'
						set @SzQry = @SzQry + N' ''2'','
						set @SzQry = @SzQry + N' imgurl,'
						set @SzQry = @SzQry + N' account_yn,'
						set @SzQry = @SzQry + N' factory,'
						set @SzQry = @SzQry + N' goodscode,'
						set @SzQry = @SzQry + N' freeinterest,'
						set @SzQry = @SzQry + N' dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
						set @SzQry = @SzQry + N' (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
						set @SzQry = @SzQry + N' isnull(price_card,0),'
						--핸드폰판매가격
						If (@strVcode = '47' or @strVcode = '57' or @strVcode = '806' or @strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516')
							begin
								set @SzQry = @SzQry + N' isnull(TAG_PRICE,0), isnull(CALL_PLAN,''''), isnull(IN_FEE_YN,''''), isnull(SHIP_FEE_YN,''''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0),'
							end
						set @SzQry = @SzQry + N' getdate()'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
						set @SzQry = @SzQry + N' where pl_no is null and goodsnm <> '''' option(maxdop 1)'
						
						exec(@SzQry)
						set @AddCnt = @@rowcount
					End
				--추가상품 입력
				--insert into pricelist_search_target(pl_no, pl_modelno, pl_category, pl_goodsnm, pl_goodsfactory, pl_price, status, pl_vcode)
				--select pl_no, pl_modelno, pl_category, pl_goodsnm, pl_goodsfactory, pl_price, 'I', pl_vcode
				--from pricelist with(readuncommitted)
				--where  pl_vcode = @strVcode and pl_no > @IChk and pl_goodsnm <> '' and pl_modelno < 1
					

				--If (@strVcode = '57')
				--	Begin
				--		update NB01.dbo.TBL_DATA_TOTAL_57 set cate = left(cate, charindex('<|>',cate)-1), homeflag = replace(right(cate, len(cate) - charindex('<|>',cate)+1),'<|>','')
				--	End
				--홈쇼핑 처리   (57)Hmall,(75)GS이숍,(663)롯데홈쇼핑, (806)cjmall, (974)NS이숍
				If (@strVcode = '57' or @strVcode = '75' or @strVcode = '663' or @strVcode = '806' or @strVcode = '974')
					Begin
						set @SzQry = N'update pricelist'
						set @SzQry = @SzQry + N' set pl_date = getdate(),'
						--가격체크
						set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
						--홈쇼핑처리
						set @SzQry = @SzQry + N' pl_homeflag = homeflag'		
						--select count(*)
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_nochange <> ''1'' and pl_goodsnm <> '''' and goodsnm is not null' 
						set @SzQry = @SzQry + N' and isnull(pl_homeflag,''N'') <> homeflag option(maxdop 1)'
						exec(@SzQry)
					End
				

				--수정처리 분할
				--536,4027,5910,55,1878,806,663,47,75,90,49,57,6361,974,6389 
				If (@strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '55' or @strVcode = '1878' or @strVcode = '806' or @strVcode = '663' or @strVcode = '47' or @strVcode = '75' or @strVcode = '90' or @strVcode = '49' or @strVcode = '57' or @strVcode = '6361' or @strVcode = '974' or @strVcode = '6389')
					Begin
						DECLARE @U TABLE
						(
							IDX INT IDENTITY(1,1) PRIMARY KEY,
							PLNO INT,
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
							LEVEL_CHK char(1),

							TAG_PRICE MONEY,
							CALL_PLAN VARCHAR(3),
							IN_FEE_YN char(1),
							SHIP_FEE_YN char(1),	
							BOND_FEE MONEY,
							PENALITY_FEE MONEY
						)

						If (@strVcode = '536' and DATEPART(hh,getdate()) < 12)
							begin
								--Set @MultiInt = 1
								--Set @MultiCnt = (@strAllCnt / 700000) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 700000
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN 
								--		insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, level_chk) 
								--		select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								--		, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								--		from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_536
								--		on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--		where pl_vcode = 536 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
								--		and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--		or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
								--		and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 0)
								--		
								--		set @ModCnt = @ModCnt + @@rowcount
								--	
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 700000
								--	END
								set @ModCnt = 0
							end
						else If (@strVcode = '4027' and DATEPART(hh,getdate()) < 12)
							begin 
								--Set @MultiInt = 1
								--Set @MultiCnt = (@strAllCnt / 700000) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 700000
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								--		select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								--		, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								--		from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_4027
								--		on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--		where pl_vcode = 4027 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
								--		and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--		or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
								--		and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 0)
								--		
								--		set @ModCnt = @ModCnt + @@rowcount
								--	
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 700000
								--	END
								set @ModCnt = 0
							end
						else If @strVcode = '5910'
							begin
								--Set @MultiInt = 1
								--Set @MultiCnt = (@strAllCnt / 700000) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 700000
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
 								--		insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, level_chk) 
								--		select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								--		, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								--		from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_5910
								--		on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--		where pl_vcode = 5910 and pl_goodsnm <> '' and goodsnm is not null
								--		and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--		or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
								--		and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 0)
								--
								--		set @ModCnt = @ModCnt + @@rowcount
								--	
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 700000
								--	END
								set @ModCnt = 0
							end
						else If @strVcode = '55'
							begin
							--	Set @MultiInt = 1
							--	Set @MultiCnt = (@strAllCnt / 700000) + 2 
							--	set @MultiStart = 0
							--	set @MultiEnd = 700000
							--	WHILE @MultiInt < @MultiCnt
							--		BEGIN
							--			insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
							--			select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
							--			, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
							--			from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_55
							--			on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
							--			where pl_vcode = 55 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B' 
							--			and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
							--			or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
							--			and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 0)
							--			
							--			set @ModCnt = @ModCnt + @@rowcount
							--			
							--			set @MultiInt = @MultiInt + 1
							--			set @MultiStart = @MultiEnd
							--			set @MultiEnd = @MultiInt * 700000
							--		END
								set @ModCnt = 0
							end
						else If @strVcode = '1878'
							begin 
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_1878
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 1878 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						----
						else If @strVcode = '806'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								,isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_806
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 806 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '663'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_663
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 663 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '47'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate ,isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_47
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 47 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest 
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '75'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_75
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 75 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '90'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_90
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 90 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '49'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_49
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 49 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '57'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card,isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_57
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 57 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
								or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6361'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6361
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6361 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '974'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_974
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 974 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end						
						else If @strVcode = '6389'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, level_chk) 
								select pl_no, goodsnm, (case pl_nochange when '1' then pl_price else price end), url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6389
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6389 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end	
						
						--If (@strVcode <> '536' and @strVcode <> '4027' and @strVcode <> '5910' and @strVcode <> '55')
						--	Begin
						--		--모델명 변경 처리
						--		insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
						--		select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
						--		from dbo.pricelist with(readuncommitted) inner join @U
						--		on pl_no = plno where pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
						--		
						--		--무료<유료 최저가 처리(최저가 5%)
						--		insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
						--		select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '2'
						--		from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
						--		inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
						--		where pl_goodsnm <> '' and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = '무료배송' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
						--		
						--		--가격 변경 처리(최저가 10%)
						--		insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
						--		select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '1'
						--		from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
						--		inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
						--		where pl_goodsnm <> '' and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
						--		--가격 변경 처리 (삭제)
						--		--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '08%'
						--		--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '12%'
						--		--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '14%'
						--		--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '16%'
						--		--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '0501%'
						--	End
						
						Set @MultiInt = 1
						Set @MultiCnt = (@ModCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300

						WHILE @MultiInt < @MultiCnt
							BEGIN
								BEGIN TRY

									If (@strVcode <> '536' and @strVcode <> '4027' and @strVcode <> '5910' and @strVcode <> '55')
										Begin
											--모델명 변경 처리
											insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
											select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
											from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
											
											--무료<유료 최저가 처리(최저가 5%)
											insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '2'
											from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = '무료배송' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
											
											--가격 변경 처리(최저가 10%)
											insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '1'
											from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
										End
			
									update pricelist
									set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
									pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
									pl_date = getdate(),
									--pl_date = (case level_chk when '1' then getdate() else @SDate end),
									--가격체크
									pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
									--배송체크
									pl_deliveryinfo = deliveryinfo,
									pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
									--이미지체크
									pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
									--설치비
									--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
									--설치비추가
									pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag),
									--카테고리
									pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(cast(@strVcode as int), cate) else pl_category end),
									pl_price_card = price_card,
									pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0)
									--select count(*)
									from dbo.pricelist with(readuncommitted) inner join @U
									on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	

									set @MultiInt = @MultiInt + 1
									set @MultiStart = @MultiEnd
									set @MultiEnd = @MultiInt * 300
								END TRY
								BEGIN CATCH
									set @MultiInt = @MultiInt + 1
									set @MultiStart = @MultiEnd
									set @MultiEnd = @MultiInt * 300	
								END CATCH;
							END
					END
				Else
				-- 이하
					BEGIN
						--모델명 변경 처리
						set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)'
						set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and replace(pl_goodsnm,'' '','''') <> replace(goodsnm,'' '','''') and pl_modelno > 0 and pl_srvflag = ''0'''
						
						set @DutyChar = '0'
						set @DutyInt = 0
						WHILE @DutyInt <> 10
							BEGIN
								set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
								exec(@SzQryMulti)
								
								set @DutyInt = @DutyInt + 1
								set @DutyChar = cast(@DutyInt as char(1))
							END

						--무료<유료 최저가 처리(최저가 5%)
						set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''2'''
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = ''무료배송'' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'''

						set @DutyChar = '0'
						set @DutyInt = 0
						WHILE @DutyInt <> 10
							BEGIN
								set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
								exec(@SzQryMulti)
								
								set @DutyInt = @DutyInt + 1
								set @DutyChar = cast(@DutyInt as char(1))
							END

						--가격 변경 처리(최저가 10%)
						set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''1'''
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'''

						set @DutyChar = '0'
						set @DutyInt = 0
						WHILE @DutyInt <> 10
							BEGIN
								set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
								exec(@SzQryMulti)
								
								set @DutyInt = @DutyInt + 1
								set @DutyChar = cast(@DutyInt as char(1))
							END

						--수정처리

						If (@strVcode = '374' or @strVcode = '5962' or @strVcode = '241' or @strVcode = '6300' or @strVcode = '4841' or @strVcode = '273' or @strVcode = '6130')
							--374,5962,241,6300,4841,273,6130
							BEGIN
								set @SzQry = N'update pricelist'
								set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = case pl_nochange when ''1'' then pl_price else price end, pl_url = url, pl_imgurl = imgurl,'
								set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,'
								set @SzQry = @SzQry + N' pl_date = getdate(),' 
								--set @SzQry = @SzQry + N' pl_date = (pl_price <> price or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) then getdate() else '+ +' end),' 
								--가격체크
								set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
								--배송체크
								set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
								set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
								--이미지체크
								set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
								--설치비
								--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
								--설치비추가
								set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag),'
								--카테고리
								set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end)'
								If (@strVcode = '374')
									Begin
										set @SzQry = @SzQry + N', pl_price_card = price_card'
									End
								--select count(*)
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
								set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
								set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
								set @SzQry = @SzQry + N' or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or pl_freeinterest <> freeinterest or pl_status = ''3'' or pl_status = ''5'' or isnull(pl_category,'''') = '''''
								If (@strVcode = '374')
									Begin
										set @SzQry = @SzQry + N' or isnull(pl_price_card,0) <> price_card'
									End
								set @SzQry = @SzQry + N' ) and pl_nochange <> ''1'''
								set @DutyChar = '0'
								set @DutyInt = 0
								WHILE @DutyInt <> 10
									BEGIN
										set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
										exec(@SzQryMulti)
										set @ModCnt = @ModCnt + @@rowcount
										
										set @DutyInt = @DutyInt + 1
										set @DutyChar = cast(@DutyInt as char(1))
									END
							END	
						ELSE
							BEGIN
								set @SzQry = N'update pricelist'
								set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = case pl_nochange when ''1'' then pl_price else price end, pl_url = url, pl_imgurl = imgurl,'
								set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,'
								set @SzQry = @SzQry + N' pl_date = getdate(),' 
								--set @SzQry = @SzQry + N' pl_date = (pl_price <> price or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) then getdate() else '+ +' end),' 
								--가격체크
								set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
								--배송체크
								set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
								set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
								--이미지체크
								set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
								--설치비
								--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
								--설치비추가
								set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag),'
								--카테고리
								set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end)'
								--select count(*)
								If (@strVcode = '6193' or @strVcode = '6252')
									Begin
										set @SzQry = @SzQry + N', pl_price_card = price_card'
									End
								--핸드폰판매가격
								If (@strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516')
									Begin 
										set @SzQry = @SzQry + N' ,pl_tag_price = isnull(TAG_PRICE,0), pl_call_plan = isnull(CALL_PLAN,''''), pl_in_fee_yn = isnull(IN_FEE_YN,''''), pl_ship_fee_yn = isnull(SHIP_FEE_YN,''''), pl_bond_fee = isnull(BOND_FEE,0), pl_penality_fee = isnull(PENALITY_FEE,0)'
									End
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
								set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
								set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
								set @SzQry = @SzQry + N' or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or pl_freeinterest <> freeinterest or pl_status = ''3'' or pl_status = ''5'' or isnull(pl_category,'''') = '''''
								If (@strVcode = '6193' or @strVcode = '6252')
									Begin
										set @SzQry = @SzQry + N' or isnull(pl_price_card,0) <> price_card'
									End
								--핸드폰판매가격
								If (@strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516')
									Begin 
										set @SzQry = @SzQry + N' or isnull(pl_tag_price,0) <> isnull(TAG_PRICE,0) or isnull(pl_call_plan,'''') <> isnull(CALL_PLAN,'''') or isnull(pl_in_fee_yn,'''') <> isnull(IN_FEE_YN,'''') or isnull(pl_ship_fee_yn,'''') <> isnull(SHIP_FEE_YN,'''') or isnull(pl_bond_fee,0) <> isnull(BOND_FEE,0) or isnull(pl_penality_fee,0) <> isnull(PENALITY_FEE,0)'
									End
								set @SzQry = @SzQry + N' ) and pl_nochange <> ''1'' option(maxdop 1)'
									
								exec(@SzQry)
								set @ModCnt = @@rowcount
							END
					END				

						
				

				--SDU삭제 처리
				UPDATE PRICELIST SET PL_STATUS = '3' 
				WHERE PL_VCODE = @strVcode AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND PL_DATE < DATEADD(D, -2,GETDATE()) AND pl_srvflag <> 'M'
				

				--SDU중복 처리
				DECLARE @PLNO INT
				DECLARE @GOODSCODE VARCHAR(50)
				DECLARE @PRICE MONEY
				DECLARE @RIGHTNLEFT CHAR(1)
				DECLARE @DELIVERYINFO NVARCHAR(100) 
				DECLARE @CHKCOUNT INT
				DECLARE @MAX INT

				DECLARE @S TABLE
				(
					IDX INT IDENTITY(1,1),
					PLNO INT,
					GOODSCODE VARCHAR(50),
					PRICE MONEY,
					RIGHTNLEFT CHAR(1),
					DELIVERYINFO NVARCHAR(100) 
				)

				INSERT INTO @S(PLNO, GOODSCODE, PRICE, RIGHTNLEFT, DELIVERYINFO)
					SELECT PL_NO, PL_GOODSCODE, PL_PRICE, PL_RIGHTNLEFT, PL_DELIVERYINFO
					FROM PRICELIST 
					WHERE PL_VCODE= @strVcode AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND pl_srvflag <> 'M'
				
				SET @MAX = @@ROWCOUNT
				
				WHILE @MAX<>0
					BEGIN
						set @CHKCOUNT = 0
						SELECT @PLNO = PLNO, @GOODSCODE = GOODSCODE, @PRICE = PRICE, @RIGHTNLEFT = RIGHTNLEFT, @DELIVERYINFO = DELIVERYINFO
						FROM @S 
						WHERE IDX=@MAX

						SELECT @CHKCOUNT = COUNT(*)
						FROM PRICELIST
						WHERE PL_VCODE= @strVcode AND PL_GOODSCODE = @GOODSCODE AND PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
							AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'

						IF (@CHKCOUNT > 0)
							BEGIN
								--UPDATE PRICELIST
								--SET PL_STATUS = '1', PL_PRICE = @PRICE, PL_RIGHTNLEFT = @RIGHTNLEFT, PL_DELIVERYINFO = @DELIVERYINFO
								--WHERE PL_VCODE= @strVcode AND PL_GOODSCODE = @GOODSCODE AND PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
								--	AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'
			
								UPDATE PRICELIST
								SET PL_STATUS = '3'
								WHERE PL_NO = @PLNO
							END 

						SET @MAX = @MAX-1
					END
	
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')
			End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'T')
			End
END


