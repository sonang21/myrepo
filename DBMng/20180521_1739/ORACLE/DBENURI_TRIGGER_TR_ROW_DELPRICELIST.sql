/* *************************************************************************
 * NAME : DBENURI.TR_ROW_DELPRICELIST
 * TYPE : TRIGGER
 * TIME : Create: 2018-04-18 18:09:56
 *        Modify: 2018-05-11 11:07:00
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE TRIGGER "DBENURI"."TR_ROW_DELPRICELIST" BEFORE DELETE ON TBL_PRICELIST
FOR EACH ROW
BEGIN
 
 pacPricelistData.v_Modelno_old := 0;
 pacPricelistData.v_Modelno_new := 0;
 pacPricelistData.v_Pl_no_old   := 0;
 pacPricelistData.v_Pl_no_new   := 0;

 pacPricelistData.v_Modelno_old := :OLD.modelno;

 ---------------------------------------------------------------------------------------------------------------------------------------------------- 
 -- 0418 이주현 수정 : 삭제 Pl_no를 tbl_es_search_log에 입력 필요
 ---------------------------------------------------------------------------------------------------------------------------------------------------- 
 -- pacPricelistData.v_Modelno_old := :OLD.modelno;
 ---------------------------------------------------------------------------------------------------------------------------------------------------- 
 pacPricelistData.v_Pl_no_old   := :OLD.pl_no;
 
END;

------------------------------------------------------------------------------------------------------------------------------------------------------ 
-- 0418 원본 백업 
------------------------------------------------------------------------------------------------------------------------------------------------------ 
--CREATE OR REPLACE TRIGGER 
--"DBENURI"."ASIS_TRG_ROW_DELPRICELIST" BEFORE DELETE ON ASIS_TBL_PRICELIST
--FOR EACH ROW
----WHEN (OLD.modelno > 0)
--BEGIN
-- pacPricelistData.v_Modelno_old := 0;
-- pacPricelistData.v_Modelno_new := 0;
-- pacPricelistData.v_Pl_no_old := 0;
-- pacPricelistData.v_Pl_no_new := 0;

-- pacPricelistData.v_Modelno_old := :OLD.modelno;

--END;
------------------------------------------------------------------------------------------------------------------------------------------------------ 

ALTER TRIGGER "DBENURI"."TR_ROW_DELPRICELIST" ENABLE