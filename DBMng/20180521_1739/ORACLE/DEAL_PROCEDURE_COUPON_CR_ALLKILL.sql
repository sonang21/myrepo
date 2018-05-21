/* *************************************************************************
 * NAME : DEAL.COUPON_CR_ALLKILL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-05-10 15:07:33
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_CR_ALLKILL" 
(
    v_result OUT number 
)
----------------------------------------------------------------------------------------------------------------------
/*
 NGIT 체크 - 변경없음 김영원 20180418
*/
-- File Name : COUPON_CR_Allkill
-- Version      : 1.0
-- Writen Date  : 2018-01-10
-- Author    : Choi Jin Won
-- Program ID  : COUPON_CR_Allkill
-- Comments : update/insert coupon series with deal_goods/deal_sale_shop for Allkill Crawling Data
---------------------------------------------------------------------------------------------------------------------- 
IS

chk_err_fg varchar2(1);
o_err_msg varchar2(100);
v_shop_code varchar2(255) := 'auction';
v_cnt number;

BEGIN
    v_cnt := 0;
    v_result := 0;
    DBMS_OUTPUT.ENABLE;
    dbms_output.put_line('start:' || v_result);

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
    v_division varchar2(100);
    v_free_ship varchar(1);
    v_instant_deliver varchar2(1);
    v_cp_name varchar2(455); 
    
    --커서 선언
    cursor cur01 is 
    select nvl(a.cp_pid,' ') --v_pid
         ,nvl(a.cp_company,' ') --v_company
         ,0 --v_price
         ,nvl(to_number(b.price,'99999999999'),0) --v_saleprice
         ,0 --v_salerate
         ,10000 --v_maxcnt
         ,0 --v_salecnt
         ,nvl(to_char(sysdate,'yyyy-mm-dd'),' ') --v_startdate
         ,nvl(to_char(sysdate+7,'yyyy-mm-dd'),' ') --v_limitdate (수정)
         ,' ' --v_image1
         ,nvl(b.imgurl,' ') --v_image5
         ,nvl(to_char(sysdate,'yyyy-mm-dd'),' ') --v_coupon_start
         ,nvl(to_char(sysdate+7,'yyyy-mm-dd'),' ') --v_coupon_end
         ,b.url --수익코드 치환여부 (수정)
         ,'http://mitem.auction.co.kr/vip?pc=805' || '&' || 'itemNo=' || b.goodscode --v_murl 2안 : replace(b.url, 'pc=589', 'pc=805')
         ,' ' --v_address
         ,(case nvl(to_number(b.price,'99999999999'),0) when 0 then '3' else ' ' end) --v_mobile_select
         ,0 --v_mobile_original
         ,nvl(to_number(b.instance_price,'99999999999'),0) --v_mobile_price
         ,0 --v_mobile_discount
         ,dbenuri.UDF_DEAL_CATE_MAPPING(ca_code) --v_division
         ,(case b.deliveryinfo when '무료배송' then 'Y' else 'N' end) --v_free_ship
         ,'N' --v_instant_deliver
         ,nvl(b.goodsnm, ' ') --v_cp_name
    from deal.d4_coupon a
         ,dbenuri.tbl_pricelist b
    where a.cp_pid = b.goodscode
    and b.shop_code = 4027 -- (수정)
    and b.pl_no in (select pl_no from dbenuri.TBL_CRAWLING_DATA_PLNO)
    --and b.goodscode = 'A079184566' --테스트용
    and substr(a.cp_limitdate,1,10) >= to_char(sysdate,'yyyy-mm-dd')
    and dbenuri.UDF_DEAL_CATE_MAPPING(ca_code) != '(null)';

 
    begin
        --커서 열기
        open cur01;
     
        --커서에서 데이터 가져오기 및 데이터 처리
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
               ,v_mobile_discount
               ,v_division
               ,v_free_ship
               ,v_instant_deliver
               ,v_cp_name ;
            
            v_cnt := v_cnt + 1;
            if cur01%notfound then
               exit;
            end if;
            
            update d4_coupon
            set cp_price = v_price
               ,cp_saleprice = v_saleprice
               ,cp_salerate = v_salerate
               ,cp_maxcnt = v_maxcnt
               ,cp_salecnt = v_salecnt
               --,cp_startdate = v_startdate
               ,cp_limitdate = v_limitdate
               ,cp_image1 = v_image1
               ,cp_image5 = trim(v_image5)
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
               ,cp_division = v_division
               ,cp_free_ship = v_free_ship     
               ,CP_INSTANT_DELIVER = v_instant_deliver
               ,CP_NAME = v_cp_name
            where cp_pid = v_pid
            and cp_company = v_company;             
            if (sqlcode < 0) then
              o_err_msg := 'update error (' || v_pid || ': ' || v_company || ': ' || sqlcode || ')';
              chk_err_fg := '1';
            end if;
            commit;
        end loop;
        dbms_output.put_line('전체데이터 수 ' || cur01%ROWCOUNT);

        --커서 닫기
    close cur01;
    
    EXCEPTION WHEN OTHERS THEN
        dbms_output.put_line('error v_pid :' || v_pid);
        DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE:' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE:' || SQLERRM); -- 매개변수 없는 SQLERRM
        DBMS_OUTPUT.PUT_LINE( SQLERRM(SQLCODE)); -- 매개변수 있는 SQLERRM
    end;
    
    dbms_output.put_line('v_cnt  :' || v_cnt);

    --d4_coupon insert     
    insert into d4_coupon
    select to_number(deal.cp_id.nextval,'9999999999')
          ,nvl(b.goodscode,' ')
          ,' '
          ,' '
          ,' '
          ,0
          ,'admin'
          ,'auction' --(수정)
          ,nvl(b.goodsnm,' ')
          ,' '
          ,' '
          ,b.url
          ,nvl(b.imgurl,' ')
          ,' '
          ,' '
          ,' '
          ,''
          ,' '
          ,' '
          ,0
          ,nvl(to_number(b.price,'99999999999'),0)
          ,0
          ,10000 --max cnt
          ,0 -- buy cnt
          ,0
          ,nvl(to_char(sysdate,'yyyy-mm-dd'),' ')
          ,nvl(to_char(sysdate+7,'yyyy-mm-dd'),' ') 
          ,nvl(to_char(sysdate,'yyyy-mm-dd'),' ')
          ,nvl(to_char(sysdate+7,'yyyy-mm-dd'),' ') 
          ,' '
          ,0
          ,'Y'
          ,0
          ,0
          ,0
          ,0
          ,0
          ,'N'
          ,nvl(to_char(current_date,'yyyy-mm-dd HH24:MI:SS'),' ')
          ,nvl(to_char(current_date,'yyyy-mm-dd HH24:MI:SS'),' ')
          ,dbenuri.UDF_DEAL_CATE_MAPPING(ca_code)
          ,' '
          ,' '
          ,' '
          ,' '
          ,' '
          ,'N'
          ,'N'
          ,(case b.deliveryinfo when '무료배송' then 'Y' else 'N' end)
          ,' '
          ,0
          ,0
          ,1000000 --cp rank (default)
          ,0
          ,'http://mitem.auction.co.kr/vip?pc=805' || '&' || 'itemNo=' || b.goodscode --(수정)
          ,' '
          ,' '
          ,0
          ,0
          ,0
          ,0
          ,' '
          ,' '
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
          ,' '
          ,0
          ,0
          ,nvl(to_number(b.instance_price,'99999999999'),0)
          ,'',''
    from dbenuri.tbl_pricelist b
    where not exists (select 1
                      from deal.d4_coupon a
                      where b.goodscode = a.cp_pid
                      and b.shop_code = 4027) --(수정)
    --and b.goodscode = '101114057' -- 테스트용
    and dbenuri.UDF_DEAL_CATE_MAPPING(ca_code) is not null
    and b.pl_no in (select pl_no from dbenuri.TBL_CRAWLING_DATA_PLNO)--(수정)
    --and b.goodscode = 'A079184566' --테스트용
    and shop_code = 4027 and status = '0';
    commit;

    --d4_coupon image5 update
    update d4_coupon set cp_image5 = cp_image1 where (cp_image5 = ' ' or cp_image5 is null) and cp_company = v_shop_code; 
    commit;
    
    update d4_coupon set cp_salerate = 0 where cp_salerate < 0 and cp_company = v_shop_code;
    commit;

    dbms_output.put_line('ccc');

    if (sqlcode < 0) then
      o_err_msg := 'insert error (' || sqlcode || ')';
      chk_err_fg := '1';
    end if;

    -- d4_coupon_cate insert/d4_coupon cate1 update
    declare
        v_id number(11);
        v_cate2 varchar2(10);
        v_cate3 varchar2(10);
        v_cate1 varchar2(10);
   
    cursor cur02 is
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
            if cur02%notfound then
                exit;
            end if;
            
            delete d4_coupon_cate where cp_id = v_id;
            insert into d4_coupon_cate values(v_id, v_cate2, v_cate3, v_cate1);
            commit;
            
            update d4_coupon a set a.cp_cate1 = v_cate1                                        
            where a.cp_id = v_id;
            commit;
              
            if (sqlcode < 0) then
                o_err_msg := 'd4_coupon_cate insert/update error (' || v_id || ': ' || v_cate3 || ': ' || sqlcode || ')';
                chk_err_fg := '1';
            end if;
        end loop;
        close cur02;
    end;    

    update d4_coupon a set a.cp_company_name = nvl((select b.mb_name from g4_member b where b.mb_id = a.cp_company),' ')
    where cp_company = v_shop_code;
    commit;
    
    update d4_coupon a set a.cp_cate2 = nvl((select b.cate2 from d4_coupon_cate b where a.cp_id = b.cp_id and a.cp_cate1 = b.cate1 and rownum = 1),' ')
                        ,a.cp_cate1_name = nvl((select codename from d4_commoncode where code = a.cp_cate1),' ')
    where cp_cate1 <> ' ' and a.cp_company = v_shop_code;  
    commit;
                                            
    update d4_coupon a set a.cp_cate3 = nvl((select b.cate3 from d4_coupon_cate b where a.cp_id = b.cp_id and a.cp_cate1 = b.cate1 and a.cp_cate2 = b.cate2 and rownum = 1),' ')
                    ,a.cp_cate2_name = nvl((select codename from d4_commoncode where code = a.cp_cate2),' ')
    where cp_cate1 <> ' ' and a.cp_company = v_shop_code;  
    commit;
              
    update d4_coupon a set a.cp_cate3_name = nvl((select codename from d4_commoncode where code = a.cp_cate3),' ')
    where cp_cate1 <> ' ' and a.cp_company = v_shop_code;  
    commit;
              
    update d4_coupon set cp_cate1 = ' ' where cp_cate2 = ' ' and cp_company = v_shop_code;
    commit;
    
    insert into d4_coupon_cate (cp_id,cate1,cate2,cate3)  
    (select cp_id,'A02','A0210','C160' from d4_coupon where cp_id not in (select cp_id from d4_coupon_cate) and cp_id not in (select cp_id from d4_coupon_loc));
    
    update d4_coupon set cp_cate1 = 'A02' ,  cp_cate2 = 'A0210' , cp_cate3 = 'C160' , cp_cate1_name = '쇼핑' , cp_cate2_name = '온라인/e쿠폰' , cp_cate3_name = '기타/이벤트'   where cp_id in (
    select cp_id from d4_coupon_cate where cate1 = 'A02' and cate2 = 'A0210' and cate3 = 'C160'
    ) and cp_cate1 = ' ' and cp_cate2 = ' ' and cp_cate3 = ' ';

    CATEGORY_SUM_ALL('YES');

    if (chk_err_fg = '1') then
        dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg);
        rollback;
    else
        dbms_output.put_line('COUPON_CR SP EXCUTED SUCCESSSFULLY!!'); 
        select count(*)
        into v_result
        from d4_coupon
        where cp_company = 'auction'
        AND cp_lastupdate >= to_char(current_date,'yyyy-mm-dd');
        commit;     
    end if;
    
    EXCEPTION WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE( o_err_msg || ' ' || 'register is failed!');
        v_result := 0;
        ROLLBACK;
END COUPON_CR_Allkill;
