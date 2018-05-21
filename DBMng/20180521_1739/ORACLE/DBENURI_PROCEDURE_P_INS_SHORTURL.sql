/* *************************************************************************
 * NAME : DBENURI.P_INS_SHORTURL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."P_INS_SHORTURL" 
(
    orgUrl   IN  VARCHAR2  
  , shortUrl OUT VARCHAR2
) AS 
  cnt INTEGER;
BEGIN
    /*SELECT COUNT(*)
      INTO cnt
      FROM TBL_SHORT_URL
    WHERE ORG_URL = TRIM(orgUrl)
    AND rownum=1
    ;
    */ --lsm
    
     cnt:= 0; --lsm
    
  IF CNT <> 0 THEN
      SELECT short_url
        INTO shortUrl
        FROM TBL_SHORT_URL
      WHERE ORG_URL = TRIM(orgUrl)
       AND ROWNUM = 1
    ;
  ELSE
      LOOP
        SELECT  CASE ROUND(DBMS_RANDOM.value(0,2))WHEN 0 THEN DBMS_RANDOM.STRING('U',1)
                                              WHEN 1 THEN DBMS_RANDOM.STRING('L',1)
                                              WHEN 2 THEN TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0,9))) END
              ||CASE ROUND(DBMS_RANDOM.value(0,2))WHEN 0 THEN DBMS_RANDOM.STRING('U',1)
                                              WHEN 1 THEN DBMS_RANDOM.STRING('L',1)
                                              WHEN 2 THEN TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0,9))) END
              ||CASE ROUND(DBMS_RANDOM.value(0,2))WHEN 0 THEN DBMS_RANDOM.STRING('U',1)
                                              WHEN 1 THEN DBMS_RANDOM.STRING('L',1)
                                              WHEN 2 THEN TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0,9))) END
              ||CASE ROUND(DBMS_RANDOM.value(0,2))WHEN 0 THEN DBMS_RANDOM.STRING('U',1)
                                              WHEN 1 THEN DBMS_RANDOM.STRING('L',1)
                                              WHEN 2 THEN TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0,9))) END
              ||CASE ROUND(DBMS_RANDOM.value(0,2))WHEN 0 THEN DBMS_RANDOM.STRING('U',1)
                                              WHEN 1 THEN DBMS_RANDOM.STRING('L',1)
                                              WHEN 2 THEN TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0,9))) END
        INTO shortUrl
        FROM DUAL;
        
        SELECT COUNT(*)
          INTO cnt
          FROM TBL_SHORT_URL
        WHERE SHORT_URL = shortUrl 
        AND rownum=1
        ;
        
        IF (cnt = 0) THEN
          INSERT INTO TBL_SHORT_URL( SHORT_URL,ORG_URL) VALUES(shortUrl,orgUrl);
          
          COMMIT;
          EXIT;
        END IF;
      END LOOP;
    END IF;
END P_INS_SHORTURL;