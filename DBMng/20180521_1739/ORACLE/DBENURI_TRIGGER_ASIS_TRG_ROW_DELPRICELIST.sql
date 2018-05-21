/* *************************************************************************
 * NAME : DBENURI.ASIS_TRG_ROW_DELPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-03-28 17:05:11
 *        Modify: 2018-05-11 10:50:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."ASIS_TRG_ROW_DELPRICELIST" BEFORE DELETE ON ASIS_TBL_PRICELIST
FOR EACH ROW
--WHEN (OLD.modelno > 0)
BEGIN
 pacPricelistData.v_Modelno_old := 0;
 pacPricelistData.v_Modelno_new := 0;
 pacPricelistData.v_Pl_no_old := 0;
 pacPricelistData.v_Pl_no_new := 0;

 pacPricelistData.v_Modelno_old := :OLD.modelno;

END;





ALTER TRIGGER "DBENURI"."ASIS_TRG_ROW_DELPRICELIST" DISABLE