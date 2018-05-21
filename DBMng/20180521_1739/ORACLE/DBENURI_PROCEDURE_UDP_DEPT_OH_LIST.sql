/* *************************************************************************
 * NAME : DBENURI.UDP_DEPT_OH_LIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 14:08:54
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEPT_OH_LIST" AS
/*
 NGIT 수정 반영 - 김영원 20180425
*/ 
BEGIN
    begin
      insert into TBL_DEPT_OH_LIST (select distinct a.modelno,case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end,'86' 
                                      from tbl_goods a, tbl_goods_sum b, tbl_cate_goods c
                                     where a.modelno = b.modelno and a.modelno = c.modelno 
                                       and a.jobcode > '0' and b.mallcnt > 0 and a.openexpectflag = '0' and a.constrain = '1' and c.ca_code like '86%'
                                       and a.modelno not in (select modelno from TBL_DEPT_OH_LIST) );
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
              select case when nvl(b.minprice4,0) = 0 then b.minprice else b.minprice4 end into v_price
                from tbl_goods a, tbl_goods_sum b
               where a.modelno = b.modelno 
                 and a.jobcode > '0' and b.mallcnt > 0 and a.openexpectflag = '0' and a.constrain = '1' and  a.modelno = v_modelno and rownum = 1;
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
