/* *************************************************************************
 * NAME : dbo.UDP_PRICELIST_ELOC_IDENT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:53.123
 *        Modify: 2015-05-15 03:31:33.6
 *        Backup: 20180521_1739
 ************************************************************************* */


CREATE       proc UDP_PRICELIST_ELOC_IDENT

	@ModelNo 	INT, 
	@Vcode 		INT,
	@Price 		MONEY, 
	@Etc		NVARCHAR(100), 
	@Url		VARCHAR(250),
	@RightnLeft	CHAR(1), 
	@SrvFlag	CHAR(1),
	@Flag		CHAR(1)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	--ELOC
	BEGIN TRAN
		/* bslee 2004.11.26 pl_flag delete
		INSERT PRICELIST (pl_modelno, pl_vcode, pl_goodsnm, pl_price, pl_etc, pl_url, pl_rightnleft, pl_srvflag, pl_flag, pl_status, pl_date)
		VALUES (@ModelNo, @Vcode, '', @Price, @Etc, @Url, @RightnLeft, @SrvFlag, @Flag, '2', getdate() )
		*/
		INSERT PRICELIST (pl_modelno, pl_vcode, pl_goodsnm, pl_price, pl_etc, pl_url, pl_rightnleft, pl_srvflag,  pl_status, pl_date)
		VALUES (@ModelNo, @Vcode, '', @Price, @Etc, @Url, @RightnLeft, @SrvFlag, '2', getdate() )
		
		DECLARE @plno INT
		set @plno = SCOPE_IDENTITY()  -- IDENT_CURRENT('PRICELIST')
	
		select @plno
	IF @@ERROR<>0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN
END
