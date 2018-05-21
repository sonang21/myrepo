/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_UPDATE_CATE_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-09-04 13:35:06.337
 *        Modify: 2017-12-19 10:59:46.63
 *        Backup: 20180521_1737
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_UPDATE_CATE_1]

@strVcode char(4),
@strChkNo int,
@strDutyCode int,
@strStaticsNo int = 0

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @SzQry VARCHAR(3000)	
	DECLARE @ModCnt int
	set @ModCnt = -1
	
	--카테분할 변수
	DECLARE @CateInt int
	DECLARE @CateCnt int
	DECLARE @CATENAME NVARCHAR(100)
	
	--분할처리 변수
	DECLARE @MultiInt int
	DECLARE @MultiCnt int
	DECLARE @MultiStart int 
	DECLARE @MultiEnd int

	DECLARE @SLMAX VARCHAR(20)
	set @SLMAX = '0'

	--로그번호 
	DECLARE @SDate smalldatetime
	select @SDate = sdate from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS where no = @strChkNo
	
	DECLARE @CATE TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		CATE NVARCHAR(100)
	)

	DECLARE @U1 TABLE
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
	
	If @strVcode = '55'
		Begin
			--카테수집
			If @strDutyCode = 0
				Begin
					waitfor delay '00:01:00'
				End 
			Else If @strDutyCode = 1
				Begin	
					waitfor delay '00:00:05'
				End
			Else If @strDutyCode = 2
				Begin	
					waitfor delay '00:00:10'
				End
			Else If @strDutyCode = 3
				Begin	
					waitfor delay '00:00:15'
				End
			Else If @strDutyCode = 4
				Begin	
					waitfor delay '00:00:20'
				End
			Else If @strDutyCode = 5
				Begin	
					waitfor delay '00:00:25'
				End
			Else If @strDutyCode = 6
				Begin	
					waitfor delay '00:00:30'
				End
			Else If @strDutyCode = 7
				Begin	
					waitfor delay '00:00:35'
				End
			Else If @strDutyCode = 8
				Begin	
					waitfor delay '00:00:40'
				End
			Else If @strDutyCode = 9
				Begin	
					waitfor delay '00:00:45'
				End
			
			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from NB01.dbo.TBL_DATA_UPDATE_55 with(readuncommitted)
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE
			on vcode = 55 and cate = catename 
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
			

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U1(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee, delivery_lev, set_yn) 
					select row_number() over(order by pl_no), pl_no, goodsnm
					, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then price else pl_price end) else price end)
					, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
					, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then isnull(coupon,0) else pl_coupon end) else isnull(coupon,0) end)
					, (case pl_nochange when '1' then (case when pl_date < getdate() - 0.02 then price_card else pl_price_card end) else price_card end)
					, isnull(price_mobile,0)
					, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0)
					, delivery_lev, set_yn
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_55 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 55 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B' 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0)
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)
					or pl_delivery_lev <> delivery_lev or isnull(pl_set_yn,'') <> set_yn
					or isnull(pl_category,'') = '' or pl_status in ('3','5')) 
					and cate = @CATENAME option(maxdop 0)
					
					set @ModCnt = @@rowcount

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					
					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							--		from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							, g_minprice3, goodsnm, price, (case when left(g_category,4) = '0304' or left(g_category,4) = '0305' then price else instance_price end)
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
							inner join dbo.goods with(readuncommitted) on pl_modelno = g_modelno
							left outer join dbo.tbl_rt_srv_off_set with(readuncommitted) on left(g_category,4) = category
							where IDX >= @MultiStart and IDX < @MultiEnd and left(g_category,2) <> '93' and pl_goodsnm <> '' and pl_price <> price 
							and ((option_flag2 = '0' and g_minprice / 100 * isnull(limit_pct1,50) > price) 
								or (option_flag2 = '1' and pl_price / 100 * isnull(limit_pct1,50) > price) 
								or (option_flag2 = '0' and (case when left(g_category,4) = '0304' or left(g_category,4) = '0305' then price else instance_price end) > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > (case when left(g_category,4) = '0304' or left(g_category,4) = '0305' then price else instance_price end))) 
							and pl_srvflag = '0' option(maxdop 1)
							
									--insert into logdb.dbo.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_MINPRICE)
									--select sl_plno, sl_modelno, sl_vcode,
									--(case when (isnull(instance_price,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(instance_price,0)) then 'M_NURI_REAL3' else 'PC_NURI_REAL3' end),
									--'1', goodsnm, price, sl_category, instance_price,
									--(case when (isnull(instance_price,0) > 0 and isnull(g_minprice3,0) * 0.5 > isnull(instance_price,0)) then g_minprice3 else g_minprice end)
									--from TBL_STRANGE_LIST with(readuncommitted) inner join @U1
									--on sl_plno = plno
									--inner join dbo.goods with(readuncommitted)
									--on sl_modelno = g_modelno
									--where sl_vcode = @strVcode and sl_srvflag = '3' and IDX >= @MultiStart and IDX < @MultiEnd and sl_no > @SLMAX option(maxdop 1)

							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX )
							--option(maxdop 1)

							--단종3처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,'3'
							--from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
							--and pl_modelno > 0 and pl_srvflag = '0'
							--and ((pl_price * 0.3 > price and left(pl_category,2) in ('08','14'))  or (pl_price * 0.5 > price and left(pl_category,2) not in ('08','14'))) option(maxdop 1)
		
							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
							--option(maxdop 1)
														
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
							pl_coupon = coupon,
							pl_price_card = price_card,
							pl_instance_price = instance_price,
							pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
							pl_delivery_lev = delivery_lev, pl_set_yn = set_yn
							--select count(*)
							from dbo.pricelist with(readuncommitted) inner join @U1
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @strChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END

					set @CateInt = @CateInt + 10
					delete from @U1
				End
		End
	else If @strVcode = '536'
		Begin
			--카테수집
			If @strDutyCode = 0
				Begin
					waitfor delay '00:01:00'
				End 
			Else If @strDutyCode = 1
				Begin	
					waitfor delay '00:00:05'
				End
			Else If @strDutyCode = 2
				Begin	
					waitfor delay '00:00:10'
				End
			Else If @strDutyCode = 3
				Begin	
					waitfor delay '00:00:15'
				End
			Else If @strDutyCode = 4
				Begin	
					waitfor delay '00:00:20'
				End
			Else If @strDutyCode = 5
				Begin	
					waitfor delay '00:00:25'
				End
			Else If @strDutyCode = 6
				Begin	
					waitfor delay '00:00:30'
				End
			Else If @strDutyCode = 7
				Begin	
					waitfor delay '00:00:35'
				End
			Else If @strDutyCode = 8
				Begin	
					waitfor delay '00:00:40'
				End
			Else If @strDutyCode = 9
				Begin	
					waitfor delay '00:00:45'
				End

			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from NB01.dbo.TBL_DATA_UPDATE_536 with(readuncommitted)
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE
			on vcode = 536 and cate = catename 
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

			WHILE @CateInt <= @CateCnt
				Begin	
					set @CATENAME = ''
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U1(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate, price_card, isnull(price_mobile,0)
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_536 with(readuncommitted) 
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 536 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> (case when freeinterest <> '' then '1' else '' end) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0)
					or isnull(pl_category,'') = '' or pl_status in ('3','5'))
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)

					set @ModCnt = @@rowcount
					
					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					
					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							--		from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
									--from TBL_STRANGE_LIST with(readuncommitted) inner join @U1
									--on sl_plno = plno
									--inner join dbo.goods with(readuncommitted)
									--on sl_modelno = g_modelno
									--where sl_vcode = @strVcode and sl_srvflag = '3' and IDX >= @MultiStart and IDX < @MultiEnd and sl_no > @SLMAX option(maxdop 1)

							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX )
							--option(maxdop 1)

							--단종3처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,'3'
							--from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
							--and pl_modelno > 0 and pl_srvflag = '0'
							--and ((pl_price * 0.3 > price and left(pl_category,2) in ('08','14'))  or (pl_price * 0.5 > price and left(pl_category,2) not in ('08','14'))) option(maxdop 1)
		
							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
							--option(maxdop 1)

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
							pl_price_card = price_card,
							pl_instance_price = instance_price,
							pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
							pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), cate, pl_url),
							pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), pl_ca_code_dept)
							--select count(*)
							from dbo.pricelist with(readuncommitted) inner join @U1
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @strChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U1
				End
		End
	else If @strVcode = '4027'
		Begin
			--카테수집
			If @strDutyCode = 0
				Begin
					waitfor delay '00:01:00'
				End 
			Else If @strDutyCode = 1
				Begin	
					waitfor delay '00:00:05'
				End
			Else If @strDutyCode = 2
				Begin	
					waitfor delay '00:00:10'
				End
			Else If @strDutyCode = 3
				Begin	
					waitfor delay '00:00:15'
				End
			Else If @strDutyCode = 4
				Begin	
					waitfor delay '00:00:20'
				End
			Else If @strDutyCode = 5
				Begin	
					waitfor delay '00:00:25'
				End
			Else If @strDutyCode = 6
				Begin	
					waitfor delay '00:00:30'
				End
			Else If @strDutyCode = 7
				Begin	
					waitfor delay '00:00:35'
				End
			Else If @strDutyCode = 8
				Begin	
					waitfor delay '00:00:40'
				End
			Else If @strDutyCode = 9
				Begin	
					waitfor delay '00:00:45'
				End

			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from NB01.dbo.TBL_DATA_UPDATE_4027 with(readuncommitted)
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE
			on vcode = 4027 and cate = catename 
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

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U1(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, instance_price) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate, price_card, isnull(price_mobile,0)
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_4027 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 4027 and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> (case when freeinterest <> '' then '1' else '' end) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0)
					or isnull(pl_category,'') = '' or pl_status in ('3','5'))
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
			
					set @ModCnt = @@rowcount

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					
					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							--		from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
									--from TBL_STRANGE_LIST with(readuncommitted) inner join @U1
									--on sl_plno = plno
									--inner join dbo.goods with(readuncommitted)
									--on sl_modelno = g_modelno
									--where sl_vcode = @strVcode and sl_srvflag = '3' and IDX >= @MultiStart and IDX < @MultiEnd and sl_no > @SLMAX option(maxdop 1)

							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX )
							--option(maxdop 1)

							--단종3처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,'3'
							--from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
							--and pl_modelno > 0 and pl_srvflag = '0'
							--and ((pl_price * 0.3 > price and left(pl_category,2) in ('08','14'))  or (pl_price * 0.5 > price and left(pl_category,2) not in ('08','14'))) option(maxdop 1)
		
							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
							--option(maxdop 1)

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
							pl_price_card = price_card,
							pl_instance_price = instance_price,
							pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
							pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), cate, pl_url),
							pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), pl_ca_code_dept)
							--select count(*)
							from dbo.pricelist with(readuncommitted) inner join @U1
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @strChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U1
				End
		End
	else If @strVcode = '5910'
		Begin
			--카테수집
			If @strDutyCode = 0
				Begin
					waitfor delay '00:01:00'
				End 
			Else If @strDutyCode = 1
				Begin	
					waitfor delay '00:00:05'
				End
			Else If @strDutyCode = 2
				Begin	
					waitfor delay '00:00:10'
				End
			Else If @strDutyCode = 3
				Begin	
					waitfor delay '00:00:15'
				End
			Else If @strDutyCode = 4
				Begin	
					waitfor delay '00:00:20'
				End
			Else If @strDutyCode = 5
				Begin	
					waitfor delay '00:00:25'
				End
			Else If @strDutyCode = 6
				Begin	
					waitfor delay '00:00:30'
				End
			Else If @strDutyCode = 7
				Begin	
					waitfor delay '00:00:35'
				End
			Else If @strDutyCode = 8
				Begin	
					waitfor delay '00:00:40'
				End
			Else If @strDutyCode = 9
				Begin	
					waitfor delay '00:00:45'
				End

			insert into @CATE(CATE) 
			--select (case category when '' then '99' else category end), cate, count(*)
			select cate
			from NB01.dbo.TBL_DATA_UPDATE_5910 with(readuncommitted)
			left outer join NURIBOTDB.dbo.TBL_NB_SHOPCATE
			on vcode = 5910 and cate = catename 
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

			WHILE @CateInt <= @CateCnt
				Begin
					set @CATENAME = ''	
					select @CATENAME = cate from @CATE where idx = @CateInt
					
					insert into @U1(idx, plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, coupon, price_card, instance_price) 
					select row_number() over(order by pl_no), pl_no, goodsnm, price, pl_url, pl_imgurl, pl_account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), pl_goodsfactory, pl_freeinterest, cate, isnull(coupon,0), price_card, isnull(price_mobile,0)
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_UPDATE_5910 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 5910 and pl_goodsnm <> '' and goodsnm is not null
					and (pl_goodsnm <> goodsnm or pl_price <> price or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or isnull(pl_coupon,0) <> isnull(coupon,0) or isnull(pl_price_card,0) <> price_card or isnull(pl_instance_price,0) <> isnull(price_mobile,0)
					or isnull(pl_category,'') = '' or pl_status in ('3','5')) 
					and pl_nochange <> '1' and cate = @CATENAME option(maxdop 0)
								
					set @ModCnt = @@rowcount

					Set @MultiInt = 1
					Set @MultiCnt = (@ModCnt / 100) + 2 
					set @MultiStart = 0
					set @MultiEnd = 100

					
					WHILE @MultiInt < @MultiCnt
						BEGIN
							--모델명 변경 처리
							insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
							select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							--		from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
							from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
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
									--from TBL_STRANGE_LIST with(readuncommitted) inner join @U1
									--on sl_plno = plno
									--inner join dbo.goods with(readuncommitted)
									--on sl_modelno = g_modelno
									--where sl_vcode = @strVcode and sl_srvflag = '3' and IDX >= @MultiStart and IDX < @MultiEnd and sl_no > @SLMAX option(maxdop 1)

							--단종3 로그 처리
							exec UDP_NURIBOT_SRVFLAG3 @strVcode, @SLMAX

							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_no > @SLMAX )
							--option(maxdop 1)

							--단종3처리
							--insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)
							--select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,'3'
							--from dbo.pricelist with(readuncommitted) inner join @U1 on pl_no = plno 
							--where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' 
							--and pl_modelno > 0 and pl_srvflag = '0'
							--and ((pl_price * 0.3 > price and left(pl_category,2) in ('08','14'))  or (pl_price * 0.5 > price and left(pl_category,2) not in ('08','14'))) option(maxdop 1)
		
							--update pricelist set pl_srvflag = '3'
							--where pl_vcode = @strVcode and pl_srvflag = '0' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = @strVcode and sl_srvflag = '3' and sl_date > getdate() - 0.005 )
							--option(maxdop 1)

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
							pl_coupon = coupon,
							pl_price_card = price_card,
							pl_instance_price = instance_price,
							pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0),
							pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), cate, pl_url),
							pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''), pl_ca_code_dept)
							--select count(*)
							from dbo.pricelist with(readuncommitted) inner join @U1
							on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 0)	
							
							--통계처리(전체,추가,수정,삭제)	
							update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @@rowcount
							where no = @strChkNo

							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 100
						END
					set @CateInt = @CateInt + 10
					delete from @U1
				End
		End
	
END

































































































































