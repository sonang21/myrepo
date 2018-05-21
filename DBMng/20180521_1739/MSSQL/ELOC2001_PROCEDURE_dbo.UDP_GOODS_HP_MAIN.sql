/* *************************************************************************
 * NAME : dbo.UDP_GOODS_HP_MAIN
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2004-11-02 03:31:54.7
 *        Modify: 2018-05-03 17:23:35.2
 *        Backup: 20180521_1739
 ************************************************************************* */




/****** 개체: 저장 프로시저 dbo.uspGoodsHPMain    스크립트 날짜: 2004-10-21 오후 3:26:02 ******/
CREATE  PROCEDURE UDP_GOODS_HP_MAIN 
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE GOODS_HP_MAIN
		SET ghm_price =
			(
			SELECT avg(p_price)
			FROM PLIST
			WHERE p_modelno in
				(
				SELECT ghl_modelno_mutiple
				FROM GOODS_HP_LIST
				WHERE ghl_modelno IN
					(SELECT ghl_modelno
					FROM GOODS_HP_LIST
					WHERE ghl_modelno_mutiple = ghm_modelno
					)
				)
			)
		,ghm_mallcnt =
			(
			SELECT count(*)
			FROM PLIST
			WHERE p_modelno in
				(
				SELECT ghl_modelno_mutiple
				FROM GOODS_HP_LIST
				WHERE ghl_modelno IN
					(SELECT ghl_modelno
					FROM GOODS_HP_LIST
					WHERE ghl_modelno_mutiple = ghm_modelno)
				)
			)
		WHERE ghm_modelno in
			(SELECT ghl_modelno
			FROM GOODS_HP_LIST
			WHERE ghl_modelno_mutiple = ghm_modelno)
END


