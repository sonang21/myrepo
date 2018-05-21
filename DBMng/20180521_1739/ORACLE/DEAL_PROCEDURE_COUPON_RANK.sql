/* *************************************************************************
 * NAME : DEAL.COUPON_RANK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_RANK" 

(
   T_PASSWORD IN D4_COUPON.MB_ID%TYPE   
)
----------------------------------------------------------------------------------------------------------------------
-- File Name : COUPON_RANK
-- Version      : 1.0
-- Writen Date  : 2014-11-21
-- Author    : Kwon Sung Won
-- Program ID  : COUPON_RANK
-- Comments : update rank in d4_coupon
---------------------------------------------------------------------------------------------------------------------- 
IS

chk_err_fg varchar2(1);
o_err_msg varchar2(100);
v_cnt number(11) := 0;
v_row number(11) := 0;
 
BEGIN
  if (T_PASSWORD = 'YES') then
  
/*   update d4_coupon set cp_rank = 100000,cp_base_rank = 0,cp_diffsalecnt = 0 
   where cp_hit + cp_mobile_hit > 0
   and cp_display_yn = 'Y'
   and cp_del_yn <> 'Y'
   and cp_startdate <= to_char(current_date,'yyyy-mm-dd HH24:MI:SS')
   and cp_limitdate >= to_char(current_date,'yyyy-mm-dd HH24:MI:SS');*/

  /* 롯데닷컴 11번가 상품이 오늘 업데이트되었을 경우 인기도 초기화. 2015.09.11. - 김래원 주임 요청 */
  update d4_coupon
     set cp_hit = 0, cp_mobile_hit = 0
   where cp_startdate >= to_char(sysdate,'YYYY-MM-DD')
     and cp_startdate >= substr(cp_lastupdate,0,10) 
     and cp_company in ('11st','lottecom')
  ;
  
  commit;

   execute immediate 'truncate table d4_coupon_rank';
   execute immediate 'truncate table d4_coupon_rank_final';
   execute immediate 'truncate table d4_coupon_rank_use';
   
   insert /*+ append nologging */ into d4_coupon_rank
   select /*+ full(a) */ 
          a.cp_id
         ,a.cp_cate1
--         ,case when (substr(a.cp_startdate,1,10) = to_char(sysdate,'yyyy-mm-dd') and a.cp_company <> 'lottecom') then 1.07 *
--         ,case when (substr(a.cp_startdate,1,10) = to_char(sysdate,'yyyy-mm-dd') and a.cp_company <> 'lottecom') then 10.20 *
--         ,case when (substr(a.cp_startdate,1,10) = to_char(sysdate,'yyyy-mm-dd') and a.cp_company <> 'lottecom') then 8.20 *
         ,case when (substr(a.cp_startdate,1,10) = to_char(sysdate,'yyyy-mm-dd') and a.cp_company <> 'lottecom' and a.cp_cate2 = 'A0209') then 8.20 *
               (a.cp_hit + a.cp_mobile_hit) / case when (trunc(to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') 
                                                        - to_date(substr(a.cp_startdate,1,10),'yyyy-mm-dd'))) = 0 then 1
                                              else (trunc(to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') 
                                                        - to_date(substr(a.cp_startdate,1,10),'yyyy-mm-dd')))
                                         end         
          else 
               (a.cp_hit + a.cp_mobile_hit) / case when (trunc(to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') 
                                                        - to_date(substr(a.cp_startdate,1,10),'yyyy-mm-dd'))) = 0 then 1
                                              else (trunc(to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') 
                                                        - to_date(substr(a.cp_startdate,1,10),'yyyy-mm-dd')))
                                         end
          end case 
         ,0
         ,a.cp_hit + a.cp_mobile_hit
         ,to_char(current_date,'yyyy-mm-dd HH24:MI:SS')
   from d4_coupon a
   where substr(a.cp_startdate,1,10) <= to_char(sysdate,'yyyy-mm-dd')
   and substr(a.cp_limitdate,1,10) >= to_char(sysdate,'yyyy-mm-dd')
   --and ((trunc(to_date(to_char(sysdate,'yyyy-mm-dd'),'yyyy-mm-dd') - to_date(substr(cp_startdate,1,10),'yyyy-mm-dd')) <= 30) and ( a.cp_salecnt / (case when a.cp_maxcnt <= 0 then 1 else cp_maxcnt end) between 0.000001 and  0.1))
   and a.cp_cate1 > ' '
   and cp_display_yn = 'Y'
   and cp_del_yn <> 'Y';

   commit;

   insert /*+ append nologging */ into d4_coupon_rank_final
   select cp_id
         ,cate1
         ,row_number() over(order by rank desc)
         ,row_number() over(partition by cate1 order by rank desc)
         ,' '
     from d4_coupon_rank;

   commit;

-- d4_coupon update
   <<s1>>
   null;
   select count(1)
    into v_row
    from d4_coupon_rank_final where job > ' ';
    
   if(v_row >= 1000) then
     goto s2;
   end if;
                
   insert into d4_coupon_rank_use
   select a.cp_id,a.cate1,(v_cnt * 24) + row_number() over(order by a.rank)
   from (select a.cp_id,a.cate1,a.rank
          from (select *
                from d4_coupon_rank_final a
                where a.cate1 = 'A02'
                and job = ' '
                order by seq) a
          where rownum <= 10
          union 
          select a.cp_id,a.cate1,a.rank
          from (select *
               from d4_coupon_rank_final a
               where a.cate1 = 'A01'
               and job = ' '
               order by seq) a
          where rownum <= 8
          union 
          select a.cp_id,a.cate1,a.rank
          from (select *
                from d4_coupon_rank_final a
                where a.cate1 = 'A03'
                and job = ' '
                order by seq) a
          where rownum <= 4
          union 
          select a.cp_id,a.cate1,a.rank
          from (select *
                from d4_coupon_rank_final a
                where a.cate1 = 'A04'
                and job = ' '
                order by seq) a
          where rownum <= 2
          order by 3) a;
   commit;
     
   update d4_coupon_rank_final  a set a.job = 'Y'
   where exists (select 1 from d4_coupon_rank_use b where a.cp_id = b.cp_id);
   commit;

   if (sqlcode < 0) then
      o_err_msg := 'd4_coupon_rank update error (' || sqlcode || ')';
      chk_err_fg := '1';
   end if;
        
   v_cnt := v_cnt + 1;
   goto s1;
   <<s2>>
   null;
  
   merge into d4_coupon s
   using ( select d.cp_id,
                  nvl(u.rank,0) as cp_rank,
                  u.cp_id as rank_use_id,
                  r.cp_id as use_id
             from d4_coupon d,
                  d4_coupon_rank_use u,
                  d4_coupon_rank r
            where d.cp_id = u.cp_id(+)
              and d.cp_id = r.cp_id(+)
         ) t
      on (s.cp_id = t.cp_id)
    when matched then
      update set s.cp_rank = case
                               when t.rank_use_id is not null and t.cp_rank > 0 then
                                 t.cp_rank
                               else 
                                 1000000
                              end
   ;
   commit;

   if (sqlcode < 0) then
       o_err_msg := 'd4_coupon update error (' || sqlcode || ')';
       chk_err_fg := '1';
   end if;
  
  end if;

  if (chk_err_fg = '1') then
     dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
     rollback;
  else
     dbms_output.put_line('COUPON_RANK SP EXCUTED SUCCESSSFULLY!!'); 
     commit;     
  end if;

EXCEPTION

WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( 'coupon_rank register is failed!');
dbms_output.put_line(sqlerrm);
ROLLBACK;

END;
