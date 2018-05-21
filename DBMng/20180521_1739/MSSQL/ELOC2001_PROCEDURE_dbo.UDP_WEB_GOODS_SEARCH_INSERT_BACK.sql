/* *************************************************************************
 * NAME : dbo.UDP_WEB_GOODS_SEARCH_INSERT_BACK
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:57.107
 *        Modify: 2018-05-03 17:23:35.773
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_WEB_GOODS_SEARCH_INSERT_BACK    ��ũ��Ʈ ��¥: 2004-10-23 ���� 11:06:36 ******/
--*******************************
--* 2004.10.20 ���ó�� WOOKKI25
--*******************************
CREATE  PROC UDP_WEB_GOODS_SEARCH_INSERT_BACK
	@G_MODELNO	INT,
	@PL_VCODE	VARCHAR(4),
	@PL_GOODSNM	NVARCHAR(400)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @PL_NO INT
	SET @PL_NO=0
	
	SELECT @PL_NO=PL_NO
	FROM PRICELIST 
	WHERE PL_VCODE=@PL_VCODE
		AND PL_GOODSNM=@PL_GOODSNM

	IF @PL_NO<>0 
	BEGIN

		IF NOT EXISTS( SELECT WGS_G_MODELNO 
			FROM TBL_WEB_GOODS_SEARCH 
			WHERE WGS_G_MODELNO = @G_MODELNO
				AND WGS_PL_NO=@PL_NO)
		BEGIN
			INSERT INTO TBL_WEB_GOODS_SEARCH
			(WGS_G_MODELNO, WGS_PL_NO)
			VALUES
			(@G_MODELNO,@PL_NO)
		END

	END
END




