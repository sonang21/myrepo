/* *************************************************************************
 * NAME : ASISTEST.COUPON_CR_ONE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:14
 *        Modify: 2018-05-04 18:53:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."COUPON_CR_ONE" 
(
T_MB_ID IN D4_COUPON.MB_ID%TYPE,
T_CP_PID IN D4_COUPON.CP_PID%TYPE
)
----------------------------------------------------------------------------------------------------------------------
-- File Name : COUPON_CR
-- Version      : 1.0
-- Writen Date  : 2014-11-19
-- Author    : Kwon Sung Won
-- Program ID  : COUPON_CR
-- Comments : update/insert coupon series with deal_goods/deal_sale_shop
---------------------------------------------------------------------------------------------------------------------- 
IS

chk_err_fg varchar2(1);
o_err_msg varchar2(100);
v_shop_code varchar2(255);

BEGIN
dbms_output.put_line('000');

select mb_id into v_shop_code from g4_member where mb_shop_code = T_MB_ID;

dbms_output.put_line('00000');
-- d4_coupon update
declare
   v_pid varchar2(255);
   v_company varchar2(50);
   v_price number(11);
   v_saleprice number(11);
   v_salerate number(11,5);
   v_maxcnt number(11);
   v_salecnt number(11);
   v_startdate varchar2(20);
   v_limitdate varchar2(20);
   v_image1 varchar2(455);
   v_image5 varchar2(455);
   v_coupon_start varchar2(20);
   v_coupon_end varchar2(20);
   v_url varchar2(455);
   v_murl varchar2(455);
   v_address varchar2(455);
   v_mobile_select char(1);
   v_mobile_original number(11);
   v_mobile_price number(11);   
   v_mobile_discount number(11,5);
     
   cursor cur01 is
       select nvl(a.cp_pid,' ')
             ,nvl(a.cp_company,' ')
             ,nvl(to_number(b.original,'99999999999'),0)
             ,nvl(to_number(b.price,'99999999999'),0)
             ,case when(b.price = ' ' OR b.price = '0' OR b.price is null or b.original = ' ' or b.original = '0' or b.original = '0.0' or b.original is null) then 0 when (1 - nvl(round(to_number(to_char(((to_number(case when (b.price = ' ' OR b.price = '0' OR b.price is null) then '0' when (b.original = ' ' OR b.original = '0' OR b.price is null) then '0' else b.price end,'99999999999')) /
             (to_number(case when (b.original = ' ' or b.original = '0' or b.original = '0.0' or b.original is null) then '100' else b.original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 = 100 then 0
              else   (1 - nvl(round(to_number(to_char(((to_number(case when (b.price = ' ' OR b.price = '0' OR b.price is null) then '0' when (b.original = ' ' OR b.original = '0' OR b.price is null) then '0' else b.price end,'99999999999')) /
             (to_number(case when (b.original = ' ' or b.original = '0' or b.original = '0.0' or b.original is null) then '100' else b.original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 end
             ,case when nvl(to_number(b.max_count,'99999999999'),0)= 0 then 99999999999 else nvl(to_number(b.max_count,'99999999999'),0) end
             ,nvl(to_number(b.now_count,'99999999999'),0)
             ,nvl(to_char(b.start_at,'yyyy-mm-dd HH24:MI:SS'),' ')
             ,nvl(to_char(b.end_at,'yyyy-mm-dd HH24:MI:SS'),' ')
             ,nvl(b.image_w,' ')
             ,nvl(b.image_h,' ')
             ,nvl(to_char(b.coupon_start_at,'yyyy-mm-dd'),' ')
             ,nvl(to_char(b.coupon_end_at,'yyyy-mm-dd'),' ')
             ,case when b.deal_shop_code = 4027 then 'http://banner.auction.co.kr/bn_redirect.asp?ID=BN00174818' || '&' || 'lpurl=http://pd.auction.co.kr/pd_redirect.asp?itemno=' || trim(b.meta_id)
                   when b.deal_shop_code = 6508 then 'http://www.wemakeprice.com/widget/aff_bridge_public/socialmoa/' || trim(b.meta_id)
                   when b.deal_shop_code = 6641 then 'http://www.ticketmonster.co.kr/entry/?jp=80025' || '&' || 'ln=212749' || '&' || 'p_no=' || trim(b.meta_id)
                   else nvl(b.url,' ') end case
             ,case when b.deal_shop_code = 6688 then nvl(b.url,' ')
                   when b.deal_shop_code = 6508 then 'http://www.wemakeprice.com/widget/aff_bridge_public/socialmoa/' || trim(b.meta_id)
                   when b.deal_shop_code = 4027 then 'http://banner.auction.co.kr/bn_redirect.asp?ID=BN00174819' || '&' || 'lpurl=http://mobile.auction.co.kr/Item/ViewItem.aspx?ItemNo=' || trim(b.meta_id)
                   when b.deal_shop_code = 6641 then 'http://www.ticketmonster.co.kr/entry/?jp=80025' || '&' || 'ln=212749' || '&' || 'p_no=' || trim(b.meta_id)
                   else nvl(b.mobile_url,' ') end case
             ,nvl((select c.deal_sale_shop_address from dbenuri.deal_sale_shop c
                      where b.deal_idx = c.deal_idx
                        and c.deal_sale_shop_idx = (select max(deal_sale_shop_idx)
                                         from dbenuri.deal_sale_shop aaa
                                         where c.deal_idx = aaa.deal_idx)),' ')
             ,nvl(b.mobile_select,' ')                     
             ,nvl(to_number(b.mobile_original,'99999999999'),0)
             ,nvl(to_number(b.mobile_price,'99999999999'),0)
             ,case when(b.mobile_price = ' ' OR b.mobile_price = '0' OR b.mobile_price is null or b.mobile_original = ' ' or b.mobile_original = '0' or b.mobile_original = '0.0' or b.mobile_original is null) then 0 when (1 - nvl(round(to_number(to_char(((to_number(case when (b.mobile_price = ' ' OR b.mobile_price = '0' OR b.mobile_price is null) then '0' when (b.mobile_original = ' ' OR b.mobile_original = '0' OR b.mobile_price is null) then '0' else b.mobile_price end,'99999999999')) /
             (to_number(case when (b.mobile_original = ' ' or b.mobile_original = '0' or b.mobile_original = '0.0' or b.mobile_original is null) then '100' else b.mobile_original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 = 100 then 0
             else   (1 - nvl(round(to_number(to_char(((to_number(case when (b.mobile_price = ' ' OR b.mobile_price = '0' OR b.mobile_price is null) then '0' when (b.mobile_original = ' ' OR b.mobile_original = '0' OR b.mobile_price is null) then '0' else b.mobile_price end,'99999999999')) /
             (to_number(case when (b.mobile_original = ' ' or b.mobile_original = '0' or b.mobile_original = '0.0' or b.mobile_original is null) then '100' else b.mobile_original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 end
                                                      
         from d4_coupon a
             ,dbenuri.deal_goods b
             ,g4_member c
        where a.cp_pid = b.meta_id
        and b.deal_shop_code = c.mb_shop_code
        and c.mb_id = a.cp_company
        and b.deal_shop_code = T_MB_ID 
        and b.cp_pid = T_CP_PID 
        and to_char(b.reg_date,'yyyymmdd') >= to_char(sysdate,'yyyymmdd')
        and substr(a.cp_limitdate,1,10) >= to_char(sysdate,'yyyy-mm-dd');

   begin
     open cur01;
     
     loop
       fetch cur01
       into v_pid
           ,v_company
           ,v_price
           ,v_saleprice
           ,v_salerate
           ,v_maxcnt 
           ,v_salecnt
           ,v_startdate
           ,v_limitdate
           ,v_image1
           ,v_image5
           ,v_coupon_start
           ,v_coupon_end 
           ,v_url
           ,v_murl
           ,v_address
           ,v_mobile_select
           ,v_mobile_original
           ,v_mobile_price
           ,v_mobile_discount;
       if cur01%notfound
         then
           exit;
       end if;
       
       update d4_coupon
          set cp_price = v_price
             ,cp_saleprice = v_saleprice
             ,cp_salerate = v_salerate
             ,cp_maxcnt = v_maxcnt
             ,cp_salecnt = v_salecnt
             ,cp_startdate = v_startdate
             ,cp_limitdate = v_limitdate
             ,cp_image1 = v_image1
             ,cp_image5 = v_image5
             ,cp_coupon_start = v_coupon_start
             ,cp_coupon_end = v_coupon_end
             ,cp_url = v_url
             ,cp_murl = v_murl
             ,cp_address = v_address
             ,cp_lastupdate = to_char(current_date,'yyyy-mm-dd HH24:MI:SS')
             ,cp_mobile_select = v_mobile_select
             ,cp_mobile_original = v_mobile_original
             ,cp_mobile_price = v_mobile_price
             ,cp_mobile_discount = v_mobile_discount
             
       where cp_pid = v_pid
       and cp_company = v_company;             

       if (sqlcode < 0) then
          o_err_msg := 'update error (' || v_pid || ': ' || v_company || ': ' || sqlcode || ')';
          chk_err_fg := '1';
       end if;
       
       end loop;
    close cur01;
end;

dbms_output.put_line('aaa');

--d4_coupon insert     
insert into d4_coupon
select to_number(cp_id.nextval,'9999999999')
      ,nvl(b.meta_id,' ')
      ,' '
      ,' '
      ,' '
      ,0
      ,'admin'
      ,nvl((select mb_id from g4_member where b.deal_shop_code = mb_shop_code),' ')
      ,nvl(b.title,' ')
      ,nvl(b.description,' ')
      ,' '
      ,case when b.deal_shop_code = 4027 then 'http://banner.auction.co.kr/bn_redirect.asp?ID=BN00174818' || '&' || 'lpurl=http://pd.auction.co.kr/pd_redirect.asp?itemno=' || trim(b.meta_id)
            when b.deal_shop_code = 6508 then 'http://www.wemakeprice.com/widget/aff_bridge_public/socialmoa/' || trim(b.meta_id)
            when b.deal_shop_code = 6641 then 'http://www.ticketmonster.co.kr/entry/?jp=80025' || '&' || 'ln=212749' || '&' || 'p_no=' || trim(b.meta_id)
            else nvl(b.url,' ') end case
      ,nvl(b.image_w,' ')
      ,' '
      ,' '
      ,' '
      ,nvl(b.image_h,' ')
      ,nvl((select c.deal_sale_shop_address from dbenuri.deal_sale_shop c
                      where b.deal_idx = c.deal_idx
                        and c.deal_sale_shop_idx = (select max(deal_sale_shop_idx)
                                         from dbenuri.deal_sale_shop aaa
                                         where c.deal_idx = aaa.deal_idx)),' ')
      ,' '
      ,nvl(to_number(case when (b.original = ' ') then '0' else b.original end,'99999999999'),0)
      ,nvl(to_number(case when (b.price = ' ') then '0' else b.price end,'99999999999'),0)
      ,case when(b.price = ' ' OR b.price = '0' OR b.price is null or b.original = ' ' or b.original = '0' or b.original = '0.0' or b.original is null) then 0 when (1 - nvl(round(to_number(to_char(((to_number(case when (b.price = ' ' OR b.price = '0' OR b.price is null) then '0' when (b.original = ' ' OR b.original = '0' OR b.price is null) then '0' else b.price end,'99999999999')) /
      (to_number(case when (b.original = ' ' or b.original = '0' or b.original = '0.0' or b.original is null) then '100' else b.original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 = 100 then 0
       else   (1 - nvl(round(to_number(to_char(((to_number(case when (b.price = ' ' OR b.price = '0' OR b.price is null) then '0' when (b.original = ' ' OR b.original = '0' OR b.price is null) then '0' else b.price end,'99999999999')) /
      (to_number(case when (b.original = ' ' or b.original = '0' or b.original = '0.0' or b.original is null) then '100' else b.original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 end
      ,case when nvl(to_number(case when (b.max_count = ' ') then '0' else b.max_count end,'99999999999'),0) = 0 then 99999999999 else nvl(to_number(case when (b.max_count = ' ') then '0' else b.max_count end,'99999999999'),0) end
      ,nvl(to_number(case when (b.min_count = ' ') then '0' else b.min_count end,'99999999999'),0)
      ,nvl(to_number(case when (b.now_count = ' ') then '0' else b.now_count end,'99999999999'),0)
      ,nvl(to_char(b.start_at,'yyyy-mm-dd HH24:MI:SS'),' ')
      ,nvl(to_char(b.end_at,'yyyy-mm-dd HH24:MI:SS'),' ')
      ,nvl(to_char(b.coupon_start_at,'yyyy-mm-dd'),' ')
      ,nvl(to_char(b.coupon_end_at,'yyyy-mm-dd'),' ')
      ,' '
      ,0
      ,'Y'
      ,nvl((select to_number(trim(aa.deal_sale_shop_longigude))
          from dbenuri.deal_sale_shop aa
          where aa.deal_idx = b.deal_idx
          and ISNUMERIC(deal_sale_shop_longigude) = 1
          and aa.deal_sale_shop_idx = (select max(deal_sale_shop_idx)
                                         from dbenuri.deal_sale_shop aaa
                                         where aa.deal_idx = aaa.deal_idx)),0)
      ,nvl((select to_number(trim(aa.deal_sale_shop_latitude))
          from dbenuri.deal_sale_shop aa
          where aa.deal_idx = b.deal_idx
          and ISNUMERIC(deal_sale_shop_latitude) = 1
          and aa.deal_sale_shop_idx = (select max(deal_sale_shop_idx)
                                         from dbenuri.deal_sale_shop aaa
                                         where aa.deal_idx = aaa.deal_idx)),0)
      ,0
      ,0
      ,0
      ,'N'
      ,nvl(to_char(current_date,'yyyy-mm-dd HH24:MI:SS'),' ')
      ,nvl(to_char(current_date,'yyyy-mm-dd HH24:MI:SS'),' ')
      ,nvl(b.division,' ')
      ,' '
      ,nvl(b.section1,' ')
      ,nvl(b.section2,' ')
      ,nvl(b.section3,' ')
      ,' '
      ,nvl(b.today_use,' ')
      ,nvl(b.instant_deliver,' ')
      ,nvl(b.free_shipping,' ')
      ,' '
      ,0
      ,0
      ,1000000
      ,0
      ,case when b.deal_shop_code = 6688 then nvl(b.url,' ')
            when b.deal_shop_code = 6508 then 'http://www.wemakeprice.com/widget/aff_bridge_public/socialmoa/' || trim(b.meta_id)
            when b.deal_shop_code = 4027 then 'http://banner.auction.co.kr/bn_redirect.asp?ID=BN00174819' || '&' || 'lpurl=http://mobile.auction.co.kr/Item/ViewItem.aspx?ItemNo=' || trim(b.meta_id)
            when b.deal_shop_code = 6641 then 'http://www.ticketmonster.co.kr/entry/?jp=80025' || '&' || 'ln=212749' || '&' || 'p_no=' || trim(b.meta_id)
            else nvl(b.mobile_url,' ') end case
      ,' '
      ,' '
      ,0
      ,0
      ,0
      ,0
      ,nvl((select aa.deal_sale_shop_name
          from dbenuri.deal_sale_shop aa
          where aa.deal_idx = b.deal_idx
          and aa.deal_sale_shop_idx = (select max(deal_sale_shop_idx)
                                         from dbenuri.deal_sale_shop aaa
                                         where aa.deal_idx = aaa.deal_idx)),' ')
      ,nvl((select aa.deal_sale_shop_tel
          from dbenuri.deal_sale_shop aa
          where aa.deal_idx = b.deal_idx
          and aa.deal_sale_shop_idx = (select max(deal_sale_shop_idx)
                                         from dbenuri.deal_sale_shop aaa
                                         where aa.deal_idx = aaa.deal_idx)),' ')
      ,' '
      ,' '
      ,0
      ,0
      ,1000000
      ,0
      ,' '
      ,0
      ,' '
      ,' '
      ,' '
      ,' '
      ,' '
      ,' '
      ,nvl(b.mobile_select,' ')
      ,nvl(to_number(case when (b.mobile_original = ' ') then '0' else b.mobile_original end,'99999999999'),0)
      ,nvl(to_number(case when (b.mobile_price = ' ') then '0' else b.mobile_price end,'99999999999'),0)
      ,case when(b.mobile_price = ' ' OR b.mobile_price = '0' OR b.mobile_price is null or b.mobile_original = ' ' or b.mobile_original = '0' or b.mobile_original = '0.0' or b.mobile_original is null) then 0 when (1 - nvl(round(to_number(to_char(((to_number(case when (b.mobile_price = ' ' OR b.mobile_price = '0' OR b.mobile_price is null) then '0' when (b.mobile_original = ' ' OR b.mobile_original = '0' OR b.mobile_price is null) then '0' else b.mobile_price end,'99999999999')) /
      (to_number(case when (b.mobile_original = ' ' or b.mobile_original = '0' or b.mobile_original = '0.0' or b.mobile_original is null) then '100' else b.mobile_original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 = 100 then 0
      else   (1 - nvl(round(to_number(to_char(((to_number(case when (b.mobile_price = ' ' OR b.mobile_price = '0' OR b.mobile_price is null) then '0' when (b.mobile_original = ' ' OR b.mobile_original = '0' OR b.mobile_price is null) then '0' else b.mobile_price end,'99999999999')) /
      (to_number(case when (b.mobile_original = ' ' or b.mobile_original = '0' or b.mobile_original = '0.0' or b.mobile_original is null) then '100' else b.mobile_original end,'99999999999'))),'99999999999.99999')),2),0)) * 100 end
from dbenuri.deal_goods b
where not exists (select 1 
                  from d4_coupon a
                      ,g4_member c
                  where b.meta_id = a.cp_pid
                  and b.deal_shop_code = c.mb_shop_code
                  and c.mb_id = a.cp_company)
and b.deal_shop_code = T_MB_ID        
and b.cp_pid = T_CP_PID           
and substr(to_char(end_at,'yyyy-mm-dd'),1,10) >= to_char(sysdate,'yyyy-mm-dd');

dbms_output.put_line('bbb');
--d4_coupon image5 update
update d4_coupon set cp_image5 = cp_image1 where (cp_image5 = ' ' or cp_image5 is null) and cp_company = v_shop_code; 

update d4_coupon set cp_salerate = 0 where cp_salerate < 0 and cp_company = v_shop_code;

dbms_output.put_line('ccc');
if (sqlcode < 0) then
  o_err_msg := 'insert error (' || sqlcode || ')';
  chk_err_fg := '1';
end if;

dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);


-- d4_coupon_cate insert/d4_coupon cate1 update
declare
   v_id number(11);
   v_cate2 varchar2(10);
   v_cate3 varchar2(10);
   v_cate1 varchar2(10);
   v_count number(4);
   
   cursor cur02 is
/*      select a.cp_id
             ,c.pcode
             ,b.cate
             ,d.pcode
        from d4_coupon a
             ,d4_keyword_cate b
             ,d4_commoncode c
             ,d4_commoncode d
       --where b.keyword like '%' || a.cp_division || '%'
       where instr(b.keyword,a.cp_division) > 0
       and a.cp_division > ' '
       and b.cate = c.code
       and c.pcode = d.code
       group by a.cp_id
                ,c.pcode
                ,b.cate
                ,d.pcode
       order by a.cp_id;*/
      with temp as(
      select a.cp_id
              ,b.cate
      from d4_coupon a, d4_keyword_cate b
      where instr(a.cp_division,b.keyword) > 0       
      and a.cp_division > ' '
      and trim(b.idx) = trim(b.idx)
      and trim(a.cp_id) = trim(a.cp_id)
      and a.cp_company = v_shop_code
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
          
          if (sqlcode < 0) then
             o_err_msg := 'd4_coupon_cate insert/update error (' || v_id || ': ' || v_cate3 || ': ' || sqlcode || ')';
             chk_err_fg := '1';
          end if;
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
   
   cursor cur06 is

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
          
          if (sqlcode < 0) then
             o_err_msg := 'd4_coupon_cate insert/update error (' || v_id || ': ' || v_cate3 || ': ' || sqlcode || ')';
             chk_err_fg := '1';
          end if;
        end if;

      end loop;
    close cur06;    
end;    


update d4_coupon a set a.cp_company_name = nvl((select b.mb_name from g4_member b where b.mb_id = a.cp_company),' ')
where cp_company = v_shop_code;

update d4_coupon a set a.cp_cate2 = nvl((select b.cate2 from d4_coupon_cate b where a.cp_id = b.cp_id and a.cp_cate1 = b.cate1 and rownum = 1),' ')
                              ,a.cp_cate1_name = nvl((select codename from d4_commoncode where code = a.cp_cate1),' ')
where cp_cate1 <> ' ' and a.cp_company = v_shop_code;                                        
                                        
update d4_coupon a set a.cp_cate3 = nvl((select b.cate3 from d4_coupon_cate b where a.cp_id = b.cp_id and a.cp_cate1 = b.cate1 and a.cp_cate2 = b.cate2 and rownum = 1),' ')
                              ,a.cp_cate2_name = nvl((select codename from d4_commoncode where code = a.cp_cate2),' ')
where cp_cate1 <> ' ' and a.cp_company = v_shop_code;  
          
update d4_coupon a set a.cp_cate3_name = nvl((select codename from d4_commoncode where code = a.cp_cate3),' ')
where cp_cate1 <> ' ' and a.cp_company = v_shop_code;  
          
update d4_coupon set cp_cate1 = ' ' where cp_cate2 = ' ' and cp_company = v_shop_code;

dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
dbms_output.put_line('ddd');          
-- d4_coupon_loc insert
declare
   v_cp_id varchar2(10);
   v_cp_address varchar2(455);
   v_loccate varchar2(10);
   v_keyword varchar2(50);
   v_opt varchar2(3);
   t_loccate varchar2(10);
   v_true varchar2(1);
   v_rowcnt number(3);
   
   cursor cur03 is
      select a.cp_id
             ,a.cp_address
       from d4_coupon a
            ,dbenuri.deal_goods b
            ,dbenuri.deal_sale_shop c
      where 
      substr(a.cp_lastupdate,1,10) = to_char(sysdate,'yyyy-mm-dd') and 
      a.cp_pid = b.meta_id  and
       b.deal_idx = c.deal_idx
      and (a.cp_address is not null and a.cp_address <> ' ')
      --and b.meta_id = '425230';
      and a.cp_pid = T_CP_PID ;
    begin
      open cur03;
      
      loop
        fetch cur03
        into v_cp_id
            ,v_cp_address;
            
        if cur03%notfound
        then
          exit;
        end if;
        
        declare cursor cur04 is
           select loccate
                 ,trim(keyword)
                 ,opt
             from d4_keyword_loc
            order by loccate,opt desc;
            
        begin
          open cur04;
          
          loop
            fetch cur04
            into v_loccate
                ,v_keyword
                ,v_opt;
            
            if cur04%notfound
            then
               exit;
            end if;

            
            if (v_loccate <> t_loccate) and (t_loccate <> ' ') then
              if (v_true = '1' or v_true = '2') then
                 
                 select count(1)
                 into v_rowcnt
                 from d4_coupon_loc a
                 where a.cp_id = v_cp_id
                 and a.loccate = t_loccate
                 and a.loccatetop = (select b.pcode from d4_commoncode b where b.code = t_loccate);
                 if (v_rowcnt = 0) then
                   insert into d4_coupon_loc values (v_cp_id,t_loccate,(select b.pcode from d4_commoncode b where b.code = t_loccate));
                 end if;
                  
              end if;
              v_true := '0';
            end if;
            if ( instr(v_cp_address,v_keyword) > 0  and (v_opt = 'or' OR v_true = '1')) then
              v_true := '1';
            elsif (instr(v_cp_address,v_keyword) > 0 and v_opt = 'and' and v_true <> '3' and v_true <> '4') then
              v_true := '2';
            elsif (instr(v_cp_address,v_keyword) = 0 and v_opt = 'and') then
              v_true := '3';
            elsif (instr(v_cp_address,v_keyword) = 0 and v_opt = 'or') then
              v_true := '4';
            end if;            
          
            t_loccate := v_loccate;
            
          end loop;
        close cur04;
      end;
    end loop;
  close cur03;
end;   

dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
dbms_output.put_line('eee'); 

-- d4_coupon_shop insert
declare
   v_coupon_id number(11);
   v_shopname varchar2(250);
   v_shoptel varchar2(20);
   v_lat number(11,5);
   v_lng number(11,5);
   v_addr varchar2(250);
   v_row number(4);
   
   cursor cur05 is
     SELECT c.cp_id
            ,a.deal_sale_shop_name
            ,a.deal_sale_shop_tel
            ,case when ISNUMERIC(a.deal_sale_shop_latitude) = 1 then a.deal_sale_shop_latitude else '0' end
            ,case when ISNUMERIC(a.deal_sale_shop_longigude) = 1 then a.deal_sale_shop_longigude else '0' end
            ,a.deal_sale_shop_address
       FROM dbenuri.deal_sale_shop a 
            ,dbenuri.deal_goods b
            ,d4_coupon c
      WHERE a.deal_idx IN (SELECT DEAL_IDX FROM dbenuri.DEAL_GOODS WHERE (substr(to_char(end_at,'yyyy-mm-dd'),1,10) >= to_char(sysdate,'yyyy-mm-dd')) OR  SALE_OUT_FLAG = 'Y' OR FORCE_SALE_OUT = 'Y')
      and b.deal_idx = a.deal_idx
      and c.cp_pid = b.meta_id
      and b.deal_shop_code = T_MB_ID
      and b.cp_pid = T_CP_PID 
      order by c.cp_id,a.deal_sale_shop_name;
                
    begin
      open cur05;
      
      loop
        fetch cur05
        into v_coupon_id
            ,v_shopname
            ,v_shoptel
            ,v_lat
            ,v_lng
            ,v_addr;
            
        if cur05%notfound
        then
          exit;
        end if;
        
        select count(1)
        into v_row
        from d4_coupon_shop
        where cp_id = v_coupon_id
        and shopname = v_shopname;

        if v_row = 0 then
          insert into d4_coupon_shop values(v_coupon_id
                                               ,(select nvl(max(idx),0) + 1 from d4_coupon_shop where cp_id = v_coupon_id)
                                               , v_shopname
                                               , v_shoptel
                                               , v_lat
                                               , v_lng
                                               , v_addr);
                                     
          if (sqlcode < 0) then
             o_err_msg := 'd4_coupon_shop insert error (' || v_coupon_id || ': ' || v_shopname || ': ' || sqlcode || ')';
             chk_err_fg := '1';
          end if;
        end if;

      end loop;
    close cur05;
end; 

--category_sum(v_shop_code); -- categorySum SP call
CATEGORY_SUM_ALL('YES');

dbms_output.put_line('fff');
if (chk_err_fg = '1') then
  dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
  rollback;
else
  dbms_output.put_line('COUPON_CR SP EXCUTED SUCCESSSFULLY!!'); 
  commit;     
end if;

EXCEPTION
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( o_err_msg || ' ' || 'register is failed!');

ROLLBACK;

END;