/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_GROUP_KEYWORD
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:02:09
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_GROUP_KEYWORD" (v_modelno_group NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180416
*/

    v_keyword     VARCHAR2(2600):='';
    v_keyword_arr VARCHAR2(2600):='';
    i_count         NUMBER := 0;    
   
    CURSOR cur_group_keyword IS
        select distinct a.keyword
        from tbl_goods a, tbl_goods_sum b
        where a.modelno = b.modelno
        and a.modelno_group = v_modelno_group
        and a.constrain='1'
        and b.mallcnt>0
        and a.jobcode >'0';        

    BEGIN
    
    IF v_modelno_group > 0 THEN    
        OPEN cur_group_keyword;
        LOOP

            FETCH cur_group_keyword INTO v_keyword;
            EXIT WHEN cur_group_keyword%NOTFOUND;

            IF i_count <= 0 THEN
                IF v_keyword is not null THEN
                    v_keyword_arr := v_keyword;
                END IF;
            ELSE
                IF v_keyword is not null THEN
                  v_keyword_arr := v_keyword_arr || ' ' || v_keyword;
                END IF;
            END IF;
            
            IF length(v_keyword_arr) >= 1000 THEN
                EXIT;
            END IF;
            
            i_count := i_count +1;
            IF i_count > 20 THEN
                EXIT;
            END IF;

        END LOOP;
        CLOSE cur_group_keyword;
        
    END IF;
  RETURN v_keyword_arr;            
END;
