/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_GOODSCODE_LIST
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2009-11-04 14:47:49.203
 *        Modify: 2018-05-03 17:23:34.917
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE  PROCEDURE [dbo].[UDP_NURIBOT_GOODSCODE_LIST]

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
		set @NowCnt = -1
 		set @ModCnt = -1
		set @AddCnt = -1
		set @SDate = getdate()	
			

		--추가처리
		set @SzQry = N'INSERT INTO TBL_SHOP_GOODSCODE_LIST (SHOP_CODE, GOODSCODE, STATUS, SHOP_55, SHOP_536, SHOP_4027, SHOP_5910)'
		set @SzQry = @SzQry + N' SELECT '+ @strVcode +', B.GOODSCODE, ''0'', B.SHOP_55, B.SHOP_536, B.SHOP_4027, B.SHOP_5910' 
		set @SzQry = @SzQry + N' FROM TBL_SHOP_GOODSCODE_LIST A WITH(Readuncommitted) right outer join NB01.dbo.' + @strTableName + ' B'
		set @SzQry = @SzQry + N' ON A.GOODSCODE = B.GOODSCODE AND A.SHOP_CODE = '+ @strVcode 
		set @SzQry = @SzQry + N' WHERE A.GOODSCODE is null option(maxdop 1)'

		exec(@SzQry)
		set @AddCnt = @@rowcount

				
		--수정처리
		set @SzQry = N'UPDATE TBL_SHOP_GOODSCODE_LIST'
		set @SzQry = @SzQry + N' SET DATE = getdate(), STATUS = ''0'', SHOP_55 = B.SHOP_55, SHOP_536 = B.SHOP_536, SHOP_4027 = B.SHOP_4027, SHOP_5910 = B.SHOP_5910'
		set @SzQry = @SzQry + N' from TBL_SHOP_GOODSCODE_LIST A with(readuncommitted) inner join NB01.dbo.' + @strTableName + ' B'
		set @SzQry = @SzQry + N' ON A.GOODSCODE = B.GOODSCODE'
		set @SzQry = @SzQry + N' WHERE A.SHOP_CODE = '+ @strVcode +' AND A.SHOP_55 <> B.SHOP_55 OR A.SHOP_536 <> B.SHOP_536 OR A.SHOP_4027 <> B.SHOP_4027 OR A.SHOP_5910 <> B.SHOP_5910 option(maxdop 1)'
			
		exec(@SzQry)
		set @ModCnt = @@rowcount
		

		--번호작업
		DECLARE @CNT INT
		DECLARE @PL_NO BIGINT
		DECLARE @PL_MODELNO INT
		DECLARE @SHOP_CODE CHAR(4)
		DECLARE @GOODSCODE VARCHAR(50)
		DECLARE	@SHOP_55 VARCHAR(200)
		DECLARE	@SHOP_536 VARCHAR(200)
		DECLARE	@SHOP_4027 VARCHAR(200)
		DECLARE	@SHOP_5910 VARCHAR(200)
		DECLARE @CNT1 INT
	
		DECLARE @G TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			PL_MODELNO INT,
			SHOP_CODE INT,
			GOODSCODE VARCHAR(50),
			SHOP_55 VARCHAR(200),
			SHOP_536 VARCHAR(200),
			SHOP_4027 VARCHAR(200),
			SHOP_5910 VARCHAR(200)
		)

		DECLARE @E TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			PLNO BIGINT
		)
		
		insert into @G (PL_MODELNO, SHOP_CODE, GOODSCODE, SHOP_55, SHOP_536, SHOP_4027, SHOP_5910)
		select pl_modelno, SHOP_CODE, GOODSCODE, SHOP_55, SHOP_536, SHOP_4027, SHOP_5910
		from TBL_SHOP_GOODSCODE_LIST with(readuncommitted)
		inner join pricelist with(readuncommitted)
		on pl_goodscode = goodscode and pl_goodscode_cs = checksum(goodscode)
		where pl_vcode = @strVcode and pl_modelno <> 0 and status <> '3'
		set @CNT = @@rowcount
		
		--상품코드 복수 처리
		If @strVcode = '273'
			Begin
				WHILE @CNT <> 0
					Begin
						SELECT @PL_MODELNO = PL_MODELNO, @SHOP_CODE = cast(SHOP_CODE as char(4)), @GOODSCODE = GOODSCODE, @SHOP_55 = SHOP_55, @SHOP_536 = SHOP_536, @SHOP_4027 = SHOP_4027, @SHOP_5910 = SHOP_5910
						FROM @G 
						WHERE IDX=@CNT
						
						Set @PL_NO = 0
						Set @CNT1 = 0

						insert into @E(PLNO)
						Select pl_no From pricelist with(readuncommitted) where pl_vcode = 55 and pl_modelno <> @PL_MODELNO and pl_goodscode in (@SHOP_55)
						set @CNT1 = @@rowcount

						WHILE @CNT1 <> 0
							Begin
								SELECT @PL_NO = PLNO FROM @E WHERE IDX=@CNT1

								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
								--Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
								--Insert into LOG2004_197.LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0') 
								Set @CNT1 = @CNT1 - 1	
							End	
						
						Set @PL_NO = 0
						Set @CNT1 = 0

						insert into @E(PLNO)
						Select pl_no From pricelist with(readuncommitted) where pl_vcode = 536 and pl_modelno <> @PL_MODELNO and pl_goodscode in (@SHOP_55)
						set @CNT1 = @@rowcount

						WHILE @CNT1 <> 0
							Begin
								SELECT @PL_NO = PLNO FROM @E WHERE IDX=@CNT1

								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
								--Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
								
								Set @CNT1 = @CNT1 - 1	
							End	
						
						Set @PL_NO = 0
						Set @CNT1 = 0

						insert into @E(PLNO)
						Select pl_no From pricelist with(readuncommitted) where pl_vcode = 4027 and pl_modelno <> @PL_MODELNO and pl_goodscode in (@SHOP_55)
						set @CNT1 = @@rowcount

						WHILE @CNT1 <> 0
							Begin
								SELECT @PL_NO = PLNO FROM @E WHERE IDX=@CNT1

								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
						--		Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
								
								Set @CNT1 = @CNT1 - 1	
							End	
						
						Set @PL_NO = 0
						Set @CNT1 = 0

						insert into @E(PLNO)
						Select pl_no From pricelist with(readuncommitted) where pl_vcode = 5910 and pl_modelno <> @PL_MODELNO and pl_goodscode in (@SHOP_55)
						set @CNT1 = @@rowcount

						WHILE @CNT1 <> 0
							Begin
								SELECT @PL_NO = PLNO FROM @E WHERE IDX=@CNT1

								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
						--		Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
								
								Set @CNT1 = @CNT1 - 1	
							End	

						Set @CNT = @CNT - 1	
					End
			End
		Else
			Begin
				WHILE @CNT <> 0
					Begin
						SELECT @PL_MODELNO = PL_MODELNO, @SHOP_CODE = cast(SHOP_CODE as char(4)), @GOODSCODE = GOODSCODE, @SHOP_55 = SHOP_55, @SHOP_536 = SHOP_536, @SHOP_4027 = SHOP_4027, @SHOP_5910 = SHOP_5910
						FROM @G 
						WHERE IDX=@CNT
						
						Set @PL_NO = 0
						Select @PL_NO = pl_no From pricelist with(readuncommitted) where pl_vcode = 55 and pl_modelno <> @PL_MODELNO and pl_goodscode = @SHOP_55 and pl_goodscode_cs = checksum(@SHOP_55)
						If (@PL_NO <> 0)
							Begin
								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
						--		Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
							End	
						
						Set @PL_NO = 0
						Select @PL_NO = pl_no From pricelist with(readuncommitted) where pl_vcode = 536 and pl_modelno <> @PL_MODELNO and pl_goodscode = @SHOP_536 and pl_goodscode_cs = checksum(@SHOP_536)
						If (@PL_NO <> 0)
							Begin
								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
						--		Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
							End	
						
						Set @PL_NO = 0
						Select @PL_NO = pl_no From pricelist with(readuncommitted) where pl_vcode = 4027 and pl_modelno <> @PL_MODELNO and pl_goodscode = @SHOP_4027 and pl_goodscode_cs = checksum(@SHOP_4027)
						If (@PL_NO <> 0)
							Begin
								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
						--		Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
							End	

						Set @PL_NO = 0
						Select @PL_NO = pl_no From pricelist with(readuncommitted) where pl_vcode = 5910 and pl_modelno <> @PL_MODELNO and pl_goodscode = @SHOP_5910 and pl_goodscode_cs = checksum(@SHOP_5910)
						If (@PL_NO <> 0)
							Begin
								Update pricelist Set pl_status = case pl_status when '0' then '1' else pl_status end, pl_modelno = @PL_MODELNO where pl_no = @PL_NO
								Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
								select @PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price from pricelist with(readuncommitted) where pl_no = @PL_NO
						
						--		Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category) values(@PL_NO, @PL_MODELNO, @SHOP_CODE,  'NURIBOT_' + @SHOP_CODE + 'GC', '0', @PL_CATEGORY) 
							End	
								
						Set @CNT = @CNT - 1	
					End
			End

		update TBL_SHOP_GOODSCODE_LIST set status = (case status when '0' then '1' when '1' then '2' when '2' then '3' end) where status <> '3'   	
		
		--통계처리(전체,추가,수정,삭제)	
		insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
		values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, -1, @SDate, 'G')

END







