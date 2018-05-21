/* *************************************************************************
 * NAME : ASISTEST.UDP_MYSQL_META_ID_INSERT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:28
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_MYSQL_META_ID_INSERT" 
IS


BEGIN
    DELETE META_ID_MYSQL;
    INSERT INTO META_ID_MYSQL (SELECT * FROM  META_ID_MYSQL_TMP);
    DELETE META_ID_MYSQL_TMP;
    COMMIT;    
END;