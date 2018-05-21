/* *************************************************************************
 * NAME : dbo.UDP_GOODS_DC_MAIN
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2005-06-28 13:03:49.513
 *        Modify: 2018-05-03 17:23:34.713
 *        Backup: 20180521_1737
 ************************************************************************* */

create   PROCEDURE UDP_GOODS_DC_MAIN 
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	UPDATE GOODS_DC_MAIN
		SET gdm_price =
			(
			SELECT avg(p_price)
			FROM PLIST
			WHERE p_modelno in
				(
				SELECT gdl_modelno_mutiple
				FROM GOODS_DC_LIST
				WHERE gdl_modelno IN
					(SELECT gdl_modelno
					FROM GOODS_DC_LIST
					WHERE gdl_modelno_mutiple = gdm_modelno
					)
				)
			)
		,gdm_mallcnt =
			(
			SELECT count(*)
			FROM PLIST
			WHERE p_modelno in
				(
				SELECT gdl_modelno_mutiple
				FROM GOODS_DC_LIST
				WHERE gdl_modelno IN
					(SELECT gdl_modelno
					FROM GOODS_DC_LIST
					WHERE gdl_modelno_mutiple = gdm_modelno)
				)
			)
		WHERE gdm_modelno in
			(SELECT gdl_modelno
			FROM GOODS_DC_LIST
			WHERE gdl_modelno_mutiple = gdm_modelno)
END



