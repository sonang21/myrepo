/* *************************************************************************
 * NAME : ASISTEST.UDP_WEBB_GOODSCODE_DEL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_WEBB_GOODSCODE_DEL" (EnterCode IN NUMBER)
IS
    chkplno NUMBER := 0;
begin
    FOR tmp in (
            SELECT distinct goodscode, nvl(modelno,0) as modelno
            FROM tbl_pricelist
            WHERE shop_code = 4027
            group by goodscode,nvl(modelno,0)
            having count(goodscode) > 1
            order by goodscode,nvl(modelno,0)
            ) LOOP

        select pl_no into chkplno from(
 select pl_no
        from tbl_pricelist
        where shop_code = 4027
            and goodscode = tmp.goodscode
            and nvl(modelno,0) = tmp.modelno
        order by status asc, goodsnm desc)
 where rownum=1;

        delete tbl_pricelist
        where shop_code = 4027
            and goodscode = tmp.goodscode
            and nvl(modelno,0) = tmp.modelno
            and pl_no <> chkplno;

        commit;

    END LOOP;

END UDP_WEBB_GOODSCODE_DEL;