/* *************************************************************************
 * NAME : DEAL.CATEGORY_SUM_ALL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."CATEGORY_SUM_ALL" 

(
T_MB_ID IN D4_COUPON.MB_ID%TYPE
)
--------------------------------------------------------------------------------------
-- File Name : CATEGORY_SUM_ALL
-- Version      : 1.0
-- Writen Date	: 2014-11-21
-- Author		: Kwon Sung Won
-- Program ID	: CATEGORY_SUM
-- Comments : update cnt3 in d4_commoncode with d4_coupon_cate
--------------------------------------------------------------------------------------
IS

chk_err_fg varchar2(1);
o_err_msg varchar2(100);

BEGIN

declare
   v_cate varchar2(10);
   v_cnt3 number(11);
   v_count number(4);
-- d4_coupon_cate read   
   cursor cur01 is
      select a.cate3
      ,count(1)
      from d4_coupon_cate a left outer join d4_coupon b on a.cp_id = b.cp_id
      where b.cp_display_yn = 'Y'
      and b.cp_del_yn <> 'Y'
      and  to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between b.cp_startdate and b.cp_limitdate 
      and b.cp_maxcnt > b.cp_salecnt
      group by a.cate3
      union all
      select code,0 from d4_commoncode where code not in 
      (
        select a.cate3
        from d4_coupon_cate a left outer join d4_coupon b on a.cp_id = b.cp_id
        where b.cp_display_yn = 'Y'
        and b.cp_del_yn <> 'Y'
        and  to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between b.cp_startdate and b.cp_limitdate 
        group by a.cate3      
      ) and substr(code,0,1) = 'C';
                
    begin
      open cur01;
      
      loop
        fetch cur01
        into v_cate
            ,v_cnt3;
        if cur01%notfound
        then
          exit;
        end if;
-- d4_commoncode check        
        select count(1)
        into v_count
        from d4_commoncode
        where code = v_cate;

-- d4_commoncate update        
        if v_count > 0 then

             update d4_commoncode set cnt3 = v_cnt3 where code = v_cate;
             if (sqlcode < 0) then
                o_err_msg := 'd4_commoncode update error (' || v_cate || ': ' || v_cnt3 || ': ' || sqlcode || ')';
                chk_err_fg := '1';
             end if;  
          
        end if;

      end loop;
    close cur01;
end;   

declare
   v_cate2 varchar2(10);
   v_cnt2 number(11);
   v_count2 number(4);
-- d4_coupon_cate read   
   cursor cur02 is
      select a.cate2,count(1) from
      (select a.cate2
             ,a.cp_id
             ,count(1) 
      from d4_coupon_cate a left outer join d4_coupon b on a.cp_id = b.cp_id
      where b.cp_display_yn = 'Y'
      and b.cp_del_yn <> 'Y'
      --and b.cp_company = T_MB_ID      
      and  to_char(sysdate, 'YYYY-MM-DD hh24:mi:ss') between b.cp_startdate and b.cp_limitdate 
      and b.cp_maxcnt > b.cp_salecnt
      group by a.cate2,a.cp_id) a
      group by a.cate2;
    begin
      open cur02;
      
      loop
        fetch cur02
        into v_cate2
            ,v_cnt2;
        if cur02%notfound
        then
          exit;
        end if;
-- d4_commoncode check        
        select count(1)
        into v_count2
        from d4_commoncode
        where code = v_cate2;

-- d4_commoncate update        
        if v_count2 > 0 then
             update d4_commoncode set cnt3 = v_cnt2 where code = v_cate2;
             if (sqlcode < 0) then
                o_err_msg := 'd4_commoncode update2 error (' || v_cate2 || ': ' || v_cnt2 || ': ' || sqlcode || ')';
                chk_err_fg := '1';
             end if;  
          
        end if;

      end loop;
    close cur02;
end;   

if (chk_err_fg = '1') then
  dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
  rollback;
else
  dbms_output.put_line('CATEGORY_SUM_ALL SP EXCUTED SUCCESSSFULLY!!'); 
  commit;     
end if;

EXCEPTION

WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( T_MB_ID || ' ' || 'register is failed!');

ROLLBACK;

END;