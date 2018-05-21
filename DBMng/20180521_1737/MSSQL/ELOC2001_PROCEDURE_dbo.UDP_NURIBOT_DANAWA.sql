/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_DANAWA
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2013-05-24 12:53:47.18
 *        Modify: 2018-05-03 17:23:34.213
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE   PROCEDURE [dbo].[UDP_NURIBOT_DANAWA]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1)

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

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
				
		DECLARE @IChk int
		select @IChk = max(pl_no) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode
				
		set @SzQry = N'insert into tbl_danawa_goods_on_db (category, goodsnm, goodscode, url, dbdate)'
		set @SzQry = @SzQry + N' select b.cate, b.goodsnm, b.goodscode, b.url, b.dbdate'
		set @SzQry = @SzQry + N' from tbl_danawa_goods_on_db as a with(readuncommitted) right outer join NB02.dbo.' + @strTableName +' as b'
		set @SzQry = @SzQry + N' on a.goodscode = b.goodscode and a.goodscode_cs = b.goodscode_cs'
		set @SzQry = @SzQry + N' where a.goodsnm is null option(maxdop 1)'
		
		exec(@SzQry)
		set @AddCnt = @@rowcount
		
		--통계처리(전체,추가,수정,삭제)	
		insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
		values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')

END















































































