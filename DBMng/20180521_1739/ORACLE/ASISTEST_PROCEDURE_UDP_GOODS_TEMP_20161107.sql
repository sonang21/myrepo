/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_TEMP_20161107
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_TEMP_20161107" AS 

BEGIN
  declare
   v_cate varchar2(12);

    cursor cur01 is
      select ca_code from tbl_category where c_seqno > 0 and c_level = 1  order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;
          insert into TBL_GOODS_TEMP_20161107 
          select ca_code,modelno,MODELNO_GROUP,POPULAR,SUM_POPULAR,MALLCNT,IMGCHK from tbl_goods where modelno_group in 
          (
          select modelno_group from (
          select modelno_group,min(imgchk) as min_imgchk , max(imgchk) as max_imgchk from tbl_goods where jobcode > '0' AND constrain in (1,5) AND mallcnt > 0 AND modelno_group is not null
          and ca_lcode = v_cate
          group by modelno_group
          ) where min_imgchk <> max_imgchk
          ) and ca_lcode = v_cate;
          commit;
        end loop;
      close cur01;
    end;

END UDP_GOODS_TEMP_20161107;