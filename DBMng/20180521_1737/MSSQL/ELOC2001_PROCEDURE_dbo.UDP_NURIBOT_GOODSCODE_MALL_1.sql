/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_GOODSCODE_MALL_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2016-11-23 16:50:21.077
 *        Modify: 2018-05-03 17:23:35.34
 *        Backup: 20180521_1737
 ************************************************************************* */





CREATE   PROCEDURE [dbo].[UDP_NURIBOT_GOODSCODE_MALL_1]

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
	
	--NB01,NB02 체크
	DECLARE @ChkTableName char(32)
	set @ChkTableName = ''

	If (@strVcode = '7867' or @strVcode = '7943')
		set @ChkTableName = 'NB01.dbo.' + @strTableName
	Else
		set @ChkTableName = 'NB01.dbo.' + @strTableName
			
	--중복자료 삭제(전업체 설정)
	DECLARE @ChkDuty int
	set @ChkDuty = -1

	If (@strVcode = '7867' or @strVcode = '7943')
		Begin
			set @SzQry = N' select top 1 mall_id, mall_goodscode'
			set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' group by mall_id, mall_goodscode'
			set @SzQry = @SzQry + N' having count(*) > 1' 
			exec(@SzQry)
		
			set @ChkDuty = @@rowcount
			If ( @ChkDuty > 0 )
				Begin
					set @SzQry = N' DELETE ' + @ChkTableName + ' FROM ' + @ChkTableName + ' A '
					set @SzQry = @SzQry + N' INNER JOIN (select mall_id, mall_goodscode from ' + @ChkTableName + ' with(readuncommitted) group by mall_id, mall_goodscode having count(*) > 1) B'
					set @SzQry = @SzQry + N' ON A.mall_id = B.mall_id and A.mall_goodscode = B.mall_goodscode'
					set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
					exec(@SzQry)

					set @strAllCnt = @strAllCnt - @@rowcount
				End
		End

	set @SzQry = N' select top 1 mall_id'
	set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
	set @SzQry = @SzQry + N' group by mall_id, mall_goodscode'
	set @SzQry = @SzQry + N' having count(*) > 1' 
	exec(@SzQry)
		
	set @ChkDuty = @@rowcount

	If ( @ChkDuty > 0 )
		Begin
			--set @SzQry = N' DELETE ' + @ChkTableName + ' FROM ' + @ChkTableName + ' A '
			--set @SzQry = @SzQry + N' INNER JOIN (select goodscode as goodscode, min(no) as no from ' + @ChkTableName + ' with(readuncommitted) group by goodscode having count(*) > 1) B'
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
			If (@strVcode = '7867' or @strVcode = '7943')
				Begin
					--delete dbo.pricelist_shop_request_goods where kind_flag = '1' and pl_vcode = 7867
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7867'' where mall_id in (''wwsoft'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7943'' where mall_id in (''enuripc1'')'
					exec(@SzQry)

					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7872'' where mall_id in (''one8one'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7901'' where mall_id in (''broodsc'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7895'' where mall_id in (''jun2u'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7897'' where mall_id in (''itfriend'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7892'' where mall_id in (''dlffpr523'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7893'' where mall_id in (''milal5080'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7896'' where mall_id in (''ssitmall9'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7903'' where mall_id in (''stong3460'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7899'' where mall_id in (''pmqz13'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7900'' where mall_id in (''bvcha7'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7907'' where mall_id in (''hiresys'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7898'' where mall_id in (''winnersol'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7902'' where mall_id in (''pcsaja79420'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7936'' where mall_id in (''comshot01'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7934'' where mall_id in (''cpkcnc'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7961'' where mall_id in (''minseok2016'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7982'' where mall_id in (''iwantcom2018'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7983'' where mall_id in (''atbuyd'')'
					exec(@SzQry)
					set @SzQry = N'update ' + @ChkTableName + ' set mall_id = ''7979'' where mall_id in (''ojplus09n'')'
					exec(@SzQry)

				End

			--몰 모델번호 생성
			set @CNT = 0
			WHILE @CNT <> 21
				Begin
					set @SzQry = N'update ' + @ChkTableName + ' set mall_modelno = pl_modelno, mall_category = pl_category, mall_price = pl_price'
					set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
					set @SzQry = @SzQry + N' inner join eloc2001.dbo.pricelist with(readuncommitted)'
					set @SzQry = @SzQry + N' on mall_goodscode = pl_goodscode and checksum(mall_goodscode) = pl_goodscode_cs'
					set @SzQry = @SzQry + N' where pl_modelno > 0 and pl_airconfeetype = ''0'' and option_flag2 = ''0'' and pl_srvflag = ''0''' 
					set @SzQry = @SzQry + N' and pl_goodsnm <> '''' and isnull(pl_copyplno,0) = 0 and mall_modelno is null'
					
					If @CNT = '0'
						set @SzQry = @SzQry + N' and pl_vcode = 7867 and mall_id = ''7867'''
					Else If @CNT = '1'
						set @SzQry = @SzQry + N' and pl_vcode = 7872 and mall_id = ''7943'''

					Else If @CNT = '2'
						set @SzQry = @SzQry + N' and pl_vcode = 7872 and mall_id = ''7872'''
					Else If @CNT = '3'
						set @SzQry = @SzQry + N' and pl_vcode = 7901 and mall_id = ''7901'''
					Else If @CNT = '4'
						set @SzQry = @SzQry + N' and pl_vcode = 7895 and mall_id = ''7895'''
					Else If @CNT = '5'
						set @SzQry = @SzQry + N' and pl_vcode = 7897 and mall_id = ''7897'''
					Else If @CNT = '6'
						set @SzQry = @SzQry + N' and pl_vcode = 7892 and mall_id = ''7892'''
					Else If @CNT = '7'
						set @SzQry = @SzQry + N' and pl_vcode = 7893 and mall_id = ''7893'''
					Else If @CNT = '8'
						set @SzQry = @SzQry + N' and pl_vcode = 7896 and mall_id = ''7896'''
					Else If @CNT = '9'
						set @SzQry = @SzQry + N' and pl_vcode = 7903 and mall_id = ''7903'''
					Else If @CNT = '10'
						set @SzQry = @SzQry + N' and pl_vcode = 7899 and mall_id = ''7899'''
					Else If @CNT = '11'
						set @SzQry = @SzQry + N' and pl_vcode = 7900 and mall_id = ''7900'''
					Else If @CNT = '12'
						set @SzQry = @SzQry + N' and pl_vcode = 7907 and mall_id = ''7907'''
					Else If @CNT = '13'
						set @SzQry = @SzQry + N' and pl_vcode = 7898 and mall_id = ''7898'''
					Else If @CNT = '14'
						set @SzQry = @SzQry + N' and pl_vcode = 7902 and mall_id = ''7902'''
					Else If @CNT = '15'
						set @SzQry = @SzQry + N' and pl_vcode = 7936 and mall_id = ''7936'''
					Else If @CNT = '16'
						set @SzQry = @SzQry + N' and pl_vcode = 7934 and mall_id = ''7934'''
					Else If @CNT = '17'
						set @SzQry = @SzQry + N' and pl_vcode = 7961 and mall_id = ''7961'''
					Else If @CNT = '18'
						set @SzQry = @SzQry + N' and pl_vcode = 7982 and mall_id = ''7982'''
					Else If @CNT = '19'
						set @SzQry = @SzQry + N' and pl_vcode = 7983 and mall_id = ''7983'''
					Else If @CNT = '20'
						set @SzQry = @SzQry + N' and pl_vcode = 7979 and mall_id = ''7979'''
								
					set @SzQry = @SzQry + N' option(maxdop 1)'
					exec(@SzQry)

					set @CNT = @CNT + 1
				End


			--기준몰 모델번호 생성
			set @SzQry = N'update ' + @ChkTableName + ' set modelno = gc_modelno, price = gc_price, category = gc_category'
			set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' inner join ('
			set @SzQry = @SzQry + N' select goodscode as gc_goodscode, min(mall_modelno) as gc_modelno, min(mall_price) as gc_price, min(mall_category) as gc_category'
			set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
			set @SzQry = @SzQry + N' where mall_modelno > 0'
			set @SzQry = @SzQry + N' group by goodscode'
			set @SzQry = @SzQry + N' having min(mall_modelno) = max(mall_modelno)'
			set @SzQry = @SzQry + N' ) as t1'
			set @SzQry = @SzQry + N' on goodscode = gc_goodscode'
			set @SzQry = @SzQry + N' option(maxdop 1)'
			exec(@SzQry)
				
				
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
							
			If (@strVcode = '7867')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7872 and mall_id = '7872'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7867 and mall_id = '7867'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7901 and mall_id = '7901'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7895 and mall_id = '7895'
					option(maxdop 1)
					
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7897 and mall_id = '7897'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7892 and mall_id = '7892'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7893 and mall_id = '7893'
					option(maxdop 1)
	
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7896 and mall_id = '7896'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7903 and mall_id = '7903'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7899 and mall_id = '7899'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7900 and mall_id = '7900'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7907 and mall_id = '7907'
					option(maxdop 1)
						
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7898 and mall_id = '7898'
					option(maxdop 1)
																							
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7902 and mall_id = '7902'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7936 and mall_id = '7936'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7934 and mall_id = '7934'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7961 and mall_id = '7961'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7982 and mall_id = '7982'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7983 and mall_id = '7983'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7867'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7867 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7979 and mall_id = '7979'
					option(maxdop 1)
				End
			else If (@strVcode = '7943')
				Begin
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7872 and mall_id = '7872'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7867 and mall_id = '7943'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7901 and mall_id = '7901'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7895 and mall_id = '7895'
					option(maxdop 1)
					
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7897 and mall_id = '7897'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7892 and mall_id = '7892'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7893 and mall_id = '7893'
					option(maxdop 1)
	
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7896 and mall_id = '7896'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7903 and mall_id = '7903'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7899 and mall_id = '7899'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7900 and mall_id = '7900'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7907 and mall_id = '7907'
					option(maxdop 1)
						
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7898 and mall_id = '7898'
					option(maxdop 1)
																							
					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7902 and mall_id = '7902'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7936 and mall_id = '7936'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7934 and mall_id = '7934'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7961 and mall_id = '7961'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7982 and mall_id = '7982'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7983 and mall_id = '7983'
					option(maxdop 1)

					insert into @G (PL_NO, PL_MODELNO, PL_VCODE, PL_CATEGORY, MALL_ID)
					select pl_no, modelno, pl_vcode, category, '7943'
					from dbo.pricelist with(readuncommitted)
					inner join NB01.dbo.TBL_DATA_GOODSCODE_7943 with(readuncommitted)
					on pl_goodscode = mall_goodscode and pl_goodscode_cs = checksum(mall_goodscode)
					where pl_modelno = 0 and modelno > 0 and mall_modelno is null
					and pl_airconfeetype = '0' and option_flag2 = '0' and pl_srvflag = '0'
					and pl_goodsnm <> '' and isnull(pl_copyplno,0) = 0 and pl_price > price * 0.5
					and pl_vcode = 7979 and mall_id = '7979'
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
			--set @SzQry = N'update ' + @ChkTableName + ' set plno = pl_no, category = pl_category'
			--set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
			--set @SzQry = @SzQry + N' inner join eloc2001.dbo.pricelist with(readuncommitted)'
			--set @SzQry = @SzQry + N' on goodscode = pl_goodscode and checksum(goodscode) = pl_goodscode_cs'
			--set @SzQry = @SzQry + N' where pl_vcode = '+ @strVcode +' and pl_modelno = 0 and pl_airconfeetype = ''0'' and option_flag2 = ''0'' and pl_srvflag = ''0'''
			--set @SzQry = @SzQry + N' and pl_goodsnm <> '''' and isnull(pl_copyplno,0) = 0 and modelno is null and mall_modelno is null'
				
			--set @DutyChar = '0'
			--set @DutyInt = 0
			--WHILE @DutyInt <> 10
			--	BEGIN
			--		set @SzQryMulti = @SzQry + N' and pl_dutycode = '+ @DutyChar +' option(maxdop 1)'
			--		exec(@SzQryMulti)
						
			--		set @DutyInt = @DutyInt + 1
			--		set @DutyChar = cast(@DutyInt as char(1))
			--	END

				
			--미매칭 입력
			--set @SzQry = N'insert into dbo.pricelist_shop_request_goods(pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status, kind_flag)'
			--set @SzQry = @SzQry + N' select pl_no, pl_vcode, pl_goodscode, pl_category, pl_modelno, pl_srvflag, pl_status, ''1'''
			--set @SzQry = @SzQry + N' from pricelist with(readuncommitted)'
			--set @SzQry = @SzQry + N' where pl_status = ''0'' and pl_modelno = 0'
			--set @SzQry = @SzQry + N' and pl_no in ('
			--set @SzQry = @SzQry + N' select plno from ('
			--set @SzQry = @SzQry + N' select left(category,4) as category, plno, rank()over(partition by left(category,4) order by left(category,4), max(plno) desc)''rank'''
			--set @SzQry = @SzQry + N' from ' + @ChkTableName + ' with(readuncommitted)'
			--set @SzQry = @SzQry + N' where plno is not null and len(category) > 4'
			--set @SzQry = @SzQry + N' group by left(category,4), plno'
			--set @SzQry = @SzQry + N' )T where rank < 251)'
			--set @SzQry = @SzQry + N' option(maxdop 1)'
			--exec(@SzQry)
						
		End
END





















