/* *************************************************************************
 * NAME : ASISTEST.UDP_TMP_ADD_FUNC
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_TMP_ADD_FUNC" AS 
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
          (select ca_code,modelno,ltrim(rtrim(add_func)) from (
          select ca_code,modelno,replace(replace(REGEXP_REPLACE(substr(func,instr(func,'<추가 설명>'),length(func)),'<[^>]*>',''),chr(13),''),chr(10),'') as add_func  from tbl_goods where ca_code like v_cate || '%' and ca_lcode = substr(v_cate,1,2)
          and jobcode > '0' and mallcnt > 0 and openexpectflag = '0' and constrain = '1' and cateflag = '0' and instr(func,'<추가 설명>') > 0 and popular is not null order by popular desc
          ) where rownum <= 300);
          COMMIT;
        end loop;
      close cur01;
    end;    
END UDP_TMP_ADD_FUNC;