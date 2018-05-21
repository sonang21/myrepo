/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_INSERT_GS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-02-06 14:53:21.627
 *        Modify: 2018-05-03 17:23:34.553
 *        Backup: 20180521_1737
 ************************************************************************* */




CREATE   PROCEDURE [dbo].[UDP_NURIBOT_INSERT_GS]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int,
@strStaticsNo int = 0

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
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

		DECLARE @SLMAX VARCHAR(20)
		set @SLMAX = '0'

		DECLARE @ModCntChk int
		set @ModCntChk = -1
			
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
		

		--맨앞 [] 삭제
		set @SzQry = N' update NB01.dbo.' + @strTableName + ' set cate = right(ltrim(rtrim(cate)), len(ltrim(rtrim(cate))) - charindex('']'',ltrim(rtrim(cate))))'
		set @SzQry = @SzQry + N' from NB01.dbo.' + @strTableName + ' with(readuncommitted)'
		set @SzQry = @SzQry + N' where charindex(''['',cate) = 1'
		exec(@SzQry)

		--update NB01.dbo.TBL_DATA_INSERT_7871 set cate = right(ltrim(rtrim(cate)), len(ltrim(rtrim(cate))) - charindex(']',ltrim(rtrim(cate)))) 
		--select cate, right(cate, len(cate) - charindex(']',cate)) 
		--from NB01.dbo.TBL_DATA_INSERT_7871 with(readuncommitted)
		--where charindex('[',cate) = 1

		
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
		
		If @strTableName = 'TBL_DATA_INSERT_7871'	
			Begin
				insert into @D(plno)
				select pl_no
				from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_INSERT_7871 with(readuncommitted)
				on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
				left outer join tbl_external_category with(readuncommitted)
				on shop_code = 7871 and category_nm = left(cate, charindex('_',cate)-1)
				where pl_vcode = 7871 and pl_status = '4' and homeflag = 'D' and pl_modelno in (0,-100,-200,-300) and PRIORITY in (1,2,3) option(maxdop 1)
		
				set @DelCnt = @@rowcount	
			End
		Else If @strTableName = 'TBL_DATA_TOTAL_7871'	
			Begin
				insert into @D(plno)
				select pl_no
				from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_TOTAL_7871 with(readuncommitted)
				on pl_goodscode = goodscode AND pl_goodscode_cs = goodscode_cs
				left outer join tbl_external_category with(readuncommitted)
				on shop_code = 7871 and category_nm = pl_multicomment
				left outer join TBL_EXTERNAL_SEND_TARGET_MODEL with(readuncommitted)
				on pl_modelno = modelno
				where pl_vcode = 7871 and pl_status = '4' and goodscode is null and PRIORITY in (1,2,3) and ((pl_modelno > 0 and modelno is null) or pl_modelno in (0,-100,-200,-300)) option(maxdop 1)

				set @DelCnt = @@rowcount	
			End

		Set @MultiInt = 1
		Set @MultiCnt = (@DelCnt / 300) + 2 
		set @MultiStart = 0
		set @MultiEnd = 300
										
		WHILE @MultiInt < @MultiCnt
			Begin
				update pricelist set pl_date = getdate(), pl_status = '5'
				from dbo.pricelist with(readuncommitted) inner join @D
				on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
												
				set @MultiInt = @MultiInt + 1
				set @MultiStart = @MultiEnd
				set @MultiEnd = @MultiInt * 300
			End									
		
			
		--추가처리
		DECLARE @I TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			IGOODSCODE VARCHAR(50),
			MODELNO INT,
			CATEGORY VARCHAR(8),
			GOODSNM NVARCHAR(200),
			PRICE MONEY,
			URL VARCHAR(500),
			NOTE NVARCHAR(200),
			GSCATE VARCHAR(8), --GS 원카테고리코드 용도변경 : PL_CA_CODE_DEPT
			CATENAME NVARCHAR(100) --GS 원카테고리명 용도변경 : PL_MULTICOMMENT
		)
		
		If @strTableName = 'TBL_DATA_INSERT_7871'	
			Begin
				insert into @I (IGOODSCODE, modelno, category, goodsnm, price, url, gscate, catename)
				select goodscode
				--, (case 
				--	when PRIORITY = 1 then -100 
				--	when PRIORITY = 2 then -200 
				--	else -300
				--	--when charindex('일반가전_',cate) = 1 or charindex('컴퓨터_',cate) = 1 or charindex('생활가전_',cate) = 1 or charindex('디지털기기_',cate) = 1 or charindex('서비스_',cate) = 1 or charindex('여행_',cate) = 1 then -300 
				--end)
				, (case 
					when SET_YN = 'Y' then -200
					when SET_YN = 'N' then -300 
					else -100
				end)
				, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871, cate)
				, goodsnm
				, price
				, url
				, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871, cate)
				, left(cate, charindex('_',cate)-1)
				from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_INSERT_7871 with(readuncommitted)
				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 7871
				left outer join tbl_external_category with(readuncommitted)
				on shop_code = 7871 and category_nm = left(cate, charindex('_',cate)-1)
				where pl_no is null and homeflag = 'I' 
				--and NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate) <> '-'
				option(maxdop 1)

				set @AddCnt = @@rowcount
			End
		Else If @strTableName = 'TBL_DATA_TOTAL_7871'	
			Begin
				insert into @I (IGOODSCODE, modelno, category, goodsnm, price, url, gscate, catename)
				select goodscode
				--, (case 
				--	when PRIORITY = 1 then -100 
				--	when PRIORITY = 2 then -200 
				--	else -300
				--	--when charindex('일반가전_',cate) = 1 or charindex('컴퓨터_',cate) = 1 or charindex('생활가전_',cate) = 1 or charindex('디지털기기_',cate) = 1 or charindex('서비스_',cate) = 1 or charindex('여행_',cate) = 1 then -300 
				--end)
				, (case 
					when SET_YN = 'Y' then -200
					when SET_YN = 'N' then -300 
					else -100
				end)
				, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871, cate)
				, goodsnm
				, price
				, url
				, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871, cate)
				, left(cate, charindex('_',cate)-1)
				from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_TOTAL_7871 with(readuncommitted)
				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 7871
				left outer join tbl_external_category with(readuncommitted)
				on shop_code = 7871 and category_nm = left(cate, charindex('_',cate)-1)
				where pl_no is null and goodscode <> '' 
				--and NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate) <> '-'
				option(maxdop 1)

				set @AddCnt = @@rowcount
			End
		
		update @I set MODELNO = pl_modelno, CATEGORY = pl_category, NOTE = (case when isnull(replace(pl_note, ' ', ''), '') = '' and pl_modelno < 0 then '정보 불분명' else pl_note end)
		from @I inner join 
		(select pl_goodscode, max(pl_category) as pl_category, max(pl_modelno) as pl_modelno, max(pl_note) as pl_note
		from @I Inner join pricelist with(readuncommitted)
		On IGOODSCODE = pl_goodscode and CHECKSUM(IGOODSCODE) = pl_goodscode_cs 
		where pl_vcode = 75 and pl_goodsnm <> '' and pl_category not like '93%'
		group by pl_goodscode
		having count(*) = 1) as t	
		On IGOODSCODE = pl_goodscode 
		where pl_modelno > 0

		Set @MultiInt = 1
		Set @MultiCnt = (@AddCnt / 300) + 2 
		set @MultiStart = 0
		set @MultiEnd = 300
		WHILE @MultiInt < @MultiCnt
			BEGIN
				insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSCODE, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_AUTHDATE, PL_CA_CODE_DEPT, PL_NOTE, PL_MULTICOMMENT)
				select modelno, 7871, category, igoodscode, goodsnm, price, url, '4', '4', getdate(), gscate, note, catename
				from @I 
				where IDX >= @MultiStart and IDX < @MultiEnd
				
				Insert into LOGDB.dbo.JOB_PRICELIST(jp_plistno, jp_modelno, jp_vcode, jp_id, jp_flag, jp_category, jp_goodsnm, jp_price, jp_price_mobile) 
				select pl_no, pl_modelno, 7871,'NURIBOT_SYNC', '0', pl_category, pl_goodsnm, pl_price, pl_instance_price
				from @I Inner join pricelist with(readuncommitted)
				On IGOODSCODE = pl_goodscode and CHECKSUM(IGOODSCODE) = pl_goodscode_cs and IDX >= @MultiStart and IDX < @MultiEnd
				where pl_vcode = 7871 and modelno not in (0, -100, -200, -300)
					
				Insert into TBL_EXTERNAL_AUTO_TARGET(pl_no, pl_modelno)
				select pl_no, pl_modelno
				from @I Inner join pricelist with(readuncommitted)
				On IGOODSCODE = pl_goodscode and CHECKSUM(IGOODSCODE) = pl_goodscode_cs and IDX >= @MultiStart and IDX < @MultiEnd
				where pl_vcode = 7871 and modelno not in (0, -100, -200, -300)
												
				set @MultiInt = @MultiInt + 1
				set @MultiStart = @MultiEnd
				set @MultiEnd = @MultiInt * 300
			END

		--수정 처리
		DECLARE @U TABLE
		(
			IDX INT IDENTITY(1,1) PRIMARY KEY,
			PLNO BIGINT,
			MODELNO INT,
			GOODSNM NVARCHAR(200),
			PRICE MONEY,
			URL VARCHAR(500),
			CATEGORY VARCHAR(8),
			GSCATE VARCHAR(8),
			CATENAME NVARCHAR(100)
		)						
		If @strTableName = 'TBL_DATA_INSERT_7871'	
			Begin				
				insert into @U(plno, modelno, goodsnm, price, url, category, gscate, catename) 
				select pl_no
				--, (case 
				--	when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) and PRIORITY = 1 then -100 
				--	when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) and PRIORITY = 2 then -200 
				--	--when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) and (charindex('일반가전_',cate) = 1 or charindex('컴퓨터_',cate) = 1 or charindex('생활가전_',cate) = 1 or charindex('디지털기기_',cate) = 1 or charindex('서비스_',cate) = 1 or charindex('여행_',cate) = 1) then -300 
				--	when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) then -300 
				--	else pl_modelno
				--end)
				, (case 
					when (pl_modelno in (0, -100,-200,-300) and SET_YN = 'Y') then -200 
					when (pl_modelno in (0, -100,-200,-300) and SET_YN = 'N') then -300 
					when (pl_modelno in (0, -100,-200,-300) and SET_YN = '') then -100 
					else pl_modelno
				end)
				, goodsnm, price, url
				, (case 
					when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate) 
					else pl_category
				  end)
				, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate)
				, left(cate, charindex('_',cate)-1)
				from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_INSERT_7871 with(readuncommitted)
				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
				inner join tbl_external_category with(readuncommitted)
				on shop_code = 7871 and category_nm = left(cate, charindex('_',cate)-1)
				where pl_vcode = 7871 and homeflag = 'U'
				option(maxdop 1)

				set @ModCnt = @@rowcount
			End
		Else If @strTableName = 'TBL_DATA_TOTAL_7871'	
			Begin
				insert into @U(plno, modelno, goodsnm, price, url, category, gscate, catename) 
				select pl_no
				--, (case 
				--	when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) and PRIORITY = 1 then -100 
				--	when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) and PRIORITY = 2 then -200 
				--	--when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) and (charindex('일반가전_',cate) = 1 or charindex('컴퓨터_',cate) = 1 or charindex('생활가전_',cate) = 1 or charindex('디지털기기_',cate) = 1 or charindex('서비스_',cate) = 1 or charindex('여행_',cate) = 1) then -300 
				--	when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) then -300 
				--	else pl_modelno
				--  end)
				, (case 
					when (pl_modelno in (0, -100,-200,-300) and SET_YN = 'Y') then -200 
					when (pl_modelno in (0, -100,-200,-300) and SET_YN = 'N') then -300 
					when (pl_modelno in (0, -100,-200,-300) and SET_YN = '') then -100 
					else pl_modelno
				end)
				, goodsnm, price, url
				, (case 
					when (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept)) then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate) 
					else pl_category
				  end)
				, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate)
				, left(cate, charindex('_',cate)-1)
				from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_7871 with(readuncommitted)
				on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
				inner join tbl_external_category with(readuncommitted)
				on shop_code = 7871 and category_nm = left(cate, charindex('_',cate)-1)
				where pl_vcode = 7871 and goodsnm is not null 
				and (pl_status = '5' or pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept and pl_category <> NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate))) 
				option(maxdop 1)

				set @ModCnt = @@rowcount
			End 

									
		Set @MultiInt = 1
		Set @MultiCnt = (@ModCnt / 300) + 2 
		set @MultiStart = 0
		set @MultiEnd = 300

		WHILE @MultiInt < @MultiCnt
			BEGIN
				BEGIN TRY
					--모델명 변경 처리
					insert into TBL_STRANGE_LIST (sl_plno, sl_vcode, sl_goodsnm, sl_price, sl_url, sl_imgurl, sl_account_yn, sl_deliveryinfo, sl_factory, sl_freeinterest, sl_goodscode, sl_category, sl_modelno)
					select pl_no, pl_vcode, pl_goodsnm, pl_price, pl_url, pl_imgurl, pl_account_yn, pl_deliveryinfo, pl_goodsfactory, pl_freeinterest, pl_goodscode, pl_category, pl_modelno
					from dbo.pricelist with(readuncommitted) inner join @U on pl_no = plno 
					where IDX >= @MultiStart and IDX < @MultiEnd and pl_goodsnm <> '' and replace(pl_goodsnm,' ','') <> replace(goodsnm,' ','') and pl_modelno > 0 option(maxdop 1)
				
					update pricelist
					set pl_modelno = modelno,
					pl_goodsnm = goodsnm, 
					pl_price = price, 
					pl_url = url,
					pl_date = getdate(),
					pl_status = '4',		
					pl_ca_code_dept = gscate,
					pl_category = category,
					pl_multicomment = catename
					--select count(*)
					from dbo.pricelist with(readuncommitted) inner join @U
					on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	

					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300
				END TRY
				BEGIN CATCH
					set @MultiInt = @MultiInt + 1
					set @MultiStart = @MultiEnd
					set @MultiEnd = @MultiInt * 300	
				END CATCH;
			END


			----자료 수정
			--DECLARE @M TABLE
			--(
			--	IDX INT IDENTITY(1,1) PRIMARY KEY,
			--	PLNO BIGINT,
			--	MODELNO INT,
			--	CATEGORY VARCHAR(8),
			--	GSCATE VARCHAR(8),
			--	CATENAME NVARCHAR(100)
			--)						
			--
			----우선순위						
			--insert into @M(plno, modelno, category, gscate, catename) 
			--select pl_no
			--, (case 
			--	when PRIORITY = 1 then -100 
			--	when PRIORITY = 2 then -200 
			--	--when (charindex('일반가전_',cate) = 1 or charindex('컴퓨터_',cate) = 1 or charindex('생활가전_',cate) = 1 or charindex('디지털기기_',cate) = 1 or charindex('서비스_',cate) = 1 or charindex('여행_',cate) = 1) then -300 
			--	else -300 
			--end)
			--, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate) 
			--, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate)
			--, left(cate, charindex('_',cate)-1)
			--from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_7871 with(readuncommitted)
			--on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
			--inner join tbl_external_category with(readuncommitted)
			--on shop_code = 7871 and category_nm = left(cate, charindex('_',cate)-1)
			--where pl_vcode = 7871 and pl_status = '4' and (pl_modelno = 0 or (pl_modelno in (-100,-200,-300) and pl_category = pl_ca_code_dept and pl_category <> NURIBOTDB.dbo.UDF_TEST_RTN_CATE(7871 , cate)))
			--option(maxdop 1)
			--			
			--set @ModCnt = @@rowcount
			--						
			--Set @MultiInt = 1
			--Set @MultiCnt = (@ModCnt / 300) + 2 
			--set @MultiStart = 0
			--set @MultiEnd = 300
			--
			--WHILE @MultiInt < @MultiCnt
			--	BEGIN
			--		BEGIN TRY
			--			update pricelist
			--			set pl_modelno = modelno,
			--			pl_category = category,
			--			pl_ca_code_dept = gscate,
			--			pl_multicomment = catename
			--			--select count(*)
			--			from dbo.pricelist with(readuncommitted) inner join @M
			--			on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
			--
			--			set @MultiInt = @MultiInt + 1
			--			set @MultiStart = @MultiEnd
			--			set @MultiEnd = @MultiInt * 300
			--		END TRY
			--		BEGIN CATCH
			--			set @MultiInt = @MultiInt + 1
			--			set @MultiStart = @MultiEnd
			--			set @MultiEnd = @MultiInt * 300	
			--		END CATCH;
			--	END

				
	
		--통계처리(전체,추가,수정,삭제)	
		If @strTableName = 'TBL_DATA_INSERT_7871'	
			Begin 
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'I')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = @AddCnt, DELCNT = @DelCnt where no = @strStaticsNo
					END
			End
		else if @strTableName = 'TBL_DATA_TOTAL_7871'	
			Begin 
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'T')

				If (@strStaticsNo > 0)
					BEGIN
						update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS_LIST set ALLCNT = @strAllCnt, MODCNT = @ModCnt, ADDCNT = @AddCnt, DELCNT = @DelCnt where no = @strStaticsNo
					END
			End

END


