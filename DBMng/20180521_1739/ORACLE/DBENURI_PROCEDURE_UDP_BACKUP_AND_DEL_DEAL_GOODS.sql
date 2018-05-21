/* *************************************************************************
 * NAME : DBENURI.UDP_BACKUP_AND_DEL_DEAL_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:02
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_BACKUP_AND_DEL_DEAL_GOODS" 
IS
 
BEGIN

 insert into deal_goods_history (select * from deal_goods where deal_idx not in (select deal_idx from deal_goods_history ));
 delete from deal_goods where end_at < sysdate - 10;
 COMMIT;

END UDP_BACKUP_AND_DEL_DEAL_GOODS;