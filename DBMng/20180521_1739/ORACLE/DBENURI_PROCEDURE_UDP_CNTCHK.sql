/* *************************************************************************
 * NAME : DBENURI.UDP_CNTCHK
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-21 10:42:56
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CNTCHK" 
is
/******************************************************************************
**  Name: UDP_CNTCHK
**  Desc: DB SERVER CRONTAB 에서 AM 03:00에 호출되는 프로시져 중 하나
**
**  Called by: DB SERVER CRONTAB /oracle/schedule/cpc_main.sh
**
**  Parameters:
**     Input                        Output
**     ----------                   -----------
**
**
**  Example : 실행 예시 (exec UDP_CNTCHK;)
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018-05-17    김 영원         잦은 ORA-01555 오류로 프로시저 전체 수정
**                                 NGIT 반영 수정
******************************************************************************
*/
  l_sql varchar2(4000);
  l_err_code varchar2(10);
begin

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_CNTCHK','START');
  commit;

  begin
    execute immediate ('drop table TMPTBL_PNG purge');
  exception
    when others then
      if sqlcode != -942 then
        raise;
      end if;
  end;

  begin
    execute immediate ('drop table TMPTBL_SNP purge');
  exception
    when others then
      if sqlcode != -942 then
        raise;
      end if;
  end;

  l_sql := 'CREATE TABLE TMPTBL_PNG AS
            SELECT /*+ full(a) parallel(a 2) full(b) parallel(b 2) full(c) parallel(c 2) full(p) parallel(p 8) */
                   shop_code,
                   count(distinct
                         case
                           when a.jobcode <> to_char(0) and
                                a.constrain in (to_char(1),to_char(5)) and
                                c.cateflag = to_char(0) and
                                p.srvflag = to_char(0) then
                             a.modelno
                          end) pl_srvcnt,
                   count(case
                           when a.jobcode <> to_char(0) and
                                a.constrain in (to_char(1),to_char(5)) and
                                c.cateflag = to_char(0) and
                                p.srvflag = to_char(0) then
                             p.pl_no
                          end) pl_shopsrvcnt,
                 count(distinct
                       case
                         when a.jobcode <> to_char(0) and
                              b.mallcnt > 0 and
                             (a.constrain = to_char(0) or p.srvflag <> to_char(0)) then
                           a.modelno
                       end) pl_nosrvcnt,
                   count(case
                           when c.cateflag = to_char(0) and
                                p.srvflag = to_char(0) and
                                a.modelno > 0 and
                                p.price = b.minprice then
                             a.modelno
                         end) pl_minpricecnt,
                   count(distinct
                         case
                           when c.cateflag = to_char(0) and
                                p.srvflag = to_char(0) and
                                p.modelno > 0 and
                                p.price = b.minprice then
                             a.modelno
                         end) pl_minpricecnt2,
                   count(distinct
                         case
                           when c.cateflag = to_char(0) and
                                p.srvflag = to_char(0) and
                                p.modelno > 0 and
                                b.mallcnt > 1 and
                                p.price = b.minprice then
                             a.modelno
                         end) pl_minpricecnt3
              FROM TBL_GOODS a,
                   TBL_GOODS_SUM b,
                   TBL_CATE_GOODS c,
                   TBL_PRICELIST p
             WHERE 1=1
               AND a.modelno = b.modelno
               AND a.modelno = c.modelno
               AND a.modelno = p.modelno
               AND p.status < to_char(3)
               AND c.ca_code not like to_char(93)||''%''
             GROUP BY p.shop_code
           ';

  dbms_output.put_line(l_sql);
  execute immediate (l_sql);

  l_sql := 'CREATE TABLE TMPTBL_SNP AS
            SELECT /*+ full(p) parallel(p 8)*/
                   s.shop_code,
                   s.shop_name,
                   s.apflag,
                   s.service,
                   s.grade,
                   count(*) as pl_allcnt,
                   count(case
                           when nvl(p.esstockflag, to_char(0)) != to_char(1) and
                                p.modelno < 1 then
                             p.pl_no
                         end) as pl_preregcnt
              FROM TBL_SHOPLIST s, TBL_PRICELIST p
             WHERE s.shop_code = p.shop_code
               AND p.status < to_char(3)
               AND substr(p.ca_code,0,2) <> to_char(93)
             GROUP BY  s.shop_code,
                       s.shop_name,
                       s.apflag,
                       s.service,
                       s.grade
           ';

  dbms_output.put_line(l_sql);
  execute immediate (l_sql);

  insert into TBL_PRICELIST_STATIC
  select pl_static_seq.nextval,
         a.shop_code,
         a.shop_name,
         a.pl_allcnt,
         s.pl_srvcnt,
         a.apflag,
         a.service,
         a.grade,
         g.unit,
         sysdate,
         s.pl_shopsrvcnt ,
         s.pl_nosrvcnt ,
         s.pl_minpricecnt ,
         a.pl_preregcnt,
         0,
         0,
         0,
         s.pl_minpricecnt2,
         s.pl_minpricecnt3
    from TMPTBL_SNP a, TMPTBL_PNG s, TBL_SDU_GRADE g
   where a.shop_code = s.shop_code(+)
     and a.grade = g.grade(+)
  ;

  commit;

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_CNTCHK','END');
  commit;

exception
  when others then
    l_err_code := ''||SQLCODE;
    insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_CNTCHK',l_err_code);
    commit;

end UDP_CNTCHK;
