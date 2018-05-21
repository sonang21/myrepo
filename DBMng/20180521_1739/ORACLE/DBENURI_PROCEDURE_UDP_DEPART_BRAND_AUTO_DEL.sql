/* *************************************************************************
 * NAME : DBENURI.UDP_DEPART_BRAND_AUTO_DEL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-21 10:54:21
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEPART_BRAND_AUTO_DEL" as
/*
 NGIT 수정 반영 - 김영원 20180425
*/ 
  l_err_code varchar2(10);
BEGIN

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_DEPART_BRAND_AUTO_DEL','START');
  commit;

  insert into TBL_DEPT_TMP_BRAND_DEL
  select brand_no
    from TBL_DEPT_BRAND
   where brand_nm not in (select distinct(brand)
                           from TBL_GOODS a, TBL_GOODS_SUM b, TBL_CATE_GOODS c
                          where a.modelno = b.modelno
                            and a.modelno = c.modelno
                            and c.ca_code like '86%'
                            and a.constrain in ('1','5') 
                            and a.jobcode>'0' 
                            and c.cateflag='1' 
                            and b.mallcnt>0 
                            and b.minprice4>0)
  ;

  --브랜드_분류 정보 삭제
  delete from TBL_DEPT_CATE_BRAND
  where brand_no in (select brand_no
                       from TBL_DEPT_TMP_BRAND_DEL)
  ;

  --베스트브랜드_관리용 삭제
  delete from TBL_DEPT_BRAND_BEST_MAN
  where brand_no in (select brand_no
                       from TBL_DEPT_TMP_BRAND_DEL)
  ;

  --베스트브랜드_서비스용 삭제
  delete from TBL_DEPT_BRAND_BEST
  where brand_no in (select brand_no
                       from TBL_DEPT_TMP_BRAND_DEL)
  ;

  --브랜드정보 삭제
  delete from TBL_DEPT_BRAND
  where brand_no in (select brand_no
                       from TBL_DEPT_TMP_BRAND_DEL);
  commit;

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_DEPART_BRAND_AUTO_DEL','END');
  commit;

EXCEPTION
   WHEN OTHERS THEN
     rollback;
     l_err_code := SQLCODE||'';
     DBMS_OUTPUT.PUT_LINE('UDP_DEPART_BRAND_AUTO_DEL error : errorcode => ' || SQLCODE || ', ERRMSG => ' || SQLERRM);
     insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_DEPART_BRAND_AUTO_DEL',l_err_code);
     commit;
END UDP_DEPART_BRAND_AUTO_DEL;
