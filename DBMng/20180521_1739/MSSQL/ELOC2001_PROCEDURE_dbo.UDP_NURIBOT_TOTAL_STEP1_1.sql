/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_TOTAL_STEP1_1
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-11-30 09:48:40.267
 *        Modify: 2015-05-15 03:31:32.927
 *        Backup: 20180521_1739
 ************************************************************************* */







CREATE   PROCEDURE [dbo].[UDP_NURIBOT_TOTAL_STEP1_1]

@strVcode char(4),
@strChkNo int,
@strDutyCode int

AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
	DECLARE @ModCnt int
	set @ModCnt = -1
	
	--����ó�� ����
	DECLARE @MultiInt int
	DECLARE @MultiCnt int
	DECLARE @MultiStart int 
	DECLARE @MultiEnd int

	DECLARE @SDate smalldatetime
	select @SDate = sdate from NURIBOTDB.dbo.TBL_NB_SHOPSTATICS where no = @strChkNo
	
	DECLARE @DutyCode int
	set @DutyCode = @strDutyCode % 10

	If @strDutyCode % 5 = 0
		begin
			waitfor delay '00:08:05'
		end 
	else If @strDutyCode % 5 = 1
		begin
			waitfor delay '00:06:05'
		end 
	else If @strDutyCode % 5 = 2
		begin
			waitfor delay '00:04:05'
		end 
	else If @strDutyCode % 5 = 3
		begin
			waitfor delay '00:02:05'
		end 
	else If @strDutyCode % 5 = 4
		begin
			waitfor delay '00:00:05'
		end 	
	
	
	-- 1:
	DECLARE @U1_1 TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		PLNO INT,
		--GOODSCODE VARCHAR(50),
		GOODSNM NVARCHAR(200),
		PRICE MONEY,
		URL VARCHAR(500),
		IMGURL VARCHAR(250),
		ACCOUNT_YN char(1),
		DELIVERYINFO NVARCHAR(100),
		FACTORY NVARCHAR(50),
		FREEINTEREST NVARCHAR(50),
		CATE NVARCHAR(100),
		PRICE_CARD MONEY,

		TAG_PRICE MONEY,
		CALL_PLAN VARCHAR(3),
		IN_FEE_YN char(1),
		SHIP_FEE_YN char(1),	
		BOND_FEE MONEY,
		PENALITY_FEE MONEY
	)
	
	If @strVcode = '536'
	--If (@strVcode = '536' and DATEPART(hh,getdate()) < 12)
		begin
			--Set @MultiInt = 1
			---Set @MultiCnt = (@strAllCnt / 700000) + 2 
			--set @MultiStart = 0
			--set @MultiEnd = 700000
			--WHILE @MultiInt < @MultiCnt
			--	BEGIN
					insert into @U1_1(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
					select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_536 
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 536 and pl_modelno < 1 and pl_date < @SDate and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					--or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> (case when freeinterest <> '' then '1' else '' end) or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> (case when freeinterest <> '' then '1' else '' end) or isnull(pl_category,'') = '' or pl_status = '3' or pl_status = '5')
					and pl_nochange <> '1' and pl_dutycode = @DutyCode and pl_no % 20 = @strDutyCode option(maxdop 0)
			--		and no >= @MultiStart and no < @MultiEnd and pl_dutycode = @strDutyCode option(maxdop 0)
					
					set @ModCnt = @@rowcount
			--		set @MultiInt = @MultiInt + 1
			--		set @MultiStart = @MultiEnd
			--		set @MultiEnd = @MultiInt * 700000
			--	END
		end
	else If @strVcode = '4027'
	--else If (@strVcode = '4027' and DATEPART(hh,getdate()) < 12)
		begin 
			--Set @MultiInt = 1
			--Set @MultiCnt = (@strAllCnt / 700000) + 2 
			--set @MultiStart = 0
			--set @MultiEnd = 700000
			--WHILE @MultiInt < @MultiCnt
			--	BEGIN
			DECLARE @Day VARCHAR(3)
			select @Day = datename(dw,getdate())

			--If @Day = '�����_�ӽû���'
			--	begin
					insert into @U1_1(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card) 
					select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate, price_card
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_4027
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 4027 and pl_modelno < 1 and pl_date < @SDate and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> (case when freeinterest <> '' then '1' else '' end) or isnull(pl_category,'') = '' or pl_status = '3' or pl_status = '5')
					and pl_nochange <> '1' and pl_dutycode = @DutyCode and pl_no % 20 = @strDutyCode option(maxdop 0)
					
					set @ModCnt = @@rowcount
			--	end
			--else
			--	begin
			--		insert into @U1_1(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card) 
			--		select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, (case when freeinterest <> '' then '1' else '' end), cate, price_card
			--		from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_4027
			--		on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
			--		where pl_vcode = 4027 and pl_modelno < 1 and pl_date < @SDate and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B'
			--		and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
			--		or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> (case when freeinterest <> '' then '1' else '' end) or isnull(pl_price_card,0) <> price_card or pl_status = '3' or pl_status = '5' or isnull(pl_category,'') = '')
			--		and pl_dutycode = @DutyCode and pl_no % 20 = @strDutyCode  option(maxdop 0)
			--		and no >= @MultiStart and no < @MultiEnd and pl_dutycode = @strDutyCode option(maxdop 0)
			--		
			--		set @ModCnt = @@rowcount
			--	end
					
				
			--		set @MultiInt = @MultiInt + 1
			--		set @MultiStart = @MultiEnd
			--		set @MultiEnd = @MultiInt * 700000
			--	END
		end
	else If @strVcode = '5910'
		begin
			--Set @MultiInt = 1
			--Set @MultiCnt = (@strAllCnt / 700000) + 2 
			--set @MultiStart = 0
			--set @MultiEnd = 700000
			--WHILE @MultiInt < @MultiCnt
			--	BEGIN
					insert into @U1_1(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate) 
					select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_5910
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 5910 and pl_modelno < 1 and pl_date < @SDate and pl_goodsnm <> '' and goodsnm is not null
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_category,'') = '' or pl_status = '3' or pl_status = '5') 
					and pl_nochange <> '1' and pl_dutycode = @DutyCode and pl_no % 20 = @strDutyCode option(maxdop 0)
			--		and no >= @MultiStart and no < @MultiEnd and pl_dutycode = @strDutyCode option(maxdop 0)
								
					set @ModCnt = @@rowcount

			--		set @MultiInt = @MultiInt + 1
			--		set @MultiStart = @MultiEnd
			--		set @MultiEnd = @MultiInt * 700000
			--	END
		end
	else If @strVcode = '55'
		begin
			--If (@strDutyCode > 9)
			--	begin
			--		set @ModCnt = 0
			--	end
			--else
			--	BEGIN
					insert into @U1_1(plno, goodsnm, price, url, imgurl, account_yn, deliveryinfo, factory, freeinterest, cate, price_card, tag_price, call_plan, in_fee_yn, ship_fee_yn, bond_fee, penality_fee) 
					select pl_no, goodsnm, case pl_nochange when '1' then pl_price else price end, url, imgurl, account_yn, dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')), factory, freeinterest, cate, price_card, isnull(tag_price,0), isnull(call_plan,''), isnull(in_fee_yn,''), isnull(ship_fee_yn,''), isnull(bond_fee,0), isnull(penality_fee,0)
					from dbo.pricelist with(readuncommitted) inner join NB01.dbo.TBL_DATA_TOTAL_55
					on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs
					where pl_vcode = 55 and pl_modelno < 1 and pl_date < @SDate and pl_goodsnm <> '' and goodsnm is not null and pl_srvflag <> 'B' 
					and (pl_goodsnm <> goodsnm or pl_price <> price or pl_url <> url or isnull(pl_imgurl,'') <> imgurl or pl_account_yn <> account_yn
					or pl_goodsfactory <> factory or isnull(pl_deliveryinfo,'') <> dbo.UDF_RTN_DELIVERYINFO(isnull(deliveryinfo,'')) or pl_freeinterest <> freeinterest or isnull(pl_price_card,0) <> price_card 
					or isnull(pl_tag_price,0) <> isnull(tag_price,0) or isnull(pl_call_plan,'') <> isnull(call_plan,'') or isnull(pl_in_fee_yn,'') <> isnull(in_fee_yn,'') or isnull(pl_ship_fee_yn,'') <> isnull(ship_fee_yn,'') or isnull(pl_bond_fee,0) <> isnull(bond_fee,0) or isnull(pl_penality_fee,0) <> isnull(penality_fee,0)	or isnull(pl_category,'') = '' or pl_status = '3' or pl_status = '5') 
					and pl_nochange <> '1' and pl_dutycode = @DutyCode and pl_no % 20 = @strDutyCode option(maxdop 0)
										
					set @ModCnt =  @@rowcount
			--	END
		end

	--If @ModCnt > 1
	--	Begin
	--		--���ó��(��ü,�߰�,����,����)	
	--		update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set MODCNT = MODCNT + @ModCnt
	--		where no = @strChkNo
	--	End

	Set @MultiInt = 1
	Set @MultiCnt = (@ModCnt / 500) + 2 
	set @MultiStart = 0
	set @MultiEnd = 500

	WHILE @MultiInt < @MultiCnt
	--WHILE @MultiInt < @ModCnt
		BEGIN
			update pricelist
			set pl_goodsnm = goodsnm, pl_price = price, pl_url = url, pl_imgurl = imgurl,
			pl_account_yn = account_yn, pl_goodsfactory = factory, pl_freeinterest = freeinterest,
			pl_date = getdate(),
			--pl_date = (case level_chk when '1' then getdate() else @SDate end),
			--����üũ
			pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, price, pl_vcode) end),		
			--���üũ
			pl_deliveryinfo = deliveryinfo,
			pl_rightnleft = (case deliveryinfo when '������' then '1' else '2' end),
			--�̹���üũ
			pl_imgurlflag = (case pl_imgurl when imgurl then pl_imgurlflag else '0' end),
			--��ġ��
			--pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_airconfeetype),
			--��ġ���߰�
			pl_srvflag = dbo.UDF_TEST_RTN_CHK_SRVFLAG(pl_vcode, pl_modelno, pl_category, pl_goodsnm, goodsnm, pl_srvflag),
			--ī�װ�
			pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(cast(@strVcode as int), cate) else pl_category end),
			pl_price_card = price_card,
			pl_tag_price = isnull(tag_price,0), pl_call_plan = isnull(call_plan,''), pl_in_fee_yn = isnull(in_fee_yn,''), pl_ship_fee_yn = isnull(ship_fee_yn,''), pl_bond_fee = isnull(bond_fee,0), pl_penality_fee = isnull(penality_fee,0)
			--select count(*)
			from dbo.pricelist with(readuncommitted) inner join @U1_1
			on pl_no = plno where pl_vcode = @strVcode and IDX >= @MultiStart and IDX < @MultiEnd and pl_date < @SDate option(maxdop 0)	
			--on pl_no = plno where IDX = @MultiInt option(maxdop 0)	
			--on pl_no = plno and pl_vcode = @strVcode and pl_dutycode = @strDutyCode where IDX = @MultiInt option(maxdop 0)	

			update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set MODCNT = MODCNT + @@rowcount
			where no = @strChkNo

			set @MultiInt = @MultiInt + 1
			set @MultiStart = @MultiEnd
			set @MultiEnd = @MultiInt * 500
		END
	
	--If @MultiInt > 0
	--	Begin
	--		--���ó��(��ü,�߰�,����,����)	
	--		update NURIBOTDB.dbo.TBL_NB_SHOPSTATICS set DATE = getdate(), MODCNT = MODCNT + @MultiInt
	--		where no = @strChkNo
	--	End
		
END














































































