/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_SF
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-02-10 11:18:40.637
 *        Modify: 2018-05-03 17:23:35.6
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_SF]

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

				set @strAllCnt = @strAllCnt - @@rowcount
			End
		
		-- '품절'상품삭제
		set @SzQry = N' UPDATE NB02.dbo.' + @strTableName + ' SET PRICE = 1 WHERE PRICE = 0 and CATE in (SELECT CATENAME FROM NURIBOTDB.dbo.TBL_NB_SHOPCATE WITH(READUNCOMMITTED) WHERE  VCODE = '+@strVcode+' and CATEGORY LIKE ''0304%'') OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' WHERE PRICE < 1 OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' WHERE goodsnm = ''null'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' WHERE goodsnm = '''' OPTION (MAXDOP 1)'
		exec(@SzQry)

		--pc가격 = 모바일가격 (6361)홈플러스,(948)팝스포유,(2046)퍼지PC,(2047)팝스디와이,(5978)바보사랑,(6389)패션플러스,(3367)YES24,(4861)알라딘,(6367)교보문고,(6368)영풍문고,(6667)미스터쿤
		If (@strVcode = '6361' or @strVcode = '948' or @strVcode = '2046' or @strVcode = '2047' or @strVcode = '5978' or @strVcode = '6389' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368' or @strVcode = '6667')
			Begin
				set @SzQry = N' UPDATE NB02.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		
			
		--전체개수 체크
		select @NowCnt = count(distinct pl_goodscode) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and pl_srvflag <> 'B' option(maxdop 1)
		
				
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
						set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
						--set @SzQry = N'select count(*)' 
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName + ' with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' and pl_srvflag <> ''M'' and goodscode is null option(maxdop 1)'
				
						exec(@SzQry)
						set @DelCnt = @@rowcount
					End
				Else
					Begin
						set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
						exec(@SzQry)
					End 

				

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
					
				set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD,'
				set @SzQry = @SzQry + N' pl_coupon, pl_instance_price, pl_delivery_lev, pl_set_yn,'
				set @SzQry = @SzQry + N' PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE,' 	
				set @SzQry = @SzQry + N' pl_authdate, pl_airconfeetype)'
				set @SzQry = @SzQry + N' select' 
				set @SzQry = @SzQry + N' 0,'--dbo.UDF_TEST_RTN_MODELNO('+@strVcode+', goodsnm, goodscode),'		--GOODSNM
				set @SzQry = @SzQry + N' '+@strVcode+','
				set @SzQry = @SzQry + N' NURIBOTDB.dbo.UDF_TEST_RTN_CATE_1('+@strVcode+', cate),'	--CATE
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
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB02.dbo.' + @strTableName + ' with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
				set @SzQry = @SzQry + N' where pl_no is null and goodsnm <> '''' option(maxdop 1)'
				
				exec(@SzQry)
				set @AddCnt = @@rowcount
				
				Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)

				--가격
				set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag, sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)'
				set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
				set @SzQry = @SzQry + N' ,(case when (option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) then ''3'' else ''4'' end)'
				set @SzQry = @SzQry + N' ,g_minprice3, goodsnm, price, price_mobile'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB02.dbo.' + @strTableName + ' with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
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
				--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX+') option(maxdop 1)'
				--exec(@SzQry)

				

				--단종3처리
				--set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
				--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno,''3'''
				--set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB02.dbo.' + @strTableName
				--set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'	
				--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> ''''' 
				--set @SzQry = @SzQry + N' and pl_modelno > 0 and pl_srvflag = ''0'''
				--set @SzQry = @SzQry + N' and ((pl_price * 0.3 > price and left(pl_category,2) in (''08'',''14''))  or (pl_price * 0.5 > price and left(pl_category,2) not in (''08'',''14''))) option(maxdop 1)'
				--exec(@SzQry)
				--
				--set @SzQry = N'update pricelist set pl_srvflag = ''3'''
				--set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag = ''0'' and pl_no in (select sl_plno from TBL_STRANGE_LIST where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > getdate() - 0.02) option(maxdop 1)'
				--exec(@SzQry)
				
				set @SzQry = N'update pricelist'
				set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,'
				set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = isnull(factory,''''), pl_freeinterest = freeinterest,'
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
				set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),'
				--카테고리
				set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE_1('+@strVcode+', cate) else pl_category end),'
				--백화점
				set @SzQry = @SzQry + N' pl_store_flag = dbo.UDF_RTN_STORE_FLAG(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''''), cate, pl_url),'
				set @SzQry = @SzQry + N' pl_ca_code_dept = dbo.UDF_RTN_DEPT_CATE(pl_vcode, pl_modelno, pl_goodsnm, goodsnm, isnull(pl_store_flag,''''), pl_ca_code_dept)'
				--select count(*)
				set @SzQry = @SzQry + N', pl_price_card = price_card'
				set @SzQry = @SzQry + N', pl_coupon = isnull(coupon,0)'
				set @SzQry = @SzQry + N', pl_instance_price = isnull(price_mobile,0)'
				set @SzQry = @SzQry + N', pl_delivery_lev = delivery_lev'
				set @SzQry = @SzQry + N', pl_set_yn = isnull(set_yn,'''')'
				set @SzQry = @SzQry + N' ,pl_tag_price = isnull(TAG_PRICE,0), pl_call_plan = isnull(CALL_PLAN,''''), pl_in_fee_yn = isnull(IN_FEE_YN,''''), pl_ship_fee_yn = isnull(SHIP_FEE_YN,''''), pl_bond_fee = isnull(BOND_FEE,0), pl_penality_fee = isnull(PENALITY_FEE,0)'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB02.dbo.' + @strTableName + ' with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
				set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
				set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
				set @SzQry = @SzQry + N' or isnull(pl_goodsfactory,'''') <> isnull(factory,'''') or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or isnull(pl_freeinterest,'''') <> freeinterest or pl_status = ''3'' or pl_status = ''5'' or isnull(pl_category,'''') = '''''
				set @SzQry = @SzQry + N' or isnull(pl_price_card,0) <> price_card'
				set @SzQry = @SzQry + N' or isnull(pl_coupon,0) <> isnull(coupon,0)'
				set @SzQry = @SzQry + N' or isnull(pl_instance_price,0) <> isnull(price_mobile,0)'
				set @SzQry = @SzQry + N' or isnull(pl_delivery_lev,'''') <> delivery_lev'
				set @SzQry = @SzQry + N' or isnull(pl_set_yn,'''') <> isnull(set_yn,'''')'
				set @SzQry = @SzQry + N' or isnull(pl_tag_price,0) <> isnull(TAG_PRICE,0) or isnull(pl_call_plan,'''') <> isnull(CALL_PLAN,'''') or isnull(pl_in_fee_yn,'''') <> isnull(IN_FEE_YN,'''') or isnull(pl_ship_fee_yn,'''') <> isnull(SHIP_FEE_YN,'''') or isnull(pl_bond_fee,0) <> isnull(BOND_FEE,0) or isnull(pl_penality_fee,0) <> isnull(PENALITY_FEE,0)'
				set @SzQry = @SzQry + N' ) and pl_nochange <> ''1'' option(maxdop 1)'
					
				exec(@SzQry)
				set @ModCnt = @@rowcount
										
				

				--SDU삭제 처리
				UPDATE PRICELIST SET PL_STATUS = '3' 
				WHERE PL_VCODE = @strVcode AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND PL_DATE < DATEADD(D, -2,GETDATE()) AND pl_srvflag <> 'M'
				

				--SDU중복 처리
				DECLARE @PLNO BIGINT
				DECLARE @GOODSCODE VARCHAR(50)
				DECLARE @PRICE MONEY
				DECLARE @RIGHTNLEFT CHAR(1)
				DECLARE @DELIVERYINFO NVARCHAR(100) 
				DECLARE @CHKCOUNT INT
				DECLARE @MAX INT

				DECLARE @S TABLE
				(
					IDX INT IDENTITY(1,1),
					PLNO BIGINT,
					GOODSCODE VARCHAR(50),
					PRICE MONEY,
					RIGHTNLEFT CHAR(1),
					DELIVERYINFO NVARCHAR(100) 
				)

				INSERT INTO @S(PLNO, GOODSCODE, PRICE, RIGHTNLEFT, DELIVERYINFO)
					SELECT PL_NO, PL_GOODSCODE, PL_PRICE, PL_RIGHTNLEFT, PL_DELIVERYINFO
					FROM PRICELIST with(readuncommitted) 
					WHERE PL_VCODE= @strVcode AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3'
				
				SET @MAX = @@ROWCOUNT
				
				WHILE @MAX<>0
					BEGIN
						set @CHKCOUNT = 0
						SELECT @PLNO = PLNO, @GOODSCODE = GOODSCODE, @PRICE = PRICE, @RIGHTNLEFT = RIGHTNLEFT, @DELIVERYINFO = DELIVERYINFO
						FROM @S 
						WHERE IDX=@MAX

						SELECT @CHKCOUNT = COUNT(*)
						FROM PRICELIST with(readuncommitted)
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

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = @AddCnt, DELCNT = @DelCnt where no = @strStaticsNo
					END
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

