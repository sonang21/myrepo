/* *************************************************************************
 * NAME : dbo.UDP_NURIBOT_MAIN
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2015-07-23 19:39:32.7
 *        Modify: 2018-05-03 17:23:34.593
 *        Backup: 20180521_1739
 ************************************************************************* */




CREATE PROCEDURE [dbo].[UDP_NURIBOT_MAIN]

@VCODE VARCHAR(4),
@TYPE CHAR(1),
@TABLE_NAME VARCHAR(30),
@ALLCNT INT

AS
BEGIN
	SET NOCOUNT ON
	--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @SZQRY VARCHAR(3000)
	DECLARE @NOWCNT INT
	DECLARE @DELCNT INT
	DECLARE @MODCNT INT
	DECLARE @ADDCNT INT

	--분할처리 변수
	DECLARE @MultiInt int
	DECLARE @MultiCnt int
	DECLARE @MultiStart int 
	DECLARE @MultiEnd int
	
	DECLARE @TBL_NB_SHOPSTATICS_NO VARCHAR(20)
	DECLARE @INS_QRY1 VARCHAR(1000) 
	DECLARE @INS_QRY2 VARCHAR(1000) 
	DECLARE @UP_QRY1 VARCHAR(1000) 
	DECLARE @UP_QRY2 VARCHAR(1000) 
	DECLARE @DEL_QRY VARCHAR(1000) 
		
	DECLARE @GROUPINFO Char(1) 
	DECLARE @INS_FLAG Char(1) 
	DECLARE @UP_FLAG Char(1) 
	DECLARE @DEL_FLAG Char(1) 

	DECLARE @GOODSCODE_FLAG Char(1) 
	DECLARE @GOODSNM_FLAG Char(1) 
	DECLARE @PRICE_FLAG Char(1) 
	DECLARE @URL_FLAG Char(1) 
	DECLARE @DELIVERYINFO_FLAG Char(1) 
	DECLARE @IMGURL_FLAG Char(1) 
	DECLARE @ACCOUNT_YN_FLAG Char(1) 
	DECLARE @FREEINTEREST_FLAG Char(1) 
	DECLARE @FACTORY_FLAG Char(1) 
	DECLARE @CATE_FLAG Char(1) 
	DECLARE @PRICE_CARD_FLAG Char(1) 
	DECLARE @PRICE_MOBILE_FLAG Char(1) 
	DECLARE @COUPON_FLAG Char(1) 
	DECLARE @HOMEFLAG_FLAG Char(1) 
	DECLARE @DELIVERY_LEV_FLAG Char(1) 
	DECLARE @SET_YN_FLAG Char(1) 
	DECLARE @TAG_PRICE_FLAG Char(1) 
	DECLARE @CALL_PLAN_FLAG Char(1) 
	DECLARE @IN_FEE_YN_FLAG Char(1) 
	DECLARE @SHIP_FEE_YN_FLAG Char(1) 
	DECLARE @BOND_FEE_FLAG Char(1) 
	DECLARE @PENALITY_FEE_FLAG Char(1)
		
	SELECT @GROUPINFO = GROUPINFO
	, @INS_FLAG = INS_FLAG
	, @UP_FLAG = UP_FLAG
	, @DEL_FLAG = DEL_FLAG
	, @GOODSCODE_FLAG = GOODSCODE_FLAG
	, @GOODSNM_FLAG = GOODSNM_FLAG
	, @PRICE_FLAG = PRICE_FLAG
	, @URL_FLAG = URL_FLAG
	, @DELIVERYINFO_FLAG = DELIVERYINFO_FLAG
	, @IMGURL_FLAG = IMGURL_FLAG
	, @ACCOUNT_YN_FLAG = ACCOUNT_YN_FLAG
	, @FREEINTEREST_FLAG = FREEINTEREST_FLAG
	, @FACTORY_FLAG = FACTORY_FLAG
	, @CATE_FLAG = CATE_FLAG
	, @PRICE_CARD_FLAG = PRICE_CARD_FLAG
	, @PRICE_MOBILE_FLAG = PRICE_MOBILE_FLAG
	, @COUPON_FLAG = COUPON_FLAG
	, @HOMEFLAG_FLAG = HOMEFLAG_FLAG
	, @DELIVERY_LEV_FLAG = DELIVERY_LEV_FLAG
	, @SET_YN_FLAG = SET_YN_FLAG
	, @TAG_PRICE_FLAG = TAG_PRICE_FLAG
	, @CALL_PLAN_FLAG = CALL_PLAN_FLAG
	, @IN_FEE_YN_FLAG = IN_FEE_YN_FLAG
	, @SHIP_FEE_YN_FLAG = SHIP_FEE_YN_FLAG
	, @BOND_FEE_FLAG = BOND_FEE_FLAG
	, @PENALITY_FEE_FLAG = PENALITY_FEE_FLAG
	FROM NURIBOTDB.DBO.TBL_NB_SHOPLIST A WITH(READUNCOMMITTED)
	INNER JOIN NURIBOTDB.DBO.TBL_NB_SHOPURL B WITH(READUNCOMMITTED)
	ON A.VCODE = B.VCODE
	WHERE A.VCODE = @VCODE AND B.STATUSFLAG = @TYPE


	--초기 설정
	INSERT INTO NURIBOTDB.DBO.TBL_NB_SHOPSTATICS (VCODE, ALLCNT, MODCNT, ADDCNT, DELCNT, SDATE, STATUSFLAG) 
	VALUES(@VCODE, -1, -1, -1, -1, GETDATE(), @TYPE)
	SET @TBL_NB_SHOPSTATICS_NO = @@identity



	--예외처리
	



	--전체개수 체크
	SELECT @NOWCNT = COUNT(DISTINCT PL_GOODSCODE) 
	FROM DBO.PRICELIST WITH(READUNCOMMITTED)
	WHERE PL_VCODE = @VCODE AND PL_GOODSNM <> '' AND PL_STATUS NOT IN ('3','5') AND pl_srvflag not in ('M','B') OPTION(MAXDOP 1)
		

	SET @INS_QRY1 = 'INSERT INTO PRICELIST (PL_MODELNO, PL_VCODE, PL_SRVFLAG, PL_STATUS, PL_AUTHDATE, PL_AIRCONFEETYPE, PL_STORE_FLAG'
	SET @INS_QRY2 = ') SELECT 0, '+ @VCODE +', dbo.UDF_TEST_RTN_SRVFLAG(GOODSNM), ''2'', GETDATE(), DBO.UDF_RTN_AIRCONFEETYPE(GOODSNM), DBO.UDF_RTN_STORE_FLAG('+ @VCODE +', 0, '''', GOODSNM, '''', CATE, URL)'

	SET @UP_QRY1 = 'UPDATE PRICELIST SET PL_SRVFLAG = DBO.UDF_TEST_RTN_CHK_SRVFLAG(PL_VCODE, PL_MODELNO, PL_CATEGORY, PL_GOODSNM, GOODSNM, PL_SRVFLAG, PL_PRICE, PRICE)'
	SET @UP_QRY1 = @UP_QRY1 + ', PL_STATUS = (CASE PL_STATUS WHEN ''8'' THEN PL_STATUS WHEN ''9'' THEN PL_STATUS ELSE DBO.UDF_TEST_RTN_STATUS(PL_MODELNO, PL_CATEGORY, PL_PRICE, PRICE, PL_VCODE) END)'
	SET @UP_QRY1 = @UP_QRY1 + ', PL_DATE = GETDATE()'
	SET @UP_QRY1 = @UP_QRY1 + ', PL_STORE_FLAG = DBO.UDF_RTN_STORE_FLAG(PL_VCODE, PL_MODELNO, PL_GOODSNM, GOODSNM, ISNULL(PL_STORE_FLAG,''''), CATE, PL_URL)'
	SET @UP_QRY1 = @UP_QRY1 + ', PL_CA_CODE_DEPT = DBO.UDF_RTN_DEPT_CATE(PL_VCODE, PL_MODELNO, PL_GOODSNM, GOODSNM, ISNULL(PL_STORE_FLAG,''''), PL_CA_CODE_DEPT)'
	SET @UP_QRY2 = '(PL_STATUS = ''3'' OR PL_STATUS = ''5'' OR ISNULL(PL_CATEGORY,'''') = '''''

	--상품코드
	IF (@GOODSCODE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_GOODSCODE' 
	IF (@GOODSCODE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', GOODSCODE' 
		
	--상품명
	IF (@GOODSNM_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_GOODSNM'	
	IF (@GOODSNM_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', GOODSNM'	
	IF (@GOODSNM_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_GOODSNM = GOODSNM'	
	IF (@GOODSNM_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_GOODSNM <> GOODSNM'	
	
	--가격
	IF (@PRICE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_PRICE'	
	IF (@PRICE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', PRICE'	
	IF (@PRICE_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_PRICE = PRICE'	
	IF (@PRICE_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_PRICE <> PRICE'
		
	--URL
	IF (@URL_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_URL'	
	IF (@URL_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', URL'	
	IF (@URL_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_URL = URL'	
	IF (@URL_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_URL <> URL'	

	--배송비
	IF (@DELIVERYINFO_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_DELIVERYINFO, PL_RIGHTNLEFT'	
	IF (@DELIVERYINFO_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', DBO.UDF_RTN_DELIVERYINFO(ISNULL(DELIVERYINFO,'''')), (CASE DBO.UDF_RTN_DELIVERYINFO(ISNULL(DELIVERYINFO,'''')) WHEN ''무료배송'' THEN ''1'' ELSE ''2'' END)'	
	IF (@DELIVERYINFO_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_DELIVERYINFO = DBO.UDF_RTN_DELIVERYINFO(ISNULL(DELIVERYINFO,'''')), PL_RIGHTNLEF =  (CASE DBO.UDF_RTN_DELIVERYINFO(ISNULL(DELIVERYINFO,'''')) WHEN ''무료배송'' THEN ''1'' ELSE ''2'' END)'	
	IF (@DELIVERYINFO_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_DELIVERYINFO <> DELIVERYINFO'	
		
	--IMGURL
	IF (@IMGURL_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_IMGURL'	
	IF (@IMGURL_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', IMGURL'	
	IF (@IMGURL_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_IMGURL = IMGURL, PL_IMGURLFLAG = (CASE PL_IMGURL WHEN IMGURL THEN PL_IMGURLFLAG ELSE ''0'' END)'	
	IF (@IMGURL_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_IMGURL <> IMGURL'	
		
	--계산서
	IF (@ACCOUNT_YN_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_ACCOUNT_YN'	
	IF (@ACCOUNT_YN_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', ACCOUNT_YN'	
	IF (@ACCOUNT_YN_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_ACCOUNT_YN = ACCOUNT_YN'	
	IF (@ACCOUNT_YN_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_ACCOUNT_YN <> ACCOUNT_YN'	
		
	--URL
	IF (@FREEINTEREST_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_FREEINTEREST'	
	IF (@FREEINTEREST_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', FREEINTEREST'	
	IF (@FREEINTEREST_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_FREEINTEREST = FREEINTEREST'	
	IF (@FREEINTEREST_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_FREEINTEREST <> FREEINTEREST'	
			
	--제조사
	IF (@FACTORY_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_GOODSFACTORY'	
	IF (@FACTORY_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', FACTORY'	
	IF (@FACTORY_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_GOODSFACTORY = FACTORY'	
	IF (@FACTORY_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_GOODSFACTORY <> FACTORY'	
		
	--카테고리
	IF (@CATE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_CATEGORY'	
	IF (@CATE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', NURIBOTDB.dbo.UDF_TEST_RTN_CATE('+ @VCODE +' , CATE)'	
	IF (@CATE_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_CATEGORY = (CASE ISNULL(PL_CATEGORY,'') WHEN '' THEN NURIBOTDB.DBO.UDF_TEST_RTN_CATE(CAST(@VCODE AS INT), CATE) ELSE PL_CATEGORY END)'	
	IF (@CATE_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ', '	
	
	--카드가
	IF (@PRICE_CARD_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_PRICE_CARD'	
	IF (@PRICE_CARD_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', PRICE_CARD'	
	IF (@PRICE_CARD_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_PRICE_CARD = PRICE_CARD'	
	IF (@PRICE_CARD_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_PRICE_CARD <> PRICE_CARD '	
	
	--모바일가
	IF (@PRICE_MOBILE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_INSTANCE_PRICE'	
	IF (@PRICE_MOBILE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', PRICE_MOBILE'	
	IF (@PRICE_MOBILE_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_INSTANCE_PRICE = PRICE_MOBILE'	
	IF (@PRICE_MOBILE_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_INSTANCE_PRICE <> PRICE_MOBILE'	
		
	--쿠폰
	IF (@COUPON_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_COUPON'	
	IF (@COUPON_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', COUPON'	
	IF (@COUPON_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_COUPON = COUPON'	
	IF (@COUPON_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_COUPON <> COUPON'	
	
	--홈쇼핑
	IF (@HOMEFLAG_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_HOMEFLAG'	
	IF (@HOMEFLAG_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', HOMEFLAG'	
	IF (@HOMEFLAG_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_HOMEFLAG = HOMEFLAG'	
	IF (@HOMEFLAG_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_HOMEFLAG <> HOMEFLAG'	
	
	--차등배송비
	IF (@DELIVERY_LEV_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_DELIVERY_LEV'	
	IF (@DELIVERY_LEV_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', DELIVERY_LEV'	
	IF (@DELIVERY_LEV_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_DELIVERY_LEV = DELIVERY_LEV'	
	IF (@DELIVERY_LEV_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_DELIVERY_LEV <> DELIVERY_LEV'	
	
	--설치비
	IF (@SET_YN_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_SET_YN'	
	IF (@SET_YN_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', SET_YN'	
	IF (@SET_YN_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_SET_YN = SET_YN'	
	IF (@SET_YN_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_SET_YN <> SET_YN'	
	
	--휴대폰가격
	IF (@TAG_PRICE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_TAG_PRICE'	
	IF (@TAG_PRICE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', TAG_PRICE'	
	IF (@TAG_PRICE_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_TAG_PRICE = TAG_PRICE'	
	IF (@TAG_PRICE_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_TAG_PRICE <> TAG_PRICE'	
	
	--요금제
	IF (@CALL_PLAN_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_CALL_PLAN'	
	IF (@CALL_PLAN_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', CALL_PLAN'	
	IF (@CALL_PLAN_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_CALL_PLAN = CALL_PLAN'	
	IF (@CALL_PLAN_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_CALL_PLAN <> CALL_PLAN'	
	
	--가입비
	IF (@IN_FEE_YN_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_IN_FEE_YN'	
	IF (@IN_FEE_YN_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', IN_FEE_YN'	
	IF (@IN_FEE_YN_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_IN_FEE_YN = IN_FEE_YN'	
	IF (@IN_FEE_YN_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_IN_FEE_YN <> IN_FEE_YN'	
	
	--유심비
	IF (@SHIP_FEE_YN_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_SHIP_FEE_YN'	
	IF (@SHIP_FEE_YN_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', SHIP_FEE_YN'	
	IF (@SHIP_FEE_YN_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_SHIP_FEE_YN = SHIP_FEE_YN'	
	IF (@SHIP_FEE_YN_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_SHIP_FEE_YN <> SHIP_FEE_YN'	
	
	--약정비
	IF (@BOND_FEE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_BOND_FEE' 
	IF (@BOND_FEE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', BOND_FEE'	
	IF (@BOND_FEE_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_BOND_FEE = BOND_FEE'	
	IF (@BOND_FEE_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_BOND_FEE <> BOND_FEE'	
		
	--위약금
	IF (@PENALITY_FEE_FLAG = '1') SET @INS_QRY1 = @INS_QRY1 + ', PL_PENALITY_FEE' 
	IF (@PENALITY_FEE_FLAG = '1') SET @INS_QRY2 = @INS_QRY2 + ', PENALITY_FEE'	
	IF (@PENALITY_FEE_FLAG = '1') SET @UP_QRY1 = @UP_QRY1 + ', PL_PENALITY_FEE = PENALITY_FEE'	
	IF (@PENALITY_FEE_FLAG = '1') SET @UP_QRY2 = @UP_QRY2 + ' OR PL_PENALITY_FEE <> PENALITY_FEE)'	
		
	
	--삭제, 추가, 변경	

	--삭제
	IF (@DEL_FLAG = '1')
		BEGIN
			IF (@ALLCNT >= @NOWCNT * 0.9)
				BEGIN
					SET @SZQRY = N' SELECT PL_NO'
					SET @SZQRY = @SZQRY + N' FROM DBO.PRICELIST WITH(READUNCOMMITTED) LEFT OUTER JOIN '+ @TABLE_NAME +' WITH(READUNCOMMITTED)'
					SET @SZQRY = @SZQRY + N' ON PL_GOODSCODE = GOODSCODE AND PL_GOODSCODE_CS = GOODSCODE_CS'
					SET @SZQRY = @SZQRY + N' WHERE PL_VCODE = '+ @VCODE +' AND PL_GOODSNM <> '''' AND PL_STATUS NOT IN (''3'',''5'') AND PL_SRVFLAG NOT IN (''M'',''B'') AND GOODSCODE IS NULL' 

					IF (@ALLCNT > 100000)
						BEGIN
							CREATE TABLE #D 
							(
								IDX INT IDENTITY(1,1) PRIMARY KEY,
								PLNO INT
							)

							SET @SZQRY = N' INSERT INTO #D(PLNO)'+ @SZQRY +' OPTION(MAXDOP 1)'
							EXEC(@SZQRY)
							SET @DELCNT = @@ROWCOUNT

							SET @MULTIINT = 1
							SET @MULTICNT = (@DELCNT / 300) + 2 
							SET @MULTISTART = 0
							SET @MULTIEND = 300
										
							WHILE @MULTIINT < @MULTICNT
								BEGIN
									UPDATE PRICELIST SET PL_DATE = GETDATE(), PL_STATUS = '3'
									FROM DBO.PRICELIST WITH(READUNCOMMITTED) INNER JOIN #D
									ON PL_NO = PLNO WHERE IDX >= @MULTISTART AND IDX < @MULTIEND OPTION(MAXDOP 1)	
												
									SET @MULTIINT = @MULTIINT + 1
									SET @MULTISTART = @MULTIEND
									SET @MULTIEND = @MULTIINT * 300
								END
						END
					ELSE
						BEGIN
							SET @SZQRY = N' UPDATE PRICELIST SET PL_DATE = GETDATE(), PL_STATUS = ''3'' WHERE PL_NO IN ('+ @SZQRY +') OPTION(MAXDOP 1)'
							exec(@SZQRY)
							SET @DELCNT = @@ROWCOUNT
						END
				END
			ELSE
				BEGIN
					SET @SZQRY = N'UPDATE NURIBOTDB.DBO.TBL_NB_SHOPLIST SET ERRORSTATUS = ''오류(전체-삭제)'' WHERE VCODE = '+@VCODE
					EXEC(@SZQRY)
				END 
		END

	--추가	
	IF (@INS_FLAG = '1')
		BEGIN
			IF (@ALLCNT > 100000)
				BEGIN
					CREATE TABLE #I
					(
						IDX INT IDENTITY(1,1) PRIMARY KEY,
						IGOODSCODE VARCHAR(50)
					)

					SET @SZQRY = N' INSERT INTO #I(IGOODSCODE)'
					SET @SZQRY = @SZQRY + N' SELECT GOODSCODE'
					SET @SZQRY = @SZQRY + N' FROM DBO.PRICELIST WITH(READUNCOMMITTED) RIGHT OUTER JOIN '+ @TABLE_NAME +' WITH(READUNCOMMITTED)'
					SET @SZQRY = @SZQRY + N' ON PL_GOODSCODE = GOODSCODE AND PL_GOODSCODE_CS = GOODSCODE_CS AND PL_GOODSNM <> '''' AND PL_VCODE = '+ @VCODE
					SET @SZQRY = @SZQRY + N' WHERE PL_NO IS NULL AND GOODSCODE <> '''''
					EXEC(@SZQRY)			
					SET @ADDCNT = @@ROWCOUNT
					
					SET @MULTIINT = 1
					SET @MULTICNT = (@ADDCNT / 300) + 2 
					SET @MULTISTART = 0
					SET @MULTIEND = 300
										
					WHILE @MULTIINT < @MULTICNT
						BEGIN
							SET @SZQRY = @INS_QRY1 + @INS_QRY2 
							SET @SZQRY = @SZQRY + N' FROM #I INNER JOIN '+ @TABLE_NAME +' WITH(READUNCOMMITTED)' 
							SET @SZQRY = @SZQRY + N' ON IGOODSCODE = GOODSCODE AND IDX >= '+ @MULTISTART +' AND IDX < '+ @MULTIEND
							EXEC(@SZQRY)	
												
							SET @MULTIINT = @MULTIINT + 1
							SET @MULTISTART = @MULTIEND
							SET @MULTIEND = @MULTIINT * 300
						END			
				END
			ELSE
				BEGIN
					SET @SZQRY = @INS_QRY1 + @INS_QRY2 
					set @SzQry = @SzQry + N' from dbo.pricelist with(readuncommitted) right outer join ' + @TABLE_NAME + ' with(readuncommitted)'
					set @SzQry = @SzQry + N' on pl_goodscode = goodscode and pl_goodscode_cs = goodscode_cs and pl_goodsnm <> '''' and pl_vcode = '+@VCODE 
					set @SzQry = @SzQry + N' where pl_no is null and goodsnm <> '''' option(maxdop 1)'
					EXEC(@SZQRY)	
					SET @ADDCNT = @@ROWCOUNT		
				END		
		END
		
	--변경
	IF (@UP_FLAG = '1')
		BEGIN
			IF (@ALLCNT > 100000)
				BEGIN
					CREATE TABLE #U
					(
						IDX INT IDENTITY(1,1) PRIMARY KEY,
						IGOODSCODE VARCHAR(50)
					)					

					SET @SZQRY = N' INSERT INTO #U(IGOODSCODE)'
					SET @SZQRY = @SZQRY + N' SELECT GOODSCODE'
					SET @SZQRY = @SZQRY + N' FROM DBO.PRICELIST WITH(READUNCOMMITTED) INNER JOIN '+ @TABLE_NAME +' WITH(READUNCOMMITTED)'
					SET @SZQRY = @SZQRY + N' ON PL_GOODSCODE = GOODSCODE AND PL_GOODSCODE_CS = GOODSCODE_CS' 
					SET @SZQRY = @SZQRY + N' WHERE PL_VCODE = '+ @VCODE +' AND PL_GOODSNM <> '' AND GOODSNM IS NOT NULL AND PL_NOCHANGE <> ''1'''
					SET @SZQRY = @SZQRY + @UP_QRY2 + ' OPTION(MAXDOP 1)'

					EXEC(@SZQRY)			
					SET @ADDCNT = @@ROWCOUNT
					
					SET @MULTIINT = 1
					SET @MULTICNT = (@ADDCNT / 300) + 2 
					SET @MULTISTART = 0
					SET @MULTIEND = 300
										
					WHILE @MULTIINT < @MULTICNT
						BEGIN
							SET @SZQRY = @UP_QRY1 + N' FROM #U INNER JOIN '+ @TABLE_NAME +' WITH(READUNCOMMITTED)' 
							SET @SZQRY = @SZQRY + N' ON IGOODSCODE = GOODSCODE AND IDX >= '+ @MULTISTART +' AND IDX < '+ @MULTIEND
							EXEC(@SZQRY)	
												
							SET @MULTIINT = @MULTIINT + 1
							SET @MULTISTART = @MULTIEND
							SET @MULTIEND = @MULTIINT * 300
						END			
				END
			ELSE
				BEGIN
				     set @SZQRY = ''
				END		
		END


	--SDU 처리	
	IF (@TYPE = 'T')
		BEGIN
			--SDU삭제 처리
			UPDATE PRICELIST SET PL_STATUS = '3' 
			WHERE PL_VCODE = @VCODE AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3' AND PL_DATE < DATEADD(D, -2,GETDATE()) AND pl_srvflag <> 'M'
				
			--SDU중복 처리
			DECLARE @PLNO INT
			DECLARE @GOODSCODE VARCHAR(50)
			DECLARE @PRICE MONEY
			DECLARE @RIGHTNLEFT CHAR(1)
			DECLARE @DELIVERYINFO NVARCHAR(100) 
			DECLARE @CHKCOUNT INT
			DECLARE @MAX INT

			DECLARE @S TABLE
			(
				IDX INT IDENTITY(1,1),
				PLNO INT,
				GOODSCODE VARCHAR(50),
				PRICE MONEY,
				RIGHTNLEFT CHAR(1),
				DELIVERYINFO NVARCHAR(100) 
			)

			INSERT INTO @S(PLNO, GOODSCODE, PRICE, RIGHTNLEFT, DELIVERYINFO)
				SELECT PL_NO, PL_GOODSCODE, PL_PRICE, PL_RIGHTNLEFT, PL_DELIVERYINFO
				FROM PRICELIST with(readuncommitted)
				WHERE PL_VCODE= @VCODE AND PL_MODELNO > 0 AND PL_GOODSNM = '' AND PL_GOODSNM_CS = CHECKSUM('') AND PL_STATUS < '3'
				
			SET @MAX = @@ROWCOUNT
				
			WHILE @MAX<>0
				BEGIN
					set @CHKCOUNT = 0
					SELECT @PLNO = PLNO, @GOODSCODE = GOODSCODE, @PRICE = PRICE, @RIGHTNLEFT = RIGHTNLEFT, @DELIVERYINFO = DELIVERYINFO
					FROM @S 
					WHERE IDX=@MAX

					SELECT @CHKCOUNT = COUNT(*)
					FROM PRICELIST with(readuncommitted)
					WHERE PL_VCODE= @VCODE AND PL_GOODSCODE = @GOODSCODE AND PL_GOODSCODE_CS = CHECKSUM(@GOODSCODE)
						AND PL_MODELNO > 0 AND PL_GOODSNM <> '' AND pl_goodsnm <> '' AND PL_STATUS < '3'

					IF (@CHKCOUNT > 0)
						BEGIN
							UPDATE PRICELIST SET PL_STATUS = '3' WHERE PL_NO = @PLNO
						END 

					SET @MAX = @MAX-1
				END
		END

			
END





























































































