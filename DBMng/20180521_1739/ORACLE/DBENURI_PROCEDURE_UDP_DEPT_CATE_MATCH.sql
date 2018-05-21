/* *************************************************************************
 * NAME : DBENURI.UDP_DEPT_CATE_MATCH
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 14:04:32
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_DEPT_CATE_MATCH" AS
/*
 NGIT 수정 반영 - 김영원 20180425
*/ 
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 2 and c_seqno > 0 and ca_code1 <> '86' order by ca_code;
    begin
      delete tbl_departcate_from_lp;
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          insert into tbl_departcate_from_lp (ca_code, depart_ca_code)
          (select  v_cate ,cc.ca_code
             from tbl_cate_goods cc
            where modelno in ( select a.modelno
                                 from tbl_goods a, tbl_goods_sum b, tbl_cate_goods c
                                where a.modelno = b.modelno and a.modelno = c.modelno 
                                  AND c.ca_code like v_cate || '%'
                                  AND a.constrain IN ('1','5')
                                  AND a.jobcode>'0'
                                  AND (b.mallcnt>0 OR b.mallcnt3>0)
                                  AND a.openexpectflag='0' ) 
              and cc.ca_code like '86%'
            group by cc.ca_code);
        end loop;
      close cur01;
    end;    
   commit;
END UDP_DEPT_CATE_MATCH;
