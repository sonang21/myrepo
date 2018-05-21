/* *************************************************************************
 * NAME : dbo.UDP_ELOC_PRICELIST_INSERT
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-03 17:38:06.48
 *        Modify: 2015-09-17 16:49:12.38
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE         PROC [dbo].[UDP_ELOC_PRICELIST_INSERT]

	@MODELNO	INT,
	@VCODE		INT,
	@PRICE		MONEY,
	@ETC		NVARCHAR(100),
	@URL		VARCHAR(255),
	@RIGHTNLEFT	CHAR(1),
	@SRVFLAG	CHAR(1),
	@PL_GOODSNM		NVARCHAR(400) = NULL,
	@PL_GOODSCODE	VARCHAR(50),

	@PLNO		bigINT	OUTPUT,
	@iRETURN	INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRAN
		/* bslee 2004.11.27
		INSERT PRICELIST (pl_modelno, pl_vcode, pl_goodsnm, pl_price, pl_etc, pl_url, pl_rightnleft, pl_srvflag, pl_flag, pl_status, pl_date)
		VALUES (@ModelNo, @Vcode, '', @Price, @Etc, @Url, @RightnLeft, @SrvFlag, @Flag, '2', getdate() )
		*/
		DECLARE @CATE VARCHAR(8)
		SET @CATE = ISNULL((SELECT  TOP 1 G_CATEGORY FROM GOODS WHERE G_MODELNO=@ModelNo),'00000000')

		INSERT PRICELIST (pl_modelno, pl_category, pl_vcode, pl_goodsnm, pl_price, pl_etc, pl_url, pl_rightnleft, pl_srvflag, pl_status, pl_date,pl_goodscode)
		VALUES (@ModelNo, @CATE, @Vcode, @PL_GOODSNM, @Price, @Etc, @Url, @RightnLeft, @SrvFlag, '0', getdate(),@PL_GOODSCODE)

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
