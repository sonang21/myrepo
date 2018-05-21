/* *************************************************************************
 * NAME : ES_APP.UDF_CATEGORY_SUB2
 * TYPE : FUNCTION
 * TIME : Create: 2018-04-05 16:42:54
 *        Modify: 2018-04-05 16:42:54
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_CATEGORY_SUB2" 
(
  IN_CATEGORY IN VARCHAR2,
  IN_SUBSTR IN NUMBER
)
RETURN VARCHAR2 AS 
    V_CATEGORY VARCHAR2(2000) := '';
BEGIN

    RETURN NULL;
    
END UDF_CATEGORY_SUB2;