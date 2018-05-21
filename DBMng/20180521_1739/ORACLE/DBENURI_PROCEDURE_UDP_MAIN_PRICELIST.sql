/* *************************************************************************
 * NAME : DBENURI.UDP_MAIN_PRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MAIN_PRICELIST" 
IS
   result_code VARCHAR2(1000) := '';
   result_desc VARCHAR2(1000) := '';
   startTime   VARCHAR2(1000) := '';
   endTime     VARCHAR2(1000) := '';
BEGIN

 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_MAIN_PRICELIST start ......');

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   INTO startTime
   FROM DUAL;

 BEGIN
   UDP_PRICELIST_DAILY_ANALYZE(result_code, result_desc, startTime, endTime);
 EXCEPTION WHEN OTHERS THEN
   result_code := result_code || '' || SQLCODE;
   result_desc := result_desc || 'UDP_MAIN_PRICELIST => ERROR';
 END;

 result_code := '0';
 result_desc := 'UDP_MAIN_PRICELIST => SUCCESS';

 SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
    INTO endTime
    FROM DUAL;

 --DBMS_OUTPUT.PUT_LINE('startTime : ' || startTime || ', endTime : ' || endTime || ', result_code : ' || result_code || ', result_desc : ' || result_desc);

 EXCEPTION
     WHEN OTHERS THEN
       SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
          INTO endTime
          FROM DUAL;

       result_code := '' || SQLCODE;
       result_desc := 'UDP_MAIN_PRICELIST => ERROR';

END;
 