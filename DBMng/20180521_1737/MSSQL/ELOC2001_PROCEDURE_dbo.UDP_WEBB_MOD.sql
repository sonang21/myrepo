/* *************************************************************************
 * NAME : dbo.UDP_WEBB_MOD
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2008-07-16 14:58:31.91
 *        Modify: 2015-05-15 03:31:33.473
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE PROC [dbo].[UDP_WEBB_MOD]

	@VCODE			INT,
	@CATENAME		VARCHAR(100),
	@PL_GOODSNM		NVARCHAR(200),
	@PRICE			MONEY,
	@URL			VARCHAR(500),
	@IMGURL		VARCHAR(250),
	@ACCOUNT_YN		CHAR(1),
	@FREEINTEREST		VARCHAR(50),
	@GOODSFACTORY	VARCHAR(50),
	@GOODSCODE		VARCHAR(50),
	@DELIVERY		VARCHAR(100),
		
	@iRETURN	INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		
	If @DELIVERY = '무료배송' 
		begin
			update pricelist
			set pl_date = getdate(), pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_imgurl = @IMGURL,
			pl_account_yn = @ACCOUNT_YN, pl_goodsfactory = @GOODSFACTORY, pl_freeinterest = @FREEINTEREST,
			--가격체크
			pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, @PRICE) end),		
			--배송체크
			pl_deliveryinfo = '무료배송', pl_rightnleft = '1',
			--이미지체크
			pl_imgurlflag = (case pl_imgurl when @IMGURL then pl_imgurlflag else '0' end),
			--설치비
			pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_modelno, pl_category, pl_goodsnm, @PL_GOODSNM, pl_airconfeetype),
			--설치비추가
			pl_srvflag = dbo.UDF_TEST_RTN_FEETYPE_SRVFLAG(pl_modelno, pl_category, pl_goodsnm, @PL_GOODSNM, pl_srvflag),
			--카테고리
			pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(@VCODE, @CATENAME) else pl_category end)
			Where pl_goodscode = @GOODSCODE and pl_goodscode_cs = checksum(@GOODSCODE) and pl_vcode = @VCODE
		end
	else if @DELIVERY = ''	
		begin
			update pricelist
			set pl_date = getdate(), pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_imgurl = @IMGURL,
			pl_account_yn = @ACCOUNT_YN, pl_goodsfactory = @GOODSFACTORY, pl_freeinterest = @FREEINTEREST,
			--가격체크
			pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, @PRICE) end),		
			--배송체크
			pl_deliveryinfo = '유무료', pl_rightnleft = '2',
			--이미지체크
			pl_imgurlflag = (case pl_imgurl when @IMGURL then pl_imgurlflag else '0' end),
			--설치비
			pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_modelno, pl_category, pl_goodsnm, @PL_GOODSNM, pl_airconfeetype),
			--설치비추가
			pl_srvflag = dbo.UDF_TEST_RTN_FEETYPE_SRVFLAG(pl_modelno, pl_category, pl_goodsnm, @PL_GOODSNM, pl_srvflag),
			--카테고리
			pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(@VCODE, @CATENAME) else pl_category end)
			Where pl_goodscode = @GOODSCODE and pl_goodscode_cs = checksum(@GOODSCODE) and pl_vcode = @VCODE
		end 
	else
		begin
			update pricelist
			set pl_date = getdate(), pl_goodsnm = @PL_GOODSNM, pl_price = @PRICE, pl_url = @URL, pl_imgurl = @IMGURL,
			pl_account_yn = @ACCOUNT_YN, pl_goodsfactory = @GOODSFACTORY, pl_freeinterest = @FREEINTEREST,
			--가격체크
			pl_status = (case pl_status when '8' then pl_status when '9' then pl_status else dbo.UDF_TEST_RTN_STATUS(pl_modelno, pl_category, pl_price, @PRICE) end),		
			--배송체크
			pl_deliveryinfo = @DELIVERY, pl_rightnleft = '2',
			--이미지체크
			pl_imgurlflag = (case pl_imgurl when @IMGURL then pl_imgurlflag else '0' end),
			--설치비
			pl_airconfeetype = dbo.UDF_TEST_RTN_FEETYPE(pl_modelno, pl_category, pl_goodsnm, @PL_GOODSNM, pl_airconfeetype),
			--설치비추가
			pl_srvflag = dbo.UDF_TEST_RTN_FEETYPE_SRVFLAG(pl_modelno, pl_category, pl_goodsnm, @PL_GOODSNM, pl_srvflag),
			--카테고리
			pl_category = (case isnull(pl_category,'') when '' then NURIBOTDB.dbo.UDF_TEST_RTN_CATE(@VCODE, @CATENAME) else pl_category end)
			Where pl_goodscode = @GOODSCODE and pl_goodscode_cs = checksum(@GOODSCODE) and pl_vcode = @VCODE
		end 

	IF @@ERROR<>0
		BEGIN
			SET @iRETURN = 99
		END
	ELSE
		BEGIN
			SET @iRETURN = 0
		END

END
