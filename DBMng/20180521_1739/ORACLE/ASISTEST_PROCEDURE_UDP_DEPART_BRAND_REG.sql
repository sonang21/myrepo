/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPART_BRAND_REG
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPART_BRAND_REG" as
    v_max_brandno   NUMBER(12) := 0;
BEGIN
    SELECT nvl(max(brand_no),0) INTO v_max_brandno from tbl_dept_brand;

    --���� ���� ��ǰ�� ��ȭ���� ��� �ȵ� �귣��
    insert into tbl_dept_brand (brand_no, brand_nm, brand_nm_1st,del_yn)
    select v_max_brandno+rownum,brand,'1','Y' from (
    	select distinct(brand) brand
    	from tbl_goods
    	where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and cateflag='1' and mallcnt>0 and minprice4>0 and brand<>'[�Ҹ�]' and brand is not null and brand<>'[�߰�]' and brand<>'[ȣȯ��ü]'
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
    update tbl_dept_brand set brand_nm_1st='��' where del_yn='Y' and brand_nm_1st='1' and brand_nm='??';

    update tbl_dept_brand set del_yn='N' where del_yn='Y';

    --�з� ���̺� ��� �ȵ� ������ ó��
    insert into tbl_dept_cate_brand (ca_code, brand_no)
    select ca_code, brand_no
    from (
    	select ca_code,(select brand_no from tbl_dept_brand where brand_nm=a.brand) brand_no
    	from (
    		select ca_code,brand
    		from tbl_goods
    		where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and modelno>0 and cateflag='1' and mallcnt>0 and minprice4>0
    			and brand is not null and brand<>'[�Ҹ�]' and brand<>'[�߰�]' and brand<>'[ȣȯ��ü]'
    		group by ca_code, brand
    	) a
    )
    where (ca_code, brand_no) not in (select ca_code,brand_no from tbl_dept_cate_brand);

    commit;

END UDP_DEPART_BRAND_REG;