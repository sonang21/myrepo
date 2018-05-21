/* *************************************************************************
 * NAME : dbo.UDP_DEL_GOODS
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2006-07-26 09:23:10.943
 *        Modify: 2018-05-03 17:23:35.32
 *        Backup: 20180521_1739
 ************************************************************************* */






CREATE	PROCEDURE [dbo].[UDP_DEL_GOODS]
	@modelno int 
AS
BEGIN
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DELETE FROM GOODS_ADDCATE WHERE ga_modelno = @modelno

	DELETE FROM GOODS_PRTSUPPLY WHERE gprt_modelno = @modelno or gprt_pointmodelno = @modelno

	--DELETE FROM GOODS_HP_LIST WHERE ghl_modelno = @modelno or ghl_modelno_mutiple = @modelno
	--DELETE FROM GOODS_MP3_LIST WHERE gml_modelno = @modelno or gml_modelno_multiple = @modelno
	--DELETE FROM GOODS_DC_LIST WHERE gdl_modelno = @modelno or gdl_modelno_mutiple = @modelno
	--DELETE FROM GOODS_ETC1_LIST WHERE ge1l_modelno = @modelno or ge1l_modelno_mutiple = @modelno
	--DELETE FROM GOODS_ETC2_LIST WHERE ge2l_modelno = @modelno or ge2l_modelno_mutiple = @modelno
	--DELETE FROM GOODS_ETC3_LIST WHERE ge3l_modelno = @modelno or ge3l_modelno_mutiple = @modelno
	DELETE FROM GOODS_GROUP_LIST WHERE ggl_modelno = @modelno or ggl_modelno_multiple = @modelno

	-- WEEKDATA
	/*
	DELETE FROM WEEKDATA_196.WEEKDATA.dbo.PLIST_ADD WHERE seqno = @modelno
	UPDATE WEEKDATA_196.WEEKDATA.dbo.TBL_WEEK_GOODS SET
		wg_minprice=(SELECT min(price) FROM WEEKDATA_196.WEEKDATA.DBO.PLIST_ADD WITH (ReadUncommitted) WHERE wg_date_id = date_id  and seqno = @modelno)
		,wg_avgprice=(SELECT avg(price) FROM WEEKDATA_196.WEEKDATA.DBO.PLIST_ADD WITH (ReadUncommitted) WHERE wg_date_id = date_id and seqno = @modelno)
		,wg_maxprice=(SELECT max(price) FROM WEEKDATA_196.WEEKDATA.DBO.PLIST_ADD WITH (ReadUncommitted) WHERE wg_date_id = date_id and seqno = @modelno)
		,wg_shop_cnt=(SELECT count(seqno) FROM WEEKDATA_196.WEEKDATA.DBO.PLIST_ADD WITH (ReadUncommitted) WHERE wg_date_id = date_id and seqno = @modelno)
		WHERE wg_modelno = @modelno
	*/
	-- ELOC2001 PRICELIST
	DELETE FROM PRICELIST WHERE pl_modelno = @modelno

	-- ELOC2001GOODS
	DELETE FROM GOODS WHERE g_modelno = @modelno
	INSERT INTO GOODS(g_modelno, g_modelnm) VALUES(@modelno, '▶추가가능')

	SET NOCOUNT OFF
END



