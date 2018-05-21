/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPT_OH_LIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPT_OH_LIST" AS 
BEGIN
    begin
      insert into TBL_DEPT_OH_LIST (select distinct modelno,case when nvl(minprice4,0) = 0 then minprice else minprice4 end,'86' from tbl_goods where jobcode > '0' and mallcnt > 0 and openexpectflag = '0' and constrain = '1' and ca_lcode = '86' and modelno not in (select modelno from TBL_DEPT_OH_LIST) );
      commit;
    end;    
    declare
    v_modelno number(12);
    v_price number(20);
    cursor cur02 is
      select modelno from TBL_DEPT_OH_LIST;
      begin
        open cur02;
          loop
            fetch cur02
            into v_modelno;
            if cur02%notfound
              then
              exit;
            end if;
            v_price := 0;
            begin 
              select case when nvl(minprice4,0) = 0 then minprice else minprice4 end into v_price from tbl_goods where jobcode > '0' and mallcnt > 0 and openexpectflag = '0' and constrain = '1' and  modelno = v_modelno and rownum = 1;
              update TBL_DEPT_OH_LIST a set a.minprice  =  v_price where a.modelno =  v_modelno and a.minprice > v_price;
            exception 
              WHEN NO_DATA_FOUND THEN
              update TBL_DEPT_OH_LIST a set a.minprice  =  0 where a.modelno =  v_modelno ;
            end;
            commit;
          end loop;
        close cur02;
      end;
      delete TBL_DEPT_OH_LIST where minprice = 0;
      commit;
END UDP_DEPT_OH_LIST;