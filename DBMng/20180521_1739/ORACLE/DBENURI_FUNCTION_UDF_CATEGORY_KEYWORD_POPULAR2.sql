/* *************************************************************************
 * NAME : DBENURI.UDF_CATEGORY_KEYWORD_POPULAR2
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-05-14 11:26:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_CATEGORY_KEYWORD_POPULAR2" (v_modelno NUMBER)
RETURN VARCHAR2 AS 
/*
 NGIT 수정 반영 - 김영원 20180416
*/    
  re_keyword2 varchar2(2600); 
BEGIN 

  with sfv as (
    select substr(c.ca_code,0,4) m_cd,
           substr(c.ca_code,0,6) s_cd,
           substr(c.ca_code,0,8) d_cd
      from tbl_goods a, 
           tbl_cate_goods c
     where a.modelno = c.modelno
       and (a.modelno_group = v_modelno or a.modelno = v_modelno)
       and a.jobcode > '0'
       and a.constrain in ('1','5')
     group by substr(c.ca_code,0,4),
              substr(c.ca_code,0,6),
              substr(c.ca_code,0,8)
  )
  select listagg(k_name || ' ') within group(order by ca_code)
    into re_keyword2
    from tbl_category_keyword_popular p
   where p.ca_code in ( select m_cd from sfv union all
                        select s_cd from sfv union all
                        select d_cd from sfv)
  ;

  if length(re_keyword2)> 1200 then
    re_keyword2 := substr(re_keyword2, 0, 1200);
  end if;

  RETURN re_keyword2; 

END;
