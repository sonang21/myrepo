/* *************************************************************************
 * NAME : ASISTEST.UDP_UPDATE_IMGCHK2_5
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_UPDATE_IMGCHK2_5" AS 
BEGIN
  declare
   v_modelno number(8);
    cursor cur01 is
      select modelno from tmp_img5_goods;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_modelno;
          if cur01%notfound
            then
            exit;
          end if;  
          update tbl_goods set imgchk2 = '2' where modelno = v_modelno and not EXISTS (select modelno from tbl_goods where modelno = v_modelno and imgchk2 = '2');
          commit;

        end loop;
      close cur01;
    end;    

END UDP_UPDATE_IMGCHK2_5;