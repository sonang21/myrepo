/* *************************************************************************
 * NAME : DBENURI.UDP_AUTH_CREATE_TABLE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 11:32:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_AUTH_CREATE_TABLE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
/*
 NGIT ���� �ݿ� - �迵�� 20180420
*/ 
  CURSOR cur_pricelist_s IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select modelno
                         from tbl_goods g
                         where g.factory = '�Ҵ�');

  CURSOR cur_pricelist_i IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select modelno
                         from tbl_goods g
                         where g.factory = '���̿�');

  CURSOR cur_pricelist_d IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select g.modelno
                         from tbl_goods g
                         where g.ca_code like '0209%'
                           and g.factory like '���%');

  CURSOR cur_pricelist_c IS
  SELECT /*+ ORDERED(g, p) parallel(g 4) parallel(p 4) */ distinct modelno
     FROM TBL_PRICELIST p
    WHERE modelno in (select g.modelno
                         from tbl_goods g
                         where g.ca_code like '0209%'
                           and g.factory = 'ī�ÿ�');

 v_ca_code_tmp tbl_cate_goods.ca_code%TYPE := ' ';
 v_modelno_tmp tbl_goods.modelno%TYPE := 0;
 v_minprice    tbl_goods_sum.minprice%TYPE := 0;
 v_avgprice    tbl_goods_sum.avgprice%TYPE := 0;
 v_maxprice    tbl_goods_sum.maxprice%TYPE := 0;
 v_mallcnt     tbl_goods_sum.mallcnt%TYPE := 0;
 v_pl_no       tbl_pricelist.pl_no%TYPE := 0;
 v_modelno     tbl_pricelist.modelno%TYPE := 0;

 i_count       NUMBER := 0;

 tmp_start     VARCHAR2(100) := '';
 tmp_end    VARCHAR2(100) := '';
  v_str     VARCHAR2(1000);

BEGIN

  SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
   FROM DUAL;

 startTime := startTime || '|5 : ' || tmp_start;

 i_count := 0;

 --DROP TABLE TBL_GOODS_AUTH_560;
 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_560';
 EXECUTE IMMEDIATE v_str;

  INSERT INTO TBL_GOODS_AUTH_560
  SELECT a.ca_code, a.modelno, a.modelnm, b.minprice, a.c_date, a.jobcode, b.mallcnt
    FROM tbl_goods a, tbl_goods_sum b
   WHERE a.modelno = b.modelno
     AND a.factory like '�Ҵ�'
     AND a.jobcode > '0'
     AND a.constrain = '1'
     AND b.mallcnt > 0
     AND a.openexpectflag='0'
     ;

  COMMIT;

 --TRUNCATE TABLE TBL_GOODS_AUTH_572;
 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_572';
 EXECUTE IMMEDIATE v_str;

 INSERT INTO TBL_GOODS_AUTH_572
 SELECT a.ca_code, a.modelno, a.modelnm, b.minprice, a.c_date, a.jobcode, b.mallcnt
    FROM tbl_goods a, tbl_goods_sum b
   WHERE a.modelno = b.modelno
     AND a.factory = '���̿�'
     AND a.jobcode > '0'
     AND a.constrain = '1'
     AND b.mallcnt > 0
     AND a.openexpectflag='0'
    ;

 --TRUNCATE TABLE TBL_GOODS_AUTH_563;
 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_563';
 EXECUTE IMMEDIATE v_str;

 INSERT INTO TBL_GOODS_AUTH_563
 SELECT a.ca_code, a.modelno, a.modelnm, b.minprice, a.c_date, a.jobcode, b.mallcnt
   FROM tbl_goods a, tbl_goods_sum b
  WHERE a.modelno = b.modelno
    AND a.ca_code like '0209%'
    AND a.factory like '���%'
    AND a.jobcode > '0'
    AND a.constrain = '1'
    AND b.mallcnt > 0
    AND a.openexpectflag='0'
    ;

 v_str := 'TRUNCATE TABLE TBL_GOODS_AUTH_5064';
 EXECUTE IMMEDIATE v_str;

 INSERT INTO TBL_GOODS_AUTH_5064
 SELECT a.ca_code, a.modelno, a.modelnm, b.minprice, a.c_date, a.jobcode, b.mallcnt
   FROM tbl_goods a, tbl_goods_sum b
  WHERE a.modelno = b.modelno
    AND a.ca_code like '0209%'
    AND a.factory = 'ī�ÿ�'
    AND a.jobcode > '0'
    AND a.constrain = '1'
    AND b.mallcnt > 0
    AND a.openexpectflag='0'
    ;

 OPEN cur_pricelist_s;
 LOOP

  FETCH cur_pricelist_s INTO v_modelno;
  EXIT WHEN cur_pricelist_s%NOTFOUND;

   i_count := i_count + 1;
   UPDATE TBL_PRICELIST set authvcode = 560
    WHERE modelno = v_modelno;

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
 
