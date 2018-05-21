/* *************************************************************************
 * NAME : DBENURI.TR_ORACLE_LOGON_LOG
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:09
 *        Modify: 2018-03-28 18:50:09
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ORACLE_LOGON_LOG" AFTER LOGON ON DATABASE
BEGIN
    IF INSTR(SYS_CONTEXT('USERENV', 'IP_ADDRESS'),'124.243.126') > 0 THEN 
        NULL;
    ELSIF INSTR(SYS_CONTEXT('USERENV', 'IP_ADDRESS'),'100.100.100') > 0 THEN
        NULL;
    ELSIF INSTR(SYS_CONTEXT('USERENV', 'IP_ADDRESS'),'1.255.6') > 0 THEN
        NULL; 
    ELSE
        INSERT INTO LOG_CONNECT_LOG(
          LOG_NO   
          ,LOG_ACTION
          ,CONNECT_YMD
          ,CONNECT_TIME
          ,CONNECT_DATE
          ,IP_ADDRESS
          ,SESSION_USER
          ,INSTANCE_NAME
          ,OS_USER
          ,SERVER_HOST
        ) VALUES (
          LOG_CONNECT_LOG_SEQ.NEXTVAL
          ,'LOGON'
          ,TO_CHAR(SYSDATE,'YYYYMMDD')
          ,TO_CHAR(SYSDATE,'HH24MISS')
          ,SYSDATE   
          ,SYS_CONTEXT('USERENV','IP_ADDRESS')
          ,SYS_CONTEXT('USERENV','SESSION_USER')
          ,SYS_CONTEXT('USERENV','INSTANCE_NAME')
          ,SYS_CONTEXT('USERENV','OS_USER')
          ,SYS_CONTEXT('USERENV','SERVER_HOST')
        );
    END IF;
END;

ALTER TRIGGER "DBENURI"."TR_ORACLE_LOGON_LOG" ENABLE