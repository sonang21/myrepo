/* *************************************************************************
 * NAME : dbo.UDP_SELECT_PRICE_LIST_CNT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-03-03 08:20:30.09
 *        Modify: 2015-05-15 03:31:33.887
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** 개체: 저장 프로시저 dbo.UDP_SELECT_PRICE_LIST_CNT    스크립트 날짜: 2004-11-26 오후 2:21:41 ******/
/****** 개체: 저장 프로시저 dbo.UDP_SELECT_PRICE_LIST_CNT    스크립트 날짜: 2004-11-26 오후 1:28:45 ******/
/****** 개체: 저장 프로시저 dbo.UDP_SELECT_PRICE_LIST_CNT    스크립트 날짜: 2004-10-19 오후 2:24:08 ******/
/****** 개체: 저장 프로시저 dbo.uspSelectPriceListCnt    스크립트 날짜: 2004-10-18 오후 12:30:17 ******/

create         PROC UDP_SELECT_PRICE_LIST_CNT
	@SHOP_CODE INT
	,@intOpt tinyint
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	IF @intOpt=0
	BEGIN
		SELECT COUNT(distinct g_modelno) as cnt
		FROM GOODS 
		INNER JOIN PRICELIST  
		ON g_modelno = pl_modelno	
		WHERE PL_VCODE  = @SHOP_CODE
			AND g_jobcode <> '0'
			AND g_mallcnt > 0
			AND g_constrain = '1'
			AND pl_status < '3'
			AND pl_srvflag ='0'
	END

	ELSE IF 	@intOpt=1
	BEGIN
		SELECT COUNT(*) AS CNT
		FROM PRICELIST 
		WHERE PL_VCODE = @SHOP_CODE
			AND pl_modelno > 0
			AND pl_status < '3'
			AND pl_srvflag ='0'
	END

	ELSE IF @intOpt=2
	BEGIN
		SELECT COUNT(*)  AS CNT
		FROM PRICELIST 
		WHERE PL_VCODE = @SHOP_CODE
			AND PL_STATUS < '3'
			AND PL_SRVFLAG='0'
	END

	ELSE IF @intOpt=3
	BEGIN
		SELECT COUNT(*) AS CNT
		FROM PRICELIST
		WHERE PL_VCODE=@SHOP_CODE
			AND (PL_MODELNO<1 OR PL_MODELNO IS NULL)
			AND PL_STATUS<'3'
			AND PL_SRVFLAG='0'
	END

	ELSE IF @intOpt=4
	BEGIN
		SELECT COUNT(DISTINCT G_MODELNO) AS CNT
		FROM GOODS 
		INNER JOIN PRICELIST 
		ON G_MODELNO=PL_MODELNO
		WHERE PL_VCODE=@SHOP_CODE
			AND G_JOBCODE<>'0'
			AND G_MALLCNT>'0'
			AND G_CONSTRAIN = '1'
			AND PL_STATUS<'3'
			AND PL_SRVFLAG='0'
			AND G_MINPRICE = PL_PRICE

	END

END





