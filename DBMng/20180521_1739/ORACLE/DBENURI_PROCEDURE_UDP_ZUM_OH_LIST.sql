/* *************************************************************************
 * NAME : DBENURI.UDP_ZUM_OH_LIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ZUM_OH_LIST" AS 
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 1 and c_seqno > 0 and ca_code not in ('90','91','92','95') order by ca_code;
      /*select ca_code from tbl_category where c_level = 1 and c_seqno > 0 and ca_code  in ('02') order by ca_code;*/
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          insert into TBL_ZUM_OH_LIST (select modelno,case when nvl(minprice3,0) = 0 then minprice else minprice3 end,ca_code from tbl_goods where jobcode > '0' and mallcnt3 > 0 and openexpectflag = '0' and constrain = '1' and ca_lcode = v_cate and cateflag = '0' and modelno not in (select modelno from TBL_ZUM_OH_LIST) );
          commit;
          /*
          update TBL_ZUM_OH_LIST a set a.minprice  =  (select case when nvl(minprice3,0) = 0 then minprice else minprice3 end from tbl_goods where a.modelno = modelno and jobcode > '0' and mallcnt3 > 0 and openexpectflag = '0' and constrain = '1' and ca_lcode = v_cate and cateflag = '0' ) 
          where exists (select 1 from tbl_goods where a.modelno = modelno and a.minprice > (select case when nvl(minprice3,0) = 0 then minprice else minprice3 end from tbl_goods where a.modelno = modelno and jobcode > '0' and mallcnt3 > 0 and openexpectflag = '0' and constrain = '1' and ca_lcode = v_cate and cateflag = '0' ));
          */
        end loop;
      close cur01;
    end;    
    declare
    v_modelno number(12);
    v_price number(20);
    cursor cur02 is
      select modelno from TBL_ZUM_OH_LIST;
      begin
        open cur02;
          loop
            fetch cur02
            into v_modelno;
            if cur02%notfound
              then
              exit;
            end if;
            /*select mb_id into v_shop_code from g4_member where mb_shop_code = T_MB_ID;*/
            v_price := 0;
            begin 
              select case when nvl(minprice3,0) = 0 then minprice else minprice3 end into v_price from tbl_goods where jobcode > '0' and mallcnt3 > 0 and openexpectflag = '0' and constrain = '1' and  modelno = v_modelno and cateflag = '0';
              update TBL_ZUM_OH_LIST a set a.minprice  =  v_price where a.modelno =  v_modelno and a.minprice > v_price;
            exception 
              WHEN NO_DATA_FOUND THEN
              update TBL_ZUM_OH_LIST a set a.minprice  =  0 where a.modelno =  v_modelno ;
            end;
            commit;
          end loop;
        close cur02;
      end;
      delete TBL_ZUM_OH_LIST where minprice = 0;
      commit;
END UDP_ZUM_OH_LIST;