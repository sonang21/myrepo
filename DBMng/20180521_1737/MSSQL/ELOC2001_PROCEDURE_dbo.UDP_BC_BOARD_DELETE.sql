/* *************************************************************************
 * NAME : dbo.UDP_BC_BOARD_DELETE
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:53.53
 *        Modify: 2018-05-03 17:23:34.947
 *        Backup: 20180521_1737
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_BC_BOARD_DELETE    ��ũ��Ʈ ��¥: 2004-10-23 ���� 10:55:26 ******/
CREATE  PROC UDP_BC_BOARD_DELETE
	@GROUP 	INT,
	@BB_NO		INT,
	@PWD		VARCHAR(12),

	@iRETURN 	INT 	OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE @REF INT
	DECLARE @STEP INT
	DECLARE @DEPTH INT
	DECLARE @O_PWD VARCHAR(12)
	SET @REF=0
	SET @STEP = -1
	SET @DEPTH = -1

	BEGIN TRAN

		SELECT @REF = BB_REF,
			@STEP = BB_STEP,
			@DEPTH = BB_STEP,
			@O_PWD = BB_PWD
		FROM TBL_BC_BOARD (NOLOCK) 
		WHERE BB_GROUP=@GROUP 
			AND BB_NO=@BB_NO
			AND BB_DELFLAG='0'

		IF @REF > 0 
		BEGIN
			IF EXISTS (SELECT BB_NO
					FROM TBL_BC_BOARD (NOLOCK) 
					WHERE BB_GROUP=@GROUP 
						AND BB_REF=@REF
						AND BB_STEP = @STEP+1
						AND BB_DEPTH = @DEPTH+1
						AND BB_DELFLAG='0')
			BEGIN
				SET @iRETURN =2 --����� �����Ƿ� ����� ����.
			END
			ELSE
			BEGIN
				IF (LOWER(@O_PWD) = LOWER(@PWD))
				BEGIN
					UPDATE TBL_BC_BOARD
					SET BB_DELFLAG='1'
					WHERE BB_GROUP=@GROUP
						AND BB_NO = @BB_NO
					SET @iRETURN = 0
				END
				ELSE
				BEGIN
					SET @iRETURN = 3 -- ����� Ʋ��.
				END
			END	
	
		END
		ELSE
		BEGIN
			SET @iRETURN =1 --�� ����.
		END

	IF @@ERROR<>0
	BEGIN
		ROLLBACK TRAN
		SET @iRETURN=99
	END
	ELSE
	BEGIN
		COMMIT TRAN
	END
	print @iRETURN
END

--SP_HELP TBL_BC_BOARD



