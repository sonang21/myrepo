/* *************************************************************************
 * NAME : DBENURI.PROINTMPINDEXKEY
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."PROINTMPINDEXKEY" (
 v_table_name IN tbl_tmpindexkey.index_tablenm%TYPE,
 v_intKey     IN tbl_tmpindexkey.index_key%TYPE,
 v_strCmd     IN tbl_tmpindexkey.index_tablenm%TYPE)
IS
 CURSOR cur_pricelist IS
   SELECT pl_no
     FROM TBL_PRICELIST
    WHERE modelno = v_intKey
      AND status <= '2'
      AND srvflag = '0'
      AND flag = '0'
      AND (soldflag < 2  OR (soldflag = 2 AND (to_number(to_char(sysdate, 'YYYYMMDDHH24')) - to_number(to_char(solddate, 'YYYYMMDDHH24'))) <= 24)
                         OR (soldflag = 3 AND (to_number(to_char(sysdate, 'YYYYMMDD')) - to_number(to_char(solddate, 'YYYYMMDD'))) >= 8));

  v_pl_no_tmp tbl_pricelist.pl_no%TYPE;
BEGIN

 IF v_strCmd = 'insGOODS_PRICELIST'  THEN

  OPEN cur_pricelist;
  LOOP
   FETCH cur_pricelist INTO v_pl_no_tmp;
   EXIT WHEN cur_pricelist%NOTFOUND;

     --INSERT INTO TBL_TMPINDEXKEY(index_no, index_tablenm, index_key, index_date) VALUES ((select NVL(max(index_no), 0) +1 from tbl_tmpindexkey), v_table_name, v_pl_no_tmp, sysdate);
     INSERT INTO TBL_TMPINDEXKEY(index_tablenm, index_key, index_date) VALUES (v_table_name, v_pl_no_tmp, sysdate);

    END LOOP;
    CLOSE cur_pricelist;

 ELSE

  --INSERT INTO TBL_TMPINDEXKEY(index_no, index_tablenm, index_key, index_date) VALUES ((select NVL(max(index_no), 0) +1 from tbl_tmpindexkey), v_table_name, v_intKey, sysdate);
  INSERT INTO TBL_TMPINDEXKEY(index_tablenm, index_key, index_date) VALUES (v_table_name, v_intKey, sysdate);

 END IF;

END proInTmpindexkey;
 