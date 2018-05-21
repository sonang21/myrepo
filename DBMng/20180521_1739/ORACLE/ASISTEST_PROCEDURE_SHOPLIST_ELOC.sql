/* *************************************************************************
 * NAME : ASISTEST.SHOPLIST_ELOC
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:15
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."SHOPLIST_ELOC" 
( a IN String, b IN String
) as language java
name 'Shoplist_Ett.shopList_Eloc(java.lang.String, java.lang.String)';