/* *************************************************************************
 * NAME : dbo.UDF_GOODS_EXTERNAL_NON_ATTRIBUTE
 * TYPE : FUNCTION (SQL_TABLE_VALUED_FUNCTION)
 * TIME : Create: 2017-04-12 13:55:55.25
 *        Modify: 2018-05-03 17:23:34.923
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE FUNCTION UDF_GOODS_EXTERNAL_NON_ATTRIBUTE
(
	@SHOP_CODE INT,
	@CATEGORY VARCHAR(12)
)
RETURNS @RETURN_TABLE TABLE(G_MODELNO INT)
AS
BEGIN
	DECLARE @TARGET TABLE(G_MODELNO INT, G_CATEGORY VARCHAR(12));
	DECLARE @ATTRIBUTE_TARGET TABLE (G_MODELNO INT);
	
	INSERT @TARGET
	SELECT DISTINCT G_MODELNO, G_CATEGORY
	FROM GOODS WITH (READUNCOMMITTED)
		INNER JOIN TBL_EXTERNAL_NON_TARGET WITH (READUNCOMMITTED) ON SHOP_CODE = @SHOP_CODE AND MODELNO = G_MODELNO
	WHERE G_CATEGORY LIKE @CATEGORY + '%'
	  --AND EXISTS (SELECT TOP 1 1 FROM PRICELIST WITH (READUNCOMMITTED) WHERE PL_VCODE = @SHOP_CODE AND PL_MODELNO = G_MODELNO AND PL_SRVFLAG = '4' AND PL_STATUS = '4')
	
	INSERT @ATTRIBUTE_TARGET
	SELECT DISTINCT A.G_MODELNO
	FROM @TARGET A
		INNER JOIN TBL_EXTERNAL_ATTRIBUTE B WITH (READUNCOMMITTED) ON B.SHOP_CODE = @SHOP_CODE AND B.CATEGORY = LEFT(G_CATEGORY, LEN(B.CATEGORY))
		--INNER JOIN GOODS_CATEGORY_ATTRIBUTE C WITH (READUNCOMMITTED) ON C.ATTRIBUTE_ID = B.ATTRIBUTE_ID AND B.CATEGORY IN (SELECT TOP 1 CATEGORY FROM GOODS_CATEGORY_ATTRIBUTE WITH (READUNCOMMITTED) WHERE CATEGORY = LEFT(G_CATEGORY, 4) OR CATEGORY = LEFT(G_CATEGORY, 6) OR CATEGORY = LEFT(G_CATEGORY, 8) ORDER BY LEN(CATEGORY) DESC)
		INNER JOIN GOODS_CATALOG_ATTRIBUTE D WITH (READUNCOMMITTED) ON D.G_MODELNO = A.G_MODELNO AND D.ATTRIBUTE_ID = B.ATTRIBUTE_ID AND DEL_YN = 'N'
	
	INSERT @RETURN_TABLE
	SELECT G_MODELNO
	FROM @TARGET
	WHERE G_MODELNO NOT IN (SELECT G_MODELNO FROM @ATTRIBUTE_TARGET)
	
	RETURN
END;
