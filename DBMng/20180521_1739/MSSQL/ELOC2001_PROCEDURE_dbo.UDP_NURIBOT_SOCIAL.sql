/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_SOCIAL
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-10-29 10:13:49.367
 *        Modify: 2018-05-03 17:23:35.67
 *        Backup: 20180521_1739
 ************************************************************************* */






CREATE   PROCEDURE [dbo].[UDP_NURIBOT_SOCIAL]

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

		set @SzQry = N' select top 1 nbd_goodscode'
		set @SzQry = @SzQry + N' from NB02.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' group by nbd_goodscode'
		set @SzQry = @SzQry + N' having count(*) > 1' 
		exec(@SzQry)
		
		set @ChkDuty = @@rowcount

		If ( @ChkDuty > 0 )
			Begin
				set @SzQry = N' DELETE NB02.dbo.' + @strTableName + ' FROM NB02.dbo.' + @strTableName + ' A '
				set @SzQry = @SzQry + N' INNER JOIN (select nbd_goodscode as nbd_goodscode, min(nbd_no) as nbd_no from NB02.dbo.' + @strTableName + ' with(readuncommitted) group by nbd_goodscode having count(*) > 1) B'
				set @SzQry = @SzQry + N' ON A.nbd_goodscode = B.nbd_goodscode WHERE A.nbd_no <> B.nbd_no'
				set @SzQry = @SzQry + N' OPTION (MAXDOP 1)'
				exec(@SzQry)

				set @strAllCnt = @strAllCnt - @@rowcount
			End
			
		--전체개수 체크
		select @NowCnt = count(distinct pl_goodscode) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
		
		--삭제처리
		If (@strAllCnt >= @NowCnt * 0.7)
			Begin
				set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3''' 
				--set @SzQry = N'select count(*)' 
				set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB02.dbo.' + @strTableName
				set @SzQry = @SzQry + N' on pl_goodscode = nbd_goodscode AND pl_goodscode_cs = nbd_goodscode_cs'
				set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm <> '''' and pl_status <> ''5'' and pl_status <> ''3'' and nbd_goodscode is null option(maxdop 1)'
		
				exec(@SzQry)
				set @DelCnt = @@rowcount
			End
		Else
			Begin
				set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
				exec(@SzQry)
			End 
		
		--추가처리
		set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_GOODSCODE, PL_PRICE, PL_URL, PL_IMGURL, PL_SRVFLAG, PL_STATUS, PL_SOLDOUTDATE, OPTION_FLAG2, PL_AUTHDATE)'
		set @SzQry = @SzQry + N' select' 
		set @SzQry = @SzQry + N' 0,'
		set @SzQry = @SzQry + N' '+@strVcode+','
		set @SzQry = @SzQry + N' nbd_category,'
		set @SzQry = @SzQry + N' nbd_goodsnm,'
		set @SzQry = @SzQry + N' nbd_goodscode,'
		set @SzQry = @SzQry + N' nbd_price,'
		set @SzQry = @SzQry + N' nbd_url,'
		set @SzQry = @SzQry + N' nbd_imgurl,'
		set @SzQry = @SzQry + N' dbo.UDF_TEST_RTN_SRVFLAG(nbd_goodsnm),'
		set @SzQry = @SzQry + N' ''2'','
		set @SzQry = @SzQry + N' nbd_date,'
		set @SzQry = @SzQry + N' ''2'','
		set @SzQry = @SzQry + N' getdate()'
		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB02.dbo.' + @strTableName
		set @SzQry = @SzQry + N' on pl_goodscode = nbd_goodscode and pl_goodscode_cs = nbd_goodscode_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
		set @SzQry = @SzQry + N' where pl_no is null option(maxdop 1)'
		
		exec(@SzQry)
		set @AddCnt = @@rowcount
				
		--수정처리
		set @SzQry = N'update pricelist'
		set @SzQry = @SzQry + N' set pl_price = nbd_price, pl_imgurl = nbd_imgurl,' 
		--set @SzQry = @SzQry + N' pl_goodsnm = nbd_goodsnm, pl_url = (case when pl_vcode = 6643 and pl_modelno > 0 then pl_url else nbd_url end),'
		set @SzQry = @SzQry + N' pl_soldoutdate = nbd_date, pl_date = getdate(),'
		set @SzQry = @SzQry + N' pl_status = (case pl_status when ''8'' then pl_status when ''9'' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, nbd_price, pl_vcode) end)'		
		--set @SzQry = @SzQry + N' , pl_category = nbd_category' 
		set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB02.dbo.' + @strTableName
		set @SzQry = @SzQry + N' on pl_goodscode = nbd_goodscode and pl_goodscode_cs = nbd_goodscode_cs'
		set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and nbd_goodsnm is not null' 
		set @SzQry = @SzQry + N' and (pl_price <> nbd_price or pl_soldoutdate <> nbd_date or pl_imgurl <> nbd_imgurl or pl_status = ''3'' or pl_status = ''5'''
		--set @SzQry = @SzQry + N' or pl_category = '''''
		--If (@strVcode != '6643')
		--	Begin
		--		set @SzQry = @SzQry + N' or pl_url <> nbd_url'
		--	End
		set @SzQry = @SzQry + N' ) option(maxdop 1)'
			
		exec(@SzQry)
		set @ModCnt = @@rowcount
		
		--통계처리(전체,추가,수정,삭제)	
		insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
		values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')
		
END

































































