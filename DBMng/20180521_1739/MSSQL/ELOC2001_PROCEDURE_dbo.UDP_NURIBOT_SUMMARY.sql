/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_SUMMARY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-05-23 16:35:26.503
 *        Modify: 2015-09-22 13:28:51.583
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE   PROCEDURE [dbo].[UDP_NURIBOT_SUMMARY]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1)

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
		DECLARE @SzQry VARCHAR(2000)
		DECLARE @UpdateChk Char(1)		
		DECLARE @NowCnt int
		DECLARE @DelCnt int
		DECLARE @ModCnt int
		DECLARE @AddCnt int
		DECLARE @SDate smalldatetime
		DECLARE @SLCnt int
		set @UpdateChk = '1'		
		set @NowCnt = -1
 		set @DelCnt = -1
		set @ModCnt = -1
		set @AddCnt = -1
		set @SDate = getdate()
		set @SLCnt = -1

		DECLARE @SLMAX VARCHAR(20)
		set @SLMAX = '0'

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


		--pc가격 = 모바일가격 (6361)홈플러스,(948)팝스포유,(2046)퍼지PC,(2047)팝스디와이,(5978)바보사랑,(6389)패션플러스,(3367)YES24,(4861)알라딘,(6367)교보문고,(6368)영풍문고,(6667)미스터쿤
		If (@strVcode = '6361' or @strVcode = '948' or @strVcode = '2046' or @strVcode = '2047' or @strVcode = '5978' or @strVcode = '6389' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368' or @strVcode = '6667')
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
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
		where pl_vcode  = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'B' option(maxdop 1)
		
		--DECLARE @BeforCnt int
		--DECLARE @PriceModCnt int
		--set @BeforCnt = -1
		--set @PriceModCnt = -1
		--
		----이전 통계 수집
		--select top 1 @BeforCnt = ALLCNT 
		--from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted)
		--where VCODE = @strVcode 
		--order by NO desc
		--
		--If (@strChkData = '1' and @BeforCnt > -1)
		--	Begin
		--		--가격변경 개수 수집
		--		set @SzQry = N'select pl_no'
		--			set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
		--			set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		--			set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_nochange <> ''1'' and pl_price <> price option(maxdop 1)'
		--		exec(@SzQry)
		--		set @PriceModCnt = @@rowcount
		--
		--		--가격변경 개수 수집
		--		--set @SzQry = N'select @count = count(pl_no)'
		--		--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
		--		--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		--		--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_nochange <> ''1'' and pl_price <> price option(maxdop 1)'
		--		--exec(@SzQry)
		--		--set @PriceModCnt = @@rowcount
		--		--EXEC sp_ExecuteSQL @SzQry, N'@count INT OUTPUT', @count=@PriceModCnt OUTPUT
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
				
				--삭제처리 
				DECLARE @D TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					PLNO BIGINT
				)
				If (@strAllCnt >= @NowCnt * 0.9)
					Begin
						If (@strVcode = '55' or @strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '1878' or @strVcode = '663' or @strVcode = '49' or @strVcode = '47' or @strVcode = '75' or @strVcode = '57' or @strVcode = '90' or @strVcode = '806' or @strVcode = '6665')
							Begin
								If @strVcode = '4027'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_4027 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 4027 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '5910'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_5910 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 5910 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount	
									end
								else If @strVcode = '536'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_536 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 536 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '55'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_55 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 55 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '1878'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_1878 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 1878 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								---
								else If @strVcode = '663'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_663 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 663 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '49'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_49 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 49 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '47'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_47 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 47 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '75'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_75 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 75 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '57'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_57 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 57 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '90'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_90 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 90 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '806'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_806 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 806 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6665'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_SUMMARY_6665 with(readuncommitted)
										on pl_goodscode = goodscode
										where pl_vcode  = 6665 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
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
						Else
							Begin 
								set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
								--set @SzQry = N'select count(*)' 
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
								set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_status <> ''5'' and pl_status <> ''3'' and pl_srvflag <> ''M'' and goodscode is null option(maxdop 1)'
						
								exec(@SzQry)
								set @DelCnt = @@rowcount
							End
					End
				Else
					Begin
						set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
						exec(@SzQry)
					End 

				If (@strVcode != '5910') 
					Begin
						--수정처리 분할
						If (@strVcode = '55' or @strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '1878' or @strVcode = '663' or @strVcode = '49' or @strVcode = '47' or @strVcode = '75' or @strVcode = '57' or @strVcode = '90' or @strVcode = '806' or @strVcode = '6665')
						-- 1000000 이상 (4027,536,55,5910,3539,1878)
						-- 300000 이상 (663,49,47,75,57,90,806)
							Begin
								DECLARE @U TABLE
								(
									IDX INT IDENTITY(1,1) PRIMARY KEY,
									PLNO BIGINT,
									--GOODSCODE VARCHAR(50),
									GOODSNM NVARCHAR(200),
									PRICE MONEY,
									DELIVERYINFO NVARCHAR(100),
									--
									AIRCONFEETYPE CHAR(1),
									SRVFLAG CHAR(1),
									STATUS CHAR(1),
									RIGHTNLEFT CHAR(1),
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

								If @strVcode = '4027'
									begin
										Set @MultiInt = 1
										Set @MultiCnt = (@strAllCnt / 500000) + 2 
										set @MultiStart = 0
										set @MultiEnd = 500000
										WHILE @MultiInt < @MultiCnt
											BEGIN
												insert into @U(plno, goodsnm, price) 
												select pl_no, goodsnm, price
												from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_4027 with(readuncommitted)
												on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
												where pl_vcode = 4027 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_status = '3' or pl_status = '5')
												and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
																					
												set @ModCnt = @ModCnt + @@rowcount
											
												set @MultiInt = @MultiInt + 1
												set @MultiStart = @MultiEnd
												set @MultiEnd = @MultiInt * 500000
											END
									end
								else If @strVcode = '536'
									begin
										Set @MultiInt = 1
										Set @MultiCnt = (@strAllCnt / 500000) + 2 
										set @MultiStart = 0
										set @MultiEnd = 500000
										WHILE @MultiInt < @MultiCnt
											BEGIN 
												insert into @U(plno, goodsnm, price, deliveryinfo) 
												select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))
												from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_536 with(readuncommitted)
												on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
												where pl_vcode = 536 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')))
												and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
																					
												set @ModCnt = @ModCnt + @@rowcount
											
												set @MultiInt = @MultiInt + 1
												set @MultiStart = @MultiEnd
												set @MultiEnd = @MultiInt * 500000
											END
									end
								else If @strVcode = '55'
									begin
										Set @MultiInt = 1
										Set @MultiCnt = (@strAllCnt / 500000) + 2 
										set @MultiStart = 0
										set @MultiEnd = 500000
										WHILE @MultiInt < @MultiCnt
											BEGIN  
												insert into @U(plno, goodsnm, price, deliveryinfo, price_card) 
												select pl_no, goodsnm
												, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then price else pl_price end) else price end)
												, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))
												, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then price_card else pl_price_card end) else price_card end)
												from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_55 with(readuncommitted)
												on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
												where pl_vcode = 55 and pl_goodsnm <> '' and goodsnm is not null and (replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') or pl_price <> price or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')))
												and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
																					
												set @ModCnt = @ModCnt + @@rowcount
											
												set @MultiInt = @MultiInt + 1
												set @MultiStart = @MultiEnd
												set @MultiEnd = @MultiInt * 500000
											END
									end
								else If @strVcode = '5910'
									begin
										Set @MultiInt = 1
										Set @MultiCnt = (@strAllCnt / 500000) + 2 
										set @MultiStart = 0
										set @MultiEnd = 500000
										WHILE @MultiInt < @MultiCnt
											BEGIN   
												insert into @U(plno, goodsnm, price, deliveryinfo) 
												select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))
												from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_5910 with(readuncommitted)
												on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
												where pl_vcode = 5910 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')))
												and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
																					
												set @ModCnt = @ModCnt + @@rowcount
											
												set @MultiInt = @MultiInt + 1
												set @MultiStart = @MultiEnd
												set @MultiEnd = @MultiInt * 500000
											END
									end
								else If @strVcode = '1878'
									begin 
										insert into @U(plno, goodsnm, price, deliveryinfo, price_card) 
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), price_card
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_1878 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 1878 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)

										set @ModCnt = @@rowcount
									end
								---
								else If @strVcode = '663'
									begin
										insert into @U(plno, goodsnm, price, price_card)
										select pl_no, goodsnm, price, price_card
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_663 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 663 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5') and pl_nochange <> '1' option(maxdop 1)
										
										set @ModCnt = @@rowcount
									end
								else If @strVcode = '49'
									begin
										insert into @U(plno, goodsnm, price, deliveryinfo) 
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_49 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 49 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)

										set @ModCnt = @@rowcount
									end
								else If @strVcode = '47'
									begin
										insert into @U(plno, goodsnm, price, deliveryinfo, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, coupon, instance_price, delivery_lev, set_yn)
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,'')
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_47 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 47 and pl_goodsnm <> '' and goodsnm is not null 
										and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card 
										or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
										or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or pl_delivery_lev <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
										or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)
										
										set @ModCnt = @@rowcount
									end
								else If @strVcode = '75'
									begin
										insert into @U(plno, goodsnm, price, deliveryinfo, price_card, coupon, instance_price, delivery_lev, set_yn)
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,'')
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_75 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 75 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card
										or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or pl_delivery_lev <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
										or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)
										
										set @ModCnt = @@rowcount
									end
								else If @strVcode = '57'
									begin
										insert into @U(plno, goodsnm, price, price_card)
										select pl_no, goodsnm, price, price_card
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_57 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 57 and pl_goodsnm <> '' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price  or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5') and pl_nochange <> '1' option(maxdop 1)
										
										set @ModCnt = @@rowcount
									end
								else If @strVcode = '90'
									begin
										insert into @U(plno, goodsnm, price, deliveryinfo, price_card, coupon, instance_price, delivery_lev, set_yn) 
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,'')
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_90 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 90 and pl_goodsnm <> '' and goodsnm is not null 
										and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card  
										or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or pl_delivery_lev <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
										or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)

										set @ModCnt = @@rowcount
									end
								else If @strVcode = '806'
									begin
										insert into @U(plno, goodsnm, price, deliveryinfo, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, coupon, instance_price, delivery_lev, set_yn)
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,'')
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_806 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 806 and pl_goodsnm <> '' and goodsnm is not null 
										and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card 
										or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
										or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or pl_delivery_lev <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
										or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)
										
										set @ModCnt = @@rowcount
									end
								else If @strVcode = '6665'
									begin
										insert into @U(plno, goodsnm, price, deliveryinfo, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, coupon, instance_price, delivery_lev, set_yn)
										select pl_no, goodsnm, price, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,'')
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_SUMMARY_6665 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6665 and pl_goodsnm <> '' and goodsnm is not null 
										and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_price_card,0) <> price_card 
										or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
										or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or pl_delivery_lev <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
										or pl_status = '3' or pl_status = '5' or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,''))) and pl_nochange <> '1' option(maxdop 1)

										set @ModCnt = @@rowcount
									end

								select @SLCnt = count(pl_no) 
								from dbo.pricelist with(readuncommitted) inner join @U
								on pl_no = plno where pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 option(maxdop 1)
								
								
								Set @MultiInt = 1
								Set @MultiCnt = (@ModCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								
								WHILE @MultiInt < @MultiCnt
									BEGIN
										BEGIN TRY
											
											--모델명 변경 처리
											If (@ModCnt <= @NowCnt * 0.1) or (@SLCnt <= @NowCnt * 0.1)
												Begin
													insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
													select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
													from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
													where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
												End
											
											--가격처리
											--			insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--			select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
											--			,(case 
											--			--50% pl_srvflag:3 
											--			when g_minprice * 0.5 > price and option_flag2 <> '1' then '3'
											--			--10% pl_status:P
											--			--when g_minprice * 0.9 > price then '1'
											--			-- 5% pl_status:F
											--			--when g_minprice * 0.95 > price then '2' 
											--			when g_minprice * 0.9 > price and pl_price * 0.9 > price then '1'
											--			--30% 자신가격 pl_status:8
											--			when pl_price * 0.85 > price then '8'
											--			--나머지
											--			else ''
											--			end)
											--			from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--			inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											--			where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
											--			and g_minprice > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
											--			
											--			update pricelist set pl_srvflag = '3'
											--			where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005)
											--			option(maxdop 1)

											Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)
								
											insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)
											select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
											,(case when (option_flag2 = '0' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = '1' and pl_price / 100 * isnull(limit_pct1,50) > price) then '3' else '4' end)
											, g_minprice3, goodsnm, price, instance_price
											from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											left outer join dbo.tbl_rt_srv_off_set with(readuncommitted) on left(g_category,4) = category
											where IDX >= @MultiStart and IDX < @MultiEnd and left(g_category,2) <> '93' and pl_goodsnm <> '' 
											and ((option_flag2 = '0' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = '1' and pl_price / 100 * isnull(limit_pct1,50) > price ) or (option_flag2 = '0' and instance_price > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > instance_price))
											and pl_srvflag = '0' option(maxdop 1)
														
														--insert into logdb.dbo.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_MINPRICE)
														--select sl_plno, sl_modelno, sl_vcode,
														--(case when (isnull(instance_price,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(instance_price,0)) then 'M_NURI_REAL3' else 'PC_NURI_REAL3' end),
														--'1', goodsnm, price, sl_category, instance_price,
														--(case when (isnull(instance_price,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(instance_price,0)) then g_minprice3 else g_minprice end)
														--from TBL_STRANGE_LIST with(readuncommitted) inner join @U
														--on sl_plno = plno
														--inner join dbo.goods with(readuncommitted)
														--on sl_modelno = g_modelno
														--where sl_vcode = @strVcode and sl_srvflag = '3' and IDX >= @MultiStart and IDX < @MultiEnd and sl_no > @SLMAX option(maxdop 1)
											
											--단종3 로그 처리
											exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

											--update pricelist set pl_srvflag = '3'
											--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX)
											--option(maxdop 1)
											
											

											--무료<유료 최저가 처리(최저가 5%)
											--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '2'
											--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = '무료배송' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
											
											--가격 변경 처리(최저가 10%)
											--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '1'
											--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
											
											--단종3처리
											--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,'3'
											--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
											--and pl_modelno > 0 and pl_srvflag = '0'
											--and ((pl_price * 0.3 > price and left(pl_category,2) in ('08','14'))  or (pl_price * 0.5 > price and left(pl_category,2) not in ('08','14'))) option(maxdop 1)
											--
											--update pricelist set pl_srvflag = '3'
											--where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
											--option(maxdop 1)
											
											if (@strVcode = '55' or @strVcode = '5910' or @strVcode = '536' or @strVcode = '1878' or @strVcode = '49' or @strVcode = '90')
												Begin
													update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price,
													--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
													pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),
													pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),
													pl_deliveryinfo = deliveryinfo,
													pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
													pl_price_card = price_card 
													from dbo.pricelist with(readuncommitted) inner join @U
													on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
												End
											else if (@strVcode = '806' or @strVcode = '47' or @strVcode = '6665' or @strVcode = '75' )
												Begin
													update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price,
													--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
													pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),
													pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),
													pl_deliveryinfo = deliveryinfo,
													pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
													pl_price_card = price_card, 
													pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0), 
													pl_coupon = isnull(coupon,0),
													pl_instance_price = isnull(instance_price,0),
													pl_delivery_lev = delivery_lev, pl_set_yn = isnull(set_yn,'')
													from dbo.pricelist with(readuncommitted) inner join @U
													on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
												End
											else
												Begin
													update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price,
													--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
													pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),
													pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),
													pl_price_card = price_card, 
													pl_coupon = isnull(coupon,0),
													pl_instance_price = isnull(instance_price,0),
													pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0)
													from dbo.pricelist with(readuncommitted) inner join @U
													on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
												End
											
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
						--Else If (@strVcode = '663' or @strVcode = '49' or @strVcode = '47' or @strVcode = '75' or @strVcode = '57' or @strVcode = '90' or @strVcode = '806')
						-- 300000 이상 (663,49,47,75,57,90,806)
						--	BEGIN
						--		DECLARE @SzQryMulti VARCHAR(2000)
						--		DECLARE @DutyChar char(1)
						--		DECLARE @DutyInt int
						--		
						--		if (@strVcode = '49' or @strVcode = '90')
						--			Begin	
						--				set @SzQry = N'update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = case pl_nochange when ''1'' then pl_price else price end,' 
						--				set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
						--				set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag),'
						--				set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
						--				set @SzQry = @SzQry + N' pl_deliveryinfo = (case deliveryinfo when '''' then ''유무료'' else deliveryinfo end),'
						--				set @SzQry = @SzQry + N' pl_rightnleft = (case deliveryinfo when ''무료배송'' then ''1'' else ''2'' end)'
						--				--set @SzQry = N'select count(*)' 
						--				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						--				set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_deliveryinfo <> (case deliveryinfo when '''' then ''유무료'' else deliveryinfo end) or pl_status = ''5'')'
						--			End
						--		else
						--			Begin	
						--				set @SzQry = N'update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = case pl_nochange when ''1'' then pl_price else price end,' 
						--				set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
						--				set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag),'
						--				set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end)'		
						--				--set @SzQry = N'select count(*)' 
						--				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						--				set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_status = ''5'')'
						--			End
			
						--		set @DutyChar = '0'
						--		set @DutyInt = 0
						--		WHILE @DutyInt <> 10
						--			BEGIN
						--				set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
						--				exec(@SzQryMulti)
						--				set @ModCnt = @ModCnt + @@rowcount
						--				
						--				set @DutyInt = @DutyInt + 1
						--				set @DutyChar = cast(@DutyInt as char(1))
						--			END
						--	END	
						Else
						-- 이하
							BEGIN
								--모델명 변경 처리
								set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)'
									set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
									set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
									set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
									set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and replace(pl_goodsnm,'' '','''') <> replace(goodsnm,'' '','''') and pl_modelno > 0 and pl_srvflag = ''0'' and pl_nochange <> ''1''  option(maxdop 1)'
								exec(@SzQry)
								
								--가격처리
								--			set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
								--			set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
								--			set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price and pl_price * 0.9 > price then ''1'' when pl_price * 0.85 > price then ''8'' else '''' end)'
								--			set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								--			set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
								--			set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
								--			set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
								--			set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and g_minprice > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' option(maxdop 1)'
								--			exec(@SzQry)
								--						
								--			set @SzQry = N'update pricelist set pl_srvflag = ''3'''
								--			set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > getdate() - 0.02) option(maxdop 1)'
								--			exec(@SzQry)	
								
								Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)

								set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)'
								set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
								set @SzQry = @SzQry + N' ,(case when (option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) then ''3'' else ''4'' end)'
								set @SzQry = @SzQry + N' ,g_minprice3, goodsnm, price, price_mobile'
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
								set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
								set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
								set @SzQry = @SzQry + N' left outer join dbo.tbl_rt_srv_off_set with(readuncommitted)'
								set @SzQry = @SzQry + N' on left(g_category,4) = category'
								set @SzQry = @SzQry + N' where left(g_category,2) <> ''93'' and pl_vcode = '+@strVcode+' and pl_goodsnm <> '''''
								set @SzQry = @SzQry + N' and ((option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price ) or (option_flag2 = ''0'' and isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > isnull(price_mobile,0)))'
								set @SzQry = @SzQry + N' and pl_srvflag = ''0'' option(maxdop 1)'
								exec(@SzQry)

											--set @SzQry = N'insert into logdb.dbo.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_MINPRICE)'
											--set @SzQry = @SzQry + N' select sl_plno, sl_modelno, sl_vcode,'
											--set @SzQry = @SzQry + N' (case when (isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(price_mobile,0)) then ''M_NURI_REAL3'' else ''PC_NURI_REAL3'' end),'
											--set @SzQry = @SzQry + N' ''1'', goodsnm, price, sl_category, price_mobile,'
											--set @SzQry = @SzQry + N' (case when (isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(price_mobile,0)) then g_minprice3 else g_minprice end)'
											--set @SzQry = @SzQry + N' from TBL_STRANGE_LIST with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
											--set @SzQry = @SzQry + N' on sl_goodscode = goodscode and checksum(sl_goodscode) = goodscode_cs'
											--set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
											--set @SzQry = @SzQry + N' on sl_modelno = g_modelno'
											--set @SzQry = @SzQry + N' where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX+' option(maxdop 1)'
											--exec(@SzQry)

								--단종3 로그 처리
								exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX						

								--set @SzQry = N'update pricelist set pl_srvflag = ''3'''
								--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX+') option(maxdop 1)'
								--exec(@SzQry)			
								
								

								--무료<유료 최저가 처리(최저가 5%)
								--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
								--	set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''2'''
								--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
								--	set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
								--	set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
								--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = ''무료배송'' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' option(maxdop 1)'
								--exec(@SzQry)

								--가격 변경 처리(최저가 10%)
								--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
								--	set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''1'''
								--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
								--	set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
								--	set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
								--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' option(maxdop 1)'
								--exec(@SzQry)

								--단종3처리
								--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
								--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,''3'''
								--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
								--set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'	
								--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> ''''' 
								--set @SzQry = @SzQry + N' and pl_modelno > 0 and pl_srvflag = ''0'''
								--set @SzQry = @SzQry + N' and ((pl_price * 0.3 > price and left(pl_category,2) in (''08'',''14''))  or (pl_price * 0.5 > price and left(pl_category,2) not in (''08'',''14'')))  option(maxdop 1)'
								--exec(@SzQry)
									
								--set @SzQry = N'update pricelist set pl_srvflag = ''3'''
								--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > getdate() - 0.02) option(maxdop 1)'

								
								if (@strVcode = '241')
									Begin
										set @SzQry = N'update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price,' 
										--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
										set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),'
										set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
										set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
										set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end)'
										--set @SzQry = N'select count(*)' 
										set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
										set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
										set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_deliveryinfo,'''') <> (case isnull(deliveryinfo,'''') when '''' then ''유무료'' else deliveryinfo end) or pl_status = ''3'' or pl_status = ''5'') and pl_nochange <> ''1'' option(maxdop 1)'
									End
								Else
									Begin
										set @SzQry = N'update pricelist set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price,' 
										--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
										set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),'
										set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end)'		
										--set @SzQry = N'select count(*)' 
										set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
										set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
										set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null and (pl_goodsnm <> goodsnm or pl_price <> price or pl_status = ''3'' or pl_status = ''5'') and pl_nochange <> ''1'' option(maxdop 1)'
									End	

								exec(@SzQry)
								set @ModCnt = @@rowcount
							END
					END	
							
				--통계처리(전체,수정,추가,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, 0, @DelCnt, @SDate, 'S')

			End
		Else
			Begin
				--통계처리(전체,수정,추가,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'S')
			End
END




















































































