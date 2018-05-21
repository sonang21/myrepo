/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_10
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-08-04 15:37:12.46
 *        Modify: 2018-03-13 09:27:02.43
 *        Backup: 20180521_1739
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_10]

@strVcode char(4),
@strChkNo int,
@strDutyCode int,
@strStaticsNo int = 0


AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @SzQry VARCHAR(3000)	
	DECLARE @NowCnt int
	DECLARE @AllCnt int

	DECLARE @ModCnt int
	set @ModCnt = 0

	DECLARE @DelCnt int
	set @DelCnt = 0
	DECLARE @AddCnt int
	set @AddCnt = 0
		
	--카테분할 변수
	DECLARE @CateInt int
	DECLARE @CateCnt int
	DECLARE @CATENAME NVARCHAR(100)
	
	--분할처리 변수
	DECLARE @MultiInt int
	DECLARE @MultiCnt int
	DECLARE @MultiStart int 
	DECLARE @MultiEnd int
		
	--로그 
	UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_S3_1 = GETDATE() WHERE STEP_S3_1 is null and NO = @strChkNo

	--로그번호 
	DECLARE @ChkNo int
	DECLARE @SDate smalldatetime
	DECLARE @SLMAX VARCHAR(10)
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
		SET_YN char(1),
		MOBILE_URL VARCHAR(500)
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
	
	If @strVcode = '6665'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6665 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 6665 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
						
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6665 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 6665 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6665
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
							select 0, 6665, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6665 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6665 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6665 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 6665 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '75'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 75 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 75 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
									
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 75 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 75 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 75
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
							select 0, 75, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(75 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(75, 0, '', goodsnm, '', cate, url)
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 75 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_75 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 75 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '663'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 663 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 663 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)

					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 663 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 663 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 663
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
							select 0, 663, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(663 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(663, 0, '', goodsnm, '', cate, url), 'N'
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 663 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_663 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 663 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '47'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 47 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 47 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
									
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 47 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 47 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)

							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 47
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
							select 0, 47, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(47 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(47, 0, '', goodsnm, '', cate, url)
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 47 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_47 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 47 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '6641'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6641 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
			
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn, MOBILE_URL) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn, isnull(MOBILE_URL,'')
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 6641 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn or isnull(pl_mobile_url,'') <> isnull(MOBILE_URL,'')
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
						
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6641 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 6641 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6641
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_mobile_url)
							select 0, 6641, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6641 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, MOBILE_URL 
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6641 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn, MOBILE_URL) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn, isnull(MOBILE_URL,'')
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6641 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 6641 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn or isnull(pl_mobile_url,'') <> isnull(MOBILE_URL,'')
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
						
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '57'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 57 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 57 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
														
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 57 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 57 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 57
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
							select 0, 57, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(57 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(57, 0, '', goodsnm, '', cate, url), 'N'
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																																	
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 57 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_57 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 57 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '806'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 806 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 806 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)								
									
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 806 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 806 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 806
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
							select 0, 806, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(806 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(806, 0, '', goodsnm, '', cate, url)
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 806 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_806 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 806 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)								
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '7692'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 7692 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 7692 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
						
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 7692 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 7692 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 7692
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
							select 0, 7692, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7692 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 7692 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_7692 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 7692 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '49'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 49 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 49 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
									
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 49 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 49 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 49
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
							select 0, 49, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(49 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(49, 0, '', goodsnm, '', cate, url)
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 49 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_49 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 49 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
								
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '6644'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6644 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 6644 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
						
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6644 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 6644 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6644
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
							select 0, 6644, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6644 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 6644 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price, coupon, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(price_mobile,0), isnull(coupon,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_6644 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 6644 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0)
					or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '') 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '374'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 374 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
		
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 374 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
						
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 374 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 374 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 374
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype)
							select 0, 374, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(374 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 374 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_374 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 374 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
					
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End
	else If @strVcode = '90'
		Begin
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 90 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT > -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC
			
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
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
						
			--가격비교
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 90 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno > 0 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
										
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							--from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 and pl_srvflag = '0' option(maxdop 1)
							
							--가격처리
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
							
							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
			
			UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_1 = GETDATE(), STEP_S3_2 = (case when STEP_S3_2 is null then GETDATE() else STEP_S3_2 end) WHERE NO = @strChkNo

			--일반상품
			If @strDutyCode = 0
				Begin	
					Set @CateInt = 1
					
					select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 90 and STATUSFLAG = 'T' and AllCNT > 0 and MODCNT = -1 and ADDCNT = 0 and DELCNT = 0 order by NO DESC

					--삭제
					select top 1 @NowCnt = ALLCNT from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where VCODE = @strVcode and STATUSFLAG = 'T' and ALLCNT * 0.1 > DELCNT and DELCNT > 0 order by NO desc
					select @AllCnt = count(*) from NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
					
					If (@AllCnt >= @NowCnt * 0.9)
						Begin
							insert into @D(plno)
							select pl_no
							from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
							on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
							where pl_vcode = 90 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'M' and goodscode is null
							option(maxdop 1)
							set @DelCnt = @@rowcount

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

					--추가
					insert into @I (IGOODSCODE)
					select goodscode
					from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 90
					where pl_no is null and goodscode <> '' 
					option(maxdop 1)
					set @AddCnt = @@rowcount
								
					Set @MultiInt = 1
					Set @MultiCnt = (@AddCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300
					WHILE @MultiInt < @MultiCnt
						BEGIN
							insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype, pl_store_flag)
							select 0, 90, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(90 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(90, 0, '', goodsnm, '', cate, url)
							from @I Inner join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted) 
							On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																																																							
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
						END
					--통계처리(전체,추가,수정,삭제)	
					update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), DELCNT = @DelCnt, ADDCNT = @AddCnt
					where no = @ChkNo
				End
			Else If @strDutyCode = 1
				Begin	
					Set @CateInt = 2
				End
			Else If @strDutyCode = 2
				Begin	
					Set @CateInt = 3
				End
			Else If @strDutyCode = 3
				Begin	
					Set @CateInt = 4
				End
			Else If @strDutyCode = 4
				Begin	
					Set @CateInt = 5
				End
			Else If @strDutyCode = 5
				Begin	
					Set @CateInt = 6
				End
			Else If @strDutyCode = 6
				Begin	
					Set @CateInt = 7
				End
			Else If @strDutyCode = 7
				Begin	
					Set @CateInt = 8
				End
			Else If @strDutyCode = 8
				Begin	
					Set @CateInt = 9
				End
			Else If @strDutyCode = 9
				Begin	
					Set @CateInt = 10
				End
			
			select top 1 @ChkNo = no from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted) where vcode = 90 and STATUSFLAG = 'T' and AllCNT > 0 and ADDCNT = -1 and DELCNT = -1 order by NO DESC
			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, coupon, instance_price, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(coupon,0), isnull(price_mobile,0), delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_90 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 90 and pl_goodsnm <> '' and goodsnm is not null and pl_modelno < 1 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_freeinterest,'') <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or isnull(pl_delivery_lev,'') <> delivery_lev or isnull(pl_set_yn,'') <> set_yn	
					or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount
					UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET MODCNT = MODCNT + @ModCnt WHERE NO = @strChkNo
							
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist
							set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
							pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
							pl_date = getdate(),
							--가격체크
							pl_status = (case pl_status when '8' then '9' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
							--배송체크
							pl_deliveryinfo = deliveryinfo,
							pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
							--이미지체크
							pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
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
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @ChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U
				End
		End

	UPDATE NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST SET STEP_E3_2 = GETDATE(), ADDCNT = ADDCNT + @AddCnt, DELCNT = DELCNT + @DelCnt WHERE NO = @strChkNo	
END



