/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_MODELNM
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-16 10:00:54
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_MODELNM" AS
/*
 NGIT ¼öÁ¤ ¹Ý¿µ - ±è¿µ¿ø 20180426
*/
BEGIN

  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 2 and c_seqno > 0 order by ca_code;
      begin
        delete TBL_GOODS_MODELNM_TMP;
        commit;
        open cur01;
          loop
            fetch cur01      
            into v_cate;
            if cur01%notfound
              then
              exit;
            end if;        

            insert into TBL_GOODS_MODELNM_TMP (
              select a.modelno,
                     a.ca_code,
                     a.modelnm,
                     replace(regexp_replace(Regexp_replace(trim(lower(nvl(modelnm,''))),'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),'[[:space:]]{1,}',' ') ,regexp_replace(condiname,'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),''),
                     replace(trim(lower(brand)),'[ºÒ¸í]','') || replace(regexp_replace(Regexp_replace(trim(lower(modelnm)),'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),'[[:space:]]{1,}',' ') ,regexp_replace(condiname,'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),''),
                     b.popular,
                     a.constrain
                from TBL_GOODS a, TBL_GOODS_SUM b
               where a.modelno = b.modelno
                 and a.modelno > 0
                 and a.ca_code like v_cate || '%'
                 and a.jobcode > '0'
                 and b.mallcnt > 0
            );
            commit;
          end loop;
        close cur01;
      end;
      
      delete TBL_GOODS_MODELNM;

      insert into TBL_GOODS_MODELNM (select * from TBL_GOODS_MODELNM_TMP);
      
      if (sqlcode < 0) then
        DBMS_OUTPUT.PUT_LINE( SQLERRM );
        rollback;
      else
        commit;
      end if;

EXCEPTION
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( SQLERRM );
    rollback;      

END UDP_GOODS_MODELNM;
