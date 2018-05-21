/* *************************************************************************
 * NAME : dbo.UDF_GETGOODSCODE
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2006-05-22 12:37:52.227
 *        Modify: 2018-05-03 17:23:34.047
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE FUNCTION [dbo].[UDF_GETGOODSCODE](@SHOPCODE INT , @URL VARCHAR(500) )
	RETURNS VARCHAR(20)
AS
BEGIN
	DECLARE @PSTR  VARCHAR(20)
	SET @PSTR=''
	DECLARE @GOODSCODE VARCHAR(50)
	SET @GOODSCODE=''
	DECLARE @TU VARCHAR(500)


	IF @SHOPCODE=47
		SET @PSTR = LOWER('productid=')

	ELSE IF @SHOPCODE=49
		SET @PSTR = LOWER('curgoodsno=')

	ELSE IF @SHOPCODE=51
		SET @PSTR = LOWER('itemcd=')

	ELSE IF @SHOPCODE=52
		SET @PSTR = LOWER('pf_id=')

	ELSE IF @SHOPCODE=55
		SET @PSTR = LOWER('goods_no=')

	ELSE IF @SHOPCODE=57
		SET @PSTR = LOWER('itemcode=')

	ELSE IF @SHOPCODE=75
		SET @PSTR = LOWER('ecpid=')

	ELSE IF @SHOPCODE=90
		SET @PSTR = LOWER('cd=')

	ELSE IF @SHOPCODE=224
		SET @PSTR = LOWER('idx=')

	ELSE IF @SHOPCODE=241
		SET @PSTR = LOWER('item_id=')

	ELSE IF @SHOPCODE=251
		SET @PSTR = LOWER('pf_id=')

	ELSE IF @SHOPCODE=269
		SET @PSTR = LOWER('id=')

	ELSE IF @SHOPCODE=273
		SET @PSTR = LOWER('it_num=')

	ELSE IF @SHOPCODE=274
		SET @PSTR = LOWER('assortid=')

	ELSE IF @SHOPCODE=281
		SET @PSTR = LOWER('itemid=')

	ELSE IF @SHOPCODE=300
		SET @PSTR = LOWER('itemid=')

	ELSE IF @SHOPCODE=307
		SET @PSTR = LOWER('gno=')

	ELSE IF @SHOPCODE=309
		SET @PSTR = LOWER('itemid=')

	ELSE IF @SHOPCODE=356
		SET @PSTR = LOWER('productid=')

	ELSE IF @SHOPCODE=374
		SET @PSTR = LOWER('item_id=')

	ELSE IF @SHOPCODE=536
		SET @PSTR = LOWER('goodscode=')

	ELSE IF @SHOPCODE=663
		SET @PSTR = LOWER('i_code=')

	ELSE IF @SHOPCODE=806
		SET @PSTR = LOWER('item_code=')

	ELSE IF @SHOPCODE=922
		SET @PSTR = LOWER('product_code=')

	ELSE IF @SHOPCODE=949
		SET @PSTR = LOWER('gd=')

	ELSE IF @SHOPCODE=1289
		SET @PSTR = LOWER('goodsno=')

	ELSE IF @SHOPCODE=1675
		SET @PSTR = LOWER('noprod=')

	ELSE IF @SHOPCODE=1878
		SET @PSTR = LOWER('pid=')

	ELSE IF @SHOPCODE=3367
		SET @PSTR = LOWER('goodsno=')

	ELSE IF @SHOPCODE=3539
		SET @PSTR = LOWER('hi_prdid=')

	ELSE IF @SHOPCODE=4027
		SET @PSTR = LOWER('itemno=')

	ELSE IF @SHOPCODE=5217
		SET @PSTR = LOWER('noprd%3d')




	ELSE
		SET @PSTR =''



	IF @PSTR<>''
	BEGIN
		IF CHARINDEX(@PSTR, LOWER(@URL)) >0
		BEGIN
			SET @TU = SUBSTRING(LOWER(@URL), CHARINDEX(@PSTR, LOWER(@URL))+LEN(@PSTR), LEN(@URL))
			IF  CHARINDEX( '&', @TU)>0
			BEGIN
				SET @GOODSCODE = SUBSTRING(@TU, 1,  CHARINDEX('&', @TU )-1)
			END
			ELSE
			BEGIN
				SET @GOODSCODE = SUBSTRING(@TU,1, LEN(@TU))
			END
		END
		ELSE
		BEGIN
			SET @GOODSCODE=''
		END
	END

	RETURN @GOODSCODE
END

--print dbo.UDF_GETGOODSCODE( 5217, 'http://www.mple.com/join/BridgeAction.do?method=bridge&BscCode=enuri&DtlCode=enuri-005-000&tUrl=%2Fprd%2Fprdbiz%2Fprddetail%2FPrdDetailAction.do%3Fmethod%3DprdDetail%26noPrd%3D1000536957')
