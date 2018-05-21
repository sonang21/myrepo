/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_UPDATE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-08-08 16:16:08.877
 *        Modify: 2018-03-21 15:09:52.683
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE   PROCEDURE [dbo].[UDP_NURIBOT_UPDATE]

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
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = ''품절'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = '''' OPTION (MAXDOP 1)'
		exec(@SzQry)

		--pc가격 = 모바일가격 (6361)홈플러스,(948)팝스포유,(2046)퍼지PC,(2047)팝스디와이,(5978)바보사랑,(6389)패션플러스,(3367)YES24,(4861)알라딘,(6367)교보문고,(6368)영풍문고,(6667)미스터쿤
		If (@strVcode = '6361' or @strVcode = '948' or @strVcode = '2046' or @strVcode = '2047' or @strVcode = '5978' or @strVcode = '6389' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368' or @strVcode = '6667')
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		
		If @strVcode = '5910'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET deliveryinfo = ''착불'' where deliveryinfo = ''-1'' OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		--디앤샵(1878)		
		If @strVcode = '1878'
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET url = replace(url,''chnl_no=CH15040287'',''chnl_no=CH15020046'') OPTION (MAXDOP 1)'
				exec(@SzQry)
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
		
				UPDATE NB01.DBO.TBL_DATA_UPDATE_6641 SET goodsnm = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(goodsnm,'★','-'),'●','-'),'◆','-'),'■','-'),'▲','-'),'▼','-'),'◀','-'),'▶','-'),'♠','-'),'♥','-'),'♣','-'),'◈','-'),'▣','-'),'⊙','-'),'◐','-'),'◑','-'),'<b>',''),'　',' ') OPTION (MAXDOP 1)

				UPDATE NB01.DBO.TBL_DATA_UPDATE_6641 SET account_yn = 'N' OPTION (MAXDOP 1)
				
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

		-- 핸드폰CPA(75,5910)
		--If @strVcode = '75'
		--	Begin
		--		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''11'' WHERE factory = ''휴대폰1'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''12'' WHERE factory = ''휴대폰2'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''13'' WHERE factory = ''휴대폰3'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--	End
		--Else If @strVcode = '5910'
		--	Begin
		--		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET factory = ''21'' WHERE factory = ''휴대폰1'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--	End

		--536업체 품절처리 임시
		--If (@strVcode = '536')
		--	Begin
		--		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE PRICE < 1000 AND DELIVERYINFO = ''무료배송'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--	End
		--55업체 배송처리 임시
		--If (@strVcode = '55')
		--	Begin
		--		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET DELIVERYINFO = ''무료배송'' WHERE DELIVERYINFO = ''0'' OPTION (MAXDOP 1)'
		--		exec(@SzQry)
		--	End		

		
		--전체개수 체크
		--select @NowCnt = count(pl_no) 
		--from dbo.pricelist with(readuncommitted)
		--where pl_vcode  = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
		

		If (@UpdateChk = '1')
			Begin
				--홈쇼핑 처리   (57)Hmall,(75)GS이숍,(663)롯데홈쇼핑
				If (@strVcode = '57' or @strVcode = '75' or @strVcode = '663' or @strVcode = '806' or @strVcode = '974' or @strVcode = '6588' or @strVcode = '7851' or @strVcode = '7852')
					Begin
						set @SzQry = N'update pricelist'
						set @SzQry = @SzQry + N' set pl_date = getdate(),'
						--가격체크
						set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'		
						--홈쇼핑처리
						set @SzQry = @SzQry + N' pl_homeflag = homeflag'		
						--select count(*)
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
						set @SzQry = @SzQry + N' and isnull(pl_homeflag,''N'') <> homeflag option(maxdop 1)'
						exec(@SzQry)
					End
				
				--수정처리 분할
				DECLARE @MultiInt int
				DECLARE @MultiCnt int
				DECLARE @MultiStart int 
				DECLARE @MultiEnd int
				
				If (@strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '55' or @strVcode = '1878' or @strVcode = '806' or @strVcode = '663' or @strVcode = '47' or @strVcode = '75' or @strVcode = '90' or @strVcode = '49' or @strVcode = '57' or @strVcode = '6361' or @strVcode = '974' or @strVcode = '6389' or @strVcode = '6620' or @strVcode = '7851' or @strVcode = '374' or @strVcode = '6665' or @strVcode = '6641' or @strVcode = '6508')
					Begin
						DECLARE @U TABLE
						(
							IDX INT IDENTITY(1,1) PRIMARY KEY,
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
							COUPON tinyint,
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

						--536,5910,4027,55  분할 처리
						If @strVcode = '536'
							begin 
								delete NB01.dbo.TBL_DATA_UPDATE_536 where goodscode = '630692532' and goodscode_cs = checksum('630692532')
							End
						If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55')
							begin
								set @ModCnt = 0
							end
						else If @strVcode = '4027'
							begin 
								Set @MultiInt = 1
								Set @MultiCnt = (@strAllCnt / 500000) + 2 
								set @MultiStart = 0
								set @MultiEnd = 500000
								WHILE @MultiInt < @MultiCnt
									BEGIN
										insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card) 
										select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate, price_card
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_4027 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 4027 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
										and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
										or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> (case when freeinterest <> '' then '1' else '' end) or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
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
										insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
										select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_536 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 536 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
										and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
										or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> (case when freeinterest <> '' then '1' else '' end) or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
										and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										
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
 										insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card) 
										select pl_no, goodsnm, price, pl_url, pl_imgurl, pl_account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), pl_goodsfactory, pl_freeinterest, cate, isnull(coupon,0), price_card
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_5910 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 5910 and pl_goodsnm <> '' and goodsnm is not null 
										and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
										and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										--insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
										--select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
										--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_5910
										--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										--where pl_vcode = 5910 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
										--and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
										--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
										--and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										
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
										insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, instance_price, delivery_lev, set_yn) 
										select pl_no, goodsnm
										, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then price else pl_price end) else price end)
										, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
										, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then isnull(coupon,0) else pl_coupon end) else isnull(coupon,0) end)
										, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then price_card else pl_price_card end) else price_card end)
										, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0)
										, isnull(price_mobile,0), delivery_lev, set_yn
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_55 with(readuncommitted)
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 55 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
										and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
										or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
										or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
										or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
										or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
										and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										
										set @ModCnt = @ModCnt + @@rowcount
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 500000
									END
							end
						else If @strVcode = '1878'
							begin 
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_1878 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 1878 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						----
						else If @strVcode = '806'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_806 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 806 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '663'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_663 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 663 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '47'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_47 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 47 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '374'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_374 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 374 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6665'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_6665 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6665 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end	
						else If @strVcode = '75'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_75 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 75 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '90'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_90 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 90 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '49'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_49 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 49 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '57'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_57 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 57 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6361'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_6361 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6361 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '974'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_974 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 974 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end						
						else If @strVcode = '6389'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_6389 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6389 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end	
						else If @strVcode = '6620'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_6620 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6620 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end		
						else If @strVcode = '7851'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, isnull(coupon,0), price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_7851 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 7851 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end		
						else If @strVcode = '6641'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn, MOBILE_URL) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn, isnull(MOBILE_URL,'')
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_6641 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6641 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn or isnull(pl_mobile_url,'') <> isnull(MOBILE_URL,'')
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end
						else If @strVcode = '6508'
							begin
								insert into @U(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
								select pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_6508 with(readuncommitted)
								on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
								where pl_vcode = 6508 and pl_goodsnm <> '' and goodsnm is not null 
								and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
								or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
								or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn 
								or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') and pl_nochange <> '1' option(maxdop 1)
								
								set @ModCnt = @@rowcount
							end									
						
						Set @MultiInt = 1
						Set @MultiCnt = (@ModCnt / 100) + 2 
						set @MultiStart = 0
						set @MultiEnd = 100

						WHILE @MultiInt < @MultiCnt
							BEGIN
								BEGIN TRY
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
									--		--10% pl_status:P
									--		--when g_minprice * 0.9 > price then '1'
									--		-- 5% pl_status:F
									--		--when g_minprice * 0.95 > price then '2' 
									--		when g_minprice * 0.9 > price and pl_price * 0.9 > price then '1'
									--		--30% 자신가격 pl_status:8
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
									--		where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
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
									--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX )
									--option(maxdop 1)

									

									--무료<유료 최저가 처리(최저가 5%)
									--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
									--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '2'
									--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
									--inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
									--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = '무료배송' and g_mallcnt > 1 and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
									--		
									--가격 변경 처리(최저가 10%)
									--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
									--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, '1'
									--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
									--inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
									--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = '0' and catalog_flag = '0' option(maxdop 1)
									--가격 변경 처리 (삭제)
									--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '08%'
									--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '12%'
									--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '14%'
									--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '16%'
									--delete TBL_STRANGE_LIST where sl_srvflag = 'P' and sl_category like '0501%'

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

									If @strVcode = '6641'
										Begin
											update pricelist
											set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
											pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
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
											pl_instance_price = instance_price,
											pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
											pl_delivery_lev = delivery_lev, pl_set_yn = isnull(set_yn,''), pl_mobile_url = isnull(mobile_url,'')
											--select count(*)
											from dbo.pricelist with(readuncommitted) inner join @U
											on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
										End
									else
										Begin
											update pricelist
											set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
											pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
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
											pl_instance_price = instance_price,
											pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
											pl_delivery_lev = delivery_lev, pl_set_yn = isnull(set_yn,'')
											--select count(*)
											from dbo.pricelist with(readuncommitted) inner join @U
											on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
										End

									set @MultiInt = @MultiInt + 1
									set @MultiStart = @MultiEnd
									set @MultiEnd = @MultiInt * 100
								END TRY
								BEGIN CATCH
									set @MultiInt = @MultiInt + 1
									set @MultiStart = @MultiEnd
									set @MultiEnd = @MultiInt * 100	
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
							If (@strVcode = '0000')
								Begin
									set @SzQry = @SzQry + N' and homeflag = ''U'''
								End
							set @SzQry = @SzQry + N' option(maxdop 1)'
						exec(@SzQry)
						
						--가격처리
						--		set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--		set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
						--		set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price and pl_price * 0.9 > price then ''1'' when pl_price * 0.85 > price then ''7'' else '''' end)'
						--		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--		set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--		set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						--		set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and g_minprice > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' option(maxdop 1)'
						--		exec(@SzQry)
						--					
						--		set @SzQry = N'update pricelist set pl_srvflag = ''3'''
						--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > - 0.02)'
						--		If (@strVcode = '0000')
						--			Begin
						--				set @SzQry = @SzQry + N' and homeflag = ''U'''
						--			End
						--		set @SzQry = @SzQry + N' option(maxdop 1)'
						--		exec(@SzQry)		

						Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)

						set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)'
						set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
						set @SzQry = @SzQry + N' ,(case when (option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) then ''3'' else ''4'' end)'
						set @SzQry = @SzQry + N' ,g_minprice3, goodsnm, price, price_mobile'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						set @SzQry = @SzQry + N' left outer join dbo.tbl_rt_srv_off_set with(readuncommitted)'
						set @SzQry = @SzQry + N' on left(g_category,4) = category'
						set @SzQry = @SzQry + N' where left(g_category,2) <> ''93'' and pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and pl_price <> price'
						set @SzQry = @SzQry + N' and ((option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''0'' and isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > isnull(price_mobile,0)))'
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
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX+')'
						--set @SzQry = @SzQry + N' option(maxdop 1)'
						--exec(@SzQry)		

						
						--무료<유료 최저가 처리(최저가 5%)
						--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--	set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''2'''
						--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--	set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						--	set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and price < 100000 and g_minprice * 0.95 > price and g_minprice * 0.9 < price and pl_deliveryinfo = ''무료배송'' and g_mallcnt > 1 and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' option(maxdop 1)'
						--exec(@SzQry)

						--가격 변경 처리(최저가 10%)
						--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--	set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''1'''
						--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--	set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
						--	set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
						--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' option(maxdop 1)'
						--exec(@SzQry)


						--단종3처리
						--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
						--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno, ''3'''
						--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						--set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and pl_modelno > 0 and pl_srvflag = ''0'''
						--set @SzQry = @SzQry + N' and ((pl_price * 0.3 > price and left(pl_category,2) in (''08'',''14''))  or (pl_price * 0.5 > price and left(pl_category,2) not in (''08'',''14''))) option(maxdop 1)'
						--exec(@SzQry)
						--
						--set @SzQry = N'update pricelist set pl_srvflag = ''3'''
						--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > - 0.02)'
						--set @SzQry = @SzQry + N' option(maxdop 1)'
						--exec(@SzQry)		
						
						--수정처리
						set @SzQry = N'update pricelist'
						set @SzQry = @SzQry + N' set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,'
						set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,'
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
						--쿠폰가
						If (@strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '6620' or @strVcode = '7455' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7908' or @strVcode = '7941')
							Begin
								set @SzQry = @SzQry + N', pl_coupon = isnull(coupon,0)'
								set @SzQry = @SzQry + N', pl_instance_price = isnull(price_mobile,0)'
								set @SzQry = @SzQry + N', pl_delivery_lev = delivery_lev'
								set @SzQry = @SzQry + N', pl_set_yn = isnull(set_yn,'''')'
							End
						If (@strVcode = '6780')
							Begin
								set @SzQry = @SzQry + N', pl_coupon = isnull(coupon,0)'
								set @SzQry = @SzQry + N', pl_delivery_lev = delivery_lev'
								set @SzQry = @SzQry + N', pl_set_yn = isnull(set_yn,'''')'
							End
						If (@strVcode = '974' or @strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '6620' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7908')
							Begin
								set @SzQry = @SzQry + N', pl_price_card = price_card'
							End
						--핸드폰판매가격
						If (@strVcode = '6547' or @strVcode = '7797')
							Begin 
								set @SzQry = @SzQry + N' ,pl_tag_price = isnull(TAG_PRICE,0), pl_call_plan = isnull(CALL_PLAN,''''), pl_in_fee_yn = isnull(IN_FEE_YN,''''), pl_ship_fee_yn = isnull(SHIP_FEE_YN,''''), pl_bond_fee = isnull(BOND_FEE,0), pl_penality_fee = isnull(PENALITY_FEE,0)'
							End

						--MOBILE_URL
						If (@strVcode = '6641')
							Begin 
								set @SzQry = @SzQry + N',pl_instance_price = isnull(price_mobile,0)'
								set @SzQry = @SzQry + N',pl_mobile_url = isnull(mobile_url,'''')'
							End

						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
						set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
						set @SzQry = @SzQry + N' or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or isnull(pl_freeinterest,'''') <> freeinterest or pl_status = ''3'' or pl_status = ''5'' or isnull(pl_category,'''') = '''''
						--쿠폰가
						If (@strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '6620' or @strVcode = '7455' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7908' or @strVcode = '7941')
							Begin
								set @SzQry = @SzQry + N' or isnull(pl_coupon,0) <> isnull(coupon,0)'
								set @SzQry = @SzQry + N' or pl_instance_price <> isnull(price_mobile,0)'
								set @SzQry = @SzQry + N' or isnull(pl_delivery_lev,'''') <> delivery_lev'
								set @SzQry = @SzQry + N' or isnull(pl_set_yn,'''') <> isnull(set_yn,'''')'
							End
						If (@strVcode = '6780')
							Begin
								set @SzQry = @SzQry + N' or isnull(pl_coupon,0) <> isnull(coupon,0)'
								set @SzQry = @SzQry + N' or isnull(pl_delivery_lev,'''') <> delivery_lev'
								set @SzQry = @SzQry + N' or isnull(pl_set_yn,'''') <> isnull(set_yn,'''')'
							End
						If (@strVcode = '974' or @strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '6620' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7908')
							Begin
								set @SzQry = @SzQry + N' or isnull(pl_price_card,0) <> isnull(price_card,0)'
							End
						--핸드폰판매가격
						If (@strVcode = '6547' or @strVcode = '7797')
							Begin 
								set @SzQry = @SzQry + N' or isnull(pl_tag_price,0) <> isnull(TAG_PRICE,0) or isnull(pl_call_plan,'''') <> isnull(CALL_PLAN,'''') or isnull(pl_in_fee_yn,'''') <> isnull(IN_FEE_YN,'''') or isnull(pl_ship_fee_yn,'''') <> isnull(SHIP_FEE_YN,'''') or isnull(pl_bond_fee,0) <> isnull(BOND_FEE,0) or isnull(pl_penality_fee,0) <> isnull(PENALITY_FEE,0)'
							End
						--MOBILE_URL
						If (@strVcode = '6641')
							Begin 
								set @SzQry = @SzQry + N' or pl_instance_price <> isnull(price_mobile,0)'
								set @SzQry = @SzQry + N' or isnull(pl_mobile_url,'''') <> isnull(mobile_url,'''')'
							End


						set @SzQry = @SzQry + N' ) and pl_nochange <> ''1'''
						If (@strVcode = '0000')
							Begin
								set @SzQry = @SzQry + N' and homeflag = ''U'''
							End						
						set @SzQry = @SzQry + N' option(maxdop 1)'
							
						exec(@SzQry)
						set @ModCnt = @@rowcount
					END	
				
				
				--4027 웹비로그 남기기
				If (@strVcode = '4027')
					Begin
						set @SzQry = N' insert into WEBBDB.dbo.TBL_WEBB_LOG(WE_VCODE, WE_ERRID, WE_ERRNO, WE_ERRCONTENTS, WE_FLAG)'
						set @SzQry = @SzQry + N' values('+@strVcode+', 9, ''0'', ''변경주기완료-'+cast(@strAllCnt as varchar)+'.'', 2)'
						exec(@SzQry)

					--	UPDATE NURIBOTDB.dbo.TBL_NB_RESERVATION SET SRVFLAG = '1' WHERE GROUPINFO = 'B8' AND STATUSFLAG = 'U'
					End		
				

				--naver_xml
				If (@strVcode = '6508')
					Begin
						--삭제
						set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
						--set @SzQry = N'select count(*)' 
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' and pl_srvflag <> ''M'' and goodscode is null and homeflag = ''D'' option(maxdop 1)'
				
						exec(@SzQry)
						set @DelCnt = @@rowcount

						--추가
						set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD,'
						set @SzQry = @SzQry + N' pl_coupon, pl_instance_price, pl_delivery_lev, pl_set_yn,'
						set @SzQry = @SzQry + N' PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE,' 	
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
						set @SzQry = @SzQry + N' isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,''''),'
						set @SzQry = @SzQry + N' isnull(TAG_PRICE,0), isnull(CALL_PLAN,''''), isnull(IN_FEE_YN,''''), isnull(SHIP_FEE_YN,''''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0),'
						set @SzQry = @SzQry + N' getdate(),'
						set @SzQry = @SzQry + N' dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
						set @SzQry = @SzQry + N' where pl_no is null and goodsnm <> '''' and homeflag = ''I'' option(maxdop 1)'
						
						exec(@SzQry)
						set @AddCnt = @@rowcount
					End


				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, -1, -1, @SDate, 'U')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = -1, DELCNT = -1 where no = @strStaticsNo
					END
			End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'U')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = -1, MODCNT = -1, ADDCNT = -1, DELCNT = -1 where no = @strStaticsNo
					END
			End
END









































































































