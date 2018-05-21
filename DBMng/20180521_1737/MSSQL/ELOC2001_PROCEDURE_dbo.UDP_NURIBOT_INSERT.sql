/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_INSERT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-05-23 16:35:50.44
 *        Modify: 2018-05-03 17:23:35.283
 *        Backup: 20180521_1737
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_INSERT]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strStaticsNo int = 0

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		DECLARE @SzQry VARCHAR(3000)
		DECLARE @NowCnt int
		DECLARE @DelCnt int
		DECLARE @ModCnt int
		DECLARE @AddCnt int
		DECLARE @SDate smalldatetime
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
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE PRICE < 1 or PRICE >= 1000000000 OPTION (MAXDOP 1)'
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

		--수정처리
		--set @SzQry = N'update pricelist'
		--set @SzQry = @SzQry + N' set pl_date = getdate(), pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,'
		--	set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,'
		--	--가격체크
		--	set @SzQry = @SzQry + N' pl_status = ''1'','		
		--	--배송체크
		--	set @SzQry = @SzQry + N' pl_deliveryinfo = (case deliveryinfo when '''' then ''유무료'' else deliveryinfo end),'
		--	set @SzQry = @SzQry + N' pl_rightnleft = (case deliveryinfo when ''무료배송'' then ''1'' else ''2'' end),'
		--	--이미지체크
		--	set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
		--	--설치비
		--	set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
		--	--카테고리
		--	set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end)'
		--	--select count(*)
		--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.' + @strTableName
		--	set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodsnm <> '''' and pl_vcode = '+@strVcode
		--	set @SzQry = @SzQry + N' where pl_no > 0 and goodsnm <> '''' and pl_status = ''5'' option(maxdop 1)'
		
		--변경
		--모델명 변경 처리
		set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)'
		set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and replace(pl_goodsnm,'' '','''') <> replace(goodsnm,'' '','''') and pl_modelno > 0 and pl_srvflag = ''0'' option(maxdop 1)'
		exec(@SzQry)
			
		--가격처리
		--		set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
		--		set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
		--		--set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price then ''1'' when g_minprice * 0.95 > price then ''2'' when pl_price * 0.85 > price then ''8'' else '''' end)'
		--		set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price and pl_price * 0.9 > price then ''1'' when pl_price * 0.85 > price then ''7'' else '''' end)'
		--		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
		--		set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		--		set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
		--		set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
		--		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and g_minprice > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' and (pl_status = ''3'' or pl_status = ''5'') option(maxdop 1)'
		--		exec(@SzQry)
		--			
		--		set @SzQry = N'update pricelist set pl_srvflag = ''3'''
		--		set @SzQry = @SzQry + N' where pl_srvflag <> ''3'' and pl_no in (select sl_plno from TBL_STRANGE_LIST inner join NB01.dbo.' + @strTableName + ' on sl_goodscode = goodscode where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_date > getdate() - 0.02) option(maxdop 1)'
		--		exec(@SzQry)

		Select @SLMAX = max(sl_no) From TBL_STRANGE_LIST With(ReadUncommitted)

		If (@strVcode = '55')
			Begin
				set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag,sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)'
				set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
				set @SzQry = @SzQry + N' ,(case when (option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) then ''3'' else ''4'' end)'
				set @SzQry = @SzQry + N' ,g_minprice3, goodsnm, price, (case when left(g_category,4) = ''0304'' or left(g_category,4) = ''0305'' then price else price_mobile end)'
		--		--set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price then ''1'' when g_minprice * 0.95 > price then ''2'' when pl_price * 0.85 > price then ''8'' else '''' end)'
		--		set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price and pl_price * 0.9 > price then ''1'' when pl_price * 0.85 > price then ''7'' else '''' end)'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
				set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
				set @SzQry = @SzQry + N' left outer join dbo.tbl_rt_srv_off_set with(readuncommitted)'
				set @SzQry = @SzQry + N' on left(g_category,4) = category'
				set @SzQry = @SzQry + N' where left(g_category,2) <> ''93'' and pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_price <> price and'
				set @SzQry = @SzQry + N' ((option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price ) or (option_flag2 = ''0'' and (case when left(g_category,2) = ''0304'' or left(g_category,4) = ''0305'' then price else price_mobile end) > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > (case when left(g_category,4) = ''0304'' or left(g_category,2) = ''0305'' then price else price_mobile end)))'
				set @SzQry = @SzQry + N' and pl_srvflag = ''0'' option(maxdop 1)'
				exec(@SzQry)
			End
		else
			Begin
				set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag,sl_minprice, sl_up_goodsnm, sl_up_price, sl_up_price_mobile)'
				set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno'
				set @SzQry = @SzQry + N' ,(case when (option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price) then ''3'' else ''4'' end)'
				set @SzQry = @SzQry + N' ,g_minprice3, goodsnm, price, price_mobile'
		--		--set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price then ''1'' when g_minprice * 0.95 > price then ''2'' when pl_price * 0.85 > price then ''8'' else '''' end)'
		--		set @SzQry = @SzQry + N' ,(case when g_minprice * 0.5 > price and option_flag2 <> ''1'' then ''3'' when g_minprice * 0.9 > price and pl_price * 0.9 > price then ''1'' when pl_price * 0.85 > price then ''7'' else '''' end)'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
				set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
				set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
				set @SzQry = @SzQry + N' left outer join dbo.tbl_rt_srv_off_set with(readuncommitted)'
				set @SzQry = @SzQry + N' on left(g_category,4) = category'
				set @SzQry = @SzQry + N' where left(g_category,2) <> ''93'' and pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_price <> price and'
				set @SzQry = @SzQry + N' ((option_flag2 = ''0'' and g_minprice / 100 * isnull(limit_pct1,50) > price) or (option_flag2 = ''1'' and pl_price / 100 * isnull(limit_pct1,50) > price ) or (option_flag2 = ''0'' and isnull(price_mobile,0) > 0 and isnull(g_minprice3,0) / 100 * isnull(limit_pct1,50) > isnull(price_mobile,0)))'
				set @SzQry = @SzQry + N' and pl_srvflag = ''0'' option(maxdop 1)'
				exec(@SzQry)
			End				
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
		--set @SzQry = @SzQry + N' where pl_no in (select sl_plno from TBL_STRANGE_LIST with(readuncommitted) where sl_vcode = '+@strVcode+' and sl_srvflag = ''3'' and sl_no > '+@SLMAX+') option(maxdop 1)'
		--exec(@SzQry)
				
					
		--변경				
		set @SzQry = N'update pricelist'
		set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,'
		set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = factory,'
		set @SzQry = @SzQry + N' pl_freeinterest = freeinterest,'
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
		set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end)'
		set @SzQry = @SzQry + N', pl_instance_price = isnull(price_mobile,0)'
		--select count(*)
		If (@strVcode = '55' or @strVcode = '57' or @strVcode = '75' or @strVcode = '806' or @strVcode = '974' or @strVcode = '1878' or @strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '49' or @strVcode = '6620' or @strVcode = '47' or @strVcode = '6665' or @strVcode = '90'  or @strVcode = '7797' or @strVcode = '7851' or @strVcode = '7852' or @strVcode = '7935')
			Begin
				set @SzQry = @SzQry + N', pl_price_card = price_card'
				set @SzQry = @SzQry + N', pl_coupon = isnull(coupon,0)'
				set @SzQry = @SzQry + N', pl_delivery_lev = delivery_lev'
				set @SzQry = @SzQry + N', pl_set_yn = isnull(set_yn,'''')'
			End  
		--핸드폰판매가격
		If (@strVcode = '6547' or @strVcode = '7797' or @strVcode = '7935')
			Begin 
				set @SzQry = @SzQry + N' ,pl_tag_price = isnull(TAG_PRICE,0), pl_call_plan = isnull(CALL_PLAN,''''), pl_in_fee_yn = isnull(IN_FEE_YN,''''), pl_ship_fee_yn = isnull(SHIP_FEE_YN,''''), pl_bond_fee = isnull(BOND_FEE,0), pl_penality_fee = isnull(PENALITY_FEE,0)'
			End
		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
		set @SzQry = @SzQry + N' and (pl_status = ''3'' or pl_status = ''5'') and pl_srvflag <> ''B'' option(maxdop 1)'
			
		exec(@SzQry)
		set @ModCnt = @@rowcount
		


		--추가처리
		DECLARE @I TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			IGOODSCODE VARCHAR(50)
		)

		--분할처리 변수
		DECLARE @MultiInt int
		DECLARE @MultiCnt int
		DECLARE @MultiStart int 
		DECLARE @MultiEnd int

		DECLARE @SzQryMulti VARCHAR(2000)
		DECLARE @DutyChar char(1)
		DECLARE @DutyInt int
				
		DECLARE @IChk BIGINT
		select @IChk = max(pl_no) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode
		
		--536,5910,4027,55,806,49,663,75,47,57,90,1878,974
		If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55' or @strVcode = '806' or @strVcode = '49' or @strVcode = '663' or @strVcode = '75' or @strVcode = '47' or @strVcode = '57' or @strVcode = '90' or @strVcode = '1878' or @strVcode = '974' or @strVcode = '6665' or @strVcode = '7851' or @strVcode = '374' or @strVcode = '374' or @strVcode = '6588')
			Begin
				------------------------------------------------------------------------------------------------------------------------------------------
				--536,5910,4027,55
				If (@strVcode = '536')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_536 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 536
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_INSTANCE_PRICE, pl_authdate, pl_airconfeetype, pl_store_flag)
								select 0, 536, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(536 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, (case when freeinterest <> '' then '1' else '' end), dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(price_mobile,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(5910, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_536 with(readuncommitted) 
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
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_5910 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 5910
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
					
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_COUPON, PL_PRICE_CARD, pl_authdate, pl_airconfeetype, pl_store_flag)
								select 0, 5910, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(5910 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), isnull(coupon,0), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(5910, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_5910 with(readuncommitted) 
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
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_4027 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 4027
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
					
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_INSTANCE_PRICE, pl_authdate, pl_airconfeetype, pl_store_flag)
								select 0, 4027, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(4027 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, (case when freeinterest <> '' then '1' else '' end), dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(price_mobile,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(5910, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_4027 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If (@strVcode = '55')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_55 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 55
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_COUPON, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
								select 0, 55, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(55 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), isnull(coupon,0), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_55 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				------------------------------------------------------------------------------------------------------------------------------------------
				--100000개 이상
				Else If (@strVcode = '806')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_806 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 806
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								select 0, 806, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(806 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(806, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_806 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If(@strVcode = '49')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_49 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 49
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
					
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								select 0, 49, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(49 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(49, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_49 with(readuncommitted)
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If(@strVcode = '663')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_663 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 663
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
					
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
								select 0, 663, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(663 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(663, 0, '', goodsnm, '', cate, url), 'N'
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_663 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If(@strVcode = '75')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_75 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 75
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
					
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								select 0, 75, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(75 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(75, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_75 with(readuncommitted)
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If (@strVcode = '47')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_47 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 47
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag)
								select 0, 47, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(47 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(47, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_47 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd

								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If (@strVcode = '374')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_374 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 374
						where pl_no is null and goodscode <> '' option(maxdop 1)
								
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
					End
				Else If (@strVcode = '57')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_57 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 57
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn, pl_store_flag, pl_homeflag)
								select 0, 57, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(57 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn, dbo.UDF_RTN_STORE_FLAG(57, 0, '', goodsnm, '', cate, url), 'N'
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_57 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If(@strVcode = '90')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_90 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 90
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
					
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, pl_authdate, pl_airconfeetype, pl_store_flag)
								select 0, 90, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(90 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), dbo.UDF_RTN_STORE_FLAG(90, 0, '', goodsnm, '', cate, url)
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_90 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If(@strVcode = '1878')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_1878 with(readuncommitted)
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
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_1878 with(readuncommitted) 
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
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_974 with(readuncommitted)
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
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_974 with(readuncommitted) 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				Else If (@strVcode = '6665')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_6665 with(readuncommitted)
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6665
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_INSTANCE_PRICE, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_PRICE_CARD, PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE, PL_COUPON, pl_authdate, pl_airconfeetype, pl_delivery_lev, pl_set_yn)
								select 0, 6665, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6665 , cate), goodsnm, price, url, dbo.UDF_TEST_RTN_SRVFLAG(goodsnm), '2', imgurl, account_yn, isnull(price_mobile,0), factory, goodscode, freeinterest, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) when '무료배송' then '1' else '2' end), price_card, isnull(TAG_PRICE,0), isnull(CALL_PLAN,''), isnull(IN_FEE_YN,''), isnull(SHIP_FEE_YN,''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0), isnull(coupon,0), getdate(), dbo.UDF_RTN_AIRCONFEETYPE(goodsnm), delivery_lev, set_yn
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_6665 with(readuncommitted) 
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
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_7851 with(readuncommitted)
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
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_7851 with(readuncommitted) 
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
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_6588 with(readuncommitted)
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
								from @I Inner join NB01.dbo.TBL_DATA_INSERT_6588 with(readuncommitted) 
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
				If (@strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '6620' or @strVcode = '90' or @strVcode = '6780'  or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7935' or @strVcode = '7941')
					Begin
						set @SzQry = @SzQry + N' pl_coupon, pl_instance_price, pl_delivery_lev, pl_set_yn,'
					End
				--핸드폰판매가격
				If (@strVcode = '6547' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7935')
					begin
						set @SzQry = @SzQry + N' PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE,' 	
					end  
				set @SzQry = @SzQry + N' pl_authdate, pl_airconfeetype'
				--백화점
				If (@strVcode = '6547' or @strVcode = '6588' or @strVcode = '6620')
					begin
						set @SzQry = @SzQry + N' , pl_store_flag'
					end

				set @SzQry = @SzQry + N' ) select' 
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
				If (@strVcode = '6547' or @strVcode = '6588' or @strVcode = '6634' or @strVcode = '6620' or @strVcode = '90' or @strVcode = '6780' or @strVcode = '7692' or @strVcode = '7797' or @strVcode = '7852' or @strVcode = '7935' or @strVcode = '7941')
					Begin
						set @SzQry = @SzQry + N' isnull(coupon,0), isnull(price_mobile,0), delivery_lev, isnull(set_yn,''''),'
					End
				--핸드폰판매가격
				If (@strVcode = '6547' or @strVcode = '6780' or @strVcode = '7797' or @strVcode = '7935')
					begin
						set @SzQry = @SzQry + N' isnull(TAG_PRICE,0), isnull(CALL_PLAN,''''), isnull(IN_FEE_YN,''''), isnull(SHIP_FEE_YN,''''), isnull(BOND_FEE,0), isnull(PENALITY_FEE,0),'
					end  
				set @SzQry = @SzQry + N' getdate(),'
				set @SzQry = @SzQry + N' dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)'
				--백화점
				If (@strVcode = '6547' or @strVcode = '6588' or @strVcode = '6620')
					begin
						set @SzQry = @SzQry + N' ,dbo.UDF_RTN_STORE_FLAG('+ @strVcode +', 0, '''', goodsnm, '''', cate, url)'	
					end
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
		
		--홈쇼핑 처리   (57)Hmall,(75)GS이숍,(663)롯데홈쇼핑, (806)cjmall, (974)NS이숍
		If (@strVcode = '57' or @strVcode = '75' or @strVcode = '663' or @strVcode = '806' or @strVcode = '974' or @strVcode = '6588' or @strVcode = '7851' or @strVcode = '7852' or @strVcode = '7935')
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


		--통계처리(전체,추가,수정,삭제)	
		insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
		values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'I')

		If (@strStaticsNo > 0)
			BEGIN
				update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = @AddCnt, DELCNT = @DelCnt where no = @strStaticsNo
			END
		
		DECLARE @ChkPlnoMax bigint
		If @strVcode = '5910' 
			Begin
				set @ChkPlnoMax = -1
				select @ChkPlnoMax = max(pl_no) from pricelist_make_goodscode with(readuncommitted) where pl_vcode = 5910
				--select @ChkPlnoMax
				insert pricelist_make_goodscode (pl_no, pl_vcode, pl_goodscode, pl_url_goodscode)
				select pl_no, pl_vcode, pl_goodscode, left(replace(pl_url, 'http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&prdNo=',''), charindex('&', replace(pl_url, 'http://www.11st.co.kr/connect/Gateway.tmall?method=Xsite&prdNo=',''))-1) 
				from [dbo].[pricelist] with(readuncommitted) 
				where pl_vcode = 5910  and pl_goodscode like '%[_]%' and pl_no > @ChkPlnoMax
				OPTION (MAXDOP 1)
			End
		
END
















































































































