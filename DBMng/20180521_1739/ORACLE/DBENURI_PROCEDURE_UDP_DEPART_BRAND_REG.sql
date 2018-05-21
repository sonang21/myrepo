/* *************************************************************************
 * NAME : DBENURI.UDP_DEPART_BRAND_REG
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 13:53:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEPART_BRAND_REG" as
/*
 NGIT ���� �ݿ� - �迵�� 20180425
*/ 
    v_max_brandno   NUMBER(12) := 0;
BEGIN
    SELECT nvl(max(brand_no),0) INTO v_max_brandno from tbl_dept_brand;

    --���� ���� ��ǰ�� ��ȭ���� ��� �ȵ� �귣��
    insert into tbl_dept_brand (brand_no, brand_nm, brand_nm_1st,del_yn)
    select v_max_brandno+rownum,brand,'1','Y' from (
    	select distinct(brand) brand
    	  from tbl_goods a, tbl_goods_sum b, tbl_cate_goods c
      where a.modelno = b.modelno and a.modelno = c.modelno
        and c.ca_code like '86%' and a.constrain in ('1','5') and a.jobcode>'0' and c.cateflag='1' and b.mallcnt>0 and b.minprice4>0 and a.brand<>'[�Ҹ�]' and a.brand is not null and a.brand<>'[�߰�]' and a.brand<>'[ȣȯ��ü]'
    )
    where brand not in (select brand_nm from tbl_dept_brand)
    order by brand;

    --�ʼ� ����
    update tbl_dept_brand set brand_nm_1st=substr(brand_nm,0,1) where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1) between '0' and '9';
    update tbl_dept_brand set brand_nm_1st=upper(substr(brand_nm,0,1)) where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1) between 'a' and 'z';
    update tbl_dept_brand set brand_nm_1st=substr(brand_nm,0,1) where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1) between 'A' and 'Z';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'ī';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='ī' and substr(brand_nm,0,1)<'Ÿ';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='Ÿ' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'��';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='��' and substr(brand_nm,0,1)<'������';
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and brand_nm='��';

    update tbl_dept_brand set del_yn='N' where del_yn='Y';

    --�з� ���̺� ��� �ȵ� ������ ó��
    insert into tbl_dept_cate_brand (ca_code, brand_no)
    select ca_code, brand_no
    from (
    	select ca_code,(select brand_no from tbl_dept_brand where brand_nm=a.brand) brand_no
    	from (
    		select c.ca_code, a.brand
    		  from tbl_goods a, tbl_goods_sum b, tbl_cate_goods c
       where a.modelno = b.modelno and a.modelno = c.modelno
    		   and c.ca_lcode='86' and a.constrain in ('1','5') and a.jobcode>'0' and a.modelno>0 and c.cateflag='1' and b.mallcnt>0 and b.minprice4>0
    			  and a.brand is not null and a.brand<>'[�Ҹ�]' and a.brand<>'[�߰�]' and a.brand<>'[ȣȯ��ü]'
    		 group by c.ca_code, a.brand
    	) a
    )
    where (ca_code, brand_no) not in (select ca_code,brand_no from tbl_dept_cate_brand);

    commit;

END UDP_DEPART_BRAND_REG;
