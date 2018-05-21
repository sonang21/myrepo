/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-04-20 15:43:40.5
 *        Modify: 2018-03-14 09:57:07.86
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1),
@strStaticsNo int = 0

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
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

		DECLARE @SLMAX VARCHAR(20)
		set @SLMAX = '0'

		DECLARE @ModCntChk int
		set @ModCntChk = -1
			
		--중복자료 삭제(전업체 설정)
		DECLARE @ChkDuty int
		set @ChkDuty = -1

		--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
		--	BEGIN
		--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 1)
		--	END

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
		
		--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
		--	BEGIN
		--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 2)
		--	END

		-- '품절'상품삭제
		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE = 1 WHERE PRICE = 0 and CATE in (SELECT CATENAME FROM NURIBOTDB.dbo.TBL_NB_SHOPCATE WITH(READUNCOMMITTED) WHERE  VCODE = '+@strVcode+' and CATEGORY LIKE ''0304%'') OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE PRICE < 1 OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = ''null'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = '''' OPTION (MAXDOP 1)'
		exec(@SzQry)



		--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
		--	BEGIN
		--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 3)
		--	END

		--업체설정 
		-------------------------------------------------------------------------------------------------------------------------------------------------------

		--pc가격 = 모바일가격 (6361)홈플러스,(948)팝스포유,(2046)퍼지PC,(2047)팝스디와이,(5978)바보사랑,(6389)패션플러스,(3367)YES24,(4861)알라딘,(6367)교보문고,(6368)영풍문고,(6667)미스터쿤
		If (@strVcode = '6361' or @strVcode = '948' or @strVcode = '2046' or @strVcode = '2047' or @strVcode = '5978' or @strVcode = '6389' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368' or @strVcode = '6667')
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		
		--상품코드생성
		DECLARE @ChkPlnoMax bigint
		If @strVcode = '6508' --위메프
			Begin
				set @ChkPlnoMax = -1
				select @ChkPlnoMax = max(pl_no) from pricelist_make_goodscode with(readuncommitted) where pl_vcode = 6508
				--select @ChkPlnoMax
				insert pricelist_make_goodscode (pl_no, pl_vcode, pl_goodscode, pl_url_goodscode)
				select pl_no, pl_vcode, pl_goodscode,
					(case 
						when charindex('http://www.wemakeprice.com/widget/aff_bridge_public/enuri/', pl_url) > 0 then left(replace(pl_url, 'http://www.wemakeprice.com/widget/aff_bridge_public/enuri/',''), charindex('/', replace(pl_url, 'http://www.wemakeprice.com/widget/aff_bridge_public/enuri/',''))-1)
						when charindex('https://front.wemakeprice.com/affiliate/bridge?channelId=1000017&prodNo=', pl_url) > 0 then left(replace(pl_url, 'https://front.wemakeprice.com/affiliate/bridge?channelId=1000017&prodNo=',''), charindex('&', replace(pl_url, 'https://front.wemakeprice.com/affiliate/bridge?channelId=1000017&prodNo=',''))-1)
						else pl_goodscode
					end)
				from [dbo].[pricelist] with(readuncommitted) 
				where pl_vcode = 6508 and pl_no > @ChkPlnoMax
				OPTION (MAXDOP 1)
			End
		If @strVcode = '6641' --티몬
			Begin
				set @ChkPlnoMax = -1
				select @ChkPlnoMax = max(pl_no) from pricelist_make_goodscode with(readuncommitted) where pl_vcode = 6641
				--select @ChkPlnoMax
				insert pricelist_make_goodscode (pl_no, pl_vcode, pl_goodscode, pl_url_goodscode)
				select pl_no, pl_vcode, pl_goodscode, 
					(case 
						when charindex('&o_no', pl_url) > 0 then left(replace(pl_url, 'http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=',''), charindex('&', replace(pl_url, 'http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=',''))-1) 
						when charindex('http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=', pl_url) > 0 then replace(pl_url, 'http://www.ticketmonster.co.kr/entry/?jp=80024&ln=205013&p_no=','')
						else pl_goodscode 
					end) 
				from [dbo].[pricelist] with(readuncommitted) 
				where pl_vcode = 6641 and pl_no > @ChkPlnoMax
				OPTION (MAXDOP 1)
			End	

		-- 티몬(6641)
		If @strVcode = '6641'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-3) where charindex(''___'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-2) where charindex(''__'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-1) where charindex(''_'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET deliveryinfo = ''착불'' where deliveryinfo = ''-1'' OPTION (MAXDOP 1)'
				exec(@SzQry)

				--set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET coupon = null OPTION (MAXDOP 1)'
				--exec(@SzQry)
		
				--mourl
				--set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET url = left(url, charindex(''<<<mourl>>>'', url)-1) where where url like ''%mourl%'' OPTION (MAXDOP 1)'
				--exec(@SzQry)

				-- url 비교 상품코드 업데이트 		
				set @SzQry = N'update pricelist'
				set @SzQry = @SzQry + N' set pl_goodscode = goodscode'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join'

				set @SzQry = @SzQry + N' (select goodsnm, goodscode, left(url, charindex(''&coupon_srl='',url)) + right(url, len(url) - charindex(''&p_no'',url)) as url'
				set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
				set @SzQry = @SzQry + N' where goodscode like ''TP%'') as t1'

				set @SzQry = @SzQry + N' on pl_url = url and pl_url_cs = checksum(url)'
				set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
				set @SzQry = @SzQry + N' and pl_goodscode <> goodscode'
				exec(@SzQry)
									
			End

		-- 이랜드몰(7908)
		If @strVcode = '7908'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-3) where charindex(''___'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-2) where charindex(''__'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-1) where charindex(''_'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET deliveryinfo = ''착불'' where deliveryinfo = ''-1'' OPTION (MAXDOP 1)'
				exec(@SzQry)
			End

		-- 11st(5910)
		If @strVcode = '5910'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET deliveryinfo = ''착불'' where deliveryinfo = ''-1'' OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		-- 위메프(6508)
		If @strVcode = '6508'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-3) where charindex(''___'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-2) where charindex(''__'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = left(cate, len(cate)-1) where charindex(''_'',reverse(cate)) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)

				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET set_yn = replace(replace(replace(set_yn,''m'',''''),''b'',''''),''f'','''') OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		--디앤샵(1878)		
		If @strVcode = '1878'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET url = replace(url,''chnl_no=CH15040287'',''chnl_no=CH15020046'') OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		--쿠팡(7861)	
		If @strVcode = '7861'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, ''(Old)'', '''') where charindex(''(Old)'', cate) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, ''(0)'', '''') where charindex(''(0)'', cate) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, ''(old-new)'', '''') where charindex(''(old-new)'', cate) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, ''(N)'', '''') where charindex(''(N)'', cate) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, ''(New)'', '''') where charindex(''(New)'', cate) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, ''(O)'', '''') where charindex(''(O)'', cate) = 1 OPTION (MAXDOP 1)'
				exec(@SzQry)

				set @ChkDuty = 0

				WHILE @ChkDuty < 4
				BEGIN
					set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, SUBSTRING(cate, CHARINDEX(''('',cate) , CHARINDEX('')'',cate) - CHARINDEX(''('',cate) + 1), '''')'
					set @SzQry = @SzQry + N' where cate like ''%(%'' and ISNUMERIC (SUBSTRING(cate, CHARINDEX(''('',cate) + 1, CHARINDEX('')'',cate) - CHARINDEX(''('',cate) - 1)) > 0 OPTION (MAXDOP 1)'
					exec(@SzQry)

					set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET cate = replace(cate, reverse(SUBSTRING(reverse(cate), CHARINDEX('')'',reverse(cate)) , CHARINDEX(''('',reverse(cate)) - CHARINDEX('')'',reverse(cate)) + 1)), '''')'
					set @SzQry = @SzQry + N' where cate like ''%(%'' and ISNUMERIC (SUBSTRING(reverse(cate), CHARINDEX('')'',reverse(cate)) + 1, CHARINDEX(''('',reverse(cate)) - CHARINDEX('')'',reverse(cate)) - 1)) > 0 OPTION (MAXDOP 1)'
					exec(@SzQry)
					
					SET @ChkDuty = @ChkDuty + 1
				END
			End
		
		--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
		--	BEGIN
		--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 4)
		--	END
		-------------------------------------------------------------------------------------------------------------------------------------------------------
		
				
		--전체개수 체크
		If (@strVcode = '55' or @strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '6508' or 
			@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '90' or 
			@strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374')
			BEGIN
				select top 1 @NowCnt = ALLCNT 
				from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted)
				where VCODE = @strVcode and STATUSFLAG = 'T' and MODCNT > 0 and ADDCNT > 0 and DELCNT > 0
				order by NO desc
			END
		Else
			BEGIN 
				select @NowCnt = count(distinct pl_goodscode) 
				from dbo.pricelist with(readuncommitted)
				where pl_vcode = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'B' option(maxdop 1)
			END
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
		--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
		--	BEGIN
		--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 5)
		--	END

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
					PLNO BIGINT
				)

				--536,5910,4027,55,806,49,663,75,47,57,90,1878,974,6361,6389,5978,374,5962
				If (@strAllCnt >= @NowCnt * 0.9)
					Begin
						If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55' or @strVcode = '806' or @strVcode = '49' or @strVcode = '663' or @strVcode = '75' or @strVcode = '47' or @strVcode = '57' or @strVcode = '90' 
							or @strVcode = '1878' or @strVcode = '974' or @strVcode = '6361' or @strVcode = '6389' or @strVcode = '5978' or @strVcode = '374' or @strVcode = '5962' or @strVcode = '6665' or @strVcode = '6547' or @strVcode = '6588' or @strVcode = '6620' 
							or @strVcode = '6095' or @strVcode = '6695' or @strVcode = '6508' or @strVcode = '6641' or @strVcode = '7851' or @strVcode = '7861' or @strVcode = '7692' or @strVcode = '6644')
							Begin
								------------------------------------------------------------------------------------------------------------------------------------------
								--536,5910,4027,55
								If @strVcode = '536'
									begin 
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_536 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 536 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null 
										--and pl_goodscode <> '630692532' and pl_goodscode_cs <> checksum('630692532')
										--option(maxdop 1)
										--set @DelCnt = @@rowcount
										--insert into nb01.dbo.sample (GOODSCODE, GOODSCODE_CS, GOODSNM, GOODSNM_CS, PRICE, URL, IMGURL, ACCOUNT_YN, DELIVERYINFO, FACTORY, FREEINTEREST, CATE, PRICE_CARD, COUPON, HOMEFLAG, DATE, TAG_PRICE, CALL_PLAN, IN_FEE_YN, SHIP_FEE_YN, BOND_FEE, PENALITY_FEE, PRICE_MOBILE, DELIVERY_LEV, SET_YN) 
										--select GOODSCODE, GOODSCODE_CS, GOODSNM, GOODSNM_CS, PRICE, URL, IMGURL, ACCOUNT_YN, DELIVERYINFO, FACTORY, FREEINTEREST, CATE, PRICE_CARD, COUPON, HOMEFLAG, DATE, TAG_PRICE, CALL_PLAN, IN_FEE_YN, SHIP_FEE_YN, BOND_FEE, PENALITY_FEE, PRICE_MOBILE, DELIVERY_LEV, SET_YN from nb01.dbo.TBL_DATA_TOTAL_536 with(readuncommitted) where goodscode = '568004222'
										
										set @DelCnt = 0
									end
								else If @strVcode = '5910'
									begin 
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_5910 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 5910 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
										--option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '4027'
									begin 
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_4027 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 4027 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '55'
									begin 
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_55 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 55 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and pl_srvflag <> 'B' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '6508'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6508 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 6508 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								------------------------------------------------------------------------------------------------------------------------------------------
								--1000000개 이상
								else If @strVcode = '6665'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 6665 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '90'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 90 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '75'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 75 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '663'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 663 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '47'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 47 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '6641'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 6641 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '7692'
									begin
										set @DelCnt = 0
									end
								else If @strVcode = '57'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 57 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '806'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 806 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '49'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 49 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								else If @strVcode = '6644'
									begin
										set @DelCnt = 0
									end
								else If @strVcode = '374'
									begin
										--insert into @D(plno)
										--select pl_no
										--from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
										--on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 374 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										--set @DelCnt = @@rowcount
										set @DelCnt = 0
									end
								
								------------------------------------------------------------------------------------------------------------------------------------------
								--100000개 이상
								else If @strVcode = '1878'
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_1878 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 1878 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '974'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_974 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 974 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6361'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6361 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6361 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6389'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6389 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6389 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '5978'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_5978 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 5978 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '5962'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_5962 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 5962 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6547'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6547 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6547 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6588'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6588 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6588 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6620'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6620 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6620 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6095'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6095 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6095 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '6695'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6695 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6695 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '7851'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_7851 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 7851 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If @strVcode = '7861'
									begin
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_7861 with(readuncommitted)
										on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
										where pl_vcode = 7861 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null option(maxdop 1)
										
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
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs'
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

				--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
				--	BEGIN
				--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 6)
				--	END

				--추가처리
				DECLARE @I TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					IGOODSCODE VARCHAR(50)
				)
				
				DECLARE @IChk BIGINT
				select @IChk = max(pl_no) 
				from dbo.pricelist with(readuncommitted)
				where pl_vcode = @strVcode
				
				--536,5910,4027,55,806,49,663,75,47,57,90,1878,974,6361,6389,5978,374,5962
				If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55' or @strVcode = '806' or @strVcode = '49' or @strVcode = '663' or @strVcode = '75' or @strVcode = '47' or @strVcode = '57' or @strVcode = '90' 
							or @strVcode = '1878' or @strVcode = '974' or @strVcode = '6361' or @strVcode = '6389' or @strVcode = '5978' or @strVcode = '374' or @strVcode = '5962' or @strVcode = '6665' or @strVcode = '6547' or @strVcode = '6588' or @strVcode = '6620' 
							or @strVcode = '6095' or @strVcode = '6695' or @strVcode = '6508' or @strVcode = '6641' or @strVcode = '7851' or @strVcode = '7861' or @strVcode = '7692' or @strVcode = '6644')
					Begin
						------------------------------------------------------------------------------------------------------------------------------------------
						--536,5910,4027,55
						If (@strVcode = '536')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_536 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 536
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_INSTANCE_PRICE, pl_authdate, pl_airconfeetype, pl_store_flag)
								--		select 0, 536, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(536 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, (case when freeinterest <> '' then '1' else '' end), dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), isnull(price_card,0), isnull(price_mobile,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(536, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_536  with(readuncommitted)
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '5910')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_5910 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 5910
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_COUPON, PL_INSTANCE_PRICE, pl_authdate, pl_airconfeetype, pl_store_flag)
								--		select 0, 5910, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(5910 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), isnull(coupon,0), isnull(price_mobile,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(5910, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_5910 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--																																															
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '4027')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_4027 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 4027
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_INSTANCE_PRICE, pl_authdate, pl_airconfeetype, pl_store_flag)
								--		select 0, 4027, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(4027 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, (case when freeinterest <> '' then '1' else '' end), dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), isnull(price_card,0), isnull(price_mobile,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(4027, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_4027 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If (@strVcode = '55')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_55 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 55
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
								--		select 0, 55, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(55 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_55 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '6508')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6508 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6508
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
								--		select 0, 6508, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6508 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn 
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6508 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						------------------------------------------------------------------------------------------------------------------------------------------
						--1000000개 이상
						Else If(@strVcode = '6665')
							--Begin
							--	insert into @I (IGOODSCODE)
							--	select goodscode
							--	from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
							--	on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6665
							--	where pl_no is null and goodscode <> '' option(maxdop 1)
							--	
							--	set @AddCnt = @@rowcount
							--
							--	Set @MultiInt = 1
							--	Set @MultiCnt = (@AddCnt / 300) + 2 
							--	set @MultiStart = 0
							--	set @MultiEnd = 300
							--	WHILE @MultiInt < @MultiCnt
							--		BEGIN
							--			insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
							--			select 0, 6665, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6665 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
							--			from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted) 
							--			On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
							--			
							--			
							--			set @MultiInt = @MultiInt + 1
							--			set @MultiStart = @MultiEnd
							--			set @MultiEnd = @MultiInt * 300
							--		END
							--End
							set @AddCnt = 0
						Else If(@strVcode = '90')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 90
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype, pl_store_flag)
								--		select 0, 90, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(90 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(90, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '75')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 75
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								--		select 0, 75, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(75 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(75, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '663')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 663
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
								--		select 0, 663, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(663 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(663, 0, '', goodsnm, '', cate, url), 'N'
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If (@strVcode = '47')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 47
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								--		select 0, 47, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(47 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(47, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '6641')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6641
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_mobile_url)
								--		select 0, 6641, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6641 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, MOBILE_URL 
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '7692')
							Begin
								set @AddCnt = 0
							End
						Else If (@strVcode = '57')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 57
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
								--		select 0, 57, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(57 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(57, 0, '', goodsnm, '', cate, url), 'N'
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If (@strVcode = '806')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 806
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								--		select 0, 806, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(806 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(806, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '49')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 49
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								--		select 0, 49, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(49 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(49, 0, '', goodsnm, '', cate, url)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted) 
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						Else If(@strVcode = '6644')
							Begin
								set @AddCnt = 0
							End
						Else If(@strVcode = '374')
							Begin
								--insert into @I (IGOODSCODE)
								--select goodscode
								--from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 374
								--where pl_no is null and goodscode <> '' option(maxdop 1)
								--
								--set @AddCnt = @@rowcount
								--
								--Set @MultiInt = 1
								--Set @MultiCnt = (@AddCnt / 300) + 2 
								--set @MultiStart = 0
								--set @MultiEnd = 300
								--WHILE @MultiInt < @MultiCnt
								--	BEGIN
								--		insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype)
								--		select 0, 374, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(374 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)
								--		from @I Inner join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
								--		On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								--		
								--		set @MultiInt = @MultiInt + 1
								--		set @MultiStart = @MultiEnd
								--		set @MultiEnd = @MultiInt * 300
								--	END
								set @AddCnt = 0
							End
						
						------------------------------------------------------------------------------------------------------------------------------------------
						--100000개 이상
						
						
						Else If(@strVcode = '1878')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_1878 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 1878
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
										select 0, 1878, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(1878 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(1878, 0, '', goodsnm, '', cate, url)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_1878 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd

										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '974')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_974 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 974
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
										select 0, 974, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(974 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(974, 0, '', goodsnm, '', cate, url), 'N'
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_974 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6361')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6361 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6361
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype, pl_store_flag)
										select 0, 6361, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6361 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(6361, 0, '', goodsnm, '', cate, url)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6361 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6389')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6389 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6389
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype)
										select 0, 6389, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6389 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6389 with(readuncommitted)
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '5978')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_5978 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 5978
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype)
										select 0, 5978, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(5978 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_5978 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '5962')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_5962 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 5962
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype)
										select 0, 5962, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(5962 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_5962 with(readuncommitted)
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6547')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6547 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6547
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
										select 0, 6547, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6547 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(6547, 0, '', goodsnm, '', cate, url)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6547 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6588')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6588 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6588
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
										select 0, 6588, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6588 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(6588, 0, '', goodsnm, '', cate, url), 'N'
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6588 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6620')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6620 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6620
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
										select 0, 6620, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6620 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(6620, 0, '', goodsnm, '', cate, url)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6620 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6095')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6095 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6095
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
										select 0, 6095, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6095 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6095 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '6695')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6695 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6695
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
										select 0, 6695, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6695 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6695 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If (@strVcode = '7851')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_7851 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 7851
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
								
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
										select 0, 7851, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7851 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(7851, 0, '', goodsnm, '', cate, url)
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_7851 with(readuncommitted) 
										On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									END
							End
						Else If(@strVcode = '7861')
							Begin
								insert into @I (IGOODSCODE)
								select goodscode
								from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_7861 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 7861
								where pl_no is null and goodscode <> '' option(maxdop 1)
								
								set @AddCnt = @@rowcount
							
								Set @MultiInt = 1
								Set @MultiCnt = (@AddCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
										select 0, 7861, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7861 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn 
										from @I Inner join NB01.dbo.TBL_DATA_TOTAL_7861 with(readuncommitted) 
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
						--쿠폰가
						If (@strVcode = '1634' or @strVcode = '6634' or @strVcode = '6193' or @strVcode = '6603' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '6508' or @strVcode = '6641' or @strVcode = '7455' or @strVcode = '7695' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7857' or @strVcode = '7870' or @strVcode = '7885' or @strVcode = '7908' or @strVcode = '6095' or @strVcode = '7935' or @strVcode = '7941' or @strVcode = '7957')
							Begin
								set @SzQry = @SzQry + N' pl_coupon, pl_instance_price, pl_delivery_lev, pl_set_yn,'
							end
						If (@strVcode = '6780' or @strVcode = '6658' or @strVcode = '7822' or @strVcode = '5438')
							Begin
								set @SzQry = @SzQry + N' pl_coupon, pl_delivery_lev, pl_set_yn,'
							end
						--핸드폰판매가격
						If (@strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516' or @strVcode = '6556' or @strVcode = '6210' or @strVcode = '6672' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7885' or @strVcode = '7935')
							begin
								set @SzQry = @SzQry + N' PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE,' 	
							end
						set @SzQry = @SzQry + N' pl_authdate, pl_airconfeetype)'
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
						--쿠폰가
						If (@strVcode = '1634' or @strVcode = '6634' or @strVcode = '6193' or @strVcode = '6603' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '6508'or @strVcode = '6641' or @strVcode = '7455' or @strVcode = '7695' or @strVcode = '7692' or @strVcode = '7797'  or @strVcode = '7852' or @strVcode = '7857' or @strVcode = '7870' or @strVcode = '7885' or @strVcode = '7908' or @strVcode = '6095' or @strVcode = '7935' or @strVcode = '7941' or @strVcode = '7957')
							Begin
								set @SzQry = @SzQry + N' isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,''''),'
							end
						If (@strVcode = '6780' or @strVcode = '6658' or @strVcode = '7822')
							Begin
								set @SzQry = @SzQry + N' isnull(coupon,0), delivery_lev, isnull(set_yn,''''),'
							end
						--핸드폰판매가격
						If (@strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516' or @strVcode = '6556' or @strVcode = '6210' or @strVcode = '6672' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7885' or @strVcode = '7935')
							begin
								set @SzQry = @SzQry + N' isnull(TAG_PRICE,0), isnull(CALL_PLAN,''''), isnull(IN_FEE_YN,''''), isnull(SHIP_FEE_YN,''''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0),'
							end
						set @SzQry = @SzQry + N' getdate(),'
						set @SzQry = @SzQry + N' dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
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
				--홈쇼핑 개별처리 663 ,57,974,6588 정리 170804
				--홈쇼핑 처리   (57)Hmall,(75)GS이숍,(663)롯데홈쇼핑, (806)cjmall, (974)NS이숍
				--If (@strVcode = '57' or @strVcode = '75' or @strVcode = '663' or @strVcode = '806' or @strVcode = '974' or @strVcode = '6588' or @strVcode = '7851' or @strVcode = '7852' or @strVcode = '7870' or @strVcode = '7935')
				--	Begin
				--		set @SzQry = N'update pricelist'
				--		set @SzQry = @SzQry + N' set pl_date = getdate(),'
				--		--가격체크
				--		set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
				--		--홈쇼핑처리
				--		set @SzQry = @SzQry + N' pl_homeflag = isnull(homeflag,''N'')'		
				--		--select count(*)
				--		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
				--		set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
				--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and goodsnm is not null' 
				--		set @SzQry = @SzQry + N' and isnull(pl_homeflag,''N'') <> isnull(homeflag,''N'')'
				--		
				--		set @DutyChar = '0'
				--		set @DutyInt = 0
				--		WHILE @DutyInt <> 10
				--			BEGIN
				--				set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
				--				exec(@SzQryMulti)
				--				
				--				set @DutyInt = @DutyInt + 1
				--				set @DutyChar = cast(@DutyInt as char(1))
				--			END
				--	End
				

				--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
				--	BEGIN
				--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 7)
				--	END

				--수정처리 분할
				--536,5910,4027,55,806,49,663,75,47,57,90,1878,974,6361,6389,5978,374,5962 
				If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55' or @strVcode = '806' or @strVcode = '49' or @strVcode = '663' or @strVcode = '75' or @strVcode = '47' or @strVcode = '57' or @strVcode = '90' 
							or @strVcode = '1878' or @strVcode = '974' or @strVcode = '6361' or @strVcode = '6389' or @strVcode = '5978' or @strVcode = '374' or @strVcode = '5962' or @strVcode = '6665' or @strVcode = '6547' or @strVcode = '6588' or @strVcode = '6620' 
							or @strVcode = '6095' or @strVcode = '6695' or @strVcode = '6508' or @strVcode = '6641' or @strVcode = '7851' or @strVcode = '7861' or @strVcode = '7692' or @strVcode = '6644')
				
					Begin
						DECLARE @U TABLE
						(
							IDX INT IDENTITY(1,1) PRIMARY KEY,
							PLNO BIGINT,
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
							SET_YN char(1),
							MOBILE_URL VARCHAR(500)
						)
						
						--If (@strVcode = '536' and DATEPART(hh,getdate()) < 12)
						--	begin
						--		Set @MultiInt = 1
						--		Set @MultiCnt = (@strAllCnt / 700000) + 2 
						--		set @MultiStart = 0
						--		set @MultiEnd = 700000
						--		WHILE @MultiInt < @MultiCnt
						--			BEGIN 
						--				insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, level_chk) 
						--				select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
						--				, (case when pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) then '1' else '0' end)
						--				from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_536
						--				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
						--				where pl_vcode = 536 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
						--				and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
						--				or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
						--				and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 0)
						--				
						--				set @ModCnt = @ModCnt + @@rowcount
						--			
						--				set @MultiInt = @MultiInt + 1
						--				set @MultiStart = @MultiEnd
						--				set @MultiEnd = @MultiInt * 700000
						--			END
						--		set @ModCnt = 0
						--	end
						------------------------------------------------------------------------------------------------------------------------------------------
						--536,5910,4027,55
						If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55' or @strVcode = '6508')
							begin
								If (@strVcode = '55')
									begin
										INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
										select distinct 55, CATE, '-' 
										From (select cate from NB01.dbo.TBL_DATA_TOTAL_55 with(readuncommitted) group by cate) as t1 
										left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
										on CATE = CATENAME and Vcode = 55 
										where CATENAME is null
									end
								If (@strVcode = '536')
									begin
										delete NB01.dbo.TBL_DATA_TOTAL_536 where goodscode = '630692532' and goodscode_cs = checksum('630692532')

										INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
										select distinct 536, CATE, '-' 
										From (select cate from NB01.dbo.TBL_DATA_TOTAL_536 with(readuncommitted) group by cate) as t1 
										left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
										on CATE = CATENAME and Vcode = 536 
										where CATENAME is null
									end
								If (@strVcode = '4027')
									begin
										INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
										select distinct 4027, CATE, '-' 
										From (select cate from NB01.dbo.TBL_DATA_TOTAL_4027 with(readuncommitted) group by cate) as t1 
										left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
										on CATE = CATENAME and Vcode = 4027 
										where CATENAME is null
									end
								If (@strVcode = '5910')
									begin
										INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
										select distinct 5910, CATE, '-' 
										From (select cate from NB01.dbo.TBL_DATA_TOTAL_5910 with(readuncommitted) group by cate) as t1 
										left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
										on CATE = CATENAME and Vcode = 5910 
										where CATENAME is null
									end
								If (@strVcode = '6508')
									begin
										INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
										select distinct 6508, CATE, '-' 
										From (select cate from NB01.dbo.TBL_DATA_TOTAL_6508 with(readuncommitted) group by cate) as t1 
										left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
										on CATE = CATENAME and Vcode = 6508 
										where CATENAME is null
									end
								set @ModCnt = 0
							end
						------------------------------------------------------------------------------------------------------------------------------------------
						--1000000개 이상
						else If @strVcode = '6665'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 6665 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								--or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 6665, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 6665
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '90'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 90 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								--or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--	
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 90, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 90
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '75'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 75 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								--or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 75, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 75
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '663'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 663 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								--or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 663, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 663
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '47'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 47 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								--or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 47, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 47
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '6641'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn, MOBILE_URL) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn, isnull(MOBILE_URL,'')
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 6641 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								--or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn or isnull(pl_mobile_url,'') <> isnull(MOBILE_URL,'')
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 6641, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 6641
								where CATENAME is null
								set @ModCnt = 0
							end		
						else If @strVcode = '7692'
							begin
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 7692, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 7692
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '57'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 57 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								--or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 57, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 57
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '806'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 806 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								--or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 806, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 806
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '49'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 49 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								--or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 49, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 49
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '6644'
							begin
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 6644, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 6644
								where CATENAME is null
								set @ModCnt = 0
							end
						else If @strVcode = '374'
							begin
								--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								--select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
								--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								--where pl_vcode = 374 and pl_goodsnm <> '' and goodsnm is not null 
								--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								--or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								--or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								--
								--set @ModCnt = @@rowcount
								INSERT INTO NURIBOTDB.dbo.TBL_NB_SHOPCATE (VCODE, CATENAME, CATEGORY) 
								select distinct 374, CATE, '-' 
								From (select cate from NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted) group by cate) as t1 
								left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE with(readuncommitted)  
								on CATE = CATENAME and Vcode = 374
								where CATENAME is null
								set @ModCnt = 0
							end	
						
						------------------------------------------------------------------------------------------------------------------------------------------
						--100000개 이상
						
						else If @strVcode = '1878'
							begin 
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_1878 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 1878 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '974'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_974 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 974 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end					
						else If @strVcode = '6361'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6361 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6361 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6389'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6389 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6389 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end	
						else If @strVcode = '5978'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_5978 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 5978 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end	
						else If @strVcode = '5962'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_5962 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 5962 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6620'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6620 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6620 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end	
						else If @strVcode = '6547'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6547 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6547 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6588'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6588 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6588 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end		
						else If @strVcode = '6620'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6620 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6620 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end				
						else If @strVcode = '6095'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6095 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6095 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end		
						else If @strVcode = '6695'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6695 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6695 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end		
						else If @strVcode = '6508'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6508 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6508 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end					
						else If @strVcode = '7851'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_7851 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 7851 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '7861'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_7861 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 7861 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end					
									
						Set @MultiInt = 1
						Set @MultiCnt = (@ModCnt / 200) + 2 
						set @MultiStart = 0
						set @MultiEnd = 200

						WHILE @MultiInt < @MultiCnt
							BEGIN
								BEGIN TRY
									If (@strVcode <> '536' and @strVcode <> '4027' and @strVcode <> '5910' and @strVcode <> '55' and @strVcode <> '6508' and
										@strVcode <> '6665' and @strVcode <> '75' and @strVcode <> '663' and @strVcode <> '47' and @strVcode <> '6641' and @strVcode <> '7692' and @strVcode <> '90' and
										@strVcode <> '57' and @strVcode <> '806' and @strVcode <> '49' and @strVcode <> '6644' and @strVcode <> '374')
										Begin
											--모델명 변경 처리
											insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
											select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
											from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
											
											--가격처리
											--		insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--		select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
											--		,(case 
											--		--50% pl_srvflag:3 
											--		when g_minprice * 0.5 > price and option_flag2 <> '1' then '3'
											--		--10% pl_status:P1
											--		--when g_minprice * 0.9 > price then '1'
											--		-- 5% pl_status:F
											--		--when g_minprice * 0.95 > price and pl_deliveryinfo = '무료배송' and price < 100000 then '2'
											--		--when g_minprice * 0.95 > price  then '2' 
											--		when g_minprice * 0.9 > price and pl_price * 0.9 > price then '1'
											--		--15% 자신가격 pl_status:8
											--		when pl_price * 0.85 > price then '7'
											--		--나머지
											--		else ''
											--		end)
											--		from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--		inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											--		where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
											--		and g_minprice > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
											--		
											--		update pricelist set pl_srvflag = '3'
											--		where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005)
											--		option(maxdop 1)
											
											Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)
						
											insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)
											select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
											,(case when (option_flag2 = '0' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = '1' and pl_price / 100 * isnull(limit_pct1,50) > price) then '3' else '4' end)
											, g_minprice3, goodsnm, price, instance_price
											from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											left outer join dbo.tbl_rt_srv_off_set with(readuncommitted) on left(g_category,4) = category
											where IDX >= @MultiStart and IDX < @MultiEnd and left(g_category,2) <> '93' and pl_goodsnm <> '' and pl_price <> price 
											and ((option_flag2 = '0' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = '1' and pl_price / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = '0' and instance_price > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > instance_price))
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
											--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX)
											--option(maxdop 1)
					
											

											--(case (select top 1 '3' from TBL_STRANGE_LIST where sl_vcode = pl_vcode and sl_plno = pl_no and sl_srvflag = '3') when '3' then '3' else pl_srvflag end)
											
											--무료<유료 최저가 처리(최저가 5%)
											--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '2'
											--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
											--and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = '무료배송' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
											
											--가격 변경 처리(최저가 10%)
											--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '1'
											--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
											--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
											--and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)

											--단종3처리
											--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
											--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,'3'
											--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
											--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
											--and pl_modelno > 0 and pl_srvflag = '0'
											--and ((pl_price * 0.3 > price and left(pl_category,2) in ('08','14'))  or (pl_price * 0.5 > price and left(pl_category,2) not in ('08','14'))) option(maxdop 1)
		
											--update pricelist set pl_srvflag = '3'
											--where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
											--option(maxdop 1)
										End
									
									If @strVcode = '6641'
										Begin
											update pricelist
											set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
											pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
											pl_date = getdate(),
											--pl_date = (case level_chk when '1' then getdate() else @SDate end),
											--가격체크
											pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
											--배송체크
											pl_deliveryinfo = deliveryinfo,
											pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
											--이미지체크
											pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
											--설치비
											--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
											--설치비추가
											pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),
											--카테고리
											pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(cast(@strVcode as int), cate) else pl_category end),
											--백화점	
											pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), cate, pl_url),
											pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), pl_ca_code_dept),
											pl_price_card = price_card,
											pl_coupon = isnull(coupon,0),
											pl_instance_price = isnull(instance_price,0),
											pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
											pl_delivery_lev = delivery_lev, pl_set_yn = isnull(set_yn,''),
											pl_mobile_url = isnull(mobile_url,'')
											--select count(*)
											from dbo.pricelist with(readuncommitted) inner join @U
											on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
										End
									else
										Begin
											update pricelist
											set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
											pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
											pl_date = getdate(),
											--pl_date = (case level_chk when '1' then getdate() else @SDate end),
											--가격체크
											pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
											--배송체크
											pl_deliveryinfo = deliveryinfo,
											pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
											--이미지체크
											pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
											--설치비
											--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
											--설치비추가
											pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),
											--카테고리
											pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(cast(@strVcode as int), cate) else pl_category end),
											--백화점	
											pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), cate, pl_url),
											pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), pl_ca_code_dept),
											pl_price_card = price_card,
											pl_coupon = isnull(coupon,0),
											pl_instance_price = isnull(instance_price,0),
											pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
											pl_delivery_lev = delivery_lev, pl_set_yn = isnull(set_yn,'')
											--select count(*)
											from dbo.pricelist with(readuncommitted) inner join @U
											on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
										End

									set @MultiInt = @MultiInt + 1
									set @MultiStart = @MultiEnd
									set @MultiEnd = @MultiInt * 200
								END TRY
								BEGIN CATCH
									set @MultiInt = @MultiInt + 1
									set @MultiStart = @MultiEnd
									set @MultiEnd = @MultiInt * 200	
								END CATCH;
							END
					END
				Else
				-- 이하
					BEGIN
						--모델명 변경 처리
						set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)'
						set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and replace(pl_goodsnm,'' '','''') <> replace(goodsnm,'' '','''') and pl_modelno > 0 and pl_srvflag = ''0'' and pl_nochange <> ''1'' '
						
						set @DutyChar = '0'
						set @DutyInt = 0
						WHILE @DutyInt <> 10
							BEGIN
								set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
								exec(@SzQryMulti)
								
								set @DutyInt = @DutyInt + 1
								set @DutyChar = cast(@DutyInt as char(1))
							END
						
						--가격처리
						--		set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--		set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
						--		set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price and pl_price * 0.9 > price then ''1'' when pl_price * 0.85 > price then ''7'' else '''' end)'
						--		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--		set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						--		set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						--		set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and g_minprice > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'''

						--		set @DutyChar = '0'
						--		set @DutyInt = 0
						--		WHILE @DutyInt <> 10
						--			BEGIN
						--				set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
						--				exec(@SzQryMulti)
						--				
						--				set @DutyInt = @DutyInt + 1
						--				set @DutyChar = cast(@DutyInt as char(1))
						--			END
						--			
						--		set @SzQry = N'update pricelist set pl_srvflag = ''3'''
						--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > getdate() - 0.02'
						--		
						--		set @DutyChar = '0'
						--		set @DutyInt = 0
						--		WHILE @DutyInt <> 10
						--			BEGIN
						--				set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +') option(maxdop 1)'
						--				exec(@SzQryMulti)
						--				
						--				set @DutyInt = @DutyInt + 1
						--				set @DutyChar = cast(@DutyInt as char(1))
						--			END
						Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)
						
						set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)'
						set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
						set @SzQry = @SzQry + N' ,(case when (option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) then ''3'' else ''4'' end)'
						set @SzQry = @SzQry + N' ,g_minprice3, goodsnm, price, price_mobile'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						set @SzQry = @SzQry + N' left outer join dbo.tbl_rt_srv_off_set with(readuncommitted)'
						set @SzQry = @SzQry + N' on left(g_category,4) = category'
						set @SzQry = @SzQry + N' where left(g_category,2) <> ''93'' and pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and pl_price <> price'
						set @SzQry = @SzQry + N' and ((option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price)  or (option_flag2 = ''0'' and isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > isnull(price_mobile,0)))'
						set @SzQry = @SzQry + N' and pl_srvflag = ''0'''

						set @DutyChar = '0'
						set @DutyInt = 0
						WHILE @DutyInt <> 10
							BEGIN
								set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
								exec(@SzQryMulti)
										
								set @DutyInt = @DutyInt + 1
								set @DutyChar = cast(@DutyInt as char(1))
							END

								--set @SzQry = N'insert into logdb.dbo.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_MINPRICE)'
								--set @SzQry = @SzQry + N' select sl_plno, sl_modelno, sl_vcode,'
								--set @SzQry = @SzQry + N' (case when (isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(price_mobile,0)) then ''M_NURI_REAL3'' else ''PC_NURI_REAL3'' end),'
								--set @SzQry = @SzQry + N' ''1'', goodsnm, price, sl_category, price_mobile,'
								--set @SzQry = @SzQry + N' (case when (isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(price_mobile,0)) then g_minprice3 else g_minprice end)'
								--set @SzQry = @SzQry + N' from TBL_STRANGE_LIST with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
								--set @SzQry = @SzQry + N' on sl_goodscode = goodscode and checksum(sl_goodscode) = goodscode_cs'
								--set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
								--set @SzQry = @SzQry + N' on sl_modelno = g_modelno'
								--set @SzQry = @SzQry + N' where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX
								--set @DutyChar = '0'
								--set @DutyInt = 0
								--WHILE @DutyInt <> 10
								--	BEGIN
								--		set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +') option(maxdop 1)'
								--		exec(@SzQryMulti)
								--		
								--		set @DutyInt = @DutyInt + 1
								--		set @DutyChar = cast(@DutyInt as char(1))
								--	END

						--단종3 로그 처리
						exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX		

						--set @SzQry = N'update pricelist set pl_srvflag = ''3'''
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX
						--		
						--set @DutyChar = '0'
						--set @DutyInt = 0
						--WHILE @DutyInt <> 10
						--	BEGIN
						--		set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +') option(maxdop 1)'
						--		exec(@SzQryMulti)
						--				
						--		set @DutyInt = @DutyInt + 1
						--		set @DutyChar = cast(@DutyInt as char(1))
						--	END
						
						

						--무료<유료 최저가 처리(최저가 5%)
						--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''2'''
						--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						--set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = ''무료배송'' and pl_modelno > 0 and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'''
						--
						--set @DutyChar = '0'
						--set @DutyInt = 0
						--WHILE @DutyInt <> 10
						--	BEGIN
						--		set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
						--		exec(@SzQryMulti)
						--		
						--		set @DutyInt = @DutyInt + 1
						--		set @DutyChar = cast(@DutyInt as char(1))
						--	END
						--
						--가격 변경 처리(최저가 10%)
						--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''1'''
						--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						--set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'''
						--
						--set @DutyChar = '0'
						--set @DutyInt = 0
						--WHILE @DutyInt <> 10
						--	BEGIN
						--		set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
						--		exec(@SzQryMulti)
						--		
						--		set @DutyInt = @DutyInt + 1
						--		set @DutyChar = cast(@DutyInt as char(1))
						--	END

						--단종3처리
						--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,''3'''
						--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'	
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> ''''' 
						--set @SzQry = @SzQry + N' and pl_modelno > 0 and pl_srvflag = ''0'''
						--set @SzQry = @SzQry + N' and ((pl_price * 0.3 > price and left(pl_category,2) in (''08'',''14''))  or (pl_price * 0.5 > price and left(pl_category,2) not in (''08'',''14'')))'
		
						--set @DutyChar = '0'
						--		set @DutyInt = 0
						--		WHILE @DutyInt <> 10
						--			BEGIN
						--				set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
						--				exec(@SzQryMulti)
						--				
						--				set @DutyInt = @DutyInt + 1
						--				set @DutyChar = cast(@DutyInt as char(1))
						--			END
						--			
						--		set @SzQry = N'update pricelist set pl_srvflag = ''3'''
						--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > getdate() - 0.02'
						--		
						--		set @DutyChar = '0'
						--		set @DutyInt = 0
						--		WHILE @DutyInt <> 10
						--			BEGIN
						--				set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +') option(maxdop 1)'
						--				exec(@SzQryMulti)
						--				
						--				set @DutyInt = @DutyInt + 1
						--				set @DutyChar = cast(@DutyInt as char(1))
						--			END

						
						--수정처리

						If (@strVcode = '241' or @strVcode = '6300' or @strVcode = '4841' or @strVcode = '273' or @strVcode = '6130')
							--241,6300,4841,273,6130
							BEGIN
								set @SzQry = N'update pricelist'
								set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,'
								set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,'
								set @SzQry = @SzQry + N' pl_date = getdate(),' 
								--set @SzQry = @SzQry + N' pl_date = (pl_price <> price or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) then getdate() else '+ +' end),' 
								--가격체크
								set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then ''9'' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
								--배송체크
								set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
								set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
								--이미지체크
								set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
								--설치비
								--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
								--설치비추가
								set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),'
								--카테고리
								set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end),'
								--백화점
								set @SzQry = @SzQry + N' pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''''), cate, pl_url),'
								set @SzQry = @SzQry + N' pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''''), pl_ca_code_dept)'
								--select count(*)
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
								set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and goodsnm is not null' 
								set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
								set @SzQry = @SzQry + N' or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or isnull(pl_freeinterest,'''') <> freeinterest or pl_status = ''3'' or pl_status = ''5'' or isnull(pl_category,'''') = '''''
								set @SzQry = @SzQry + N' ) and pl_nochange <> ''1'' '
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
								set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,'
								set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,'
								set @SzQry = @SzQry + N' pl_date = getdate(),' 
								--set @SzQry = @SzQry + N' pl_date = (pl_price <> price or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) then getdate() else '+ +' end),' 
								--가격체크
								set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then ''9'' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
								--배송체크
								set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
								set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
								--이미지체크
								set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
								--설치비
								--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
								--설치비추가
								set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),'
								--카테고리
								set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end),'
								--백화점
								set @SzQry = @SzQry + N' pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''''), cate, pl_url),'
								set @SzQry = @SzQry + N' pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''''), pl_ca_code_dept)'
								--select count(*)
								--카드가
								If (@strVcode = '1634' or @strVcode = '6634' or @strVcode = '6252' or @strVcode = '6603' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '6780' or @strVcode = '6508'or @strVcode = '6641' or @strVcode = '7455' or @strVcode = '7695' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '6658' or @strVcode = '7822' or @strVcode = '5438' or @strVcode = '7908' or @strVcode = '6095' or @strVcode = '7935' or @strVcode = '7852')
									Begin
										set @SzQry = @SzQry + N', pl_price_card = price_card'
									End
								--쿠폰가
								If (@strVcode = '1634'  or @strVcode = '6634' or @strVcode = '6603' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '6508'or @strVcode = '6641' or @strVcode = '7455' or @strVcode = '7695' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7857' or @strVcode = '7870' or @strVcode = '7885' or @strVcode = '7908' or @strVcode = '6095' or @strVcode = '7935' or @strVcode = '7941' or @strVcode = '7957')
									Begin
										set @SzQry = @SzQry + N', pl_coupon = isnull(coupon,0)'
										set @SzQry = @SzQry + N', pl_instance_price = isnull(price_mobile,0)'
										set @SzQry = @SzQry + N', pl_delivery_lev = delivery_lev'
										set @SzQry = @SzQry + N', pl_set_yn = isnull(set_yn,'''')'
									End
								If (@strVcode = '6780' or @strVcode = '6658' or @strVcode = '7822' or @strVcode = '5438')
									Begin
										set @SzQry = @SzQry + N', pl_coupon = isnull(coupon,0)'
										set @SzQry = @SzQry + N', pl_delivery_lev = delivery_lev'
										set @SzQry = @SzQry + N', pl_set_yn = isnull(set_yn,'''')'
									End
								--핸드폰판매가격
								If (@strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516' or @strVcode = '6556' or @strVcode = '6210' or @strVcode = '6672' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7885' or @strVcode = '7935')
									Begin 
										set @SzQry = @SzQry + N' ,pl_tag_price = isnull(TAG_PRICE,0), pl_call_plan = isnull(CALL_PLAN,''''), pl_in_fee_yn = isnull(IN_FEE_YN,''''), pl_ship_fee_yn = isnull(SHIP_FEE_YN,''''), pl_bond_fee = isnull(BOND_FEE,0), pl_penality_fee = isnull(PENALITY_FEE,0)'
									End
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
								set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
								set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
								set @SzQry = @SzQry + N' or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or isnull(pl_freeinterest,'''') <> freeinterest or pl_status = ''3'' or pl_status = ''5'' or isnull(pl_category,'''') = '''''
								--카드가
								If (@strVcode = '1634' or @strVcode = '6634' or @strVcode = '6252' or @strVcode = '6603' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '6780' or @strVcode = '6508'or @strVcode = '6641' or @strVcode = '7455' or @strVcode = '7695' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '6658' or @strVcode = '7822' or @strVcode = '5438' or @strVcode = '7908' or @strVcode = '6095' or @strVcode = '7935' or @strVcode = '7852')
									Begin
										set @SzQry = @SzQry + N' or isnull(pl_price_card,0) <> isnull(price_card,0)'
									End
								--쿠폰가
								If (@strVcode = '1634' or @strVcode = '6634' or @strVcode = '6603' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '6508'or @strVcode = '6641' or @strVcode = '7455' or @strVcode = '7695' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7857' or @strVcode = '7870' or @strVcode = '7885' or @strVcode = '7908' or @strVcode = '6095' or @strVcode = '7935' or @strVcode = '7941' or @strVcode = '7957')
									Begin
										set @SzQry = @SzQry + N' or isnull(pl_coupon,0) <> isnull(coupon,0)'
										set @SzQry = @SzQry + N' or isnull(pl_instance_price,0) <> isnull(price_mobile,0)'
										set @SzQry = @SzQry + N' or isnull(pl_delivery_lev,'''') <> delivery_lev'
										set @SzQry = @SzQry + N' or isnull(pl_set_yn,'''') <> isnull(set_yn,'''')'
									End
								If (@strVcode = '6780' or @strVcode = '6658' or @strVcode = '7822' or @strVcode = '5438')
									Begin
										set @SzQry = @SzQry + N' or isnull(pl_coupon,0) <> isnull(coupon,0)'
										set @SzQry = @SzQry + N' or isnull(pl_delivery_lev,'''') <> delivery_lev'
										set @SzQry = @SzQry + N' or isnull(pl_set_yn,'''') <> isnull(set_yn,'''')'
									End
								--핸드폰판매가격
								If (@strVcode = '6104' or @strVcode = '6346' or @strVcode = '6498' or @strVcode = '6501' or @strVcode = '6516' or @strVcode = '6556' or @strVcode = '6210' or @strVcode = '6672' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7885' or @strVcode = '7935')
									Begin 
										set @SzQry = @SzQry + N' or isnull(pl_tag_price,0) <> isnull(TAG_PRICE,0) or isnull(pl_call_plan,'''') <> isnull(CALL_PLAN,'''') or isnull(pl_in_fee_yn,'''') <> isnull(IN_FEE_YN,'''') or isnull(pl_ship_fee_yn,'''') <> isnull(SHIP_FEE_YN,'''') or isnull(pl_bond_fee,0) <> isnull(BOND_FEE,0) or isnull(pl_penality_fee,0) <> isnull(PENALITY_FEE,0)'
									End
								set @SzQry = @SzQry + N' ) and pl_nochange <> ''1''  option(maxdop 1)'
									
								exec(@SzQry)
								set @ModCnt = @@rowcount
							END
					END				

						
				--If (@strVcode = '536')
				--	BEGIN
				--		insert into nb01.dbo.Testsample (GOODSCODE, GOODSCODE_CS, GOODSNM, GOODSNM_CS, PRICE, URL, IMGURL, ACCOUNT_YN, DELIVERYINFO, FACTORY, FREEINTEREST, CATE, PRICE_CARD, COUPON, HOMEFLAG, DATE, TAG_PRICE, CALL_PLAN, IN_FEE_YN, SHIP_FEE_YN, BOND_FEE, PENALITY_FEE, PRICE_MOBILE, DELIVERY_LEV, SET_YN) 
				--		select GOODSCODE, GOODSCODE_CS, GOODSNM, GOODSNM_CS, PRICE, URL, IMGURL, ACCOUNT_YN, DELIVERYINFO, FACTORY, FREEINTEREST, CATE, PRICE_CARD, COUPON, HOMEFLAG, DATE, TAG_PRICE, CALL_PLAN, IN_FEE_YN, SHIP_FEE_YN, BOND_FEE, PENALITY_FEE, PRICE_MOBILE, DELIVERY_LEV, SET_YN from nb01.dbo.TBL_DATA_TOTAL_536 with(readuncommitted) where goodscode = '568004222'
				--	END
				
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')
				
				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = @AddCnt, DELCNT = @DelCnt where no = @strStaticsNo
					END

				If (@strVcode = '974')
					BEGIN
						update pricelist set pl_status ='0', pl_modelno = '0' where pl_status ='1' and pl_no in (2693329614,2693329616,2902166775,2986570783)
					END


				If (@strVcode = '55' or @strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '6508' or 
					@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '90' or
					@strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374')
					BEGIN
						insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
						values(@strVcode, @strAllCnt, -1, 0, 0, @SDate, 'T')

						insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
						values(@strVcode, @strAllCnt, 0, -1, -1, @SDate, 'T')
					END

				--SDU삭제 처리
				UPDATE PRICELIST SET PL_STATUS = '3' 
				WHERE PL_VCODE = @strVcode AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND PL_DATE < DATEADD(D, -2,GETDATE()) AND pl_srvflag <> 'M'
				

				--SDU중복 처리
		--	DECLARE @PLNO BIGINT
		--	DECLARE @GOODSCODE VARCHAR(50)
		--	DECLARE @PRICE MONEY
		--	DECLARE @RIGHTNLEFT CHAR(1)
		--	DECLARE @DELIVERYINFO NVARCHAR(100) 
		--	DECLARE @CHKCOUNT INT
		--	DECLARE @MAX INT
		--
		--	DECLARE @S TABLE
		--	(
		--		IDX INT IDENTITY(1,1),
		--		PLNO BIGINT,
		--		GOODSCODE VARCHAR(50),
		--		PRICE MONEY,
		--		RIGHTNLEFT CHAR(1),
		--		DELIVERYINFO NVARCHAR(100) 
		--	)
		--
		--	INSERT INTO @S(PLNO, GOODSCODE, PRICE, RIGHTNLEFT, DELIVERYINFO)
		--		SELECT PL_NO, PL_GOODSCODE, PL_PRICE, PL_RIGHTNLEFT, PL_DELIVERYINFO
		--		FROM PRICELIST with(readuncommitted)
		--		WHERE PL_VCODE= @strVcode AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3'
		--	
		--	SET @MAX = @@ROWCOUNT
		--	
		--	WHILE @MAX<>0
		--		BEGIN
		--			set @CHKCOUNT = 0
		--			SELECT @PLNO = PLNO, @GOODSCODE = GOODSCODE, @PRICE = PRICE, @RIGHTNLEFT = RIGHTNLEFT, @DELIVERYINFO = DELIVERYINFO
		--			FROM @S 
		--			WHERE IDX=@MAX
		--
		--			SELECT @CHKCOUNT = COUNT(*)
		--			FROM PRICELIST with(readuncommitted)
		--			WHERE PL_VCODE= @strVcode AND PL_GOODSCODE = @GOODSCODE AND PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
		--				AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'
		--
		--			IF (@CHKCOUNT > 0)
		--				BEGIN
		--					--UPDATE PRICELIST
		--					--SET PL_STATUS = '1', PL_PRICE = @PRICE, PL_RIGHTNLEFT = @RIGHTNLEFT, PL_DELIVERYINFO = @DELIVERYINFO
		--					--WHERE PL_VCODE= @strVcode AND PL_GOODSCODE = @GOODSCODE AND PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
		--					--	AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'
		--
		--					UPDATE PRICELIST
		--					SET PL_STATUS = '3'
		--					WHERE PL_NO = @PLNO
		--				END 
		--
		--			SET @MAX = @MAX-1
		--		END
		
			--If (@strVcode = '6665' or @strVcode = '75' or @strVcode = '663' or @strVcode = '47' or @strVcode = '6641' or @strVcode = '7692' or @strVcode = '57' or @strVcode = '806' or @strVcode = '49' or @strVcode = '6644' or @strVcode = '374' or @strVcode = '90' or @strVcode = '6603' or @strVcode = '7941' or @strVcode = '6389')
			--	BEGIN
			--		insert into NURIBOTDB.dbo.TEST_LOG (VCODE,STEP) values(@strVcode, 9)
			--	END
		  End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'T')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = -1, MODCNT = -1, ADDCNT = -1, DELCNT = -1 where no = @strStaticsNo
					END
			End
END

