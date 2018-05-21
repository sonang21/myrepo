/* *************************************************************************
 * NAME : ASISTEST.UDP_TOUR_SUBTITLE_CREATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-07 13:11:16
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_TOUR_SUBTITLE_CREATE" (v_shop_code IN NUMBER)
	IS
		v_str VARCHAR2(4000) := '';
		v_str2 VARCHAR2(4000) := '';

	BEGIN
		IF v_shop_code > 0 THEN
			v_str := 'DELETE FROM TBL_TOUR_GOODSUB_TITLE WHERE SHOP_CODE='||v_shop_code;
		ELSE
			v_str := 'DELETE FROM TBL_TOUR_GOODSUB_TITLE';
		END IF;
		EXECUTE IMMEDIATE v_str;

		v_str := '';

		IF v_shop_code > 0 THEN
			v_str := 'INSERT INTO TBL_TOUR_GOODSUB_TITLE (MODELNO,TR_GOODSUBNAME,TR_FACTORY,SHOP_CODE)';
			v_str2 := ' SELECT MODELNO,TR_GOODSUBNAME,MAX(TR_FACTORY),'||v_shop_code||' FROM TBL_TOUR_GOODSUB WHERE SHOP_CODE='||v_shop_code||' AND TR_DEL_FLAG=to_char(0) GROUP BY MODELNO, TR_GOODSUBNAME';
		ELSE
			v_str := 'INSERT INTO TBL_TOUR_GOODSUB_TITLE (MODELNO,TR_GOODSUBNAME,TR_FACTORY,SHOP_CODE)';
			v_str2 := ' SELECT MODELNO,TR_GOODSUBNAME,MAX(TR_FACTORY),MAX(SHOP_CODE) FROM TBL_TOUR_GOODSUB WHERE TR_DEL_FLAG=to_char(0) GROUP BY MODELNO, TR_GOODSUBNAME';
		END IF;

		EXECUTE IMMEDIATE v_str||v_str2;

		COMMIT;

END UDP_TOUR_SUBTITLE_CREATE;

--------------------------------------------------;