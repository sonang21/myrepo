/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_OLD
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2007-09-12 14:21:22.28
 *        Modify: 2018-05-03 17:23:35.9
 *        Backup: 20180521_1739
 ************************************************************************* */







CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_OLD]

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
			
		--중복자료 삭제(전업체 설정)
		DECLARE @ChkDuty int
		set @ChkDuty = -1

		set @SzQry = N' select top 1 nbd_goodsnm'
		set @SzQry = @SzQry + N' from NB02.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' group by nbd_goodsnm'
		set @SzQry = @SzQry + N' having count(*) > 1' 
		exec(@SzQry)
		
		set @ChkDuty = @@rowcount

		If ( @ChkDuty > 0 )
			Begin
				set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' FROM NB02.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select nbd_goodsnm as nbd_goodsnm, min(nbd_price) as nbd_price, max(nbd_no) as no from NB02.dbo.' + @strTableName + ' with(readuncommitted) group by nbd_goodsnm having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.nbd_goodsnm = B.nbd_goodsnm WHERE A.nbd_price <> B.nbd_price'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @strAllCnt = @strAllCnt - @@rowcount

				set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' FROM NB02.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select nbd_goodsnm as nbd_goodsnm, min(nbd_no) as nbd_no from NB02.dbo.' + @strTableName + ' with(readuncommitted) group by nbd_goodsnm having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.nbd_goodsnm = B.nbd_goodsnm WHERE A.nbd_no <> B.nbd_no'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @strAllCnt = @strAllCnt - @@rowcount
			End


		-- '품절'상품삭제
		--set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' WHERE nbd_goodsnm like ''%품절%''  OPTION (MAXDOP 1)'
		--exec(@SzQry)
		set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' WHERE nbd_goodsnm = ''null'' OPTION (MAXDOP 1)'
		exec(@SzQry)

		--전체개수 체크
		select @NowCnt = count(distinct pl_goodsnm) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode  = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3'  option(maxdop 1)
				
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
		--		--set @SzQry = N'select @count = count(pl_no)'
		--		--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName
		--		--	set @SzQry = @SzQry + N' on pl_goodsnm = nbd_goodsnm'
		--		--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and nbd_goodsnm is not null and pl_nochange <> ''1'' and pl_price <> nbd_price option(maxdop 1)'
		--		--
		--		--EXEC sp_ExecuteSQL @SzQry, N'@count INT OUTPUT', @count=@PriceModCnt OUTPUT
		--		--가격변경 개수 수집
		--		set @SzQry = N'select pl_no'
		--			set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName
		--			set @SzQry = @SzQry + N' on on pl_goodsnm = nbd_goodsnm'
		--			set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and nbd_goodsnm is not null and pl_nochange <> ''1'' and pl_price <> nbd_price option(maxdop 1)'
		--		exec(@SzQry)
		--		set @PriceModCnt = @@rowcount			
		--		
		--		If(@PriceModCnt > @NowCnt/2)
		--			Set @UpdateChk = '0'
		--	End
		
		--55업체 배송처리 임시
		
		If (@UpdateChk = '1')
			Begin
				--삭제처리 
				If (@strAllCnt >= @NowCnt * 0.9)
					begin
						set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
						--set @SzQry = N'select count(*)' 
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodsnm = nbd_goodsnm and pl_goodsnm_cs = nbd_goodsnm_cs'
						set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' and pl_srvflag <> ''B'' and nbd_goodsnm is null option(maxdop 1)'
						
						exec(@SzQry)
						set @DelCnt = @@rowcount
					End
				Else
					Begin
						set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
						exec(@SzQry)
					End 
				

				--추가처리
				DECLARE @IChk BIGINT
				select @IChk = max(pl_no) 
				from dbo.pricelist with(readuncommitted)
				where pl_vcode = @strVcode
				
				set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT,'
				--핸드폰판매가격
				If (@strVcode = '2562' or @strVcode = '5843' or @strVcode = '6063' or @strVcode = '6469')
					begin
						set @SzQry = @SzQry + N' PL_TAG_PRICE, PL_CALL_PLAN, PL_IN_FEE_YN, PL_SHIP_FEE_YN, PL_BOND_FEE, PL_PENALITY_FEE,' 	
					end
				set @SzQry = @SzQry + N' pl_authdate, pl_airconfeetype)'
				set @SzQry = @SzQry + N' select' 
				--funshop 예외처리
				If @strVcode = '6237' 
					begin 
						set @SzQry = @SzQry + N' -5,'
					end
				else
					begin 
						set @SzQry = @SzQry + N' 0,'--dbo.UDF_TEST_RTN_MODELNO('+@strVcode+', goodsnm, goodscode),'	--GOODSNM
					end
				set @SzQry = @SzQry + N' '+@strVcode+','
				set @SzQry = @SzQry + N' isnull(nbd_category,''''),'--CATE
				set @SzQry = @SzQry + N' nbd_goodsnm,'
				set @SzQry = @SzQry + N' nbd_price,'
				set @SzQry = @SzQry + N' nbd_url,'
				--funshop 예외처리
				If @strVcode = '6237' 
					begin 
						set @SzQry = @SzQry + N' ''9'','
					end
				--제조사상품처리
				else If (@strVcode = '169' or @strVcode = '6287' or @strVcode = '896' or @strVcode = '1621' or @strVcode = '780' or @strVcode = '1624' or @strVcode = '1752' or @strVcode = '1538' or @strVcode = '2281' or @strVcode = '2285' or @strVcode = '2287')
					begin 
						set @SzQry = @SzQry + N' (case when nbd_rightnleft = ''S'' then ''4'' else dbo.UDF_TEST_RTN_SRVFLAG(nbd_goodsnm) end),'
					end
				else
					begin 
						set @SzQry = @SzQry + N' dbo.UDF_TEST_RTN_SRVFLAG(nbd_goodsnm),'
					end
				set @SzQry = @SzQry + N' ''2'','
				set @SzQry = @SzQry + N' nbd_imgurl,'
				set @SzQry = @SzQry + N' nbd_account_yn,'
				set @SzQry = @SzQry + N' nbd_factory,'
				set @SzQry = @SzQry + N' nbd_goodscode,'
				set @SzQry = @SzQry + N' nbd_freeinterest,'
				--배송체크
				set @SzQry = @SzQry + N' dbo.UDF_RTN_DELIVERYINFO(isnull(nbd_deliveryinfo,'''')),'
				set @SzQry = @SzQry + N' (case dbo.UDF_RTN_DELIVERYINFO(isnull(nbd_deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
				--핸드폰판매가격
				If (@strVcode = '2562' or @strVcode = '5843' or @strVcode = '6063' or @strVcode = '6469')
					begin
						set @SzQry = @SzQry + N' isnull(nbd_TAG_PRICE,0), isnull(nbd_CALL_PLAN,''''), isnull(nbd_IN_FEE_YN,''''), isnull(nbd_SHIP_FEE_YN,''''), isnull(nbd_BOND_FEE,0), isnull(nbd_PENALITY_FEE,0),'
					end
				set @SzQry = @SzQry + N' getdate(),'
				set @SzQry = @SzQry + N' dbo.UDF_RTN_AIRCONFEETYPE(nbd_goodsnm)'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB02.dbo.' + @strTableName
				set @SzQry = @SzQry + N' on pl_goodsnm = nbd_goodsnm and pl_goodsnm_cs = nbd_goodsnm_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
				set @SzQry = @SzQry + N' where pl_no is null and nbd_goodsnm <> '''''
				
				exec(@SzQry)
				set @AddCnt = @@rowcount

				--추가상품 입력
				--insert into pricelist_search_target(pl_no, pl_modelno, pl_category, pl_goodsnm, pl_goodsfactory, pl_price, status, pl_vcode)
				--select pl_no, pl_modelno, pl_category, pl_goodsnm, pl_goodsfactory, pl_price, 'I', pl_vcode
				--from pricelist with(readuncommitted)
				--where  pl_vcode = @strVcode and pl_no > @IChk and pl_goodsnm <> '' and pl_modelno < 1
				
				--카테고리처리
				set @SzQry = @SzQry + N' update pricelist set pl_status = ''1'', pl_category = nbd_category' 
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName
				set @SzQry = @SzQry + N' on pl_goodsnm = nbd_goodsnm and pl_goodsnm_cs = nbd_goodsnm_cs'
				set @SzQry = @SzQry + N' inner join NURIBOTDB.dbo.tbl_nb_category'
				set @SzQry = @SzQry + N' on nbd_cateno = nbc_no'
				set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and nbd_goodsnm is not null and nbc_vcode = '+@strVcode+' and nbc_date > getdate()-1'
				set @SzQry = @SzQry + N' and isnull(pl_category,'''') <> isnull(nbd_category,'''') option(maxdop 1)'

				--수정처리
				set @SzQry = N'update pricelist'
				set @SzQry = @SzQry + N' set pl_date = getdate(), pl_goodscode = nbd_goodscode,'
					set @SzQry = @SzQry + N' pl_price = nbd_price,'
					set @SzQry = @SzQry + N' pl_url = nbd_url, pl_imgurl = nbd_imgurl,'
					set @SzQry = @SzQry + N' pl_account_yn = nbd_account_yn, pl_goodsfactory = nbd_factory, pl_freeinterest = nbd_freeinterest,'
					--가격체크
					set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then ''9'' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, nbd_price, pl_vcode) end),'	
					--배송체크
					set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(nbd_deliveryinfo,'''')),'
					set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(nbd_deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
					--이미지체크
					set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when nbd_imgurl then pl_imgurlflag else ''0'' end),'
					--설치비
					--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, nbd_goodsnm, pl_airconfeetype),'
					--설치비추가
					If (@strVcode = '169' or @strVcode = '6287' or @strVcode = '896' or @strVcode = '1621' or @strVcode = '780' or @strVcode = '1624' or @strVcode = '1752' or @strVcode = '1538' or @strVcode = '2281' or @strVcode = '2285' or @strVcode = '2287')
						begin 
							set @SzQry = @SzQry + N' pl_srvflag = (case when nbd_rightnleft = ''S'' then ''4'' else ''0'' end),'
						end
					else 
						begin
							set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, nbd_goodsnm, pl_srvflag, pl_price, nbd_price),'
						end
					--카테고리
					set @SzQry = @SzQry + N' pl_category = (case when pl_category = '''' then isnull(nbd_category,'''') else pl_category end)'
					--핸드폰판매가격
					If (@strVcode = '2562' or @strVcode = '5843' or @strVcode = '6063' or @strVcode = '6469')
						Begin 
							set @SzQry = @SzQry + N' ,pl_tag_price = isnull(NBD_TAG_PRICE,0), pl_call_plan = isnull(NBD_CALL_PLAN,''''), pl_in_fee_yn = isnull(NBD_IN_FEE_YN,''''), pl_ship_fee_yn = isnull(NBD_SHIP_FEE_YN,''''), pl_bond_fee = isnull(NBD_BOND_FEE,0), pl_penality_fee = isnull(NBD_PENALITY_FEE,0)'
						End
					--select count(*)
					set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName
					set @SzQry = @SzQry + N' on pl_goodsnm = nbd_goodsnm and pl_goodsnm_cs = nbd_goodsnm_cs'
					set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and nbd_goodsnm is not null'
					set @SzQry = @SzQry + N' and (pl_price <> nbd_price or pl_url <> nbd_url or isnull(pl_imgurl,'''') <> nbd_imgurl or pl_account_yn <> nbd_account_yn'
					set @SzQry = @SzQry + N' or pl_goodsfactory <> nbd_factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(nbd_deliveryinfo,'''')) or pl_freeinterest <> nbd_freeinterest or isnull(pl_goodscode,'''') <> nbd_goodscode'
					--제조사업체
					If (@strVcode = '169' or @strVcode = '6287' or @strVcode = '896' or @strVcode = '1621' or @strVcode = '780' or @strVcode = '1624' or @strVcode = '1752' or @strVcode = '1538' or @strVcode = '2281' or @strVcode = '2285' or @strVcode = '2287')
						begin 
							set @SzQry = @SzQry + N' or pl_srvflag <> (case when nbd_rightnleft = ''S'' then ''4'' else ''0'' end)'					
						end	
					--핸드폰판매가격
					If (@strVcode = '2562' or @strVcode = '5843' or @strVcode = '6063' or @strVcode = '6469')
						Begin 
							set @SzQry = @SzQry + N' or isnull(pl_tag_price,0) <> isnull(NBD_TAG_PRICE,0) or isnull(pl_call_plan,'''') <> isnull(NBD_CALL_PLAN,'''') or isnull(pl_in_fee_yn,'''') <> isnull(NBD_IN_FEE_YN,'''') or isnull(pl_ship_fee_yn,'''') <> isnull(NBD_SHIP_FEE_YN,'''') or isnull(pl_bond_fee,0) <> isnull(NBD_BOND_FEE,0) or isnull(pl_penality_fee,0) <> isnull(NBD_PENALITY_FEE,0)'
						End
					set @SzQry = @SzQry + N' or pl_status = ''5'' or pl_status = ''3'' or (pl_modelno < 1 and isnull(pl_category,'''') = '''')) and pl_nochange <> ''1'' option(maxdop 1)'
				
				exec(@SzQry)
				set @ModCnt = @@rowcount
				
				
				--SDU삭제 처리
				UPDATE PRICELIST SET PL_STATUS = '3' 
				WHERE PL_VCODE = @strVcode AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND PL_DATE < DATEADD(D, -2,GETDATE())
				

				--SDU중복 처리
		--	DECLARE @PLNO BIGINT
		--	DECLARE @URL VARCHAR(500)
		--	DECLARE @PRICE MONEY
		--	DECLARE @RIGHTNLEFT CHAR(1)
		--	DECLARE @DELIVERYINFO NVARCHAR(100) 
		--	DECLARE @CHKCOUNT CHAR(1)
		--	DECLARE @MAX INT
		--
		--	DECLARE @T TABLE
		--	(
		--		IDX INT IDENTITY(1,1),
		--		PLNO BIGINT,
		--		URL VARCHAR(500),
		--		PRICE MONEY,
		--		RIGHTNLEFT CHAR(1),
		--		DELIVERYINFO NVARCHAR(100) 
		--	)
		--
		--	INSERT INTO @T(PLNO, URL, PRICE, RIGHTNLEFT, DELIVERYINFO)
		--		SELECT PL_NO, PL_URL, PL_PRICE, PL_RIGHTNLEFT, PL_DELIVERYINFO
		--		FROM PRICELIST 
		--		WHERE PL_VCODE= @strVcode AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' 
		--	
		--	SET @MAX = @@ROWCOUNT
		--	
		--	WHILE @MAX<>0
		--		BEGIN
		--			SELECT @PLNO = PLNO, @URL = URL, @PRICE = PRICE, @RIGHTNLEFT = RIGHTNLEFT, @DELIVERYINFO = DELIVERYINFO
		--			FROM @T 
		--			WHERE IDX=@MAX
		--
		--			SELECT @CHKCOUNT = COUNT(*)
		--			FROM PRICELIST
		--			WHERE PL_VCODE= @strVcode AND PL_URL = @URL AND PL_URL_CS = CHECKSUM(@URL)
		--				AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'
		--
		--			IF (@CHKCOUNT > 0)
		--				BEGIN
		--					--UPDATE PRICELIST
		--					--SET PL_STATUS = '1', PL_PRICE = @PRICE, PL_RIGHTNLEFT = @RIGHTNLEFT, PL_DELIVERYINFO = @DELIVERYINFO
		--					--WHERE PL_VCODE= @strVcode AND PL_GOODSNM = @GOODSNM AND PL_GOODSNM_CS = CHECKSUM(@GOODSNM)
		--					--	AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'
		--
		--					UPDATE PRICELIST
		--					SET PL_STATUS = '3'
		--					WHERE PL_NO = @PLNO
		--				END 
		--
		--			SET @MAX = @MAX-1
		--		END


				
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')

			End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'T')
				
				set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
				exec(@SzQry)
			End
END



