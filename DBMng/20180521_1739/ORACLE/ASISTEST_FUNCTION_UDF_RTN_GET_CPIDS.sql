/* *************************************************************************
 * NAME : ASISTEST.UDF_RTN_GET_CPIDS
 * TYPE : FUNCTION
 * TIME : Create: 2018-05-04 18:33:37
 *        Modify: 2018-05-04 18:33:37
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ASISTEST"."UDF_RTN_GET_CPIDS" 
(cp_ca_code tbl_goods.ca_code%type, cp_modelno tbl_goods.modelno%type, cp_cpt_id tbl_component_title.cpt_id%type)
return tbl_component_summary.cp_ids%type as
    cpid tbl_component.cp_id%type := 0;
    component_list tbl_component_summary.cp_ids%type := ' ';

    cursor cur_cpid is
		select distinct cp_id
		from tbl_component_modelno
		where modelno = cp_modelno and del_yn = 'N' and cp_id in (
			select distinct cp_id
			from tbl_component_mapping a
				inner join tbl_component_title b on ca_code = cp_ca_code And a.cpt_id = b.cpt_id
			where a.cpt_id = cp_cpt_id and a.del_yn = 'N' and b.del_yn = 'N')
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