/* *************************************************************************
 * NAME : dbo.UDP_NB_MODELIN_UPDATE_PROC
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:36:36.28
 *        Modify: 2015-05-15 00:52:25.977
 *        Backup: 20180521_1739
 ************************************************************************* */



/****** ��ü: ���� ���ν��� dbo.UP_NB_MODELIN_UPDATE_PROC    ��ũ��Ʈ ��¥: 2004-10-21 ���� 3:36:49 ******/
-- UP_NB_MODELIN_UPDATE_PROC  :   2004.7.23 --
CREATE    PROC UDP_NB_MODELIN_UPDATE_PROC
	@szInsCcode INT,
	@szInsMcode NVARChar(400)
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	UPDATE TBL_NB_MODEL_IN 
	SET nbmi_moddate = getdate() 
	WHERE nbmi_vcode = @szInsCcode  and nbmi_goodsnm = @szInsMcode
END	


