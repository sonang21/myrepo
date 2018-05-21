/* *************************************************************************
 * NAME : ASISTEST.UDP_SCATE_SPEC_INFO_TEST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:30
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SCATE_SPEC_INFO_TEST" AS 

BEGIN
  declare
   v_cate varchar2(12);
    cursor cur01 is
      select distinct ca_code from (
      select ca_code from tbl_category where c_level = 3 and c_seqno > 0 
      union all
      select CA_SUB_CODE as ca_code from tbl_category, tbl_goods_copycate where c_level = 3 and c_seqno > 0  and tbl_category.ca_code = tbl_goods_copycate.ca_code
      ) order by ca_code;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          insert into tbl_scate_spec_info_tmp2 (SEARCH_CA_CODE,GPNO,GPSNO,SPEC_GROUP_SPECNO,SPEC_CATE_TITLE,COMMENTS,SPEC_CATE_AOFLAG,SPEC_CATE_DELFLAG,CATE,CATE_KB_NO,
          SPEC_CATEDETAIL_TITLE,SPEC_CATEDETAIL_AOFLAG,SPEC_CATEDETAIL_DELFLAG,
          SPEC_GROUP_TITLE, SPEC_GROUP_DELFLAG,CA_CODE,CA_CODE_DETAIL,
          GROUP_NAME,STAIR_FLAG,HEIGHT,ISLEFTRIGHT,WIDTH,KB_NO,SPEC_CATE_SORTNO,SPEC_DETAIL_SORTNO,SPEC_GROUP_SORTNO) 
            SELECT v_cate,A.GPNO ,B.GPSNO,C.SPECNO SPEC_GROUP_SPECNO, A.TITLE SPEC_CATE_TITLE, A.COMMENTS, A.AOFLAG SPEC_CATE_AOFLAG, A.DELFLAG SPEC_CATE_DELFLAG,A.CATE,A.KB_NO CATE_KB_NO, 
            B.TITLE SPEC_CATEDETAIL_TITLE,B.AOFLAG SPEC_CATEDETAIL_AOFLAG,B.DELFLAG SPEC_CATEDETAIL_DELFLAG,
            C.TITLE SPEC_GROUP_TITLE,C.DELFLAG SPEC_GROUP_DELFLAG ,C.CA_CODE CA_CODE,B.CA_CODE CA_CODE_DETAIL,
            A.GROUP_NAME, A.STAIR_FLAG, A.HEIGHT, C.ISLEFTRIGHT, C.WIDTH  ,C.KB_NO, A.SORTNO  , B.SORTNO,  C.SORTNO 
            FROM TBL_SPEC_CATE A,TBL_SPEC_CATEDETAIL B, TBL_SPEC_GROUP C WHERE A.CATE = substr(v_cate,1,4) AND A.GPNO = B.GPNO
            AND B.GPSNO = C.GPSNO AND B.GPNO = C.GPNO AND A.DELFLAG='0' AND B.DELFLAG !='2' AND C.DELFLAG != '2'  
            AND (C.SPECNO IN 
            (select SPECNO from tbl_modelno_spec where modelno in (select modelno from tbl_goods where ca_code like v_cate || '%' and ca_lcode = substr(v_cate,1,2)  and  constrain in ('1','5') and jobcode > '0' and mallcnt > 0 )) 
            OR C.DELFLAG = '9')
            ORDER BY A.SORTNO , B.SORTNO,C.SORTNO;
          commit;
        end loop;
      close cur01;
    end;
    declare
    v_search_cate VARCHAR2(12) := '';
    v_gpno    NUMBER(10) := 0;
    v_gpsno    NUMBER(10) := 0;
    v_specno    NUMBER(10) := 0;
    v_spec_cate_title VARCHAR2(50) := '';
    v_spec_group_title VARCHAR2(50) := '';
    v_spec_del_flag    CHAR(1) := '';
    
    v_prv_search_cate VARCHAR2(12) := '';
    v_prv_gpno    NUMBER(10) := 0;
    v_prv_gpsno    NUMBER(10) := 0;
    v_prv_specno    NUMBER(10) := 0;
    v_prv_spec_cate_title VARCHAR2(50) := '';
    v_prv_spec_group_title VARCHAR2(50) := '';
    v_prv_spec_del_flag    CHAR(1) := '';    
    cursor cur02 is
    select search_ca_code,gpno,gpsno,spec_group_specno,spec_cate_title,spec_group_title,spec_group_delflag from tbl_scate_spec_info_tmp2
      order by search_ca_code, spec_cate_sortno,spec_detail_sortno,spec_group_sortno;
      begin
        open cur02;
          loop
            fetch cur02      
            into v_search_cate,v_gpno,v_gpsno,v_specno,v_spec_cate_title,v_spec_group_title,v_spec_del_flag;
            if cur02%notfound
              then
              exit;
            end if;  
            IF (v_spec_del_flag = '9' and v_spec_group_title <> 'blank') THEN
              IF (v_prv_spec_del_flag = '9' and v_prv_spec_group_title <> 'blank') then
                delete tbl_scate_spec_info_tmp2 where search_ca_code = v_prv_search_cate and gpno = v_prv_gpno and gpsno = v_prv_gpsno and spec_group_specno = v_prv_specno;
              END IF;
            ELSIF ((v_spec_del_flag = '0' and v_prv_spec_del_flag = '9') and (v_prv_search_cate <> v_search_cate or v_prv_gpno <> v_gpno or v_prv_gpsno <> v_gpsno) and v_prv_spec_group_title <> 'blank') then
                delete tbl_scate_spec_info_tmp2 where search_ca_code = v_prv_search_cate and gpno = v_prv_gpno and gpsno = v_prv_gpsno and spec_group_specno = v_prv_specno;              
            END IF;
            v_prv_spec_del_flag := v_spec_del_flag;
            v_prv_gpno := v_gpno;
            v_prv_gpsno := v_gpsno;
            v_prv_specno := v_specno;
            v_prv_search_cate := v_search_cate;           
            v_prv_spec_group_title := v_spec_group_title;           
          end loop;
        close cur02; 
      end;    
      commit;

      if (sqlcode < 0) then
        rollback;
      else
        commit;
      end if;      
      EXCEPTION
        WHEN OTHERS THEN 
        rollback;      
      
END UDP_SCATE_SPEC_INFO_TEST;