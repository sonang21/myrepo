/* *************************************************************************
 * NAME : ASISTEST.UDF_GETSHA256
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:34
 *        Modify: 2018-05-07 13:11:11
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_GETSHA256" (str varchar2) RETURN VARCHAR2 
AS LANGUAGE JAVA 
NAME 'EnuriUtilSha2.udf_getsha256(java.lang.String) return java.lang.String';