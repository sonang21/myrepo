/* *************************************************************************
 * NAME : DBENURI.UDP_PRICELIST_OPTION_DIFF_INS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_PRICELIST_OPTION_DIFF_INS" 
is  
begin  
  -- 초기화
  delete from TBL_PRICELIST_OPTION_DIFF;
  commit;
  
  -- 대상모델 입력
  insert into tbl_pricelist_option_diff(pl_no)
  -- 추가, 변경 된 놈  
  select distinct t.pl_no 
  from 
    tbl_pricelist_option2 t -- 현재
        left outer join 
    tbl_pricelist_option3 y -- 과거
  on t.pl_no = y.pl_no 
  and t.option_name = y.option_name 
  and t.option_sub_name = y.option_sub_name
  and sign(t.option_price) = sign(y.option_price)
  where  y.pl_no is null
  
  union
  
  -- 삭제된 놈
  select t.pl_no
  from
  (select pl_no, count(*) cnt from tbl_pricelist_option2 group by pl_no) t -- 현재
  inner join 
  (select pl_no, count(*) cnt from tbl_pricelist_option3 group by pl_no) y -- 과거
  on t.pl_no = y.pl_no
  where t.cnt < y.cnt; -- 현재 옵션 개수가 과거 옵션 개수보다 적다.
  commit;
  
  --====================================================================================
  
  delete from TBL_PRICELIST_OPTION_ADD;
  commit;
    
  insert into TBL_PRICELIST_OPTION_ADD(pl_no)
  select t.pl_no
  from
  (select distinct pl_no from tbl_pricelist_option2 ) t -- 현재
  left outer join 
  (select distinct pl_no from tbl_pricelist_option3  ) y -- 과거
  on t.pl_no = y.pl_no 
  where y.pl_no is null; 
end;