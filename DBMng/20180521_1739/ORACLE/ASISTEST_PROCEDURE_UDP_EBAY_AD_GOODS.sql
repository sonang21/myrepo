/* *************************************************************************
 * NAME : ASISTEST.UDP_EBAY_AD_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:20
 *        Modify: 2018-05-07 13:11:14
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_EBAY_AD_GOODS" 
(
  r_sqlcode out varchar2,
  r_sqlmsg out varchar2
)as
begin
  execute immediate ('truncate table TBL_EBAY_AD_GOODS_BAK');

  insert into TBL_EBAY_AD_GOODS_BAK (gd_cd
                                    ,spm_cd
                                    ,ins_dtm)
  select gd_cd
       , spm_cd
       , ins_dtm
    from TBL_EBAY_AD_GOODS
   ;

   delete TBL_EBAY_AD_GOODS;

   insert into TBL_EBAY_AD_GOODS(gd_cd
                                ,spm_cd
                                ,ins_dtm)
   select gd_cd
        , spm_cd
        , ins_dtm
     from TBL_EBAY_AD_GOODS_TMP;

  commit;

  r_sqlcode := SQLCODE;
  r_sqlmsg  := SQLERRM;

 exception
     when others then
       r_sqlcode := SQLCODE;
       r_sqlmsg  := SQLERRM;
       rollback;
end UDP_EBAY_AD_GOODS;