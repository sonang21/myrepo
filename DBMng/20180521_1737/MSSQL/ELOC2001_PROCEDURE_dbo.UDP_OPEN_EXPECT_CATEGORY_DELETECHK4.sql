/* *************************************************************************
 * NAME : dbo.UDP_OPEN_EXPECT_CATEGORY_DELETECHK4
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-12-24 11:32:06.903
 *        Modify: 2018-05-03 17:23:35.887
 *        Backup: 20180521_1737
 ************************************************************************* */


/****** 개체: 저장 프로시저 dbo.UDP_OPEN_EXPECT_CATEGORY_DELETECHK2    스크립트 날짜: 2004-12-24 오전 11:10:27 ******/

/****** 개체: 저장 프로시저 dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK2    스크립트 날짜: 2004-11-03 오전 11:34:18 ******/

/****** 개체: 저장 프로시저 dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK2    스크립트 날짜: 2004-11-01 오전 10:08:21 ******/


/****** 개체: 저장 프로시저 dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK2    스크립트 날짜: 2004-10-29 오후 4:40:42 ******/

/****** 개체: 저장 프로시저 dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK    스크립트 날짜: 2004-10-29 오후 3:10:20 ******/
CREATE      PROC UDP_OPEN_EXPECT_CATEGORY_DELETECHK4
	@MODELNO	INT,
	
	@iRETURN1 	INT OUTPUT,
	@iRETURN2 	INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	--삭제된 카테고리에 대한 정보 삭제.	
	


	IF NOT EXISTS (SELECT * FROM TBL_OPEN_EXPECT_CATEGORY
			WHERE OEC_MODELNO=@MODELNO
				AND OEC_DELFLAG='0'
	)
	BEGIN
		SET @iRETURN1=0 --출시예정 존재안함.	
	
		
	END
	ELSE
	BEGIN
		SET @iRETURN1=1 --출시예정상품 존재함
	END

	IF NOT EXISTS (SELECT * FROM TBL_OPEN_EXPECT_CATEGORY
			WHERE OEC_MODELNO=@MODELNO
				AND OEC_NEWGOODS_FLAG='0'
	)
	BEGIN
		SET @iRETURN2=2
	END
	ELSE
	BEGIN		SET @iRETURN2=3
	END

	DELETE TBL_OPEN_EXPECT_CATEGORY
	WHERE OEC_MODELNO=@MODELNO
		AND OEC_DELFLAG='1'
		AND OEC_NEWGOODS_FLAG='1'
	
	
END






