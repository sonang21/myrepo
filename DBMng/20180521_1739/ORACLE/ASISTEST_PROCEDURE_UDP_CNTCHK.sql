/* *************************************************************************
 * NAME : ASISTEST.UDP_CNTCHK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:17
 *        Modify: 2018-05-04 18:33:17
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_CNTCHK" 
IS
  v_str     VARCHAR2(4000) := '';
  v_str2    VARCHAR2(4000) := '';
  v_str3  VARCHAR2(4000) := '';
  i_exists      NUMBER := 0;
 v_status   tbl_pricelist.status%TYPE := '3';

 tmp_start     VARCHAR2(100) := '';
 tmp_end    VARCHAR2(100) := '';

BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_CNTCHK start ......');

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO tmp_start
    FROM DUAL;

  SELECT count(TABLE_NAME)
    INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_ALLCNT';

 IF i_exists > 0 THEN
  v_str := 'DROP TABLE TMPTBL_ALLCNT';
  EXECUTE IMMEDIATE v_str;
 END IF;

 v_str := '';
 v_str2 := '';

 v_str := 'CREATE TABLE TMPTBL_ALLCNT AS SELECT p.shop_code, shop_name, apflag, service, grade, count(*) pl_allcnt FROM TBL_SHOPLIST s, TBL_PRICELIST p ';
 v_str2 := ' WHERE s.shop_code = p.shop_code AND p.status < to_char(3) AND substr(p.ca_code,0,2) <> to_char(93) GROUP BY p.shop_code, shop_name, apflag, service, grade ';

 EXECUTE IMMEDIATE v_str||v_str2;

  i_exists := 0;

  SELECT count(TABLE_NAME)
   INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_SRVCNT';

  IF i_exists > 0 THEN
   v_str := 'DROP TABLE TMPTBL_SRVCNT';
   EXECUTE IMMEDIATE v_str;
  END IF;

  v_str := '';
  v_str2 := '';

  v_str := 'CREATE TABLE TMPTBL_SRVCNT AS SELECT shop_code, count(distinct p.modelno) pl_srvcnt, count(*) pl_shopsrvcnt FROM TBL_GOODS g, TBL_PRICELIST p ';
  v_str2 := ' WHERE g.jobcode <> to_char(0) AND g.constrain in (to_char(1),to_char(5)) AND g.cateflag = to_char(0) AND g.modelno = p.modelno AND p.status < to_char(3) and srvflag = to_char(0) AND g.ca_lcode <> to_char(93) GROUP BY p.shop_code ';

 EXECUTE IMMEDIATE v_str||v_str2;

 i_exists := 0;

 SELECT count(TABLE_NAME)
    INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_NOSRVCNT';

 IF i_exists > 0 THEN
  v_str := 'DROP TABLE TMPTBL_NOSRVCNT';
  EXECUTE IMMEDIATE v_str;
 END IF;

 v_str := '';
 v_str2 := '';

 v_str := 'CREATE TABLE TMPTBL_NOSRVCNT AS SELECT shop_code, count(distinct p.modelno) pl_nosrvcnt FROM TBL_GOODS g, TBL_PRICELIST p ';
 v_str2 := ' WHERE g.jobcode <> to_char(0) AND mallcnt > 0 and (g.constrain = to_char(0) or srvflag <> to_char(0) ) AND g.cateflag = to_char(0) AND g.modelno = p.modelno AND p.status < to_char(3)  AND g.ca_lcode <> to_char(93) GROUP BY p.shop_code ';

 EXECUTE IMMEDIATE v_str||v_str2;

 i_exists := 0;

 SELECT count(TABLE_NAME)
    INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_MINPRICECNT';

 IF i_exists > 0 THEN
  v_str := 'DROP TABLE TMPTBL_MINPRICECNT';
  EXECUTE IMMEDIATE v_str;
 END IF;

 v_str := '';
 v_str2 := '';
 v_str3 := '';

 v_str := 'CREATE TABLE TMPTBL_MINPRICECNT AS SELECT shop_code, count(modelno) pl_minpricecnt,count(distinct modelno) pl_minpricecnt2 FROM (SELECT p.shop_code, p.modelno ';
 --v_str2 := ' , (case when (NVL(s.es_use,to_char(0)) = to_char(9) or p.jobtype = to_char(2)) and NVL(p.instance_price, 0) > 0 then p.instance_price when s.shop_code = 55 then trunc(p.price, -1) else p.price end) tmp_price, g.minprice FROM TBL_GOODS g, TBL_PRICELIST p, TBL_SHOPLIST s ';
 v_str2 := ' , p.price tmp_price, g.minprice FROM TBL_GOODS g, TBL_PRICELIST p, TBL_SHOPLIST s ';
 v_str3 := ' WHERE g.modelno = p.modelno AND g.cateflag = to_char(0) AND p.srvflag = to_char(0) AND status < to_char(3) AND p.modelno > 0 AND p.shop_code = s.shop_code AND g.ca_lcode <> to_char(93)) WHERE minprice = tmp_price GROUP BY shop_code ';

 EXECUTE IMMEDIATE v_str||v_str2||v_str3;

 i_exists := 0;

 SELECT count(TABLE_NAME)
    INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_MINPRICECNT3';

 IF i_exists > 0 THEN
  v_str := 'DROP TABLE  TMPTBL_MINPRICECNT3';
  EXECUTE IMMEDIATE v_str;
 END IF;

 v_str := '';
 v_str2 := '';
 v_str3 := '';

 v_str := 'CREATE TABLE TMPTBL_MINPRICECNT3 AS SELECT shop_code, count(distinct modelno) pl_minpricecnt3 FROM (SELECT p.shop_code, p.modelno ';
 --v_str2 := ' , (case when (NVL(s.es_use,to_char(0)) = to_char(9) or p.jobtype = to_char(2)) and NVL(p.instance_price, 0) > 0 then p.instance_price when s.shop_code = 55 then trunc(p.price, -1) else p.price end) tmp_price, g.minprice FROM TBL_GOODS g, TBL_PRICELIST p, TBL_SHOPLIST s ';
 v_str2 := ' ,p.price tmp_price, g.minprice FROM TBL_GOODS g, TBL_PRICELIST p, TBL_SHOPLIST s ';
 v_str3 := ' WHERE g.modelno = p.modelno AND g.cateflag = to_char(0) AND g.mallcnt>1 AND p.srvflag = to_char(0) AND status < to_char(3) AND p.modelno > 0 AND p.shop_code = s.shop_code AND g.ca_lcode <> to_char(93)) WHERE minprice = tmp_price GROUP BY shop_code ';

 EXECUTE IMMEDIATE v_str||v_str2||v_str3;

 i_exists := 0;

 SELECT count(TABLE_NAME)
    INTO i_exists
    FROM USER_TABLES
   WHERE TABLE_NAME = 'TMPTBL_PREREGCNT';

 IF i_exists > 0 THEN
  v_str := 'DROP TABLE TMPTBL_PREREGCNT';
  EXECUTE IMMEDIATE v_str;
 END IF;

 v_str := '';
 v_str2 := '';

 v_str := 'CREATE TABLE TMPTBL_PREREGCNT AS SELECT shop_code, count(*) pl_preregcnt FROM TBL_PRICELIST';
 v_str2 := ' WHERE status < to_char(3) AND NVL(esstockflag, to_char(0)) != to_char(1) AND modelno < 1 AND substr(ca_code,0,2) <> to_char(93) group by shop_code ';

 EXECUTE IMMEDIATE v_str||v_str2;

 v_str := '';
 v_str2 := '';
 v_str3 := '';

 v_str := 'INSERT INTO TBL_PRICELIST_STATIC  SELECT pl_static_seq.NEXTVAL, a.shop_code, a.shop_name, a.pl_allcnt, s.pl_srvcnt, a.apflag, a.service, a.grade, g.unit, sysdate, s.pl_shopsrvcnt , n.pl_nosrvcnt , m.pl_minpricecnt , p.pl_preregcnt,0,0,0, m.pl_minpricecnt2, p3.pl_minpricecnt3 ';
 v_str2 := ' FROM TMPTBL_ALLCNT a, TMPTBL_SRVCNT s, TBL_SDU_GRADE g , TMPTBL_NOSRVCNT n , TMPTBL_MINPRICECNT m , TMPTBL_PREREGCNT p, TMPTBL_MINPRICECNT3 p3  ';
 v_str3 := ' WHERE a.shop_code = s.shop_code(+) AND a.grade = g.grade(+) and a.shop_code = n.shop_code(+) and a.shop_code = m.shop_code(+) and a.shop_code = p.shop_code(+) and a.shop_code = p3.shop_code(+)';

 EXECUTE IMMEDIATE v_str||v_str2||v_str3;

 COMMIT;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_ALLCNT';
 --EXECUTE IMMEDIATE v_str;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_SRVCNT';
 --EXECUTE IMMEDIATE v_str;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_NOSRVCNT';
 --EXECUTE IMMEDIATE v_str;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_MINPRICECNT';
 --EXECUTE IMMEDIATE v_str;

 v_str := '';
 v_str := 'DROP TABLE TMPTBL_PREREGCNT';
 --EXECUTE IMMEDIATE v_str;


END UDP_CNTCHK;