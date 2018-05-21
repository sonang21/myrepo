/* *************************************************************************
 * NAME : DEAL.COUPON_HIT_RANK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_HIT_RANK" 
(
   T_PASSWORD IN D4_COUPON.MB_ID%TYPE   
)
----------------------------------------------------------------------------------------------------------------------
-- File Name : COUPON_HIT_RANK
-- Version      : 1.0
-- Writen Date  : 2014-11-20
-- Author    : Kwon Sung Won
-- Program ID  : COUPON_HIT_RANK
-- Comments : update/insert mobile columns d4_coupon
---------------------------------------------------------------------------------------------------------------------- 
IS

chk_err_fg varchar2(1);
o_err_msg varchar2(100);
strTime  varchar2(20) := to_char(current_date,'yyyy-mm-dd HH24:MI:SS') ;

BEGIN
  if (T_PASSWORD = 'YES') then
    
   delete from d4_coupon_hit_rank;
   delete from d4_coupon_hit_rank_final;
   
   insert into d4_coupon_hit_rank
   select a.cp_id
         ,a.cp_mobile_hit - a.cp_mobile_hit_old
   from d4_coupon a
   where a.cp_mobile_hit + a.cp_mobile_hit_old > 0
   and a.cp_display_yn = 'Y'
   and a.cp_del_yn <> 'Y'
   and a.cp_startdate <= to_char(current_date,'yyyy-mm-dd HH24:MI:SS')
   and a.cp_limitdate >= to_char(current_date,'yyyy-mm-dd HH24:MI:SS');
   
   insert into d4_coupon_hit_rank_final
   select cp_id
         ,row_number() over(order by hit desc)
     from d4_coupon_hit_rank;

-- d4_coupon update     
   update d4_coupon set cp_mobile_rank_old = cp_mobile_rank 
   where cp_mobile_hit + cp_mobile_hit_old > 0
   and cp_display_yn = 'Y'
   and cp_del_yn <> 'Y'
   and cp_startdate <= to_char(current_date,'yyyy-mm-dd HH24:MI:SS')
   and cp_limitdate >= to_char(current_date,'yyyy-mm-dd HH24:MI:SS');
   
   update d4_coupon a set a.cp_mobile_rank = 
                         (select b.rank
                            from d4_coupon_hit_rank_final b
                          where a.cp_id = b.cp_id)
   where exists (select 1 from d4_coupon_hit_rank_final c where a.cp_id = c.cp_id);

   update d4_coupon a set a.cp_mobile_rank = 0 where not exists (select 1 from d4_coupon_hit_rank_final b
                                                                                 where a.cp_id = b.cp_id);
   
   update d4_coupon set cp_mobile_hit_old = cp_mobile_hit where cp_mobile_hit + cp_mobile_hit_old > 0;
   
   update d4_coupon set cp_mobile_hit_time = strTime
   where cp_display_yn = 'Y'
   and cp_del_yn <> 'Y'
   and cp_startdate <= to_char(current_date,'yyyy-mm-dd HH24:MI:SS')
   and cp_limitdate >= to_char(current_date,'yyyy-mm-dd HH24:MI:SS');   

   if (sqlcode < 0) then
      o_err_msg := 'd4_coupon update error (' || sqlcode || ')';
      chk_err_fg := '1';
   end if;
  end if;
    
  if (chk_err_fg = '1') then
     dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
     rollback;
  else
     dbms_output.put_line('COUPON_HIT_RANK SP EXCUTED SUCCESSSFULLY!!'); 
     commit;     
  end if;

EXCEPTION

WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( 'coupon_hit_rank register is failed!');

ROLLBACK;

END;