/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_SPECOPT
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:56:21
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_SPECOPT" (v_modelno NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180418
*/ 
    v_specno tbl_modelno_spec.specno%TYPE := 0;
    tmpSpec_List VARCHAR2(3000) :=' ';

    CURSOR cur_spec IS
    
     select distinct specno
       from tbl_modelno_spec
      where modelno in (SELECT distinct a.modelno
                          FROM TBL_GOODS a, TBL_GOODS_SUM b
                         WHERE a.modelno = b.modelno
                           AND (a.modelno= v_modelno OR a.modelno_group = v_modelno)
                           AND a.jobcode>'0'
                           AND a.constrain='1'
                           AND b.mallcnt > 0);

   i_count     NUMBER := 0;

BEGIN

  OPEN cur_spec;
  LOOP

    FETCH cur_spec INTO v_specno;
    EXIT WHEN cur_spec%NOTFOUND;

    IF i_count <= 0 THEN
      tmpSpec_List := v_specno;
    ELSE
      tmpSpec_List := tmpSpec_List || ' ' || v_specno;
    END IF;

    i_count := i_count +1;

  END LOOP;
  CLOSE cur_spec;

  RETURN tmpSpec_List;

END;
