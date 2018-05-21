/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_ETC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-02-15 14:12:19.627
 *        Modify: 2018-05-03 17:23:34.32
 *        Backup: 20180521_1737
 ************************************************************************* */







CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_ETC]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1),
@strStaticsNo int = 0

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
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
			
		--�ߺ��ڷ� ����(����ü ����)
		DECLARE @ChkDuty int
		set @ChkDuty = -1

		set @SzQry = N' select top 1 goodsnm'
		set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' group by goodsnm'
		set @SzQry = @SzQry + N' having count(*) > 1' 
		exec(@SzQry)
		
		set @ChkDuty = @@rowcount

		If ( @ChkDuty > 0 )
			Begin
				set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' FROM NB01.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select goodsnm as goodsnm, min(price) as price, max(no) as no from NB01.dbo.' + @strTableName + ' with(readuncommitted) group by goodsnm having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.goodsnm = B.goodsnm WHERE A.price <> B.price'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @strAllCnt = @strAllCnt - @@rowcount

				set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' FROM NB01.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select goodsnm as goodsnm, min(no) as no from NB01.dbo.' + @strTableName + ' with(readuncommitted) group by goodsnm having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.goodsnm = B.goodsnm WHERE A.no <> B.no'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)
				set @strAllCnt = @strAllCnt - @@rowcount
			End

		-- 'ǰ��'��ǰ����
		set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE = 1 WHERE PRICE = 0 and CATE in (SELECT CATENAME FROM NURIBOTDB.dbo.TBL_NB_SHOPCATE WITH(READUNCOMMITTED) WHERE  VCODE = '+@strVcode+' and CATEGORY LIKE ''0304%'') OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE PRICE < 1 OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = ''null'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' WHERE goodsnm = '''' OPTION (MAXDOP 1)'
		exec(@SzQry)

		--pc���� = ����ϰ��� (6361)Ȩ�÷���,(948)�˽�����,(2046)����PC,(2047)�˽������,(5978)�ٺ����,(6389)�м��÷���,(3367)YES24,(4861)�˶��,(6367)��������,(6368)��ǳ����,(6667)�̽�����
		If (@strVcode = '6361' or @strVcode = '948' or @strVcode = '2046' or @strVcode = '2047' or @strVcode = '5978' or @strVcode = '6389' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368' or @strVcode = '6667')
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		
		--��ü���� üũ
		select @NowCnt = count(distinct pl_goodsnm) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode  = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3'  option(maxdop 1)
				

		--DECLARE @BeforCnt int
		--DECLARE @PriceModCnt int
		--set @BeforCnt = -1
		--set @PriceModCnt = -1
		--
		----���� ��� ����
		--select top 1 @BeforCnt = ALLCNT 
		--from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS with(readuncommitted)
		--where VCODE = @strVcode 
		--order by NO desc
		--
		--If (@strChkData = '1' and @BeforCnt > -1)
		--	Begin
		--		--���ݺ��� ���� ����
		--		--set @SzQry = N'select @count = count(pl_no)'
		--		--	set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
		--		--	set @SzQry = @SzQry + N' on pl_goodsnm = goodsnm'
		--		--	set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and goodsnm is not null and pl_nochange <> ''1'' and pl_price <> price option(maxdop 1)'
		--		
		--		--EXEC sp_ExecuteSQL @SzQry, N'@count INT OUTPUT', @count=@PriceModCnt OUTPUT
		--
		--		--���ݺ��� ���� ����
		--		set @SzQry = N'select pl_no'
		--			set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
		--			set @SzQry = @SzQry + N' on pl_goodsnm = goodsnm'
		--			set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and goodsnm is not null and pl_nochange <> ''1'' and pl_price <> price option(maxdop 1)'
		--		exec(@SzQry)
		--		set @PriceModCnt = @@rowcount			
		--		
		--		If(@PriceModCnt > @NowCnt/2)
		--			Set @UpdateChk = '0'
		--	End
		


		If (@UpdateChk = '1')
			Begin
				--����ó�� 
				If (@strAllCnt >= @NowCnt * 0.9)
					begin
						set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
						--set @SzQry = N'select count(*)' 
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodsnm = goodsnm'
						set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' and goodsnm is null option(maxdop 1)'
						
						exec(@SzQry)
						set @DelCnt = @@rowcount
					End
				Else
					Begin
						set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''����(��ü-����)'' WHERE VCODE = '+@strVcode
						exec(@SzQry)
					End 


				--�߰�ó��
				DECLARE @IChk BIGINT
				select @IChk = max(pl_no) 
				from dbo.pricelist with(readuncommitted)
				where pl_vcode = @strVcode
				
				set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_ACCOUNT_YN, PL_GOODSFACTORY, PL_GOODSCODE, PL_FREEINTEREST, PL_DELIVERYINFO, PL_RIGHTNLEFT, pl_authdate, pl_airconfeetype)'
					set @SzQry = @SzQry + N' select' 
					set @SzQry = @SzQry + N' 0,'--dbo.UDF_TEST_RTN_MODELNO('+@strVcode+', goodsnm, goodscode),'	--GOODSNM
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
					--���üũ
					set @SzQry = @SzQry + N' dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
					set @SzQry = @SzQry + N' (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''������'' then ''1'' else ''2'' end),'
					set @SzQry = @SzQry + N' getdate(),'
					set @SzQry = @SzQry + N' dbo.UDF_RTN_AIRCONFEETYPE(goodsnm)'
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.' + @strTableName
				set @SzQry = @SzQry + N' on pl_goodsnm = goodsnm and pl_goodsnm_cs = goodsnm_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
				set @SzQry = @SzQry + N' where pl_no is null and goodsnm <> '''''
				
				exec(@SzQry)
				set @AddCnt = @@rowcount
				
				--�߰���ǰ �Է�
				--insert into pricelist_search_target(pl_no, pl_modelno, pl_category, pl_goodsnm, pl_goodsfactory, pl_price, status, pl_vcode)
				--select pl_no, pl_modelno, pl_category, pl_goodsnm, pl_goodsfactory, pl_price, 'I', pl_vcode
				--from pricelist with(readuncommitted)
				--where  pl_vcode = @strVcode and pl_no > @IChk and pl_goodsnm <> '' and pl_modelno < 1
				
				--���� ���� ó��(������ 10%)
				set @SzQry = N'insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno, sl_srvflag)'
					set @SzQry = @SzQry + N' select'
					set @SzQry = @SzQry + N' pl_no,'
					set @SzQry = @SzQry + N' pl_vcode,'
					set @SzQry = @SzQry + N' pl_goodsnm,'
					set @SzQry = @SzQry + N' pl_price,'
					set @SzQry = @SzQry + N' pl_url,'
					set @SzQry = @SzQry + N' pl_imgurl,'
					set @SzQry = @SzQry + N' pl_account_yn,'
					set @SzQry = @SzQry + N' pl_deliveryinfo,'
					set @SzQry = @SzQry + N' pl_goodsfactory,'
					set @SzQry = @SzQry + N' pl_freeinterest,'
					set @SzQry = @SzQry + N' pl_goodscode,'
					set @SzQry = @SzQry + N' pl_category,'
					set @SzQry = @SzQry + N' pl_modelno,'
					set @SzQry = @SzQry + N' ''1'''
					set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
					set @SzQry = @SzQry + N' on pl_goodsnm = goodsnm and pl_goodsnm_cs = goodsnm_cs'
					set @SzQry = @SzQry + N' inner join dbo.goods with(readuncommitted)'
					set @SzQry = @SzQry + N' on pl_modelno = g_modelno'
					set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and g_minprice * 0.9 > price and pl_price > price and pl_modelno > 0 and pl_srvflag = ''0'' and catalog_flag = ''0'' and pl_nochange <> ''1'' option(maxdop 1)'
				exec(@SzQry)


				--����ó��
				set @SzQry = N'update pricelist'
				set @SzQry = @SzQry + N' set pl_date = getdate(), pl_goodscode = goodscode,'
					set @SzQry = @SzQry + N' pl_price = price,'
					set @SzQry = @SzQry + N' pl_url = url, pl_imgurl = imgurl,'
					set @SzQry = @SzQry + N' pl_account_yn = account_yn, pl_goodsfactory = isnull(factory,''''), pl_freeinterest = freeinterest,'
					--����üũ
					set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then ''9'' else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),'	
					--���üũ
					set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
					set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''������'' then ''1'' else ''2'' end),'
					--�̹���üũ
					set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
					--��ġ��
					--set @SzQry = @SzQry + N' pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),'
					--��ġ���߰�
					set @SzQry = @SzQry + N' pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag, pl_price, price),'
					--ī�װ�
					set @SzQry = @SzQry + N' pl_category = (case isnull(pl_category,'''') when '''' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+@strVcode+', cate) else pl_category end)'
					--select count(*)
					set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
					set @SzQry = @SzQry + N' on pl_goodsnm = goodsnm and pl_goodsnm_cs = goodsnm_cs'
					set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null'
					set @SzQry = @SzQry + N' and (pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl or pl_account_yn <> account_yn'
					set @SzQry = @SzQry + N' or isnull(pl_goodsfactory,'''') <> isnull(factory,'''') or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or pl_freeinterest <> freeinterest or pl_goodscode <> goodscode or pl_status = ''5'' or pl_status = ''3'' or isnull(pl_category,'''') = '''') and pl_nochange <> ''1'' option(maxdop 1)'
									
				exec(@SzQry)
				set @ModCnt = @@rowcount
	
			

				--SDU���� ó��
				UPDATE PRICELIST SET PL_STATUS = '3' 
				WHERE PL_VCODE = @strVcode AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND PL_DATE < DATEADD(D, -2,GETDATE())
				

				--SDU�ߺ� ó��
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


				
				--���ó��(��ü,�߰�,����,����)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = @AddCnt, DELCNT = @DelCnt where no = @strStaticsNo
					END

			End
		Else
			Begin
				--���ó��(��ü,�߰�,����,����)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'T')
				
				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = -1, MODCNT = -1, ADDCNT = -1, DELCNT = -1 where no = @strStaticsNo
					END
				
				set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''����(��ü-����)'' WHERE VCODE = '+@strVcode
				exec(@SzQry)
			End
END




