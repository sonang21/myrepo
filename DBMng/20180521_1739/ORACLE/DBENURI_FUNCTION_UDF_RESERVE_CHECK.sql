/* *************************************************************************
 * NAME : DBENURI.UDF_RESERVE_CHECK
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:26:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RESERVE_CHECK" (v_modelno NUMBER)
RETURN VARCHAR2 AS 
/*
 NGIT 체크 - 변경없음 김영원 20180418
*/
    v_result char(1) := '0';
BEGIN
    BEGIN
        select '1'  
          into v_result
          from tbl_goods_change
         where is_reserve = '1' 
           and modelno in (select modelno
                             from tbl_goods
                            where modelno in (select nvl(modelno_group,modelno) 
                                                from tbl_goods
                                               where modelno = v_modelno)
                           union all
                           select modelno 
                             from tbl_goods
                            where modelno_group in (select nvl(modelno_group,modelno) 
                                                      from tbl_goods
                                                     where modelno = v_modelno)
                          )
           and rownum = 1;
    EXCEPTION WHEN OTHERS THEN
            v_result := '0';
    END;
    RETURN v_result;
END;
