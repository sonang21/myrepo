/* *************************************************************************
 * NAME : DBADM.FN_LONG_TO_CHAR
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-27 20:22:54
 *        Modify: 2018-03-27 20:22:54
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBADM"."FN_LONG_TO_CHAR" (vRowId in rowid, vTableName in varchar2, vColumnName in varchar2) return varchar2
is 
    vText varchar2(32767);
begin
    execute immediate 'select '|| vColumnName||' from '||vTableName||' where rowid = :rowid' into vText using vRowid;
    return substr(vText, 1, 20000);
end;