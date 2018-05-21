/* *************************************************************************
 * NAME : ASISTEST.UDP_AUTH_CREATE_TABLE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:15
 *        Modify: 2018-05-04 18:53:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_AUTH_CREATE_TABLE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
  CURSOR cur_pricelist_s IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select modelno
                         from tbl_goods g
                         where factory = '소니');

  CURSOR cur_pricelist_i IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select modelno
                         from tbl_goods g
                         where factory = '아이와');

  CURSOR cur_pricelist_d IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select modelno
                         from tbl_goods g
                         where ca_lcode = '02'
                           and ca_code like '0209%'
                           and cateflag = '0'
                           and factory like '산요%');

  CURSOR cur_pricelist_c IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select modelno
                         from tbl_goods g
                         where ca_lcode = '02'
                           and ca_code like '0209%'
                           and cateflag = '0'
                           and factory = '카시오');

 v_ca_code_tmp tbl_goods.ca_code%TYPE := ' ';
 v_modelno_tmp tbl_goods.modelno%TYPE := 0;
 v_minprice    tbl_goods.minprice%TYPE := 0;
 v_avgprice    tbl_goods.avgprice%TYPE := 0;
 v_maxprice    tbl_goods.maxprice%TYPE := 0;
 v_mallcnt     tbl_goods.mallcnt%TYPE := 0;
 v_pl_no       tbl_pricelist.pl_no%TYPE := 0;
 v_modelno     tbl_pricelist.modelno%TYPE := 0;

 i_count       NUMBER := 0;

 tmp_start     VARCHAR2(100) := '';
 tmp_end    VARCHAR2(100) := '';
  v_str     VARCHAR2(1000);

BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_AUTH_CREATE_TABLE start ......');

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
   FROM DUAL;

 startTime := startTime || '|5 : ' || tmp_start;

 i_count := 0;

 --DROP TABLE TBL_GOODS_AUTH_560;
 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_560';
 EXECUTE IMMEDIATE v_str;

  INSERT INTO TBL_GOODS_AUTH_560
  SELECT ca_code, modelno, modelnm, minprice, c_date, jobcode, mallcnt
    FROM TBL_GOODS
   WHERE factory like '소니'
     AND jobcode > '0'
     AND constrain = '1'
     AND mallcnt > 0
     AND openexpectflag='0'
     ANd cateflag = '0';

  COMMIT;

 --TRUNCATE TABLE TBL_GOODS_AUTH_572;
 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_572';
 EXECUTE IMMEDIATE v_str;

 INSERT INTO TBL_GOODS_AUTH_572
 SELECT ca_code, modelno, modelnm, minprice, c_date, jobcode, mallcnt
   FROM TBL_GOODS
  WHERE factory = '아이와'
     AND jobcode > '0'
     AND constrain = '1'
     AND mallcnt > 0
     AND openexpectflag='0'
     AND cateflag = '0';

 --TRUNCATE TABLE TBL_GOODS_AUTH_563;
 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_563';
 EXECUTE IMMEDIATE v_str;

 INSERT INTO TBL_GOODS_AUTH_563
 SELECT ca_code, modelno, modelnm, minprice, c_date, jobcode, mallcnt
   FROM TBL_GOODS
  WHERE ca_lcode = '02'
    AND ca_code like '0209%'
    AND factory like '산요%'
    AND jobcode > '0'
    AND constrain = '1'
    AND mallcnt > 0
    AND openexpectflag='0'
    AND cateflag = '0';

 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_5064';
 EXECUTE IMMEDIATE v_str;

 INSERT INTO TBL_GOODS_AUTH_5064
 SELECT ca_code, modelno, modelnm, minprice, c_date, jobcode, mallcnt
   FROM TBL_GOODS
  WHERE ca_lcode = '02'
    AND ca_code like '0209%'
    AND factory = '카시오'
    AND jobcode > '0'
    AND constrain = '1'
    AND mallcnt > 0
    AND openexpectflag='0'
    AND cateflag = '0';

 OPEN cur_pricelist_s;
 LOOP

  FETCH cur_pricelist_s INTO v_modelno;
  EXIT WHEN cur_pricelist_s%NOTFOUND;

   i_count := i_count + 1;
   UPDATE TBL_PRICELIST set authvcode = 560
    WHERE modelno = v_modelno;

    --UPDATE /*+ ordered use_hash(g p) parallel(g 4) parallel(p 4) */ TBL_PRICELIST p SET authvcode = 560
    -- WHERE modelno in (SELECT modelno FROM TBL_GOODS g WHERE factory = '소니');

    IF i_count = 500 THEN
     COMMIT;
     i_count := 0;
    END IF;

  END LOOP;
  CLOSE cur_pricelist_s;

  COMMIT;

  v_modelno := 0;
  i_count := 0;
  OPEN cur_pricelist_i;
  LOOP
   FETCH cur_pricelist_i INTO v_modelno;
   EXIT WHEN cur_pricelist_i%NOTFOUND;

    i_count := i_count + 1;
    UPDATE TBL_PRICELIST set authvcode = 572
     WHERE modelno = v_modelno;
      --UPDATE /*+ ordered use_hash(g p) parallel(g 4) parallel(p 4) */ TBL_PRICELIST p SET authvcode = 572
      -- WHERE modelno in (SELECT modelno FROM TBL_GOODS g WHERE factory = '아이와');

      IF i_count = 500 THEN
       COMMIT;
       i_count := 0;
      END IF;

 END LOOP;
 CLOSE cur_pricelist_i;

  COMMIT;

 v_modelno := 0;
  i_count := 0;
  OPEN cur_pricelist_d;
  LOOP
   FETCH cur_pricelist_d INTO v_modelno;
   EXIT WHEN cur_pricelist_d%NOTFOUND;

    i_count := i_count + 1;
    UPDATE TBL_PRICELIST set authvcode = 563
     WHERE modelno = v_modelno;

      IF i_count = 500 THEN
       COMMIT;
       i_count := 0;
      END IF;

 END LOOP;
 CLOSE cur_pricelist_d;

 COMMIT;

 v_modelno := 0;
  i_count := 0;
  OPEN cur_pricelist_c;
  LOOP
   FETCH cur_pricelist_c INTO v_modelno;
   EXIT WHEN cur_pricelist_c%NOTFOUND;

    i_count := i_count + 1;
    UPDATE TBL_PRICELIST set authvcode = 5064
     WHERE modelno = v_modelno;

      IF i_count = 500 THEN
       COMMIT;
       i_count := 0;
      END IF;

 END LOOP;
 CLOSE cur_pricelist_c;

 COMMIT;

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
    FROM DUAL;

 endTime   := endTime || '|5 : ' || tmp_end;

 IF result_code = '' THEN
  result_code := '0';
 ELSE
  result_code := result_code || '|' || '0';
 END IF;

 IF result_desc = '' THEN
  result_desc := 'UDP_AUTH_CREATE_TABLE => SUCCESS';
 ELSE
  result_desc := result_desc || '|' || 'UDP_AUTH_CREATE_TABLE => SUCCESS';
 END IF;

 EXCEPTION
  WHEN OTHERS THEN
    COMMIT;
  	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

    IF result_code = '' THEN
   		result_code := '' || SQLCODE;
   	ELSE
    	result_code := result_code || '|' || SQLCODE;
  	END IF;

		IF result_desc = '' THEN
    	result_desc := 'UDP_AUTH_CREATE_TABLE => ERROR';
  	ELSE
  		result_desc := result_desc || '|' || 'UDP_AUTH_CREATE_TABLE => ERROR';
 		END IF;

		endTime   := endTime || '|5 error: ' || tmp_end;

END UDP_AUTH_CREATE_TABLE;