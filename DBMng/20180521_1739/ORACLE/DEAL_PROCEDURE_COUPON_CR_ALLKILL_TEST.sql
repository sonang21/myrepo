/* *************************************************************************
 * NAME : DEAL.COUPON_CR_ALLKILL_TEST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-05-10 15:07:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_CR_ALLKILL_TEST" 
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
        DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다');
        DBMS_OUTPUT.PUT_LINE('SQL ERROR CODE:' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQL ERROR MESSAGE:' || SQLERRM); -- 매개변수 없는 SQLERRM
        DBMS_OUTPUT.PUT_LINE( SQLERRM(SQLCODE)); -- 매개변수 있는 SQLERRM
    end;
    
    dbms_output.put_line('v_cnt  :' || v_cnt);

END COUPON_CR_Allkill_test;
