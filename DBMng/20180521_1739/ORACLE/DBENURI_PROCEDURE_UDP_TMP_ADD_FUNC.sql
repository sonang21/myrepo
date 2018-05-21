/* *************************************************************************
 * NAME : DBENURI.UDP_TMP_ADD_FUNC
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 13:19:09
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_TMP_ADD_FUNC" AS
/*
 NGIT 수정 반영 - 김영원 20180508
*/ 
BEGIN
  delete TBL_TMP_ADD_FUNC;
  COMMIT;
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 2 and c_seqno > 0;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          insert into TBL_TMP_ADD_FUNC 
          (select ca_code,modelno,ltrim(rtrim(add_func)) 
             from (select a.ca_code,a.modelno,replace(replace(REGEXP_REPLACE(substr(a.func,instr(a.func,'<추가 설명>'),length(a.func)),'<[^>]*>',''),chr(13),''),chr(10),'') as add_func  
                     from tbl_goods a, tbl_goods_sum b
                    where a.modelno = b.modelno
                      and a.ca_code like v_cate || '%'
                      and a.jobcode > '0'
                      and b.mallcnt > 0
                      and a.openexpectflag = '0'
                      and a.constrain = '1'
                      and instr(func,'<추가 설명>') > 0 
                      and b.popular is not null 
                    order by b.popular desc
                  )
            where rownum <= 300);
          COMMIT;
        end loop;
      close cur01;
    end;    
END UDP_TMP_ADD_FUNC;
