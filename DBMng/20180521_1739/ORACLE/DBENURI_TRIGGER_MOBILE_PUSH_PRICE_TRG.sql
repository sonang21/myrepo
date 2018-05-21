/* *************************************************************************
 * NAME : DBENURI.MOBILE_PUSH_PRICE_TRG
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 18:50:09
 *        Modify: 2018-03-28 18:50:09
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."MOBILE_PUSH_PRICE_TRG" 
BEFORE INSERT ON MOBILE_PUSH_PRICE 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.SEQNO IS NULL THEN
      SELECT MOBILE_PUSH_PRICE_SEQ.NEXTVAL INTO :NEW.SEQNO FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;

ALTER TRIGGER "DBENURI"."MOBILE_PUSH_PRICE_TRG" ENABLE