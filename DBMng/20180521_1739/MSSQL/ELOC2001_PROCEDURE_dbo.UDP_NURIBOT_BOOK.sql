/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_BOOK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-02-28 08:45:17.67
 *        Modify: 2018-05-03 17:23:35.147
 *        Backup: 20180521_1739
 ************************************************************************* */








CREATE   PROCEDURE [dbo].[UDP_NURIBOT_BOOK]

@strTableName char(21),
@strVcode char(4),
@strAllCnt int

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	-- ----------------------------------------------
	-- 작성자 : sung35 / 2011-03-07
	-- 설  명 : 쇼핑몰 Book 번호 매칭
	-- ----------------------------------------------	
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
		
		--분할처리 변수
		DECLARE @MultiInt int
		DECLARE @MultiCnt int
		DECLARE @MultiStart int 
		DECLARE @MultiEnd int

		DECLARE @SzQryMulti VARCHAR(2000)
		DECLARE @DutyChar char(1)
		DECLARE @DutyInt int


		--goods_book 업데이트
		--DECLARE @GMODELNO int
		--DECLARE @GNO int
		--DECLARE @O TABLE
		--(
		--	IDX INT IDENTITY(1,1) PRIMARY KEY,
		--	MODELNO INT
		--)

		--If (@strVcode = '336700')
		--	Begin
		--		insert into @O(MODELNO)
		--		select g_modelno
		--		from goods_book with(readuncommitted)
		--		where regdate >= getdate()-1.1

		--		Set @MultiCnt = @@rowcount	
		--		Set @MultiInt = 1
				
		--		WHILE @MultiInt < @MultiCnt
		--			Begin
		--				select @GMODELNO = MODELNO from @O where IDX = @MultiInt
		--				select @GNO = no FROM OPENQUERY( ORADB, 'select max(NO) + 1 as no from TBL_GOODS' )

		--				IF NOT EXISTS (Select modelno From ORADB..DBENURI.TBL_GOODS Where MODELNO = @GMODELNO)
		--				INSERT INTO ORADB..DBENURI.TBL_GOODS(NO, MODELNO, MODELNM, SPEC, FACTORY, C_DATE, FLAG, CA_CODE, IMGCHK, JOBCODE, CA_LCODE, CONSTRAIN, POPULAR, SUM_POPULAR, CATEFLAG, MALLCNT) 
		--				SELECT @GNO, g_modelno, g_modelnm, g_spec, g_factory, g_date, g_flag, g_category, g_imgchk, g_jobcode, left(g_category,2), '1', 0, 0, '0', 0
		--				FROM goods with(readuncommitted) WHERE g_modelno = @GMODELNO

		--				set @MultiInt = @MultiInt + 1
		--			End		
		--	End		

				
		--가격번호 업데이트
		update pricelist set pl_modelno = np.g_modelno, pl_status = '1'
		from pricelist p 
		inner join (select pl_no, g_modelno 
					from pricelist_book p inner join goods_book g 
					on p.isbn = g.isbn where g.regdate >= getdate()-7) np
		on p.pl_no = np.pl_no
		where pl_vcode = @strVcode and pl_modelno = 0 and pl_status <> '5' and pl_status <> '3'


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
		
		--6367(교보문고) 예외처리, 4027(옥션
		If (@strVcode = '6367')
			begin 	
				set @SzQry = N' update NB01.dbo.' + @strTableName + ' set isbn = goodscode where len(goodscode) = 13 OPTION (MAXDOP 1)'
				exec(@SzQry)
			end
		If (@strVcode = '4027')
			begin 	
				set @SzQry = N' update NB01.dbo.' + @strTableName + ' set deliveryinfo = replace(deliveryinfo,''.0000'','''') where deliveryinfo like ''%.0000'' OPTION (MAXDOP 1)'
				exec(@SzQry)
				
				--모바일가 처리
				update NB01.dbo.TBL_DATA_BOOK_4027 set price_mobile = price

				update NB01.dbo.TBL_DATA_BOOK_4027 set price = b.price,  price_mobile = b.PRICE_MOBILE
				from NB01.dbo.TBL_DATA_BOOK_4027 as a
				inner join NB01.dbo.TBL_DATA_TOTAL_4027 as b
				on a.goodscode = b.goodscode and a.goodscode_cs = b.goodscode_cs
				where isnull(a.price,0) <> b.price or isnull(a.price_mobile,0) <> b.PRICE_MOBILE

			end
		
		--cashback 체크
		set @SzQry = N' update NB01.dbo.' + @strTableName + ' set cashback = 999999 WHERE cashback > 999999 OPTION (MAXDOP 1)'
		exec(@SzQry)
				
		--제조사 빈칸 처리
		set @SzQry = N' update NB01.dbo.' + @strTableName + ' set factory = replace(factory,'' '','''') WHERE factory like ''% %'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		
		--품절 삭제
		set @SzQry = N' delete NB01.dbo.' + @strTableName + ' WHERE price = ''0'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @strAllCnt = @strAllCnt - @@rowcount

		--ISBN 삭제 체크
		set @SzQry = N' delete NB01.dbo.' + @strTableName + ' WHERE isbn = '''' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @strAllCnt = @strAllCnt - @@rowcount
		
		set @SzQry = N' delete NB01.dbo.' + @strTableName + ' WHERE isbn like ''%-%'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @strAllCnt = @strAllCnt - @@rowcount
		
		set @SzQry = N' delete NB01.dbo.' + @strTableName + ' WHERE len(isbn) <> 13 OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @strAllCnt = @strAllCnt - @@rowcount
		
		--국내도서만 체크
		set @SzQry = N' delete NB01.dbo.' + @strTableName + ' WHERE isbn not like ''___89%'' and isbn not like ''___11%'' OPTION (MAXDOP 1)'
		exec(@SzQry)
		set @strAllCnt = @strAllCnt - @@rowcount
		
		--pc가격 = 모바일가격 (6361)홈플러스,(948)팝스포유,(2046)퍼지PC,(2047)팝스디와이,(5978)바보사랑,(6389)패션플러스,(3367)YES24,(4861)알라딘,(6367)교보문고,(6368)영풍문고,(6667)미스터쿤
		If (@strVcode = '6361' or @strVcode = '948' or @strVcode = '2046' or @strVcode = '2047' or @strVcode = '5978' or @strVcode = '6389' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368' or @strVcode = '6667')
			Begin
				set @SzQry = N' UPDATE NB01.dbo.' + @strTableName + ' SET PRICE_MOBILE = PRICE OPTION (MAXDOP 1)'
				exec(@SzQry)
			End
		
													
		--전체개수 체크
		select @NowCnt = count(distinct pl_goodscode) 
		from dbo.pricelist with(readuncommitted)
		where pl_vcode = @strVcode and pl_srvflag = 'B' and pl_status <> '5' and pl_status <> '3' option(maxdop 1)
				

		If (@UpdateChk = '1')
			Begin
				--삭제처리 
				DECLARE @D TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					PLNO BIGINT
				)
				
				--삭제 30% 체크
				If (@strAllCnt >= @NowCnt * 0.7)
					Begin
						If (@strVcode = '6711' or @strVcode = '536' or @strVcode = '4027')
							begin 
								If (@strVcode = '6711')
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_BOOK_6711
										on pl_goodscode = goodscode
										where pl_vcode  = 6711 and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If (@strVcode = '536')
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_BOOK_536
										on pl_goodscode = goodscode
										where pl_vcode  = 536 and pl_srvflag = 'B' and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								else If (@strVcode = '4027')
									begin 
										insert into @D(plno)
										select pl_no
										from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.TBL_DATA_BOOK_4027
										on pl_goodscode = goodscode
										where pl_vcode  = 4027 and pl_srvflag = 'B' and pl_goodsnm <> '' and pl_status <> '5' and pl_status <> '3' and goodscode is null option(maxdop 1)
										
										set @DelCnt = @@rowcount
									end
								
								Set @MultiInt = 1
								Set @MultiCnt = (@DelCnt / 300) + 2 
								set @MultiStart = 0
								set @MultiEnd = 300
								
								WHILE @MultiInt < @MultiCnt
									Begin
										update pricelist set pl_date = getdate(), pl_status = '3', pl_srvflag = (case pl_srvflag when 'B' then '0' else pl_status end)
										from dbo.pricelist with(readuncommitted) inner join @D
										on pl_no = plno where IDX >= @MultiStart and IDX < @MultiEnd option(maxdop 1)	
										
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 300
									End
							end
						else -- 도서전문몰(3367,4858,4859,6367,6368,4861,6378)
							begin
								set @SzQry = N'update pricelist set pl_date = getdate(), pl_status = ''3'', pl_srvflag = (case pl_srvflag when ''B'' then ''0'' else pl_status end)' 
								--set @SzQry = N'select count(*)' 
								set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) left outer join NB01.dbo.' + @strTableName
								set @SzQry = @SzQry + N' on pl_goodscode = goodscode'
								set @SzQry = @SzQry + N' where pl_vcode  = '+@strVcode+' and pl_goodsnm_cs <> checksum('''') and pl_status <> ''5'' and pl_status <> ''3'' and goodscode is null option(maxdop 1)'
						
								exec(@SzQry)
								set @DelCnt = @@rowcount
							end
					End
				Else
					Begin
						set @SzQry = N'UPDATE NURIBOTDB.dbo.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@strVcode
						exec(@SzQry)
					End 

				
				--추가처리
				DECLARE @I TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					IGOODSCODE VARCHAR(50)
				)
				If (@strVcode = '6711')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_BOOK_6711
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 6711
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_GOODSFACTORY, PL_GOODSCODE, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_CASHBACK, PL_AUTHDATE, PL_COUPON, PL_INSTANCE_PRICE)
								select 0, 6711, NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6711 , cate), GOODSNM, PRICE, URL, 'B', '2', IMGURL, FACTORY, GOODSCODE, dbo.UDF_RTN_DELIVERYINFO(isnull(DELIVERYINFO,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(DELIVERYINFO,'')) when '무료배송' then '1' else '2' end), CASHBACK, getdate(), isnull(coupon,0), isnull(price_mobile,0)
								from @I Inner join NB01.dbo.TBL_DATA_BOOK_6711 as t2 with(readuncommitted)
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End								
				else If (@strVcode = '536')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_BOOK_536
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 536 
						where pl_no is null and goodscode <> '' option(maxdop 1)

						set @AddCnt = @@rowcount
												
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_GOODSFACTORY, PL_GOODSCODE, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_CASHBACK, PL_AUTHDATE)
								select 0, 536, '9301', GOODSNM, PRICE, URL, 'B', '2', IMGURL, FACTORY, GOODSCODE, dbo.UDF_RTN_DELIVERYINFO(isnull(DELIVERYINFO,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(DELIVERYINFO,'')) when '무료배송' then '1' else '2' end), CASHBACK, getdate()
								from @I Inner join NB01.dbo.TBL_DATA_BOOK_536 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd

								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				else If (@strVcode = '4027')
					Begin
						insert into @I (IGOODSCODE)
						select goodscode
						from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.TBL_DATA_BOOK_4027
						on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '' and pl_vcode = 4027
						where pl_no is null and goodscode <> '' option(maxdop 1)
						
						set @AddCnt = @@rowcount
						
						Set @MultiInt = 1
						Set @MultiCnt = (@AddCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_GOODSFACTORY, PL_GOODSCODE, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_CASHBACK, PL_AUTHDATE)
								select 0, 4027, '9301', GOODSNM, PRICE, URL, 'B', '2', IMGURL, FACTORY, GOODSCODE, dbo.UDF_RTN_DELIVERYINFO(isnull(DELIVERYINFO,'')), (case dbo.UDF_RTN_DELIVERYINFO(isnull(DELIVERYINFO,'')) when '무료배송' then '1' else '2' end), CASHBACK, getdate()
								from @I Inner join NB01.dbo.TBL_DATA_BOOK_4027
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
								
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					End
				else -- 도서전문몰(3367,4858,4859,6367,6368,4861,6378)
					begin
						set @SzQry = N'insert into pricelist (PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_URL, PL_SRVFLAG, PL_STATUS, PL_IMGURL, PL_GOODSFACTORY, PL_GOODSCODE, PL_DELIVERYINFO, PL_RIGHTNLEFT, PL_CASHBACK, PL_AUTHDATE, PL_COUPON, PL_INSTANCE_PRICE)'
							set @SzQry = @SzQry + N' select' 
							set @SzQry = @SzQry + N' 0,'
							set @SzQry = @SzQry + N' '+@strVcode+','
							If (@strVcode = '6378')
								Begin
									set @SzQry = @SzQry + N' NURIBOTDB.dbo.UDF_TEST_RTN_CATE(6378 , cate),'
								End
							Else
								Begin
									set @SzQry = @SzQry + N' ''9301'','
								End
							set @SzQry = @SzQry + N' goodsnm,'
							set @SzQry = @SzQry + N' price,'
							set @SzQry = @SzQry + N' url,'
							set @SzQry = @SzQry + N' ''B'','
							set @SzQry = @SzQry + N' ''2'','
							set @SzQry = @SzQry + N' imgurl,'
							set @SzQry = @SzQry + N' factory,'
							set @SzQry = @SzQry + N' goodscode,'
							set @SzQry = @SzQry + N' dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
							set @SzQry = @SzQry + N' (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
							set @SzQry = @SzQry + N' cashback,'
							set @SzQry = @SzQry + N' getdate()'
							set @SzQry = @SzQry + N' ,isnull(coupon,0), isnull(price_mobile,0)'
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join NB01.dbo.' + @strTableName +' as t2 with(readuncommitted)'
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '''' and pl_vcode = '+@strVcode 
						set @SzQry = @SzQry + N' where pl_no is null and goodsnm <> '''' option(maxdop 1)'
						
						exec(@SzQry)
						set @AddCnt = @@rowcount	
					end				

				--수정처리 분할
				DECLARE @U TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					PLNO BIGINT,
					GOODSNM NVARCHAR(200),
					PRICE MONEY,
					URL VARCHAR(500),
					IMGURL VARCHAR(250),
					DELIVERYINFO NVARCHAR(100),
					FACTORY NVARCHAR(50), 
					CASHBACK MONEY,
					CATE VARCHAR(8),
					COUPON INT, 
					INSTANCE_PRICE MONEY
				)
				If (@strVcode = '6711' or @strVcode = '536' or @strVcode = '4027')
					begin 
						If @strVcode = '6711'
							begin
								select @strAllCnt = max(no) 
								from NB01.dbo.TBL_DATA_BOOK_6711 with(readuncommitted)
								
								Set @MultiInt = 1
								Set @MultiCnt = (@strAllCnt / 30000) + 2 
								set @MultiStart = 0
								set @MultiEnd = 30000
								WHILE @MultiInt < @MultiCnt
									BEGIN 
										insert into @U(plno, goodsnm, price, url, imgurl, deliveryinfo, factory, cashback, cate, coupon, instance_price) 
										select pl_no, goodsnm, price , url, imgurl, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, cashback, pl_category, isnull(coupon,0), isnull(price_mobile,0)
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_BOOK_6711
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 6711 and pl_goodsnm <> '' and goodsnm is not null
										and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl 
										or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_cashback <> cashback  or pl_coupon <> isnull(coupon,0) or pl_instance_price <> isnull(price_mobile,0) or pl_status = '3' or pl_status = '5')
										and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										
										set @ModCnt = @ModCnt + @@rowcount
									
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 30000
									END
							End
						else If @strVcode = '536'
							begin
								select @strAllCnt = max(no) 
								from NB01.dbo.TBL_DATA_BOOK_536 with(readuncommitted)
								
								Set @MultiInt = 1
								Set @MultiCnt = (@strAllCnt / 30000) + 2 
								set @MultiStart = 0
								set @MultiEnd = 30000
								WHILE @MultiInt < @MultiCnt
									BEGIN 
										insert into @U(plno, goodsnm, price, url, imgurl, deliveryinfo, factory, cashback) 
										select pl_no, goodsnm, price , url, imgurl, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, cashback
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_BOOK_536
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 536 and pl_goodsnm <> '' and goodsnm is not null
										and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl 
										or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_cashback <> cashback or pl_status = '3' or pl_status = '5')
										and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										
										set @ModCnt = @ModCnt + @@rowcount
									
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 30000
									END
							End
						else If @strVcode = '4027'
							begin
								select @strAllCnt = max(no) 
								from NB01.dbo.TBL_DATA_BOOK_4027 with(readuncommitted)
								
								Set @MultiInt = 1
								Set @MultiCnt = (@strAllCnt / 30000) + 2 
								set @MultiStart = 0
								set @MultiEnd = 30000
								WHILE @MultiInt < @MultiCnt
									BEGIN 
										insert into @U(plno, goodsnm, price, url, imgurl, deliveryinfo, factory, cashback, instance_price) 
										select pl_no, goodsnm, price , url, imgurl, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, cashback, isnull(price_mobile,0) 
										from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_BOOK_4027
										on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
										where pl_vcode = 4027 and pl_goodsnm <> '' and goodsnm is not null
										and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl 
										or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_cashback <> cashback or isnull(pl_instance_price,0) <> isnull(price_mobile,0) or pl_status = '3' or pl_status = '5')
										and pl_nochange <> '1' and no >= @MultiStart and no < @MultiEnd option(maxdop 1)
										
										set @ModCnt = @ModCnt + @@rowcount
									
										set @MultiInt = @MultiInt + 1
										set @MultiStart = @MultiEnd
										set @MultiEnd = @MultiInt * 30000
									END
							End		
				
						Set @MultiInt = 1
						Set @MultiCnt = (@ModCnt / 300) + 2 
						set @MultiStart = 0
						set @MultiEnd = 300

						WHILE @MultiInt < @MultiCnt
							BEGIN
								BEGIN TRY
									update pricelist
									set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
									pl_goodsfactory = factory,
									pl_date = getdate(),
									pl_srvflag = 'B',
									pl_status = '1',		
									--배송체크
									pl_deliveryinfo = deliveryinfo,
									pl_rightnleft = (case deliveryinfo when '무료배송' then '1' else '2' end),
									--이미지체크
									pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
									--카테고리
									pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(cast(@strVcode as int), cate) else pl_category end),
									pl_cashback = cashback,
									pl_coupon = coupon,
									pl_instance_price = instance_price
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
					end
				Else -- 도서전문몰(3367,4858,4859,6367,6368,4861,6378)
					BEGIN
						--수정처리
						set @SzQry = N'update pricelist'
						set @SzQry = @SzQry + N' set pl_goodsnm = goodsnm, pl_price = price , pl_url = url, pl_imgurl = imgurl,'
						set @SzQry = @SzQry + N' pl_goodsfactory = factory,'
						set @SzQry = @SzQry + N' pl_date = getdate(),' 
						set @SzQry = @SzQry + N' pl_srvflag = ''B'',' 
						set @SzQry = @SzQry + N' pl_status = ''1'','		
						--배송체크
						set @SzQry = @SzQry + N' pl_deliveryinfo = dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')),'
						set @SzQry = @SzQry + N' pl_rightnleft = (case dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) when ''무료배송'' then ''1'' else ''2'' end),'
						--이미지체크
						set @SzQry = @SzQry + N' pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else ''0'' end),'
						--카테고리
						set @SzQry = @SzQry + N' pl_category = (case when pl_modelno > 0 then pl_category else ''9301'' end),'
						set @SzQry = @SzQry + N' pl_cashback = cashback'
						If (@strVcode = '6378' or @strVcode = '4858' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368')
							Begin
								set @SzQry = @SzQry + N' ,pl_coupon = isnull(coupon,0), pl_instance_price = isnull(price_mobile,0)'
							End
						set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) inner join NB01.dbo.' + @strTableName
						set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_goodsnm <> '''' and goodsnm is not null' 
						set @SzQry = @SzQry + N' and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'''') <> imgurl'
						set @SzQry = @SzQry + N' or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'''') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'''')) or pl_cashback <> cashback'
						If (@strVcode = '6378' or @strVcode = '4858' or @strVcode = '3367' or @strVcode = '4861' or @strVcode = '6367' or @strVcode = '6368')
							Begin
								set @SzQry = @SzQry + N' or pl_coupon <> isnull(coupon,0) or pl_instance_price <> isnull(price_mobile,0)'
							End
						set @SzQry = @SzQry + N' or pl_status = ''3'' or pl_status = ''5'')'
						set @SzQry = @SzQry + N' and pl_nochange <> ''1'' option(maxdop 1)'
							
						exec(@SzQry)
						set @ModCnt = @@rowcount
					END				
				

				--pricelist_book 추가처리
				DECLARE @I_1 TABLE
				(
					IDX INT IDENTITY(1,1) PRIMARY KEY,
					PLNO BIGINT,
					IGOODSCODE VARCHAR(50)
				)

				If @strVcode = '6711'
					begin
						insert into @I_1 (PLNO, IGOODSCODE)
						select p.pl_no, pl_goodscode
						from dbo.pricelist_book b with(readuncommitted) 
						right outer join dbo.pricelist p with(readuncommitted)
						on b.pl_no = p.pl_no 
						where pl_vcode = 6711 and pl_status in ('0','1','2') and pl_modelno < 1 and b.pl_no is null option(maxdop 1)
						
						Set @MultiCnt = (@@rowcount / 300) + 2 
						Set @MultiInt = 1
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist_book (PL_NO, ISBN, PUBLISH_DAY, AUTHOR)
								select PLNO, isbn, publish_day, isnull(author,'')
								from @I_1 Inner join NB01.dbo.TBL_DATA_BOOK_6711 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					end
				else If @strVcode = '536'
					begin
						insert into @I_1 (PLNO, IGOODSCODE)
						select p.pl_no, pl_goodscode
						from dbo.pricelist_book b with(readuncommitted) 
						right outer join dbo.pricelist p with(readuncommitted)
						on b.pl_no = p.pl_no 
						where pl_vcode = 536 and pl_srvflag = 'B' and pl_status in ('0','1','2') and pl_modelno < 1 and b.pl_no is null option(maxdop 1)
						
						Set @MultiCnt = (@@rowcount / 300) + 2 
						Set @MultiInt = 1
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist_book (PL_NO, ISBN, PUBLISH_DAY, AUTHOR)
								select PLNO, isbn, publish_day, isnull(author,'') 
								from @I_1 Inner join NB01.dbo.TBL_DATA_BOOK_536 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					end
				else If @strVcode = '4027'
					begin
						insert into @I_1 (PLNO, IGOODSCODE)
						select p.pl_no, pl_goodscode
						from dbo.pricelist_book b with(readuncommitted) 
						right outer join dbo.pricelist p with(readuncommitted)
						on b.pl_no = p.pl_no 
						where pl_vcode = 4027 and pl_srvflag = 'B' and pl_status in ('0','1','2') and pl_modelno < 1 and b.pl_no is null option(maxdop 1)
						
						Set @MultiCnt = (@@rowcount / 300) + 2 
						Set @MultiInt = 1
						set @MultiStart = 0
						set @MultiEnd = 300
						WHILE @MultiInt < @MultiCnt
							BEGIN
								insert into pricelist_book (PL_NO, ISBN, PUBLISH_DAY, AUTHOR)
								select PLNO, isbn, publish_day, isnull(author,'') 
								from @I_1 Inner join NB01.dbo.TBL_DATA_BOOK_4027 
								On IGOODSCODE = goodscode and IDX >= @MultiStart and IDX < @MultiEnd
																
								set @MultiInt = @MultiInt + 1
								set @MultiStart = @MultiEnd
								set @MultiEnd = @MultiInt * 300
							END
					end
				else -- 도서전문몰(3367,4858,4859,6367,6368,4861,6378)
					begin
						set @SzQry = N'insert into pricelist_book (PL_NO, ISBN, PUBLISH_DAY, AUTHOR)'
						set @SzQry = @SzQry + N' select p.pl_no, d.isbn, d.publish_day, isnull(d.author,'''')' 
						set @SzQry = @SzQry + N' from dbo.pricelist_book b with(readuncommitted)'
						set @SzQry = @SzQry + N' right outer join dbo.pricelist p with(readuncommitted)'
						set @SzQry = @SzQry + N' on b.pl_no = p.pl_no'
						set @SzQry = @SzQry + N' inner join NB01.dbo.' + @strTableName + ' d with(readuncommitted)'
						set @SzQry = @SzQry + N' on p.pl_goodscode = goodscode and  p.pl_goodscode_cs = goodscode_cs'
						set @SzQry = @SzQry + N' where pl_vcode = '+@strVcode+' and pl_status in (''0'',''1'',''2'') and pl_modelno < 1 and b.pl_no is null option(maxdop 1)'
						exec(@SzQry)
					end

				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, @strAllCnt, @ModCnt, @AddCnt, @DelCnt, @SDate, 'B')
			End
		Else
			Begin
				--통계처리(전체,추가,수정,삭제)	
				insert into NURIBOTDB.dbo.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
				values(@strVcode, -1, -1, -1, -1, @SDate, 'B')
			End

END

























































































