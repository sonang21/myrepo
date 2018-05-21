/* *************************************************************************
 * NAME : DBENURI.UDP_CATE_PRICELIST_M_COUNT_NEW
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-17 05:00:00
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CATE_PRICELIST_M_COUNT_NEW" AS
/*
 NGIT 수정 반영 - 김영원 20180423
*/
BEGIN
delete TBL_CATE_PRICELIST_M_COUNT_TMP;
INSERT INTO TBL_CATE_PRICELIST_M_COUNT_TMP 
WITH BASIC_CATE AS
(
select cate4, cate6, cate8, ca_code, sum(cnt) as cnt
  from (
        SELECT  /*+ full(P1) parallel(P1 8)*/
                  substr(trim(P1.ca_code),1,4) as cate4
                , substr(trim(P1.ca_code),1,6) as cate6
                , substr(trim(P1.ca_code),1,8) as cate8
                , trim(P1.ca_code) as ca_code
                , count(P1.pl_no) as cnt
          FROM   dbenuri.TBL_PRICELIST P1    
                INNER JOIN dbenuri.TBL_SHOPLIST S1    
                ON P1.SHOP_CODE = S1.SHOP_CODE
         WHERE P1.SRVFLAG in ('0','L','R','Z','2','3','6','7','9','O','D','S','P')  
              AND P1.STATUS in ('0','8','9') 
              AND (P1.ca_code IS NOT NULL
                   )
              AND P1.modelno<=0     
              AND P1.instance_price>0   
        group by substr(trim(P1.ca_code),1,4), substr(trim(P1.ca_code),1,6), substr(trim(P1.ca_code),1,8), trim(P1.ca_code)
        HAVING LENGTH(trim(P1.ca_code)) > 2
        union all
        SELECT  /*+ full(P2) parallel(P2 8) full(G) parallel(G 4)*/
                  substr(trim(P2.ca_code),1,4) as cate4
                , substr(trim(P2.ca_code),1,6) as cate6
                , substr(trim(P2.ca_code),1,8) as cate8
                , trim(P2.ca_code) as ca_code
                , count(P2.pl_no) as cnt
          FROM   dbenuri.TBL_PRICELIST P2    
                INNER JOIN dbenuri.TBL_SHOPLIST S    
                ON P2.SHOP_CODE = S.SHOP_CODE
                LEFT OUTER JOIN dbenuri.TBL_GOODS G    
                ON P2.MODELNO = G.MODELNO AND P2.MODELNO>0
                LEFT OUTER JOIN dbenuri.TBL_GOODS_SUM S
                ON G.MODELNO = S.MODELNO
         WHERE P2.SRVFLAG in ('0','L','R','Z','2','3','6','7','9','O','D','S','P')  
              AND P2.STATUS in ('0','8','9') 
              AND (P2.ca_code IS NOT NULL 
                   )
              AND P2.modelno > 0
              AND (  ( G.CONSTRAIN='1' AND G.JOBCODE = '0' )        
                OR ( G.CONSTRAIN IS NULL AND G.JOBCODE IS NULL )        
                OR G.CONSTRAIN IN ('2','3')
                OR (P2.option_flag2='1' AND S.minprice < P2.price))
              AND P2.instance_price>0        
        group by substr(trim(P2.ca_code),1,4), substr(trim(P2.ca_code),1,6), substr(trim(P2.ca_code),1,8), trim(P2.ca_code)
        HAVING LENGTH(trim(P2.ca_code)) > 2
       )
 group by cate4, cate6, cate8, ca_code
)
SELECT
    case 0 when grouping(cate4) then cate4
        when grouping(cate6) then cate6
                            else cate8 end as cate
    , sum(cnt) AS CNT
FROM BASIC_CATE A
     INNER JOIN dbenuri.tbl_category c
         on a.ca_code = c.ca_code and c.c_seqno > 0 and c.c_level > 1
GROUP BY grouping sets
    (  cate4
        , cate6
        , cate8
     )
HAVING grouping(cate4) = 0  -- 중
        OR (grouping(cate6) = 0 AND length(cate6)=6 ) -- 소
        OR (grouping(cate8) = 0 AND length(cate8)=8 ); -- 미
commit;
declare
    v_cate varchar2(12);
    v_cnt  number(10);
    cursor cur01 is
      select ca_code,count from TBL_CATE_PRICELIST_M_COUNT_TMP ;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate,v_cnt;
          if cur01%notfound
            then
            exit;
          end if;
          delete TBL_CATE_PRICELIST_M_COUNT where CA_CODE =  v_cate ;
          insert into TBL_CATE_PRICELIST_M_COUNT (CA_CODE,COUNT) values (v_cate,v_cnt);  
          commit;
        end loop;
      close cur01;
    end;

END UDP_CATE_PRICELIST_M_COUNT_NEW;
