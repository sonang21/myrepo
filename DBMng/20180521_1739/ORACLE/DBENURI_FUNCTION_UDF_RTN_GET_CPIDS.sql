/* *************************************************************************
 * NAME : DBENURI.UDF_RTN_GET_CPIDS
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 10:49:39
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_RTN_GET_CPIDS" 
(cp_ca_code tbl_cate_goods.ca_code%type, cp_modelno tbl_goods.modelno%type, cp_cpt_id tbl_component_title.cpt_id%type)
return tbl_component_summary.cp_ids%type as
/*
 NGIT 수정 반영 - 김영원 20180418
*/ 
  cpid tbl_component.cp_id%type := 0;
  component_list tbl_component_summary.cp_ids%type := ' ';

  cursor cur_cpid is
		  select distinct cp_id
		    from tbl_component_modelno
		   where modelno = cp_modelno
       and del_yn = 'N'
       and cp_id in (select distinct cp_id
			                   from tbl_component_mapping a
				                       inner join tbl_component_title b on ca_code = cp_ca_code and a.cpt_id = b.cpt_id
		                  	where a.cpt_id = cp_cpt_id
                       and a.del_yn = 'N'
                       and b.del_yn = 'N')
		   order by cp_id;

	 i number := 0;
begin
	 open cur_cpid;
	 loop
    fetch cur_cpid into cpid;
	   exit when cur_cpid%notfound;

    if i <= 0 then
     component_list := cpid;
    else
     component_list := component_list || ',' || cpid;
    end if;

		  i := i + 1;
	 end loop;
  close cur_cpid;

	return component_list;

end;
