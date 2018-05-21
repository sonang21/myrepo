/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_SRVFLAG3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-02 14:21:01.64
 *        Modify: 2018-05-03 17:23:35.423
 *        Backup: 20180521_1739
 ************************************************************************* */



CREATE   PROCEDURE [dbo].[UDP_NURIBOT_SRVFLAG3]

@strVcode CHAR(4),
@SLMAX VARCHAR(20)

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	--단종3 로그 처리
	DECLARE @SLNO INT
	DECLARE @SLCATEGORY VARCHAR(8)
	DECLARE @SLVCODE INT
	DECLARE @SLPLNO BIGINT
	DECLARE @SLMODELNO INT
	DECLARE @SLGOODSCODE VARCHAR(50)
	DECLARE @SLURL VARCHAR(500)
	DECLARE @SLPRICE MONEY
	DECLARE @SLSRVFLAG CHAR(1)

	DECLARE @SLMINPRICE MONEY 
	DECLARE @SLUPGOODSNM NVARCHAR(200)
	DECLARE @SLUPPRICE MONEY 
	DECLARE	@SLUPPRICEMOBILE MONEY
	DECLARE	@LIMITPCT1 TINYINT

	
	DECLARE @MAX INT
	DECLARE @PERCENT TINYINT

	DECLARE @SL TABLE
	(
		IDX INT IDENTITY(1,1) PRIMARY KEY,
		SLNO BIGINT,
		SLCATEGORY VARCHAR(8),
		SLVCODE INT,
		SLPLNO BIGINT,
		SLMODELNO INT,
		SLGOODSCODE VARCHAR(50),
		SLURL VARCHAR(500),
		SLPRICE MONEY,
		SLSRVFLAG CHAR(1),

		SLMINPRICE MONEY, 
		SLUPGOODSNM NVARCHAR(200),
		SLUPPRICE MONEY, 
		SLUPPRICEMOBILE MONEY,
		LIMITPCT1 TINYINT
	)

	INSERT INTO @SL(SLNO, SLCATEGORY, SLVCODE, SLPLNO, SLMODELNO, SLGOODSCODE, SLURL, SLPRICE, SLSRVFLAG, SLMINPRICE, SLUPGOODSNM, SLUPPRICE, SLUPPRICEMOBILE, LIMITPCT1)
		SELECT SL_NO, SL_CATEGORY, SL_VCODE, SL_PLNO, SL_MODELNO, SL_GOODSCODE, SL_URL, SL_PRICE, SL_SRVFLAG, SL_MINPRICE, SL_UP_GOODSNM, SL_UP_PRICE, SL_UP_PRICE_MOBILE, LIMIT_PCT1
		FROM TBL_STRANGE_LIST WITH (READUNCOMMITTED) INNER JOIN TBL_RT_SRV_OFF_SET
		ON LEFT(SL_CATEGORY,4) = CATEGORY
		WHERE SL_SRVFLAG in ('3','4') AND SL_VCODE = @strVcode AND SL_NO > @SLMAX
				
	SET @MAX = @@ROWCOUNT
				
	WHILE @MAX<>0
		BEGIN
		
			SELECT @SLNO = SLNO, @SLCATEGORY = SLCATEGORY, @SLVCODE = SLVCODE, @SLPLNO = SLPLNO, @SLMODELNO = SLMODELNO, @SLGOODSCODE = SLGOODSCODE, @SLURL = SLURL, @SLPRICE = SLPRICE, @SLSRVFLAG = SLSRVFLAG, @SLMINPRICE = SLMINPRICE, @SLUPGOODSNM = SLUPGOODSNM, @SLUPPRICE = SLUPPRICE, @SLUPPRICEMOBILE = SLUPPRICEMOBILE, @LIMITPCT1 = LIMITPCT1
			FROM @SL 
			WHERE IDX=@MAX

			SET @PERCENT = ROUND(CONVERT(FLOAT, @SLUPPRICE) / CONVERT(FLOAT, @SLMINPRICE / 100), 0)

			UPDATE PRICELIST SET PL_SRVFLAG = '3' WHERE PL_NO = @SLPLNO

			IF (@SLSRVFLAG = '3')	
				Begin
					INSERT OPENQUERY (ORADB, 'SELECT CA_CODE, SHOP_CODE, PL_NO, MODELNO, GOODSCODE, URL, ORG_PRICE, UP_PRICE, ORG_DELINFO, UP_DELINFO, ERROR_CODE, LOGO_TYPE, PRICE_CHECK, SERVICE_DIVIS, SERVICE_TYPE, MIN_PRICE, HASBEEN_PERCENT, HASBEEN_SET_PERCENT FROM TBL_MINI_NURIBOT_LOG')
					VALUES (@SLCATEGORY, @SLVCODE, @SLPLNO, @SLMODELNO,	@SLGOODSCODE, @SLURL, @SLPRICE, @SLUPPRICE, '0', '0', '9', '2', '2', '5', '1', @SLMINPRICE, @PERCENT, @LIMITPCT1)
			 
					insert into logdb.dbo.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_MINPRICE)
					values (@SLPLNO, @SLMODELNO, @SLVCODE, 'PC_NURI_REAL3', '1', @SLUPGOODSNM, @SLUPPRICE, @SLCATEGORY, @SLUPPRICEMOBILE, @SLMINPRICE)
				End
			Else
				Begin
					INSERT OPENQUERY (ORADB, 'SELECT CA_CODE, SHOP_CODE, PL_NO, MODELNO, GOODSCODE, URL, ORG_PRICE, UP_PRICE, ORG_DELINFO, UP_DELINFO, ERROR_CODE, LOGO_TYPE, PRICE_CHECK, SERVICE_DIVIS, SERVICE_TYPE, MIN_PRICE, HASBEEN_PERCENT, HASBEEN_SET_PERCENT FROM TBL_MINI_NURIBOT_LOG')
					VALUES (@SLCATEGORY, @SLVCODE, @SLPLNO, @SLMODELNO,	@SLGOODSCODE, @SLURL, @SLPRICE, @SLUPPRICE, '0', '0', '9', '2', '2', '5', '2', @SLMINPRICE, @PERCENT, @LIMITPCT1)
			 
					insert into logdb.dbo.JOB_PRICELIST (JP_PLISTNO, JP_MODELNO, JP_VCODE, JP_ID, JP_FLAG, JP_GOODSNM, JP_PRICE, JP_CATEGORY, JP_PRICE_MOBILE, JP_MINPRICE)
					values (@SLPLNO, @SLMODELNO, @SLVCODE, 'M_NURI_REAL3', '1', @SLUPGOODSNM, @SLUPPRICE, @SLCATEGORY, @SLUPPRICEMOBILE, @SLMINPRICE)

					update TBL_STRANGE_LIST set sl_srvflag = '3' where sl_no = @SLNO
				End					

			SET @MAX = @MAX-1
		END
	
END































































































































