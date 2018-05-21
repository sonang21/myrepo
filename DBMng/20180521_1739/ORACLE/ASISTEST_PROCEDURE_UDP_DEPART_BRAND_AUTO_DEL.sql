/* *************************************************************************
 * NAME : ASISTEST.UDP_DEPART_BRAND_AUTO_DEL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_DEPART_BRAND_AUTO_DEL" as
BEGIN

--브랜드_분류 정보 삭제
delete from tbl_dept_cate_brand
where brand_no in (
           select brand_no from tbl_dept_brand where brand_nm not in (
                     select distinct(brand)
                     from tbl_goods
                     where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and cateflag='1' and mallcnt>0 and minprice4>0
           )
);

--베스트브랜드_관리용 삭제
delete from tbl_dept_brand_best_man
where brand_no in (
           select brand_no from tbl_dept_brand where brand_nm not in (
                     select distinct(brand)
                     from tbl_goods
                     where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and cateflag='1' and mallcnt>0 and minprice4>0
           )
);

--베스트브랜드_서비스용 삭제
delete from tbl_dept_brand_best
where brand_no in (
           select brand_no from tbl_dept_brand where brand_nm not in (
                     select distinct(brand)
                     from tbl_goods
                     where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and cateflag='1' and mallcnt>0 and minprice4>0
           )
);

--브랜드정보 삭제
delete from tbl_dept_brand
where brand_no in (
           select brand_no from tbl_dept_brand where brand_nm not in (
                     select distinct(brand)
                     from tbl_goods
                     where ca_lcode='86' and constrain in ('1','5') and jobcode>'0' and cateflag='1' and mallcnt>0 and minprice4>0
           )
);

EXCEPTION
     WHEN OTHERS THEN
        rollback;
        DBMS_OUTPUT.PUT_LINE('UDP_DEPART_BRAND_AUTO_DEL error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
END UDP_DEPART_BRAND_AUTO_DEL;