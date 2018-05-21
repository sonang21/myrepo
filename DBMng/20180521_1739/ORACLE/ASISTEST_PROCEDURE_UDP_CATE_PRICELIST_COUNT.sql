/* *************************************************************************
 * NAME : ASISTEST.UDP_CATE_PRICELIST_COUNT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:17
 *        Modify: 2018-05-04 18:53:41
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_CATE_PRICELIST_COUNT" AS 

BEGIN
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CATE_PRICELIST_COUNT','START');
    COMMIT;
    
  declare
   v_cate varchar2(12);
   v_cate6 varchar2(12);
   v_cate6_sum NUMBER(10) := 0;
   v_cate4 varchar2(12);
   v_cate4_sum NUMBER(10) := 0;   
   v_cate_exists  NUMBER(10) := 0;   
    cursor cur01 is
      select ca_code from tbl_category where c_seqno > 0 and c_level = 2  order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;
          insert into TBL_CATE_PRICELIST_COUNT_TMP
          SELECT trim(p.ca_code),count(pl_no) as cnt
          FROM   dbenuri.TBL_PRICELIST P    
            INNER JOIN dbenuri.TBL_SHOPLIST S    
            ON P.SHOP_CODE = S.SHOP_CODE    
            INNER JOIN dbenuri.tbl_category c
            on trim(P.ca_code) = c.ca_code and c.c_seqno > 0 and c.c_level > 1 and c.ca_code like v_cate || '%'
            LEFT OUTER JOIN dbenuri.TBL_GOODS G    
            ON P.MODELNO = G.MODELNO AND G.CATEFLAG='0' and G.ca_lcode = substr(v_cate,0,2) and g.ca_code like v_cate || '%'
          WHERE  P.SRVFLAG in ('0','L','R','Z','2','3','6','7','9','O','D','S','P')  
          AND P.STATUS in ('0','8','9') 
          AND (trim(P.ca_code) IS NOT NULL  and trim(P.ca_code) like v_cate || '%')
          AND (
            P.modelno<=0        
            OR ( G.CONSTRAIN='1' AND G.JOBCODE = '0' )        
            OR ( G.CONSTRAIN IS NULL AND G.JOBCODE IS NULL )        
            OR G.CONSTRAIN IN ('2','3')
            OR (P.option_flag2='1' AND G.minprice < P.price)
          ) 
          group by trim(p.ca_code);
          
          FOR tmp_loop in 
            (select substr(ca_code,0,6) as cate6 ,sum(count) as sum_cnt from TBL_CATE_PRICELIST_COUNT_TMP where ca_code like v_cate || '%' and length(ca_code) = 8 group by substr(ca_code,0,6)) loop
            begin              
              v_cate_exists := 0;
              select count(*) into  v_cate_exists from TBL_CATE_PRICELIST_COUNT_TMP where ca_code = tmp_loop.cate6;
              if v_cate_exists > 0 then
                update TBL_CATE_PRICELIST_COUNT_TMP set count = count+tmp_loop.sum_cnt where ca_code = tmp_loop.cate6;
              else
                insert into TBL_CATE_PRICELIST_COUNT_TMP (ca_code,count) values (tmp_loop.cate6,tmp_loop.sum_cnt);
              end if;
            end;
          end loop;
  
          FOR tmp_loop in 
            (select substr(ca_code,0,4) as cate4 ,sum(count) as sum_cnt  from TBL_CATE_PRICELIST_COUNT_TMP where ca_code like v_cate || '%' and length(ca_code) = 6 group by substr(ca_code,0,4)) loop
            begin
              v_cate_exists := 0;
              select count(*) into  v_cate_exists from TBL_CATE_PRICELIST_COUNT_TMP where ca_code = tmp_loop.cate4;
              if v_cate_exists > 0 then
                update TBL_CATE_PRICELIST_COUNT_TMP set count = count+tmp_loop.sum_cnt where ca_code = tmp_loop.cate4;
              else
                insert into TBL_CATE_PRICELIST_COUNT_TMP (ca_code,count) values (tmp_loop.cate4,tmp_loop.sum_cnt);
              end if;
            end;
          end loop;
          
          delete TBL_CATE_PRICELIST_COUNT where CA_CODE like  v_cate || '%';
          insert into TBL_CATE_PRICELIST_COUNT (CA_CODE,COUNT) select CA_CODE,COUNT from TBL_CATE_PRICELIST_COUNT_TMP;  
          delete TBL_CATE_PRICELIST_COUNT_TMP;
          commit;
        end loop;
      close cur01;
    end;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_CATE_PRICELIST_COUNT','END');
    COMMIT;
    
END UDP_CATE_PRICELIST_COUNT;