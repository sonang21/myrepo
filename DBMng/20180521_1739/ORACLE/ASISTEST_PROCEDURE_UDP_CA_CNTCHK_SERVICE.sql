/* *************************************************************************
 * NAME : ASISTEST.UDP_CA_CNTCHK_SERVICE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:17
 *        Modify: 2018-05-04 18:33:17
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_CA_CNTCHK_SERVICE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
  v_str     VARCHAR2(4000) := '';
  v_str2    VARCHAR2(4000) := '';
  v_str3    VARCHAR2(4000) := '';
  i_exists  NUMBER := 0;
  v_status  tbl_pricelist.status%TYPE := '3';

 tmp_start     VARCHAR2(100) := '';
 tmp_end    VARCHAR2(100) := '';

BEGIN
 DBMS_OUTPUT.ENABLE;
 DBMS_OUTPUT.PUT_LINE('UDP_CA_CNTCHK_SERVICE start ......');

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
    FROM DUAL;

 startTime := startTime || '|2 : ' || tmp_start;

  SELECT count(TABLE_NAME)
    INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_CA_ALLCNT';

 IF i_exists > 0 THEN
  v_str := 'DROP TABLE TMPTBL_CA_ALLCNT';
  EXECUTE IMMEDIATE v_str;
 END IF;

 v_str := '';
 v_str2 := '';
 v_str3 := '';

 v_str := ' CREATE TABLE TMPTBL_CA_ALLCNT AS SELECT p.shop_code,SUBSTR(p.ca_code,0,2) ca_code,count(*) ps_allcnt FROM TBL_PRICELIST p';
 v_str2 := ' WHERE p.status=to_char(0) AND p.shop_code in (536,4027,55,75,663) ';
 v_str3 := ' GROUP BY p.shop_code,SUBSTR(p.ca_code,0,2)';

 EXECUTE IMMEDIATE v_str||v_str2||v_str3;

  i_exists := 0;

  SELECT count(TABLE_NAME)
   INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_CA_SRVCNT';

  IF i_exists > 0 THEN
   v_str := 'DROP TABLE TMPTBL_CA_SRVCNT';
   EXECUTE IMMEDIATE v_str;
  END IF;

  v_str := '';
  v_str2 := '';
  v_str3 := '';

  v_str := 'CREATE TABLE TMPTBL_CA_SRVCNT AS SELECT shop_code, SUBSTR(p.ca_code,0,2) ca_code,count(distinct p.modelno) pl_srvcnt, count(*) pl_shopsrvcnt FROM TBL_GOODS g, TBL_PRICELIST p ';
  v_str2 := ' WHERE g.jobcode <> to_char(0) AND g.constrain = to_char(1) AND g.cateflag = to_char(0) AND g.modelno = p.modelno ';
  v_str3 := ' AND p.status=to_char(0) and srvflag = to_char(0) AND p.shop_code in (536,4027,55,75,663) GROUP BY p.shop_code,SUBSTR(p.ca_code,0,2) ';

 EXECUTE IMMEDIATE v_str||v_str2||v_str3;


 v_str := '';
 v_str2 := '';
 v_str3 := '';

 v_str := 'INSERT INTO TBL_PRICELIST_CA_STATIC  SELECT a.shop_code, a.ca_code,sh.shop_name, a.ps_allcnt, s.pl_srvcnt, sh.apflag, sh.service, sh.grade, g.unit, sysdate, s.pl_shopsrvcnt ,0,0,0';
 v_str2 := ' FROM TMPTBL_CA_ALLCNT a, TMPTBL_CA_SRVCNT s, TBL_SDU_GRADE g , TBL_SHOPLIST sh WHERE a.shop_code = s.shop_code(+) ';
 v_str3 := ' AND a.ca_code = s.ca_code(+) AND a.shop_code = sh.shop_code AND sh.grade = g.grade AND a.ca_code is not null';

 EXECUTE IMMEDIATE v_str||v_str2||v_str3;

 COMMIT;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_CA_ALLCNT';
 EXECUTE IMMEDIATE v_str;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_CA_SRVCNT';
 EXECUTE IMMEDIATE v_str;

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_end
    FROM DUAL;

 IF result_code = '' THEN
  result_code := '0';
 ELSE
  result_code := result_code || '|' || '0';
 END IF;

 IF result_desc = '' THEN
  result_desc := 'UDP_CA_CNTCHK_SERVICE => SUCCESS';
 ELSE
  result_desc := result_desc || '|' || 'UDP_CA_CNTCHK_SERVICE => SUCCESS';
 END IF;

 endTime   := endTime || '|5 : ' || tmp_end;

 EXCEPTION
     WHEN OTHERS THEN
      COMMIT;
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
         INTO tmp_end
         FROM DUAL;
    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_CA_CNTCHK_SERVICE => ERROR ';
    ELSE
         result_desc := result_desc || '|' || 'UDP_CA_CNTCHK_SERVICE => ERROR';
    END IF;

    endTime   := endTime || '|2 er: ' || tmp_end;

END UDP_CA_CNTCHK_SERVICE;