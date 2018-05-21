/* *************************************************************************
 * NAME : dbo.UDF_RTN_MODELNO
 * TYPE : FUNCTION (SQL_SCALAR_FUNCTION)
 * TIME : Create: 2005-08-02 19:56:10.56
 *        Modify: 2018-05-03 17:23:34.167
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE      FUNCTION UDF_RTN_MODELNO (@FINDVCODE INT, @GOODSCODE varchar(500), @OPT VARCHAR(20))
RETURNS INT
AS
BEGIN
	-- 모델번호 반환 function : BSLEE 2005.7.28

	DECLARE @RTNNO INT
	DECLARE @CNT INT

	--SELECT @RTNNO = isNull(pl_modelno, -100) FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_goodscode = @GOODSCODE
	IF @OPT = 'GOODSCODE'
		SELECT TOP 1 @RTNNO = pl_modelno FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_goodscode = @GOODSCODE and pl_modelno is NOT NULL
	ELSE IF @OPT = 'GOODSNM'
		SELECT TOP 1 @RTNNO = pl_modelno FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_goodsnm = @GOODSCODE and pl_modelno is NOT NULL AND pl_modelno > 0
	ELSE IF @OPT = 'URL'
	BEGIN
		SELECT @CNT = COUNT(distinct pl_modelno) FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_url = @GOODSCODE and pl_modelno is NOT NULL
		IF @CNT = 1
		BEGIN
			SELECT TOP 1 @RTNNO =  pl_modelno FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_url = @GOODSCODE and pl_modelno is NOT NULL
		END
		ELSE
			SET @RTNNO = -100
	END
	ELSE IF @OPT = 'SRVURL'
	BEGIN
		SELECT @CNT = COUNT(distinct pl_modelno) FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_url = @GOODSCODE and pl_modelno is NOT NULL and pl_status < '3'
		IF @CNT = 1
		BEGIN
			SELECT TOP 1 @RTNNO =  pl_modelno FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_url = @GOODSCODE and pl_modelno is NOT NULL and pl_status < '3'
		END
		ELSE
			SET @RTNNO = -100
	END
	/* LIKE URL 은 성능 떨어짐
	ELSE IF @OPT = 'LIKEURL'
	BEGIN

		SELECT @CNT = COUNT(distinct pl_modelno) FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_url LIKE ''+ @GOODSCODE +'%' and pl_modelno is NOT NULL
		IF @CNT = 1
		BEGIN
			SELECT TOP 1 @RTNNO =  pl_modelno FROM PRICELIST WITH (READUNCOMMITTED) WHERE pl_vcode = @FINDVCODE and pl_url LIKE ''+ @GOODSCODE +'%' and pl_modelno is NOT NULL
		END
		ELSE
			SET @RTNNO = -100
	END
	*/
	/*
	IF (@return is NULL)
		SET @return = ''
	ELSE IF (@return = '★관리용')
		SET @return = ''
	*/
	RETURN @RTNNO 

	/* 사용예
	select top 10 pl_modelno, pl_goodscode, * from pricelist where pl_vcode = 536 and pl_modelno > 0
	select top 10 pl_modelno, pl_goodscode, * from pricelist where pl_vcode = 536 and pl_modelno is null

	SELECT 
		ELOC2001.dbo.UDF_RTN_MODELNO(536,'101304988', 'GOODSCODE')
		ELOC2001.dbo.UDF_RTN_MODELNO(536,'101304988', 'GOODSNM')
		ELOC2001.dbo.UDF_RTN_MODELNO(55,'101304988', 'URL')
		ELOC2001.dbo.UDF_RTN_MODELNO(55,'101304988', 'LIKEURL')
	*/
END


