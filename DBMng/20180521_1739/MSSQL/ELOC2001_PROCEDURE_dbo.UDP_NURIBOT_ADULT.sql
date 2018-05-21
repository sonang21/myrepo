/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_ADULT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2012-03-07 16:13:19.65
 *        Modify: 2018-05-03 17:23:35.163
 *        Backup: 20180521_1739
 ************************************************************************* */







CREATE PROCEDURE [dbo].[UDP_NURIBOT_ADULT]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1)

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
		DECLARE @SzQry VARCHAR(2000)
		DECLARE @UpdateChk Char(1)
		DECLARE @NowCnt int
		DECLARE @AdultCnt int
		DECLARE @ModCnt int
		DECLARE @AddCnt int
		DECLARE @SDate smalldatetime
		set @UpdateChk = '1'
		set @NowCnt = -1
 		set @AdultCnt = -1
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
				If (@strVcode = '536' or @strVcode = '4027' or @strVcode = '5910' or @strVcode = '55')
					Begin
						--분할처리 변수
						DECLARE @MultiInt int
						DECLARE @MultiCnt int
						DECLARE @MultiStart int 
						DECLARE @MultiEnd int
						
						DECLARE @SzQryMulti VARCHAR(2000)
						DECLARE @DutyChar char(1)
						DECLARE @DutyInt int

						--성인처리 
						DECLARE @S TABLE
						(
							IDX INT IDENTITY(1,1) PRIMARY KEY,
							PLNO BIGINT
						)

						If @strVcode = '536'
							Begin
								insert into @S(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_ADULT_536
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 536 and pl_srvflag <> 'S' and pl_modelno < 1 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @AdultCnt = @@rowcount
							End 
						else If @strVcode = '4027'
							Begin
								insert into @S(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_ADULT_4027
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 4027 and pl_srvflag <> 'S' and pl_modelno < 1 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @AdultCnt = @@rowcount
							End 
						else If @strVcode = '5910'
							Begin
								insert into @S(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_ADULT_5910
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 5910 and pl_srvflag <> 'S' and pl_modelno < 1 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @AdultCnt = @@rowcount
							End 
						else If @strVcode = '55'
							Begin
								insert into @S(plno)
								select pl_no
								from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_ADULT_55
								on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
								where pl_vcode = 55 and pl_srvflag <> 'S' and pl_modelno < 1 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
							
								set @AdultCnt = @@rowcount
							End 

						Set @MultiInt = 1
						Set @MultiCnt = (@AdultCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						
						WHILE @MultiInt < @MultiCnt
							Begin
								update pricelist set pl_date = getdate(), pl_srvflag = 'S', pl_category = '1640', pl_status = (case pl_status when '0' then '1' else pl_status end)
								from dbo.pricelist with(readuncommitted) inner join @S
								on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							End
					End
				Else
					Begin
						set @SzQry = N'update pricelist set pl_date = getdate(), pl_srvflag = ''S'', pl_category = ''1640'', pl_status = (case pl_status when ''0'' then ''1'' else pl_status end)'
						--set @SzQry = N'select count(*)' 
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_srvflag <> ''S'' and pl_modelno < 1 and pl_goodsnm_cs <> checksum('''') and pl_status <> ''5'' and pl_status <> ''3'' option(maxdop 1)'
						
						exec(@SzQry)
						set @AdultCnt = @@rowcount
					End

				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @AdultCnt, -1, -1, @SDate, 'A')
			End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'A')
			End
END







































































































































