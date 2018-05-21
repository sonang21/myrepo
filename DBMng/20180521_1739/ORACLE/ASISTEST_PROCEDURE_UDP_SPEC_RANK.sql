/* *************************************************************************
 * NAME : ASISTEST.UDP_SPEC_RANK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-07 13:11:15
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SPEC_RANK" AS 

BEGIN

  declare
   v_cate varchar2(12);
    cursor cur01 is
      select ca_code from tbl_category where c_level = 2 and c_seqno > 0 order by ca_code;
      begin

        open cur01;
          loop
            fetch cur01      
            into v_cate;
            if cur01%notfound
              then
              exit;
            end if;        
            DELETE TBL_CATE_SPEC_RANK WHERE CA_CODE = v_cate;
            insert into TBL_CATE_SPEC_RANK (
              select v_cate,gpno,sum_click,rownum rank from (
               select gpno,sum(click_cnt) as sum_click  from 
                (select specno,count(*) as click_cnt from TBL_LIST_KEYWORD_ATT_LOG where ATT_TYPE = 'S' and reg_date >= sysdate-30 and ca_code like v_cate || '%' group by specno ) A ,
                (SELECT A.GPNO , A.TITLE, A.CATE,C.SPECNO SPEC_GROUP_SPECNO ,C.title
                FROM TBL_SPEC_CATE A,TBL_SPEC_CATEDETAIL B, TBL_SPEC_GROUP C WHERE A.CATE = v_cate AND A.GPNO = B.GPNO 
                AND B.GPSNO = C.GPSNO AND B.GPNO = C.GPNO AND A.DELFLAG='0' AND B.DELFLAG <> '2' AND C.DELFLAG <> '2'  
                ) B 
                where A.specno = B.SPEC_GROUP_SPECNO 
               group by gpno
               order by sum(click_cnt) desc )
            );
            commit;
          end loop;
        close cur01;
        
      end;
      
    declare
    v_cate2 varchar2(12);
    cursor cur02 is
      select ca_code from tbl_category where c_level = 3 and c_seqno > 0 order by ca_code;
      begin

        open cur02;
          loop
            fetch cur02      
            into v_cate2;
            if cur02%notfound
              then
              exit;
            end if;        
            DELETE TBL_CATE_SPEC_RANK WHERE CA_CODE = v_cate2;
            insert into TBL_CATE_SPEC_RANK (
              select v_cate2,gpno,sum_click,rownum rank from (
               select gpno,sum(click_cnt) as sum_click  from 
                (select specno,count(*) as click_cnt from TBL_LIST_KEYWORD_ATT_LOG where ATT_TYPE = 'S' and reg_date >= sysdate-30 and ca_code like v_cate2 || '%' group by specno ) A ,
                (SELECT A.GPNO , A.TITLE, A.CATE,C.SPECNO SPEC_GROUP_SPECNO ,C.title
                FROM TBL_SPEC_CATE A,TBL_SPEC_CATEDETAIL B, TBL_SPEC_GROUP C WHERE A.CATE = substr(v_cate2,0,4) AND A.GPNO = B.GPNO 
                AND B.GPSNO = C.GPSNO AND B.GPNO = C.GPNO AND A.DELFLAG='0' AND B.DELFLAG <> '2' AND C.DELFLAG <> '2'  
                ) B 
                where A.specno = B.SPEC_GROUP_SPECNO 
               group by gpno
               order by sum(click_cnt) desc )
            );
            commit;
          end loop;
        close cur02;
      end;
      
      if (sqlcode < 0) then
        DBMS_OUTPUT.PUT_LINE( SQLERRM );
        rollback;
      else
        commit;
      end if;      
      EXCEPTION
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( SQLERRM );
        rollback;      
      
END UDP_SPEC_RANK;