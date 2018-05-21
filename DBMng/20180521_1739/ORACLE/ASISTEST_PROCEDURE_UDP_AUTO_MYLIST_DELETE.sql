/* *************************************************************************
 * NAME : ASISTEST.UDP_AUTO_MYLIST_DELETE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:15
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_AUTO_MYLIST_DELETE" (
     result_code IN OUT VARCHAR2,
     result_desc IN OUT VARCHAR2,
     startTime   IN OUT VARCHAR2,
     endTime     IN OUT VARCHAR2)
IS
	CURSOR cur_auto_mylist IS
	  SELECT userid FROM
  	(SELECT userid,count(userid) cnt
      FROM TBL_AUTO_MYLIST
      GROUP BY userid
    )
    WHERE cnt > 30;

  v_userid_tmp tbl_auto_mylist.userid%TYPE := '';

  v_count    NUMBER := 0;
  i_count    NUMBER := 0;

  tmp_start     VARCHAR2(20) := '';
  tmp_end    VARCHAR2(20) := '';

BEGIN
	--DBMS_OUTPUT.ENABLE;
	--DBMS_OUTPUT.PUT_LINE('UDP_GOODS_PLNO start ......');

	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
  	INTO tmp_start
  	FROM DUAL;

	startTime := startTime || '|13 : ' || tmp_start;


	OPEN cur_auto_mylist;
 	LOOP

		FETCH cur_auto_mylist INTO v_userid_tmp;
   	EXIT WHEN cur_auto_mylist%NOTFOUND;

    	i_count := i_count + 1;

			BEGIN

     		DELETE /*+APPEND NOLOGGING TBL_AUTO_MYLIST */ TBL_AUTO_MYLIST
     		WHERE userid = v_userid_tmp
     		AND modelno in (
     		  SELECT modelno FROM
            (SELECT ROWNUM num,modelno FROM
              (SELECT modelno FROM TBL_AUTO_MYLIST
              	WHERE userid = v_userid_tmp
              	ORDER BY REGDATE)
              )
          WHERE num > 30
        );

			END;
  		COMMIT;


	END LOOP;
 	CLOSE cur_auto_mylist;

 	COMMIT;
 	--DBMS_OUTPUT.PUT_LINE('v_totcnt : ' || v_totcnt);

 	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
   	INTO tmp_end
   	FROM DUAL;

	endTime   := endTime || '|2 : ' || tmp_end;

 	IF result_code = '' THEN
  	result_code := '0';
 	ELSE
  	result_code := result_code || '|' || '0';
 	END IF;

 	IF result_desc = '' THEN
  	result_desc := 'UDP_AUTO_MYLIST_DELETE => SUCCESS ';
 	ELSE
  	result_desc := result_desc || '|' || 'UDP_AUTO_MYLIST_DELETE => SUCCESS';
 	END IF;

EXCEPTION
	WHEN OTHERS THEN
  	COMMIT;
  	SELECT to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
      INTO tmp_end
      FROM DUAL;

    IF result_code = '' THEN
         result_code := SQLCODE;
    ELSE
         result_code := result_code || '|' || SQLCODE ;
    END IF;

    IF result_desc = '' THEN
         result_desc := 'UDP_AUTO_MYLIST_DELETE => ERROR : ' || SQLERRM;
    ELSE
         result_desc := result_desc || '|' || 'UDP_AUTO_MYLIST_DELETE => ERROR : ' || SQLERRM;
    END IF;

		endTime   := endTime || '|2 error: ' || tmp_end;

END UDP_AUTO_MYLIST_DELETE;