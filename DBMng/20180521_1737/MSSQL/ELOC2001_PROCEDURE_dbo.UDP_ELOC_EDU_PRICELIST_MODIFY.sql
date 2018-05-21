/* *************************************************************************
 * NAME : dbo.UDP_ELOC_EDU_PRICELIST_MODIFY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-01-25 19:15:40.28
 *        Modify: 2015-09-17 16:49:12.317
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE           PROC UDP_ELOC_EDU_PRICELIST_MODIFY
	@PL_NO			bigINT,
	@PL_VCODE		INT,
	@PL_GOODSNM		NVARCHAR(200),
	@PL_PRICE		MONEY,
	@PL_ETC		NVARCHAR(50),
	@PL_STOCKCOUNT	INT,
	@PL_REGTERM		INT,
	@PL_SPECFLAG		CHAR(1),
	@PL_ORIGIN		VARCHAR(10),
	@PL_DELFEETYPE	CHAR(1),
	@PL_DELAREATYPE	CHAR(1),
	@PL_DELPRICE		MONEY,

	@iRETURN	INT	OUTPUT		
AS 
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	DECLARE @TMPVCODE	INT
	SET @TMPVCODE=0
	SELECT @TMPVCODE = PL_VCODE
	FROM PRICELIST
	WHERE PL_NO=@PL_NO

	IF @TMPVCODE=0 -- 상품없음.
	BEGIN
		SET @iRETURN=1
	END
	ELSE
	BEGIN
		IF @TMPVCODE <> @PL_VCODE --해당업체가 아님.
		BEGIN
			SET @iRETURN=2 
		END
		ELSE
		BEGIN
			BEGIN TRAN

				UPDATE PRICELIST SET 
					PL_GOODSNM = @PL_GOODSNM, 
					PL_PRICE = @PL_PRICE, 
					PL_DATE = GETDATE(),
					PL_ETC = @PL_ETC, 
					PL_STOCKCOUNT = @PL_STOCKCOUNT, 
					PL_REGTERM = @PL_REGTERM, 
					PL_SPECFLAG = @PL_SPECFLAG, 
					PL_ORIGIN = @PL_ORIGIN, 
					PL_DELFEETYPE = @PL_DELFEETYPE, 
					PL_DELAREATYPE = @PL_DELAREATYPE, 
					PL_DELPRICE = @PL_DELPRICE
				WHERE	PL_NO= @PL_NO

			IF @@ERROR<>0
			BEGIN
				SET @iRETURN=99
				ROLLBACK TRAN
			END
			ELSE
			BEGIN
				SET @iRETURN =0
				COMMIT TRAN
			END				

		END
	

	END
	
END
