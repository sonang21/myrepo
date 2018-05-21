/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_FACTORY_RENAME
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-16 09:32:54
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_FACTORY_RENAME" as
/*
 NGIT 수정 반영 - 김영원 20180426
*/
BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code
        from tbl_category
       where c_level = 1 
         and c_seqno > 0 
         and ca_code not in ('90','91','92','95') 
       order by ca_code;

    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        

          update TBL_GOODS_RE_FACTORY t 
             set new_modelnm = (select modelnm
                                  from tbl_goods a
                                 where a.modelno = t.modelno
                                   and a.ca_code like v_cate||'%'
                                   and instr(a.modelnm,',') > 0)
           where exists (select 1
                          from tbl_goods a 
                         where a.ca_code like v_cate||'%'
                           and a.modelno = t.modelno);
        
        end loop;
      close cur01;
    end;    
    commit;
END UDP_GOODS_FACTORY_RENAME;
