/* *************************************************************************
 * NAME : DBENURI.UDP_P_OPTION_COUNT
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 12:53:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_P_OPTION_COUNT" 
IS 
/*
 NGIT 체크 - 변경없음 김영원 20180502
*/
BEGIN 

    DELETE FROM TBL_PRICELIST_OPTION_COUNT WHERE regdate < to_char(sysdate-180,'yyyymmdd'); 
    COMMIT; 
  
    DELETE FROM TBL_PRICELIST_OPTION_COUNT WHERE regdate = to_char(sysdate-1,'yyyymmdd'); 
    COMMIT; 
  
    INSERT INTO TBL_PRICELIST_OPTION_COUNT (regdate,shop_code,ca_lcode,cnt) 
        select to_char(sysdate-1,'YYYYMMDD'), a.shop_Code , substr(ca_code,0,2), count(distinct b.pl_no) 
          from tbl_pricelist A, tbl_pricelist_option B
         where a.pl_no=b.pl_no
           and to_char(b.regdate,'YYYYMMDD') = to_char(sysdate-1,'YYYYMMDD')
         group by a.shop_code,substr(ca_code,0,2);
    COMMIT; 
 
END UDP_P_OPTION_COUNT;
