/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_MD
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2010-07-21 17:42:49.11
 *        Modify: 2018-05-03 17:23:34.953
 *        Backup: 20180521_1737
 ************************************************************************* */








CREATE   PROCEDURE [dbo].[UDP_NURIBOT_MD]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strChkData char(1)

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : sung35 / 2010-07-23
	-- 설  명 : 쇼핑몰 MD 번호 매칭
	-- ----------------------------------------------
		
		DECLARE @SzQry VARCHAR(2000)
		DECLARE @ModCnt int
		DECLARE @SDate smalldatetime
		set @ModCnt = -1
		set @SDate = getdate()	
				
		--번호추출
		DECLARE @U TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			PLNO BIGINT,
			MODELNO INT
		)

		If @strVcode = '5910'
			Begin 
				insert into @U(plno, modelno)
				select pl_no, modelno
				from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_MD_5910
				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
				inner join dbo.goods on modelno = g_modelno
				where pl_vcode = 5910 and pl_goodsnm <> '' and pl_modelno = 0 
				and left(g_category,4) <> '0201' and left(g_category,4) <> '0211' 
				and left(g_category,4) <> '0304' and left(g_category,4) <> '0352' and left(g_category,4) <> '0353' and left(g_category,4) <> '0354' and left(g_category,4) <> '0361'
				and left(g_category,4) <> '0402' and left(g_category,4) <> '0404' and left(g_category,4) <> '0405' and left(g_category,4) <> '0418'
				and left(g_category,4) <> '0501' and left(g_category,4) <> '0502' and left(g_category,4) <> '0510'
				and left(g_category,4) <> '0803' and left(g_category,4) <> '0810'
				and left(g_category,4) <> '1003' and left(g_category,4) <> '1004' and left(g_category,4) <> '1005' and left(g_category,4) <> '1007' and left(g_category,4) <> '1022'
				option(maxdop 1)
				
				set @ModCnt = @@rowcount
			End
		Else If @strVcode = '273'
			Begin 
				insert into @U(plno, modelno)
				select pl_no, modelno
				from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_MD_273
				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
				where pl_vcode = 273 and pl_goodsnm <> '' and pl_modelno = 0 option(maxdop 1)
				
				set @ModCnt = @@rowcount
			End
		
		--번호작업
		update pricelist
		set pl_date = getdate(), pl_modelno = modelno, 
		pl_status = (case pl_status when '0' then '1' else pl_status end)	
		--select count(*)
		from dbo.pricelist with(readuncommitted) inner join @U
		on pl_no = plno option(maxdop 1)	
		
		--로그작업
		--insert into LOG2004_197.LOGDB.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag)
		insert into LOGDB.dbo.job_pricelist(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag)
		select plno, modelno, @strVcode, 'SHOP_MD', '0'
		from @U
						
		--통계처리(전체,추가,수정,삭제)	
		insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
		values(@strVcode, @strAllCnt, @ModCnt, -1, -1, @SDate, 'M')
		
END

















