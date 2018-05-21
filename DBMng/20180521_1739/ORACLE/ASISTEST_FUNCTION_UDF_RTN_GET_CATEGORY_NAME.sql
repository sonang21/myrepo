/* *************************************************************************
 * NAME : ASISTEST.UDF_RTN_GET_CATEGORY_NAME
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-07 13:11:12
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RTN_GET_CATEGORY_NAME" (v_ca_code varchar2)
RETURN VARCHAR2 AS
  v_c_name_tmp  VARCHAR2(60) := '';
  re_category  VARCHAR2(3000) := '';
    i_count      NUMBER := 0;

BEGIN

    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDF_RTN_GET_CATEGORY_NAME start ......');

  i_count := length(v_ca_code);

  IF i_count >= 4 THEN
   IF i_count = 8 AND substr(v_ca_code, 7, 2) <> '00' THEN

    BEGIN
      SELECT C_NAME
        INTO v_c_name_tmp
        FROM TBL_CATEGORY
       WHERE CA_CODE = substr(v_ca_code, 1, 4);
        EXCEPTION WHEN OTHERS THEN
         v_c_name_tmp := '';
        END;

        re_category := v_c_name_tmp;

    BEGIN
      SELECT C_NAME
        INTO v_c_name_tmp
        FROM TBL_CATEGORY
       WHERE CA_CODE = substr(v_ca_code, 1, 6);
        EXCEPTION WHEN OTHERS THEN
         v_c_name_tmp := '';
        END;

       IF v_c_name_tmp = '' THEN
          re_category := v_c_name_tmp;
        ELSE
          re_category := re_category || ' ' || v_c_name_tmp;
        END IF;
    /*
    BEGIN
      SELECT C_NAME
        INTO v_c_name_tmp
        FROM TBL_CATEGORY
       WHERE CA_CODE = substr(v_ca_code, 1, 8);
        EXCEPTION WHEN OTHERS THEN
         v_c_name_tmp := '';
        END;

       IF v_c_name_tmp = '' THEN
          re_category := v_c_name_tmp;
        ELSE
          re_category := re_category || ' ' || v_c_name_tmp;
        END IF;*/

   ELSIF (i_count = 8 AND substr(v_ca_code, 7, 2) = '00') OR (i_count = 6 AND substr(v_ca_code, 5, 2) <> '00') THEN

    BEGIN
      SELECT C_NAME
        INTO v_c_name_tmp
        FROM TBL_CATEGORY
       WHERE CA_CODE = substr(v_ca_code, 1, 4);
        EXCEPTION WHEN OTHERS THEN
         v_c_name_tmp := '';
        END;

        re_category := v_c_name_tmp;

    BEGIN
      SELECT C_NAME
        INTO v_c_name_tmp
        FROM TBL_CATEGORY
       WHERE CA_CODE = substr(v_ca_code, 1, 6);
        EXCEPTION WHEN OTHERS THEN
         v_c_name_tmp := '';
        END;

       IF v_c_name_tmp = '' THEN
          re_category := v_c_name_tmp;
        ELSE
          re_category := re_category || ' ' || v_c_name_tmp;
        END IF;

   ELSIF (i_count = 6 AND substr(v_ca_code, 5, 2) = '00') OR (i_count = 4 AND substr(v_ca_code, 3, 2) <> '00') THEN

    BEGIN
      SELECT C_NAME
        INTO v_c_name_tmp
        FROM TBL_CATEGORY
       WHERE CA_CODE = substr(v_ca_code, 1, 4);
        EXCEPTION WHEN OTHERS THEN
         v_c_name_tmp := '';
        END;

        re_category := v_c_name_tmp;

   END IF;
  END IF;

  RETURN re_category;

END;