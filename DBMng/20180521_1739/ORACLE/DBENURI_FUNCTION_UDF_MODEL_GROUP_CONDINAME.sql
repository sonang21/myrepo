/* *************************************************************************
 * NAME : DBENURI.UDF_MODEL_GROUP_CONDINAME
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 09:29:37
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_MODEL_GROUP_CONDINAME" (v_modelno_group NUMBER)
RETURN VARCHAR2 AS
/*
 NGIT 수정 반영 - 김영원 20180416
*/

    v_condiname     VARCHAR2(50):='';
    v_condiname_arr VARCHAR2(2000):='';
    i_count         NUMBER := 0;    
   
    CURSOR cur_group_condiname IS
        select a.condiname
        from tbl_goods a, tbl_goods_sum b
        where a.modelno = b.modelno
        and a.modelno_group = v_modelno_group
        and a.constrain='1'
        and b.mallcnt>0
        and a.jobcode >'0';   

    BEGIN
    IF v_modelno_group > 0 THEN    
        OPEN cur_group_condiname;
        LOOP

            FETCH cur_group_condiname INTO v_condiname;
            EXIT WHEN cur_group_condiname%NOTFOUND;

            IF i_count <= 0 THEN
                v_condiname_arr := v_condiname;
            ELSE
                v_condiname_arr := v_condiname_arr || ' ' || v_condiname;
            END IF;
            
            i_count := i_count +1;
            IF i_count > 50 THEN
                EXIT;
            END IF;
            

        END LOOP;
        CLOSE cur_group_condiname;
        
    END IF;
    RETURN v_condiname_arr;            
    END;
 
