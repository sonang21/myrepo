/* *************************************************************************
 * NAME : ASISTEST.UDP_PRICELIST_OPTION_DIFF_INS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_PRICELIST_OPTION_DIFF_INS" 
is  
begin  
  -- �ʱ�ȭ
  delete from TBL_PRICELIST_OPTION_DIFF;
  commit;
  
  -- ���� �Է�
  insert into tbl_pricelist_option_diff(pl_no)
  -- �߰�, ���� �� ��  
  select distinct t.pl_no 
  from 
    tbl_pricelist_option2 t -- ����
        left outer join 
    tbl_pricelist_option3 y -- ����
  on t.pl_no = y.pl_no 
  and t.option_name = y.option_name 
  and t.option_sub_name = y.option_sub_name
  and sign(t.option_price) = sign(y.option_price)
  where  y.pl_no is null
  
  union
  
  -- ������ ��
  select t.pl_no
  from
  (select pl_no, count(*) cnt from tbl_pricelist_option2 group by pl_no) t -- ����
  inner join 
  (select pl_no, count(*) cnt from tbl_pricelist_option3 group by pl_no) y -- ����
  on t.pl_no = y.pl_no
  where t.cnt < y.cnt; -- ���� �ɼ� ������ ���� �ɼ� �������� ����.
  commit;
  
  --====================================================================================
  
  delete from TBL_PRICELIST_OPTION_ADD;
  commit;
    
  insert into TBL_PRICELIST_OPTION_ADD(pl_no)
  select t.pl_no
  from
  (select distinct pl_no from tbl_pricelist_option2 ) t -- ����
  left outer join 
  (select distinct pl_no from tbl_pricelist_option3  ) y -- ����
  on t.pl_no = y.pl_no 
  where y.pl_no is null; 
end;