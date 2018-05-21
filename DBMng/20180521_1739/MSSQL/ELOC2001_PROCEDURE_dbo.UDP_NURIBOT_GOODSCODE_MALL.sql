/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_GOODSCODE_MALL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-12-02 17:43:52.217
 *        Modify: 2018-05-03 17:23:34.12
 *        Backup: 20180521_1739
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_GOODSCODE_MALL]

@strTableName char(23),
@strVcode char(4),
@strAllCnt int

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
	DECLARE @SzQry VARCHAR(2000)
	DECLARE @NowCnt int
	DECLARE @ModCnt int
	DECLARE @AddCnt int
	DECLARE @SDate smalldatetime
	DECLARE @CNT INT
	set @NowCnt = -1
 	set @ModCnt = -1
	set @AddCnt = -1
	set @SDate = getdate()	
		
	DECLARE @SzQryMulti VARCHAR(2000)
	DECLARE @DutyChar char(1)
	DECLARE @DutyInt int
		
	--중복자료 삭제(전업체 설정)
	DECLARE @ChkDuty int
	set @ChkDuty = -1

	If @strVcode = '536'
		Begin
			set @SzQry = N' select top 1 mall_id, mall_goodscode'
			set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' group by mall_id, mall_goodscode'
			set @SzQry = @SzQry + N' having count(*) > 1' 
			exec(@SzQry)
		
			set @ChkDuty = @@rowcount
			If ( @ChkDuty > 0 )
				Begin
					set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' FROM NB01.dbo.' + @strTableName + ' A '
					set @SzQry = @SzQry + N' INNER JOIN (select mall_id, mall_goodscode from NB01.dbo.' + @strTableName + ' with(readuncommitted) group by mall_id, mall_goodscode having count(*) > 1) B'
					set @SzQry = @SzQry + N' ON A.mall_id = B.mall_id and A.mall_goodscode = B.mall_goodscode'
					set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
					exec(@SzQry)

					set @strAllCnt = @strAllCnt - @@rowcount
				End
		End

	set @SzQry = N' select top 1 goodscode'
	set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
	set @SzQry = @SzQry + N' group by goodscode'
	set @SzQry = @SzQry + N' having count(*) > 1' 
	exec(@SzQry)
		
	set @ChkDuty = @@rowcount

	If ( @ChkDuty > 0 )
		Begin
			--set @SzQry = N' DELETE NB01.dbo.' + @strTableName + ' FROM NB01.dbo.' + @strTableName + ' A '
			--set @SzQry = @SzQry + N' INNER JOIN (select goodscode as goodscode, min(no) as no from NB01.dbo.' + @strTableName + ' with(readuncommitted) group by goodscode having count(*) > 1) B'
			--set @SzQry = @SzQry + N' ON A.goodscode = B.goodscode WHERE A.no <> B.no'
			--set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
			--exec(@SzQry)

			--set @strAllCnt = @strAllCnt - @@rowcount
			--통계처리(전체,추가,수정,삭제)	
			insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
			values(@strVcode, -1, -1, -1, -1, @SDate, 'G')	
		End
	Else
		Begin
			--업체체크
			If @strVcode = '536'
				Begin
					delete dbo.pricelist_shop_request_goods where kind_flag = '1' and pl_vcode = 536

					--set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''90'' where mall_id in ('''')'
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''49'' where mall_id in (''lotteec7'', ''lotteec'', ''lottehome'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''806'' where mall_id in (''cjmall0'')'
					exec(@SzQry)	
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6361'' where mall_id in (''homeplus11'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6252'' where mall_id in (''ehimart1'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6389'' where mall_id in (''faple10'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6603'' where mall_id in (''ogage12'', ''triadmin'', ''outdoors12'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6644'' where mall_id in (''halfcom'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6620'' where mall_id in (''galleria0'')'
					exec(@SzQry)

					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''47'' where mall_id in (''shinsegae9'', ''ssgmall'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''57'' where mall_id in (''hdepart01'', ''hdepart01'')'
					exec(@SzQry)
					--set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6603'' where mall_id in (''triadmin'')'
					--exec(@SzQry)
				End
			If @strVcode = '4027'
				Begin
					delete dbo.pricelist_shop_request_goods where kind_flag = '1' and pl_vcode = 4027

					--set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''90'' where mall_id in (''yic2121'')'
					--exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''49'' where mall_id in (''lotteec7'', ''lotteec'', ''lottehome'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''806'' where mall_id in (''cjmall0'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6361'' where mall_id in (''homeplus365'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6252'' where mall_id in (''ehimart1'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6389'' where mall_id in (''faple03'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6603'' where mall_id in (''ogagemall'', ''borikids'', ''outdous'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6644'' where mall_id in (''half1234'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6620'' where mall_id in (''galleria0'')'
					exec(@SzQry)

					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''57'' where mall_id in (''hdepart01'', ''hmall01'', ''hhome01'')'
					exec(@SzQry)
				End
			If @strVcode = '5910'
				Begin
					delete dbo.pricelist_shop_request_goods where kind_flag = '1' and pl_vcode = 5910

					--set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''90'' where mall_id in (''yic2121'')'
					--exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''49'' where mall_id in (''lotteec11'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''57'' where mall_id in (''hyundaihmall'', ''hyundaidepart'', ''hyundaihome'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''90'' where mall_id in (''Akmall'', ''akplaza1'', ''akplaza2'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''663'' where mall_id in (''lottedep'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''806'' where mall_id in (''cjmall0'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6389'' where mall_id in (''fashionplus'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6620'' where mall_id in (''galleria0'', ''galleria2'')'
					exec(@SzQry)
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6644'' where mall_id in (''half1234'')'
					exec(@SzQry)

				End
				
			--모델번호 생성
			set @SzQry = N'update NB01.dbo.' + @strTableName + ' set plno = pl_no, modelno = pl_modelno, category = pl_category, price = pl_price'
			set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' inner join eloc2001.dbo.pricelist with(readuncommitted)'
			set @SzQry = @SzQry + N' on goodscode = pl_goodscode and checksum(goodscode) = pl_goodscode_cs'
			set @SzQry = @SzQry + N' where pl_vcode = '+ @strVcode +' and pl_modelno > 0 and pl_airconfeetype = ''0'' and option_flag2 = ''0'' and pl_srvflag = ''0'''
			set @SzQry = @SzQry + N' and pl_goodsnm <> '''' and isnull(pl_copyplno,0) = 0'
			-- and mall_id in (''49'',''806'',''6361'',''6252'',''6389'',''6603'',''6644'')'
				
			set @DutyChar = '0'
			set @DutyInt = 0
			WHILE @DutyInt <> 10
				BEGIN
					set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
					exec(@SzQryMulti)
						
					set @DutyInt = @DutyInt + 1
					set @DutyChar = cast(@DutyInt as char(1))
				END
				
			set @CNT = 0
			WHILE @CNT <> 13
				Begin
					set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_modelno = pl_modelno, mall_category = pl_category, mall_price = pl_price'
					set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
					set @SzQry = @SzQry + N' inner join eloc2001.dbo.pricelist with(readuncommitted)'
					set @SzQry = @SzQry + N' on mall_goodscode = pl_goodscode and checksum(mall_goodscode) = pl_goodscode_cs'
					set @SzQry = @SzQry + N' where pl_modelno > 0 and pl_airconfeetype = ''0'' and option_flag2 = ''0'' and pl_srvflag = ''0''' 
					set @SzQry = @SzQry + N' and pl_goodsnm <> '''' and isnull(pl_copyplno,0) = 0 and mall_modelno is null'
					If @CNT = '0'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 49 and mall_id = ''49'''
						End
					Else If @CNT = '1'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 806 and mall_id = ''806'''
						End
					Else If @CNT = '2'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6361 and mall_id = ''6361'''
						End
					Else If @CNT = '3'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6252 and mall_id = ''6252'''
						End
					Else If @CNT = '4'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6389 and mall_id = ''6389'''
						End
					Else If @CNT = '5'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6603 and mall_id = ''6603'''
						End
					Else If @CNT = '6'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6644 and mall_id = ''6644'''
						End
					Else If @CNT = '7'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6620 and mall_id = ''6620'''
						End
					Else If @CNT = '8'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 47 and mall_id = ''47'''
						End
					Else If @CNT = '9'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 57 and mall_id = ''57'''
						End
					Else If @CNT = '10'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 6665 and mall_id = ''6665'''
						End
					Else If @CNT = '11'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 90 and mall_id = ''90'''
						End
					Else If @CNT = '12'
						Begin
							set @SzQry = @SzQry + N' and pl_vcode = 663 and mall_id = ''663'''
						End
					set @SzQry = @SzQry + N' option(maxdop 1)'
					exec(@SzQry)

					If @CNT = '8'
						Begin
							set @SzQry = N'update NB01.dbo.' + @strTableName + ' set mall_id = ''6665'' where mall_id = ''47'' and mall_modelno is null'
							exec(@SzQry)
						End

					set @CNT = @CNT + 1
				End
				
			--번호작업
			DECLARE @CNT1 INT
			DECLARE @NO BIGINT
			DECLARE @MODELNO INT
			DECLARE @ID CHAR(4)
			DECLARE @VCODE INT
			DECLARE @CATEGORY CHAR(8)
			
			DECLARE @G TABLE
			(
				IDX INT IDENTITY(1,1) PRIMARY KEY,
				PL_NO BIGINT,
				PL_MODELNO INT,
				PL_VCODE INT,
				PL_CATEGORY VARCHAR(8),
				MALL_ID VARCHAR(50)
			)
			If(@strVcode = '536')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, mall_modelno, pl_vcode, mall_category, mall_id
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = checksum(goodscode)
					where pl_vcode = 536 and pl_modelno = 0 and mall_modelno > 0 and modelno is null
					and left(pl_category,2) = left(mall_category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > mall_price * 0.5
					option(maxdop 1)
				End
			else If(@strVcode = '4027')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, mall_modelno, pl_vcode, mall_category, mall_id
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = checksum(goodscode)
					where pl_vcode = 4027 and pl_modelno = 0 and mall_modelno > 0 and modelno is null
					and left(pl_category,2) = left(mall_category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > mall_price * 0.5
					option(maxdop 1)
				End
			else If(@strVcode = '5910')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, mall_modelno, pl_vcode, mall_category, mall_id
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = checksum(goodscode)
					where pl_vcode = 5910 and pl_modelno = 0 and mall_modelno > 0 and modelno is null
					and left(pl_category,2) = left(mall_category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > mall_price * 0.5
					option(maxdop 1)
				End
				
			If(@strVcode = '536')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 49 and mall_id = '49'
					option(maxdop 1)
	
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 806 and mall_id = '806'
					option(maxdop 1)
					
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6361 and mall_id = '6361'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6252 and mall_id = '6252'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6389 and mall_id = '6389'
					option(maxdop 1)	

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6603 and mall_id = '6603'
					option(maxdop 1)
			
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6644 and mall_id = '6644'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6620 and mall_id = '6620'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 47 and mall_id = '47'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 57 and mall_id = '57'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '536'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_536 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6665 and mall_id = '6665'
					option(maxdop 1)
				End
			Else If(@strVcode = '4027')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 49 and mall_id = '49'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 806 and mall_id = '806'
					option(maxdop 1)
					
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6361 and mall_id = '6361'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6252 and mall_id = '6252'
					option(maxdop 1)
						
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6389 and mall_id = '6389'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6603 and mall_id = '6603'
					option(maxdop 1)
			
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6644 and mall_id = '6644'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6620 and mall_id = '6620'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '4027'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 57 and mall_id = '57'
					option(maxdop 1)
				End
			Else If(@strVcode = '5910')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 49 and mall_id = '49'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 57 and mall_id = '57'
					option(maxdop 1)
					
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 90 and mall_id = '90'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 663 and mall_id = '663'
					option(maxdop 1)
						
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 806 and mall_id = '806'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6389 and mall_id = '6389'
					option(maxdop 1)
			
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6620 and mall_id = '6620'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '5910'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_5910 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and left(pl_category,2) = left(category,2) and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 6644 and mall_id = '6644'
					option(maxdop 1)
				End

			select @CNT1 = count(*) from @G
			set @ModCnt = @CNT1

			WHILE @CNT1 <> 0
				Begin
					SELECT @NO = PL_NO, @MODELNO = PL_MODELNO, @VCODE = PL_VCODE, @CATEGORY = PL_CATEGORY, @ID = MALL_ID FROM @G WHERE IDX=@CNT1

					Update pricelist Set pl_status = (case pl_status when '0' then '1' else pl_status end), pl_modelno = @MODELNO, pl_category = @CATEGORY where pl_no = @NO
					Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
					select @NO, @MODELNO, @VCODE, 'NURIBOT_GC_' + @ID , '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @NO
					Set @CNT1 = @CNT1 - 1	
				End	
				
			--통계처리(전체,추가,수정,삭제)	
			insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
			values(@strVcode, @strAllCnt, @ModCnt, -1, -1, @SDate, 'G')		

			--모델번호 생성
			set @SzQry = N'update NB01.dbo.' + @strTableName + ' set plno = pl_no, category = pl_category'
			set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' inner join eloc2001.dbo.pricelist with(readuncommitted)'
			set @SzQry = @SzQry + N' on goodscode = pl_goodscode and checksum(goodscode) = pl_goodscode_cs'
			set @SzQry = @SzQry + N' where pl_vcode = '+ @strVcode +' and pl_modelno = 0 and pl_airconfeetype = ''0'' and option_flag2 = ''0'' and pl_srvflag = ''0'''
			set @SzQry = @SzQry + N' and pl_goodsnm <> '''' and isnull(pl_copyplno,0) = 0 and modelno is null and mall_modelno is null'
				
			set @DutyChar = '0'
			set @DutyInt = 0
			WHILE @DutyInt <> 10
				BEGIN
					set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
					exec(@SzQryMulti)
						
					set @DutyInt = @DutyInt + 1
					set @DutyChar = cast(@DutyInt as char(1))
				END

				
			--미매칭 입력
			set @SzQry = N'insert into dbo.pricelist_shop_request_goods(pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status, kind_flag)'
			set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status, ''1'''
			set @SzQry = @SzQry + N' from pricelist with(readuncommitted)'
			set @SzQry = @SzQry + N' where pl_status = ''0'' and pl_modelno = 0'
			set @SzQry = @SzQry + N' and pl_no in ('
			set @SzQry = @SzQry + N' select plno from ('
			set @SzQry = @SzQry + N' select left(category,4) as category, plno, rank()over(partition by left(category,4) order by left(category,4), max(plno) desc)''rank'''
			set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' where plno is not null and len(category) > 4'
			set @SzQry = @SzQry + N' group by left(category,4), plno'
			set @SzQry = @SzQry + N' )T where rank < 251)'
			set @SzQry = @SzQry + N' option(maxdop 1)'
			exec(@SzQry)

			--★옥션-롯데★ 처리
			If(@strVcode = '4027')
				Begin
					DECLARE @I TABLE
					(
						IDX INT IDENTITY(1,1) PRIMARY KEY,
						NO BIGINT
					)
					DECLARE @MultiInt int
					DECLARE @MultiCnt int
					DECLARE @MultiStart int 
					DECLARE @MultiEnd int
					Set @MultiInt = 1
					set @MultiStart = 0
					set @MultiEnd = 500

					insert into @I(NO)
					select pl_no
					from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted)
					on pl_goodscode = goodscode and pl_goodscode_cs = checksum(goodscode)
					where pl_vcode = 4027 and pl_goodsnm <> '' and goodscode is not null 
					and mall_id = '49' and isnull(pl_note,'') not like '★옥션-롯데★%' 
					option(maxdop 1)
					Set @MultiCnt = @@rowcount

					Set @MultiInt = 1
					Set @MultiCnt = (@MultiCnt / 300) + 2 
					set @MultiStart = 0
					set @MultiEnd = 300

					WHILE @MultiInt < @MultiCnt
						BEGIN
							update pricelist set pl_note = '★옥션-롯데★' + replace(isnull(pl_note,''), '★옥션-롯데★',''), pl_status = (case when pl_status = '0' then '1' else pl_status end)
							from pricelist with(readuncommitted) inner join @I
							on pl_no = NO where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)
		
							set @MultiInt = @MultiInt + 1
							set @MultiStart = @MultiEnd
							set @MultiEnd = @MultiInt * 300
							print @MultiInt
						END

					--매칭 입력
					set @SzQry = N'insert into dbo.pricelist_shop_request_goods(pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status, kind_flag)'
					set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status, ''2'''
					set @SzQry = @SzQry + N' from (select jp_plistno from [OLTPLOG_196].[OLTPLOG].[dbo].[job_pricelist] with(readuncommitted) where jp_date > CONVERT(NVARCHAR, GETDATE()-7, 23) and jp_vcode = 4027 and jp_flag in (''0'',''5'',''6'',''M'',''P'')) as t1'
					set @SzQry = @SzQry + N' left outer join (select plno from NB01.dbo.TBL_DATA_GOODSCODE_4027 with(readuncommitted) where mall_id = ''49'' and modelno > 0) as t2'
					set @SzQry = @SzQry + N' on jp_plistno = plno'
					set @SzQry = @SzQry + N' left outer join (select pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status from pricelist with(readuncommitted) where pl_vcode = 4027 and pl_modelno > 0 and pl_status = ''0'') as t3'
					set @SzQry = @SzQry + N' on jp_plistno = pl_no'
					set @SzQry = @SzQry + N' where plno > 0 and pl_no > 0'
					set @SzQry = @SzQry + N' option(maxdop 1)'
					exec(@SzQry)
				End
		End
END





















