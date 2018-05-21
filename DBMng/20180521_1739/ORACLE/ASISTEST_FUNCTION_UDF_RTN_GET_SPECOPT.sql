/* *************************************************************************
 * NAME : ASISTEST.UDF_RTN_GET_SPECOPT
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RTN_GET_SPECOPT" (v_modelno NUMBER)
RETURN VARCHAR2 AS
    v_specno tbl_modelno_spec.specno%TYPE := 0;
    tmpSpec_List VARCHAR2(3000) :=' ';

    CURSOR cur_spec IS
    
     select distinct specno
       from tbl_modelno_spec
      --where (modelno = v_modelno OR modelno_group = v_modelno);
      where modelno in (SELECT distinct modelno FROM TBL_GOODS WHERE (modelno= v_modelno OR modelno_group = v_modelno) AND cateflag='0' AND jobcode>'0' AND constrain='1' AND mallcnt > 0);

   i_count     NUMBER := 0;

BEGIN

   --DBMS_OUTPUT.ENABLE;
   --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_SPECOPT start ......');

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