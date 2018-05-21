/* *************************************************************************
 * NAME : dbo.UDP_ELOC_EDU_PRICELIST_INSERT_3
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-03-14 14:45:20.483
 *        Modify: 2015-09-17 16:49:12.26
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE      PROC UDP_ELOC_EDU_PRICELIST_INSERT_3
	@PL_MODELNO	INT,
	@PL_VCODE		INT,
	@PL_CATEGORY	VARCHAR(8),
	@PL_GOODSNM	NVARCHAR(200),
	@PL_PRICE		MONEY,
	@PL_STATUS		CHAR(1),
	@PL_JOBTYPE		CHAR(1),
	@PL_AUTHFLAG	CHAR(1),
	@PL_MULTIFLAG	CHAR(1),
	@PL_DELIVERYFLAG CHAR(1),
	@PL_AIRCONDESC  NVARCHAR(300),
	@PL_AIRCONFEETYPE CHAR(1),
	@PL_INSTANCE_PRICE  MONEY,
	@PL_DELFEETYPE CHAR(1),
	@PL_DELPRICE   MONEY,
	@PL_DELFEEDESC  NVARCHAR(100),
	@PL_BASISFROM  MONEY,
	@PL_BASISTO   MONEY,
	@PL_DELAREATYPE  CHAR(1),
	@PL_DELAREADESC  NVARCHAR(100),

	@PL_ETC	NVARCHAR(50),
	@PL_STOCKCOUNT 	INT,
	@PL_REGTERM		INT,
	@PL_SPECFLAG		CHAR(1),
	@PL_ORIGIN		NVARCHAR(10),
	@PL_ESOPTFLAG		CHAR(1),
	
	@PLNO		bigINT	OUTPUT,
	@iRETURN		INT 	OUTPUT
AS
BEGIN
	-- PL_MULTIFLAG ����.
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN	
		IF  @PL_STOCKCOUNT = -1 AND @PL_REGTERM = -1 

			INSERT INTO PRICELIST( PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_STATUS, PL_JOBTYPE, PL_AUTHFLAG
			, PL_DELIVERYFLAG, PL_AIRCONDESC, PL_AIRCONFEETYPE, PL_INSTANCE_PRICE, PL_DELFEETYPE, PL_DELPRICE
			, PL_DELFEEDESC , PL_BASISFROM, PL_BASISTO, PL_DELAREATYPE, PL_DELAREADESC
			, PL_ETC, PL_STOCKCOUNT, PL_REGTERM, PL_SPECFLAG, PL_ORIGIN, PL_ESOPTFLAG  ) 
			VALUES(@PL_MODELNO,@PL_VCODE,@PL_CATEGORY,@PL_GOODSNM,@PL_PRICE,@PL_STATUS,@PL_JOBTYPE,@PL_AUTHFLAG
			, @PL_DELIVERYFLAG, @PL_AIRCONDESC, @PL_AIRCONFEETYPE, @PL_INSTANCE_PRICE, @PL_DELFEETYPE, @PL_DELPRICE
			, @PL_DELFEEDESC , @PL_BASISFROM, @PL_BASISTO, @PL_DELAREATYPE, @PL_DELAREADESC 
			, @PL_ETC, NULL, NULL, @PL_SPECFLAG, @PL_ORIGIN, @PL_ESOPTFLAG )

		ELSE IF @PL_STOCKCOUNT = -1

			INSERT INTO PRICELIST( PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_STATUS, PL_JOBTYPE, PL_AUTHFLAG
			, PL_DELIVERYFLAG, PL_AIRCONDESC, PL_AIRCONFEETYPE, PL_INSTANCE_PRICE, PL_DELFEETYPE, PL_DELPRICE
			, PL_DELFEEDESC , PL_BASISFROM, PL_BASISTO, PL_DELAREATYPE, PL_DELAREADESC
			, PL_ETC, PL_STOCKCOUNT, PL_REGTERM, PL_SPECFLAG, PL_ORIGIN, PL_ESOPTFLAG  ) 
			VALUES(@PL_MODELNO,@PL_VCODE,@PL_CATEGORY,@PL_GOODSNM,@PL_PRICE,@PL_STATUS,@PL_JOBTYPE,@PL_AUTHFLAG
			, @PL_DELIVERYFLAG, @PL_AIRCONDESC, @PL_AIRCONFEETYPE, @PL_INSTANCE_PRICE, @PL_DELFEETYPE, @PL_DELPRICE
			, @PL_DELFEEDESC , @PL_BASISFROM, @PL_BASISTO, @PL_DELAREATYPE, @PL_DELAREADESC 
			, @PL_ETC, NULL, @PL_REGTERM, @PL_SPECFLAG, @PL_ORIGIN, @PL_ESOPTFLAG )

		ELSE IF @PL_REGTERM = -1

			INSERT INTO PRICELIST( PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_STATUS, PL_JOBTYPE, PL_AUTHFLAG
			, PL_DELIVERYFLAG, PL_AIRCONDESC, PL_AIRCONFEETYPE, PL_INSTANCE_PRICE, PL_DELFEETYPE, PL_DELPRICE
			, PL_DELFEEDESC , PL_BASISFROM, PL_BASISTO, PL_DELAREATYPE, PL_DELAREADESC
			, PL_ETC, PL_STOCKCOUNT, PL_REGTERM, PL_SPECFLAG, PL_ORIGIN, PL_ESOPTFLAG  ) 
			VALUES(@PL_MODELNO,@PL_VCODE,@PL_CATEGORY,@PL_GOODSNM,@PL_PRICE,@PL_STATUS,@PL_JOBTYPE,@PL_AUTHFLAG
			, @PL_DELIVERYFLAG, @PL_AIRCONDESC, @PL_AIRCONFEETYPE, @PL_INSTANCE_PRICE, @PL_DELFEETYPE, @PL_DELPRICE
			, @PL_DELFEEDESC , @PL_BASISFROM, @PL_BASISTO, @PL_DELAREATYPE, @PL_DELAREADESC 
			, @PL_ETC, @PL_STOCKCOUNT, NULL, @PL_SPECFLAG, @PL_ORIGIN, @PL_ESOPTFLAG )

		ELSE

			INSERT INTO PRICELIST( PL_MODELNO, PL_VCODE, PL_CATEGORY, PL_GOODSNM, PL_PRICE, PL_STATUS, PL_JOBTYPE, PL_AUTHFLAG
			, PL_DELIVERYFLAG, PL_AIRCONDESC, PL_AIRCONFEETYPE, PL_INSTANCE_PRICE, PL_DELFEETYPE, PL_DELPRICE
			, PL_DELFEEDESC , PL_BASISFROM, PL_BASISTO, PL_DELAREATYPE, PL_DELAREADESC
			, PL_ETC, PL_STOCKCOUNT, PL_REGTERM, PL_SPECFLAG, PL_ORIGIN, PL_ESOPTFLAG  ) 
			VALUES(@PL_MODELNO,@PL_VCODE,@PL_CATEGORY,@PL_GOODSNM,@PL_PRICE,@PL_STATUS,@PL_JOBTYPE,@PL_AUTHFLAG
			, @PL_DELIVERYFLAG, @PL_AIRCONDESC, @PL_AIRCONFEETYPE, @PL_INSTANCE_PRICE, @PL_DELFEETYPE, @PL_DELPRICE
			, @PL_DELFEEDESC , @PL_BASISFROM, @PL_BASISTO, @PL_DELAREATYPE, @PL_DELAREADESC 
			, @PL_ETC, @PL_STOCKCOUNT, @PL_REGTERM, @PL_SPECFLAG, @PL_ORIGIN, @PL_ESOPTFLAG )
	
		SET @PLNO=SCOPE_IDENTITY()
	
	IF @@ERROR<>0
		BEGIN
			ROLLBACK TRAN
			SET @iRETURN = 99
		END
	ELSE
		BEGIN
			COMMIT TRAN
			SET @iRETURN = 0
				
		END

END
