/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_MODELNM
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_MODELNM" AS 

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
            --dbms_output.put_line('cate :' || v_cate);
            --delete TBL_GOODS_MODELNM where ca_code like v_cate || '%';
            insert into TBL_GOODS_MODELNM_TMP (
              select 
                modelno,
                ca_code,
                modelnm,
                replace(regexp_replace(Regexp_replace(trim(lower(nvl(modelnm,''))),'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),'[[:space:]]{1,}',' ') ,regexp_replace(condiname,'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),''),
                replace(trim(lower(brand)),'[ºÒ¸í]','') || replace(regexp_replace(Regexp_replace(trim(lower(modelnm)),'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),'[[:space:]]{1,}',' ') ,regexp_replace(condiname,'[^a-z,A-Z,0-9,¤¡-¤¾,°¡-Èú]',''),''),
                popular,
                constrain
              from tbl_goods where modelno > 0 and  ca_code like v_cate || '%' and ca_lcode = substr(v_cate,1,2) and cateflag = '0' and jobcode > '0' and mallcnt > 0
            );
            commit;
          end loop;
        close cur01;
      end;
      
      dbms_output.put_line(to_char(sysdate,'yyyymmddhhmiss'));
      delete TBL_GOODS_MODELNM;
      dbms_output.put_line(to_char(sysdate,'yyyymmddhhmiss'));
      insert into TBL_GOODS_MODELNM (select * from TBL_GOODS_MODELNM_TMP);
      dbms_output.put_line(to_char(sysdate,'yyyymmddhhmiss'));
      
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