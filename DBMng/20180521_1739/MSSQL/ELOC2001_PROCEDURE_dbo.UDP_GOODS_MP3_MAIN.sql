/* *************************************************************************
 * NAME : dbo.UDP_GOODS_MP3_MAIN
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.78
 *        Modify: 2018-05-03 17:23:35.213
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.uspGoodsMP3Main    스크립트 날짜: 2004-10-21 오후 3:26:36 ******/
CREATE  PROCEDURE UDP_GOODS_MP3_MAIN 
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	UPDATE GOODS_MP3_MAIN
		SET gmm_price =
			(
			SELECT avg(p_price)
			FROM PLIST
			WHERE p_modelno in
				(
				SELECT gml_modelno_multiple
				FROM GOODS_MP3_LIST
				WHERE gml_modelno IN
					(SELECT gml_modelno
					FROM GOODS_MP3_LIST
					WHERE gml_modelno_multiple = gmm_modelno
					)
				)
			)
		,gmm_mallcnt =
			(
			SELECT count(*)
			FROM PLIST
			WHERE p_modelno in
				(
				SELECT gml_modelno_multiple
				FROM GOODS_MP3_LIST
				WHERE gml_modelno IN
					(SELECT gml_modelno
					FROM GOODS_MP3_LIST
					WHERE gml_modelno_multiple = gmm_modelno)
				)
			)
		WHERE gmm_modelno in
			(SELECT gml_modelno
			FROM GOODS_MP3_LIST
			WHERE gml_modelno_multiple = gmm_modelno)
END


