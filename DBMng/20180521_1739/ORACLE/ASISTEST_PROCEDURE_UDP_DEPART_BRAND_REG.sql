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

    --현재 서비스 상품중 백화점에 등록 안된 브랜드
    insert into tbl_dept_brand (brand_no, brand_nm, brand_nm_1st,del_yn)
    select v_max_brandno+rownum,brand,'1','Y' from (
    	select distinct(brand) brand
    	from tbl_goods
    	where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and cateflag='1' and mallcnt>0 and minprice4>0 and brand<>'[불명]' and brand is not null and brand<>'[추가]' and brand<>'[호환업체]'
    )
    where brand not in (select brand_nm from tbl_dept_brand)
    order by brand;

    --초성 세팅
    update tbl_dept_brand set brand_nm_1st=substr(brand_nm,0,1) where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1) between '0' and '9';
    update tbl_dept_brand set brand_nm_1st=upper(substr(brand_nm,0,1)) where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1) between 'a' and 'z';
    update tbl_dept_brand set brand_nm_1st=substr(brand_nm,0,1) where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1) between 'A' and 'Z';
    update tbl_dept_brand set brand_nm_1st='ㄱ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='가' and substr(brand_nm,0,1)<'나';
    update tbl_dept_brand set brand_nm_1st='ㄴ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='나' and substr(brand_nm,0,1)<'다';
    update tbl_dept_brand set brand_nm_1st='ㄷ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='다' and substr(brand_nm,0,1)<'라';
    update tbl_dept_brand set brand_nm_1st='ㄹ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='라' and substr(brand_nm,0,1)<'마';
    update tbl_dept_brand set brand_nm_1st='ㅁ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='마' and substr(brand_nm,0,1)<'바';
    update tbl_dept_brand set brand_nm_1st='ㅂ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='바' and substr(brand_nm,0,1)<'사';
    update tbl_dept_brand set brand_nm_1st='ㅅ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='사' and substr(brand_nm,0,1)<'아';
    update tbl_dept_brand set brand_nm_1st='ㅇ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='아' and substr(brand_nm,0,1)<'자';
    update tbl_dept_brand set brand_nm_1st='ㅈ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='자' and substr(brand_nm,0,1)<'차';
    update tbl_dept_brand set brand_nm_1st='ㅊ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='차' and substr(brand_nm,0,1)<'카';
    update tbl_dept_brand set brand_nm_1st='ㅋ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='카' and substr(brand_nm,0,1)<'타';
    update tbl_dept_brand set brand_nm_1st='ㅌ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='타' and substr(brand_nm,0,1)<'파';
    update tbl_dept_brand set brand_nm_1st='ㅍ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='파' and substr(brand_nm,0,1)<'하';
    update tbl_dept_brand set brand_nm_1st='ㅎ' where del_yn='Y' and brand_nm_1st='1' and substr(brand_nm,0,1)>='하' and substr(brand_nm,0,1)<'힘힘힘';
    update tbl_dept_brand set brand_nm_1st='ㅅ' where del_yn='Y' and brand_nm_1st='1' and brand_nm='??';

    update tbl_dept_brand set del_yn='N' where del_yn='Y';

    --분류 테이블에 등록 안된 데이터 처리
    insert into tbl_dept_cate_brand (ca_code, brand_no)
    select ca_code, brand_no
    from (
    	select ca_code,(select brand_no from tbl_dept_brand where brand_nm=a.brand) brand_no
    	from (
    		select ca_code,brand
    		from tbl_goods
    		where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and modelno>0 and cateflag='1' and mallcnt>0 and minprice4>0
    			and brand is not null and brand<>'[불명]' and brand<>'[추가]' and brand<>'[호환업체]'
    		group by ca_code, brand
    	) a
    )
    where (ca_code, brand_no) not in (select ca_code,brand_no from tbl_dept_cate_brand);

    commit;

END UDP_DEPART_BRAND_REG;