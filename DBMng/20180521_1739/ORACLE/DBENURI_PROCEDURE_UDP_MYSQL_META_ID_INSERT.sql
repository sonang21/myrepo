/* *************************************************************************
 * NAME : DBENURI.UDP_MYSQL_META_ID_INSERT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_MYSQL_META_ID_INSERT" 
IS


BEGIN
    DELETE META_ID_MYSQL;
    INSERT INTO META_ID_MYSQL (SELECT * FROM  META_ID_MYSQL_TMP);
    DELETE META_ID_MYSQL_TMP;
    COMMIT;    
END;