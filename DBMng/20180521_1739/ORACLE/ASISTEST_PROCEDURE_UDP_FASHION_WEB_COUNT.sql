/* *************************************************************************
 * NAME : ASISTEST.UDP_FASHION_WEB_COUNT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:22
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_FASHION_WEB_COUNT" 
IS

v_ca_code TBL_FAVORITE_GOODS.ca_code%TYPE := ' ';
i_count 				NUMBER := 0;
startTime   VARCHAR2(1000) := '';
endTime     VARCHAR2(1000) := '';

CURSOR fashion_web_count_cursor IS
	SELECT rtrim(ca_code) ca_code, COUNT(PL_NO) cnt  FROM TBL_PRICELIST p, TBL_SHOPLIST s WHERE P.SHOP_CODE = S.SHOP_CODE AND P.MODELNO <= 0  AND (P.ca_code LIKE '14%' OR P.ca_code LIKE '15%' ) AND P.status < '3' AND P.srvflag = '0'  AND DECODE(p.esstockflag, NULL, '0', p.esstockflag) < '1'  AND (P.soldflag IS NULL OR P.soldflag < 2  OR (P.soldflag = 2 AND (TO_CHAR(P.solddate, 'YYYYMMDDHH24') - TO_CHAR(SYSDATE, 'YYYYMMDDHH24')) <= 24) OR (P.soldflag = 3 AND (TO_CHAR(P.solddate, 'YYYYMMDD') - TO_CHAR(SYSDATE, 'YYYYMMDD')) >= 8)) AND (P.IMGURL IS NOT NULL AND LENGTH(P.IMGURL) > 0 ) GROUP BY rtrim(ca_code);

BEGIN

	--DBMS_OUTPUT.ENABLE;
	--DBMS_OUTPUT.PUT_LINE('Udp_Fashion_Web_Count start ......');

	SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
	INTO startTime
	FROM DUAL;


	DELETE FROM TBL_FASHION_WEB_COUNT;


OPEN fashion_web_count_cursor;
LOOP
	FETCH  fashion_web_count_cursor INTO v_ca_code,i_count;
	EXIT WHEN fashion_web_count_cursor%NOTFOUND;

	INSERT INTO TBL_FASHION_WEB_COUNT (ca_code,COUNT) VALUES (v_ca_code,i_count);


END LOOP;
CLOSE fashion_web_count_cursor;

	SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')
	INTO endTime
	FROM DUAL;

	--DBMS_OUTPUT.PUT_LINE('startTime : ' || startTime || ', endTime : ' || endTime );

COMMIT;

END Udp_Fashion_Web_Count;