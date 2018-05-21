/* *************************************************************************
 * NAME : DBENURI.PG_JOB_SCH_DAILY
 * TYPE : PACKAGE
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-03-28 18:50:01
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "DBENURI"."PG_JOB_SCH_DAILY" as
/******************************************************************************
**  Name: PG_JOB_SCH_DAILY
**  Desc: SCHEDULER JOB의 Daily 실행 관련        
**
**  Called by: DBMS_SCHEDULER.RUN_JOB
**
**  Parameters:
**     Input                        Output
**     ----------                   -----------
**                 
**
**  Example : 실행 예시 (exec UDP_DEL_WEEK_GOODS;)
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018-03-02    김 영원         기존 job_type => 'PLSQL_BLOCK' 이었던 Job의 SQL을 Package에 합쳐서 관리
******************************************************************************
*/

  /* Called by: SJ_D-0830_GOODS_RE_FACTORY */
  procedure GOODS_RE_FACTORY_P;

  /* Called by: SJ_D-0200_AUTHFLAG_HISTORY */
  procedure AUTHFLAG_HISTORY_P;

  /* Called by: SJ_D-0300_LIST_KEYWORD_ATTSUM */
  procedure LIST_KEYWORD_ATTSUM_P;

  /* Called by: SJ_D-0400_ENURIPC_GOODS_PV */
  procedure ENURIPC_GOODS_PV_P;

  /* Called by: SJ_D-0500_ENURIPC_LOG_DEL */
  procedure ENURIPC_LOG_DEL_P;

end PG_JOB_SCH_DAILY;

CREATE OR REPLACE PACKAGE BODY "DBENURI"."PG_JOB_SCH_DAILY" as

  procedure GOODS_RE_FACTORY_P
  is
  begin

    insert into TBL_GOODS_RE_FACTORY ( modelno
                                     , new_factory
                                     , new_brand
                                     , new_modelnm
                                     )
    select modelno
         , factory
         , brand
         , modelnm
      from TBL_GOODS
     where constrain = '5'
       and modelno not in (select modelno
                             from TBL_GOODS_RE_FACTORY)
    ;
    commit;

  end GOODS_RE_FACTORY_P;


  procedure AUTHFLAG_HISTORY_P
  is
  begin

    insert into TBL_AUTHFLAG_HISTORY ( reg_date
                                     , modelno
                                     , pl_no
                                     , goodscode
                                     )
    select to_char(sysdate,'YYYYMMDD')
         , modelno
         , pl_no
         , goodscode
      from TBL_PRICELIST
     where authflag = 'Y'
       and modelno > 0
       and pl_no not in (select pl_no
                            from TBL_FACTORY_CERTIFICATION
                            where status = 'Y')
    ;
    commit;

  end AUTHFLAG_HISTORY_P;


  procedure LIST_KEYWORD_ATTSUM_P
  is
  begin

    execute immediate 'truncate table TBL_LIST_KEYWORD_ATT_LOGSUM';

    insert into TBL_LIST_KEYWORD_ATT_LOGSUM ( specno
                                            , device_type
                                            , sum_cnt
                                            , gpno
                                            , gp_sum_cnt
                                            )
    select b.specno
         , nvl(device_type,'P') device_type
         , nvl(click_cnt,0) click_cnt 
         , b.gpno
         , 0 
      from (select specno
                 , nvl(device_type,'P') device_type 
                 , count(*) as click_cnt
              from TBL_LIST_KEYWORD_ATT_LOG
             where specno is not null
               and nvl(device_type,'P') = 'P'
             group by nvl(device_type,'P')
                    , specno 
           )a right outer join tbl_spec_group b on a.specno = b.specno 
    ;

    update TBL_LIST_KEYWORD_ATT_LOGSUM a 
       set gp_sum_cnt = (select sum(b.sum_cnt) 
                           from TBL_LIST_KEYWORD_ATT_LOGSUM b
                          where a.gpno = b.gpno
                            and a.device_type = b.device_type
                          group by b.gpno)
    ;

    execute immediate 'truncate table TBL_LIST_KEYWORD_ATT_LOGSUM_M';

    insert into TBL_LIST_KEYWORD_ATT_LOGSUM_M ( specno
                                              , device_type
                                              , sum_cnt
                                              , gpno
                                              , gp_sum_cnt
                                              )
    select b.specno
         , nvl(device_type,'M') device_type
         , nvl(click_cnt,0) click_cnt
         , b.gpno
         ,0 
    from (select specno
               , device_type
               , count(*) as click_cnt
            from TBL_LIST_KEYWORD_ATT_LOG
           where specno is not null
             and device_type = 'M'
           group by device_type
                  , specno 
         )a right outer join TBL_SPEC_GROUP b on a.specno = b.specno
    ;

    update TBL_LIST_KEYWORD_ATT_LOGSUM_M a
       set gp_sum_cnt = (select sum(b.sum_cnt)
                           from TBL_LIST_KEYWORD_ATT_LOGSUM_M b
                          where a.gpno = b.gpno
                            and a.device_type = b.device_type
                          group by b.gpno)
    ;
    commit;

  end LIST_KEYWORD_ATTSUM_P;


  procedure ENURIPC_GOODS_PV_P
  is
  begin

    update TBL_ENURIPC_GOODS_PV 
       set pv_cnt=pv_cnt + (select pv_cnt
                              from TBL_ENURIPC_GOODS_PV_DAILY
                             where sy_no = tbl_enuripc_goods_pv.sy_no
                               and pd_no = tbl_enuripc_goods_pv.pd_no
                               and ins_date >= to_char(sysdate-1, 'YYYY-MM-DD'))
     where (sy_no, pd_no) in (select sy_no, pd_no
                                from TBL_ENURIPC_GOODS_PV_DAILY
                               where ins_date >= to_char(sysdate-1, 'YYYY-MM-DD'))
    ;
    commit;

  end ENURIPC_GOODS_PV_P;


  procedure ENURIPC_LOG_DEL_P
  is
  begin

    delete TBL_ENURIPC_API_LOG
     where logdate < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_PARTNER_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_PRICE_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_COMPANY_PRICE_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_PRODUCT_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_PRODUCT_PILSU_B
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_GOODS_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_GOODS_PILSU_INFO_B
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_COMPANY_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_SUBGOODS_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_SUBGOODS_CHANGE_B
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    delete TBL_ENURIPC_SUBGOODS_TYPE_BAK
     where bak_date < to_char(sysdate-5, 'YYYYMMDDHHMISS')
    ;

    commit;

  end ENURIPC_LOG_DEL_P;

end PG_JOB_SCH_DAILY;
