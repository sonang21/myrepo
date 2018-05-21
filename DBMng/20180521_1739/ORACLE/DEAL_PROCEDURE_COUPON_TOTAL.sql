/* *************************************************************************
 * NAME : DEAL.COUPON_TOTAL
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-29 02:30:00
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_TOTAL" AS
BEGIN
 COUPON_CR_ALL('admin');
insert into XTMP_LOG(cont) values ('COUPON_CR_ALL');
commit;

 COUPON_HIT_RANK('YES');
insert into XTMP_LOG(cont) values ('COUPON_HIT_RANK');
commit;

 COUPON_RANK('YES');
insert into XTMP_LOG(cont) values ('COUPON_RANK');
commit;

 COUPON_BACK_END('YES');
insert into XTMP_LOG(cont) values ('COUPON_BACK_END');
commit;

 CATEGORY_SUM_ALL('admin');
insert into XTMP_LOG(cont) values ('CATEGORY_SUM_ALL');
commit;

END COUPON_TOTAL;
