/* *************************************************************************
 * NAME : DBENURI.UDF_GETSHA256
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-04-19 18:32:47
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_GETSHA256" (str varchar2) RETURN VARCHAR2 
AS LANGUAGE JAVA 
NAME 'EnuriUtilSha2.udf_getsha256(java.lang.String) return java.lang.String';