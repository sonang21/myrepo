/* *************************************************************************
 * NAME : DEAL.DELETE_DUP_COUPONCATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."DELETE_DUP_COUPONCATE" AS 
chk_err_fg varchar2(1);
o_err_msg varchar2(100);
BEGIN
-- d4_coupon_cate insert/d4_coupon cate1 update
declare
   v_id number(11);
   v_cate2 varchar2(10);
   v_cate3 varchar2(10);
   v_cate1 varchar2(10);
   v_count number(4);
    
   cursor cur02 is
      with temp as(
      select a.cp_id
              ,b.cate
      from d4_coupon a, d4_keyword_cate b
      where instr(a.cp_division,b.keyword) > 0       
      --and a.cp_id in (select cp_id from d4_coupon_cate group by cp_id having count(cp_id) > 1) 
      and a.cp_division > ' '
      and trim(b.idx) = trim(b.idx)
      and trim(a.cp_id) = trim(a.cp_id)
      )
      select a.cp_id
             ,c.pcode
             ,a.cate
             ,d.pcode
        from temp a
             ,d4_commoncode c
             ,d4_commoncode d
       where a.cate = c.code
       and c.pcode = d.code
       group by a.cp_id
                ,c.pcode
                ,a.cate
                ,d.pcode
       order by a.cp_id;
                       
    begin
      open cur02;
      
      loop
        fetch cur02
        into v_id
            ,v_cate2
            ,v_cate3
            ,v_cate1;
        if cur02%notfound
        then
          exit;
        end if;
        
        

          delete d4_coupon_cate_new where cp_id = v_id;
          commit;     
          insert into d4_coupon_cate_new values(v_id, v_cate2, v_cate3, v_cate1);
          commit;     
          update d4_coupon a set a.cp_cate1 = v_cate1                                        
          where a.cp_id = v_id;
          commit;     
          if (sqlcode < 0) then
             o_err_msg := 'd4_coupon_cate_new insert/update error (' || v_id || ': ' || v_cate3 || ': ' || sqlcode || ')';
             chk_err_fg := '1';
          end if;
      end loop;
    close cur02;
end;    
commit;     
declare
   v_id number(11);
   v_cate2 varchar2(10);
   v_cate3 varchar2(10);
   v_cate1 varchar2(10);
   v_count number(4);
   
   cursor cur06 is

      with temp as(
        select cp_id,cate from (
        select a.cp_id,a.cp_company,a.cp_name,a.cp_division,a.cp_section1,a.cp_section2,a.cp_section3,b.address
        , UDF_GET_MATCHING_CATE(a.cp_division ,a.cp_company , a.cp_name , b.address,a.cp_section1,a.cp_section2,a.cp_section3 ) as cate
       from d4_coupon a , D4_COUPON_SHOP b where 
        to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between a.cp_startdate and a.cp_limitdate and
        --a.cp_id in (select cp_id from d4_coupon_cate group by cp_id having count(cp_id) > 1) and
        a.cp_id = b.cp_id 

        ) where cate is not null  
      )
      select a.cp_id
             ,c.pcode
             ,a.cate
             ,d.pcode
        from temp a
             ,d4_commoncode c
             ,d4_commoncode d
       where a.cate = c.code
       and c.pcode = d.code
       group by a.cp_id
                ,c.pcode
                ,a.cate
                ,d.pcode
       order by a.cp_id;
                       
    begin
      open cur06;
      
      loop
        fetch cur06
        into v_id
            ,v_cate2
            ,v_cate3
            ,v_cate1;
        if cur06%notfound
        then
          exit;
        end if;

          delete d4_coupon_cate_new where cp_id = v_id;
          insert into d4_coupon_cate_new values(v_id, v_cate2, v_cate3, v_cate1);
          commit;     
          update d4_coupon a set a.cp_cate1 = v_cate1                                        
          where a.cp_id = v_id;
          commit;     
          if (sqlcode < 0) then
             o_err_msg := 'd4_coupon_cate_new insert/update error (' || v_id || ': ' || v_cate3 || ': ' || sqlcode || ')';
             chk_err_fg := '1';
          end if;

      end loop;
    close cur06;    
end;    
insert into d4_coupon_cate_new (cp_id,cate1,cate2,cate3)  
(select cp_id,'A02','A0210','C160' from d4_coupon where cp_id not in (select cp_id from d4_coupon_cate_new) and cp_id not in (select cp_id from d4_coupon_loc));
commit;     
END DELETE_DUP_COUPONCATE;