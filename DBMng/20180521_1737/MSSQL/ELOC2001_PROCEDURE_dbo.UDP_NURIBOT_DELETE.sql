/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_DELETE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-08-08 16:21:33.093
 *        Modify: 2018-05-03 17:23:34.663
 *        Backup: 20180521_1737
 ************************************************************************* */








CREATE   PROCEDURE [dbo].[UDP_NURIBOT_DELETE]

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
		
		
		--전체개수 체크
		--select @NowCnt = count(pl_no) 
		--from dbo.pricelist with(readuncommitted)
		--where pl_vcode  = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
		
		
		If (@UpdateChk = '1')
			Begin
				--536,5910,4027,55,49,663,57,1878,974
				If (@strVcode = '536' or @strVcode = '5910' or @strVcode = '4027' or @strVcode = '55' or @strVcode = '49' or @strVcode = '663' or @strVcode = '57' or @strVcode = '1878' or @strVcode = '974')
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

						If @strVcode = '536'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_536
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 536 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '5910'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_5910
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 5910 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '4027'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_4027
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 4027 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '55'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_55
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 55 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '49'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_49
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 49 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '663'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_663
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 663 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '57'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_57
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 57 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '1878'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_1878
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 1878 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 
						else If @strVcode = '974'
							Begin
								insert into @D(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_DELETE_974
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 974 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @DelCnt = @@rowcount
							End 

						Set @MultiInt = 1
						Set @MultiCnt = (@DelCnt / 100) + 2 
						set @MultiStart = 0
						set @MultiEnd = 100
						
						WHILE @MultiInt < @MultiCnt
							Begin
								update pricelist set pl_date = getdate(), pl_status = '3'
								from dbo.pricelist with(readuncommitted) inner join @D
								on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 100
							End
					End
				Else
					Begin
						set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
						--set @SzQry = N'select count(*)' 
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' option(maxdop 1)'
						
						exec(@SzQry)
						set @DelCnt = @@rowcount
					End

				--4027 웹비로그 남기기
				If (@strVcode = '4027')
					Begin
						set @SzQry = N' insert into WEBBDB.dbo.TBL_WEBB_LOG(WE_VCODE, WE_ERRID, WE_ERRNO, WE_ERRCONTENTS, WE_FLAG)'
						set @SzQry = @SzQry + N' values('+@strVcode+', 9, ''0'', ''삭제주기완료-'+cast(@strAllCnt as varchar)+'.'', 2)'
						exec(@SzQry)

					--	UPDATE NURIBOTDB.dbo.TBL_NB_RESERVATION SET SRVFLAG = '1' WHERE GROUPINFO = 'B8' AND STATUSFLAG = 'U'
					End		


				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, -1, -1, @DelCnt, @SDate, 'D')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = -1, ADDCNT = -1, DELCNT = @DelCnt where no = @strStaticsNo
					END
			End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'D')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = -1, MODCNT = -1, ADDCNT = -1, DELCNT = -1 where no = @strStaticsNo
					END
			End
END



































































































































