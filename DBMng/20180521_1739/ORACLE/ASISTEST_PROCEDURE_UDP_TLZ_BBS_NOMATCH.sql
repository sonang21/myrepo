/* *************************************************************************
 * NAME : ASISTEST.UDP_TLZ_BBS_NOMATCH
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:31
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_TLZ_BBS_NOMATCH" as
begin

  delete from TBL_GOODS_BBS_NOMATCH_SUM;

  insert into TBL_GOODS_BBS_NOMATCH_SUM (pl_no
                                        ,shop_code
                                        ,goodscode
                                        ,nomatch_cnt
                                        ,nomatch_avg
                                        )
  select b.pl_no,
         a.shop_code,
         a.goodscode,
         a.nomatch_cnt,
         a.nomatch_avg
    from (select /*+ parallel(4)*/
                 shop_code,
                 goodscode,
                 count(*)   nomatch_cnt,
                 round(avg(point),2) nomatch_avg
            from tbl_goods_bbs_nomatch
           group by shop_code,
                    goodscode) a,
         tbl_pricelist b
   where a.shop_code = b.shop_code
     and a.goodscode = b.goodscode
  ;
  commit;

  exception
    when others then
      dbms_output.put_line(SQLERRM);
      rollback;
end;