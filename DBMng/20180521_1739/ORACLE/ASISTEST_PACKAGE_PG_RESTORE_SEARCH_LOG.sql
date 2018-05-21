/* *************************************************************************
 * NAME : ASISTEST.PG_RESTORE_SEARCH_LOG
 * TYPE : PACKAGE
 * TIME : Create: 2018-05-04 18:33:38
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "ASISTEST"."PG_RESTORE_SEARCH_LOG" as
/******************************************************************************
**  Name: PG_RESTORE_SEARCH_LOG
**  Desc: SCHEDULER JOB의 추가색인 관련
**  검색엔진에서 전체색인 후 첫번째 추가색인까지 데이터가 많이 쌓여있어 첫번째 추가색인에 부하가 많이 걸려
**  첫번재 추가색인의 데이터를 6등분 하여 이후 추가색인으로 분산하기 위한 스케쥴
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

  /* Called by:  */
  procedure MOVE_SEARCH_LOG_P;

  /* Called by:  */
  procedure RESTORE_SEARCH_LOG_P( p_num in number );

end PG_RESTORE_SEARCH_LOG;
CREATE OR REPLACE PACKAGE BODY "ASISTEST"."PG_RESTORE_SEARCH_LOG" as

  procedure MOVE_SEARCH_LOG_P
  is
  begin
    execute immediate 'truncate table TBL_SEARCH_LOG_PART';

    insert into TBL_SEARCH_LOG_PART ( search_key
                                    , modelno
                                    , group_flag
                                    , category
                                    , modelnm
                                    , shop_code
                                    , factory
                                    , popular
                                    , minprice
                                    , maxprice
                                    , minprices
                                    , c_date
                                    , mallcnt
                                    , spec
                                    , openexpectflag
                                    , condiname
                                    , keyword1
                                    , keyword2
                                    , brandcode1
                                    , brandcode2
                                    , specopt
                                    , service_flag
                                    , status
                                    , regdate
                                    , ca_code
                                    , pl_no
                                    , sale_cnt
                                    , bookflag
                                    , useflag
                                    , popular2
                                    , modelnm2
                                    , weight
                                    , sc_web
                                    , sc_mobile
                                    , store_flag
                                    , minprice4
                                    , brand
                                    , ca_dept_code
                                    , minprice3
                                    , goodsbrand
                                    , maxprice3
                                    , bbs_num
                                    , minprice2
                                    , ext_condi_flag
                                    )
    select search_key
         , modelno
         , group_flag
         , category
         , modelnm
         , shop_code
         , factory
         , popular
         , minprice
         , maxprice
         , minprices
         , c_date
         , mallcnt
         , spec
         , openexpectflag
         , condiname
         , keyword1
         , keyword2
         , brandcode1
         , brandcode2
         , specopt
         , service_flag
         , status
         , regdate
         , ca_code
         , pl_no
         , sale_cnt
         , bookflag
         , useflag
         , popular2
         , modelnm2
         , weight
         , sc_web
         , sc_mobile
         , store_flag
         , minprice4
         , brand
         , ca_dept_code
         , minprice3
         , goodsbrand
         , maxprice3
         , bbs_num
         , minprice2
         , ext_condi_flag 
     from (select rownum num
                , iiv.*
             from (select search_key
                        , modelno
                        , group_flag
                        , category
                        , modelnm
                        , shop_code
                        , factory
                        , popular
                        , minprice
                        , maxprice
                        , minprices
                        , c_date
                        , mallcnt
                        , spec
                        , openexpectflag
                        , condiname
                        , keyword1
                        , keyword2
                        , brandcode1
                        , brandcode2
                        , specopt
                        , service_flag
                        , status
                        , regdate
                        , ca_code
                        , pl_no
                        , sale_cnt
                        , bookflag
                        , useflag
                        , popular2
                        , modelnm2
                        , weight
                        , sc_web
                        , sc_mobile
                        , store_flag
                        , minprice4
                        , brand
                        , ca_dept_code
                        , minprice3
                        , goodsbrand
                        , maxprice3
                        , bbs_num
                        , minprice2
                        , ext_condi_flag
                        , row_number() over(partition by search_key order by regdate desc) as rank
                     from TBL_SEARCH_LOG
                    order by regdate desc
                  ) iiv
            where iiv.rank = 1
           )iv
     where iv.num > 8000000
    ;

    delete TBL_SEARCH_LOG a
     where exists (select 1
                     from TBL_SEARCH_LOG_PART b 
                    where a.search_key = b.search_key)
    ;

    commit;

  end MOVE_SEARCH_LOG_P;


  procedure RESTORE_SEARCH_LOG_P ( p_num in number )
  is
  begin
    insert into TBL_SEARCH_LOG ( search_key
                               , modelno
                               , group_flag
                               , category
                               , modelnm
                               , shop_code
                               , factory
                               , popular
                               , minprice
                               , maxprice
                               , minprices
                               , c_date
                               , mallcnt
                               , spec
                               , openexpectflag
                               , condiname
                               , keyword1
                               , keyword2
                               , brandcode1
                               , brandcode2
                               , specopt
                               , service_flag
                               , status
                               , regdate
                               , ca_code
                               , pl_no
                               , sale_cnt
                               , bookflag
                               , useflag
                               , popular2
                               , modelnm2
                               , weight
                               , sc_web
                               , sc_mobile
                               , store_flag
                               , minprice4
                               , brand
                               , ca_dept_code
                               , minprice3
                               , goodsbrand
                               , maxprice3
                               , bbs_num
                               , minprice2
                               , ext_condi_flag
                               )
    select search_key
         , modelno
         , group_flag
         , category
         , modelnm
         , shop_code
         , factory
         , popular
         , minprice
         , maxprice
         , minprices
         , c_date
         , mallcnt
         , spec
         , openexpectflag
         , condiname
         , keyword1
         , keyword2
         , brandcode1
         , brandcode2
         , specopt
         , service_flag
         , status
         , regdate
         , ca_code
         , pl_no
         , sale_cnt
         , bookflag
         , useflag
         , popular2
         , modelnm2
         , weight
         , sc_web
         , sc_mobile
         , store_flag
         , minprice4
         , brand
         , ca_dept_code
         , minprice3
         , goodsbrand
         , maxprice3
         , bbs_num
         , minprice2
         , ext_condi_flag
      from TBL_SEARCH_LOG_PART
     where mod(case when service_flag = '1' then modelno else pl_no end, p_num ) = 0
    ;

    delete TBL_SEARCH_LOG_PART
     where mod(case when service_flag = '1' then modelno else pl_no end, p_num ) = 0
    ;

    commit;

  end RESTORE_SEARCH_LOG_P;

end PG_RESTORE_SEARCH_LOG;