/* *************************************************************************
 * NAME : DBENURI.UDP_WEBB_GOODSCODE_DEL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 13:24:19
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_WEBB_GOODSCODE_DEL" (EnterCode IN NUMBER)
IS
    chkplno NUMBER := 0;
begin
    FOR tmp in (
            select distinct goodscode, nvl(modelno,0) as modelno
              from tbl_pricelist
             where shop_code = 4027
             group by goodscode,nvl(modelno,0)
            having count(goodscode) > 1
             order by goodscode,nvl(modelno,0))
    LOOP

        select pl_no
          into chkplno
          from (select pl_no
                  from tbl_pricelist
                 where shop_code = 4027
                   and goodscode = tmp.goodscode
                   and nvl(modelno,0) = tmp.modelno
                 order by status asc, 
                          goodsnm desc)
         where rownum=1;

        delete tbl_pricelist
         where shop_code = 4027
           and goodscode = tmp.goodscode
           and nvl(modelno,0) = tmp.modelno
           and pl_no <> chkplno;

        commit;

    END LOOP;

END UDP_WEBB_GOODSCODE_DEL;
 
