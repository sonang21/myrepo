/* *************************************************************************
 * NAME : dbo.UDP_OPEN_EXPECT_CATEGORY_DELETECHK4
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-12-24 11:32:06.903
 *        Modify: 2018-05-03 17:23:35.887
 *        Backup: 20180521_1739
 ************************************************************************* */


/****** ��ü: ���� ���ν��� dbo.UDP_OPEN_EXPECT_CATEGORY_DELETECHK2    ��ũ��Ʈ ��¥: 2004-12-24 ���� 11:10:27 ******/

/****** ��ü: ���� ���ν��� dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK2    ��ũ��Ʈ ��¥: 2004-11-03 ���� 11:34:18 ******/

/****** ��ü: ���� ���ν��� dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK2    ��ũ��Ʈ ��¥: 2004-11-01 ���� 10:08:21 ******/


/****** ��ü: ���� ���ν��� dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK2    ��ũ��Ʈ ��¥: 2004-10-29 ���� 4:40:42 ******/

/****** ��ü: ���� ���ν��� dbo.UP_OPEN_EXPECT_CATEGORY_DELETECHK    ��ũ��Ʈ ��¥: 2004-10-29 ���� 3:10:20 ******/
CREATE      PROC UDP_OPEN_EXPECT_CATEGORY_DELETECHK4
	@MODELNO	INT,
	
	@iRETURN1 	INT OUTPUT,
	@iRETURN2 	INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	--������ ī�װ��� ���� ���� ����.	
	


	IF NOT EXISTS (SELECT * FROM TBL_OPEN_EXPECT_CATEGORY
			WHERE OEC_MODELNO=@MODELNO
				AND OEC_DELFLAG='0'
	)
	BEGIN
		SET @iRETURN1=0 --��ÿ��� �������.	
	
		
	END
	ELSE
	BEGIN
		SET @iRETURN1=1 --��ÿ�����ǰ ������
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






