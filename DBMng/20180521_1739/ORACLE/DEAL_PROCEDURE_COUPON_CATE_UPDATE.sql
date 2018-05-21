/* *************************************************************************
 * NAME : DEAL.COUPON_CATE_UPDATE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_CATE_UPDATE" AS 
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
      and a.cp_division > ' '
      and trim(b.idx) = trim(b.idx)
      and trim(a.cp_id) = trim(a.cp_id)
      --and substr(a.cp_lastupdate,1,10) = to_char(sysdate,'yyyy-mm-dd')
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
        
        select count(1)
        into v_count
        from d4_coupon_cate
        where cp_id = v_id
        and cate2 = v_cate2
        and cate3 = v_cate3
        and cate1 = v_cate1;
        
        if v_count = 0 then
          insert into d4_coupon_cate values(v_id, v_cate2, v_cate3, v_cate1);
          
          update d4_coupon a set a.cp_cate1 = v_cate1                                        
          where a.cp_id = v_id;
          /*
          if (sqlcode < 0) then
             o_err_msg := 'd4_coupon_cate insert/update error (' || v_id || ': ' || v_cate3 || ': ' || sqlcode || ')';
             chk_err_fg := '1';
          end if;
          */
        end if;

      end loop;
    close cur02;
end;    
-- d4_coupon_cate insert/d4_coupon cate1 update
declare
   v_id number(11);
   v_cate2 varchar2(10);
   v_cate3 varchar2(10);
   v_cate1 varchar2(10);
   v_count number(4);
   
   cursor cur03 is

      with temp as(
        select cp_id,cate from (
        select a.cp_id,a.cp_company,a.cp_name,a.cp_division,a.cp_section1,a.cp_section2,a.cp_section3,b.address
        , UDF_GET_MATCHING_CATE(a.cp_division ,a.cp_company , a.cp_name , b.address,a.cp_section1,a.cp_section2,a.cp_section3 ) as cate
       from d4_coupon a , D4_COUPON_SHOP b where 
        to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between a.cp_startdate and a.cp_limitdate and
        a.cp_id not in (select d4_coupon_cate.cp_id from d4_coupon_cate) and
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
      open cur03;
      
      loop
        fetch cur03
        into v_id
            ,v_cate2
            ,v_cate3
            ,v_cate1;
        if cur03%notfound
        then
          exit;
        end if;
         
        select count(1)
        into v_count
        from d4_coupon_cate
        where cp_id = v_id
        and cate2 = v_cate2
        and cate3 = v_cate3
        and cate1 = v_cate1;
        
        if v_count = 0 then
          insert into d4_coupon_cate values(v_id, v_cate2, v_cate3, v_cate1);
          
          update d4_coupon a set a.cp_cate1 = v_cate1                                        
          where a.cp_id = v_id;
        end if;

      end loop;
    close cur03;    
end;    
category_sum_all('YES'); -- categorySum SP call
END COUPON_CATE_UPDATE;