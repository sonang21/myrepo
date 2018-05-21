/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_GROUP_CA_LIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_GROUP_CA_LIST" 
(ca_mcode IN VARCHAR2)
IS

tmp_start char(1);
delete_chk CHAR(1) := 'N';
 v_str     VARCHAR2(4000) := '';

BEGIN

    --SET SERVEROUTPUT ON 
    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......1');

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_GROUP_CA_LIST','START');
    COMMIT;

    --WHILE i < 3 LOOP
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......' || ca_mlists(i) ||'%');
    
    DELETE tbl_goods_group  WHERE ca_code like ca_mcode || '%';
    
    INSERT INTO tbl_goods_group (
        MODELNO_GROUP,CA_CODE,MODELNM,FACTORY,SUM_POPULAR,POPULAR,OPENEXPECTFLAG,SPEC,MINPRICE,MAXPRICE,MALLCNT,C_DATE,IMGCHK,RECOMMEND,KB_NUM,
        CONDINAME,FACTORY_ETC,RSIFLAG,RSIFLAG2,SUM_SALE_CNT,SALE_CNT,IMGCHK_ROLLING,HEIGHT,WEIGHT,SPEC_GROUP,GOODS_INFO,GOODS_INFO_DATE,KB_TITLE,
        INFO_POINT1,INFO_POINT2,INFO_POINT3,INFO_SUM_POINT,CA_LCODE,JOBCODE,CONSTRAIN,GOOGLE_FLAG,ecatalog_flag,ecatalog_url,P_PL_NO,P_IMGURL,P_IMGURLFLAG,
        MALLCNT3,MINPRICE2,MINPRICE3,MAXPRICE3,MINPRICE4,BBS_POINT,BBS_POINT_AVG,BBS_NUM
        )
    SELECT NVL(modelno_group,modelno) modelno_group,ca_code,min(modelnm) as modelnm, min(factory) as factory,max(sum_popular) as sum_popular,max(popular) as popular,
            min(openexpectflag) as openexpectflag,min(spec) as spec, min(minprice) as minprice, max(minprice) as maxprice,max(mallcnt) as mallcnt,
            min(c_date) as c_date,min(imgchk) as imgchk,max(recommend) as recommend,
            UDF_KB_CNT_GROUP(MIN(ca_code),MAX(modelno_group),MAX(box_modelnm),MAX(kb_num)) kb_num,
            max(condiname) as condiname,max(factory_etc) factory_etc,max(rsiflag) rsiflag ,
            MAX(rsiflag2) rsiflag2,NVL(max(sum_sale_cnt),0) as sum_sale_cnt,NVL(max(sale_cnt),0) as sale_cnt,
            NVL(MAX(imgchk_rolling),0) imgchk_rolling,NVL(MAX(height),0) height,
            --NVL(MAX(weight),999999) weight,
            CASE WHEN substr(ca_code,0,4)='0501' THEN NVL(MAX(weight),0) ELSE NVL(MAX(weight),999999) END weight,  
            MAX(spec_group) spec_group, CASE NVL(MAX(dbms_lob.GETLENGTH(goods_info)),0)WHEN 0 THEN '' ELSE '1' END as goods_info,
            to_char(MAX(goods_info_date),'yyyy-mm-dd') goods_info_date, MAX(kb_title) kb_title,AVG(info_point1) info_point1,
            AVG(info_point2) info_point2,AVG(info_point3) info_point3, NVL(AVG(info_sum_point),0) info_sum_point, 
            MAX(ca_lcode) ca_lcode,MAX(jobcode) jobcode,MAX(constrain) constrain,max(nvl(google_flag,0)) google_flag,
            MAX(ecatalog_flag) ecatalog_flag,MAX(ecatalog_url) ecatalog_url,MAX(P_PL_NO) P_PL_NO,MAX(P_IMGURL) P_IMGURL,MAX(P_IMGURLFLAG) P_IMGURLFLAG,
            MIN(MALLCNT3) MALLCNT3,MIN(MINPRICE2) MINPRICE2,MIN(MINPRICE3) MINPRICE3,MAX(MINPRICE3) MAXPRICE3,MIN(MINPRICE4) MINPRICE4,MAX(BBS_POINT) BBS_POINT,
            MAX(BBS_POINT_AVG) BBS_POINT_AVG,MAX(BBS_NUM) BBS_NUM
            FROM tbl_goods
    WHERE ca_code like ca_mcode || '%'
      AND jobcode > '0' AND constrain IN ('1','5') AND mallcnt > 0
      AND openexpectflag = '0'
      --AND modelno_group is not null
      and sum_popular is not null
    group by ca_code,NVL(modelno_group,modelno);
    
    COMMIT;
    --===============================================================================================================================================================
    FOR tmp_loop in (SELECT distinct ca_sub_code FROM TBL_GOODS_COPYCATE WHERE ca_code like ca_mcode || '%' AND ca_sub_code NOT LIKE ca_mcode || '%') LOOP 

        IF delete_chk = 'N' THEN
            DELETE tbl_goods_group  WHERE ca_code like tmp_loop.ca_sub_code || '%';
        END IF;

        INSERT INTO tbl_goods_group (
            MODELNO_GROUP,CA_CODE,MODELNM,FACTORY,SUM_POPULAR,POPULAR,OPENEXPECTFLAG,SPEC,MINPRICE,MAXPRICE,MALLCNT,C_DATE,IMGCHK,RECOMMEND,KB_NUM,
            CONDINAME,FACTORY_ETC,RSIFLAG,RSIFLAG2,SUM_SALE_CNT,SALE_CNT,IMGCHK_ROLLING,HEIGHT,WEIGHT,SPEC_GROUP,GOODS_INFO,GOODS_INFO_DATE,KB_TITLE,
            INFO_POINT1,INFO_POINT2,INFO_POINT3,INFO_SUM_POINT,CA_LCODE,JOBCODE,CONSTRAIN,GOOGLE_FLAG,ecatalog_flag,ecatalog_url,P_PL_NO,P_IMGURL,P_IMGURLFLAG,
            MALLCNT3,MINPRICE2,MINPRICE3,MAXPRICE3,MINPRICE4,BBS_POINT,BBS_POINT_AVG,BBS_NUM)
        SELECT NVL(modelno_group,modelno) modelno_group,ca_code,min(modelnm) as modelnm, min(factory) as factory,max(sum_popular) as sum_popular,max(popular) as popular,
                min(openexpectflag) as openexpectflag,min(spec) as spec, min(minprice) as minprice, max(minprice) as maxprice, max(mallcnt) as mallcnt,
                min(c_date) as c_date,min(imgchk) as imgchk,max(recommend) as recommend,
                UDF_KB_CNT_GROUP(MIN(ca_code),MAX(modelno_group),MAX(box_modelnm),MAX(kb_num)) kb_num,
                max(condiname) as condiname,max(factory_etc) factory_etc,max(rsiflag) rsiflag ,
                MAX(rsiflag2) rsiflag2,NVL(max(sum_sale_cnt),0) as sum_sale_cnt,NVL(max(sale_cnt),0) as sale_cnt,
                NVL(MAX(imgchk_rolling),0) imgchk_rolling,NVL(MAX(height),0) height,
                CASE WHEN substr(ca_code,0,4)='0501' THEN NVL(MAX(weight),0) ELSE NVL(MAX(weight),999999) END weight,  
                --NVL(MAX(weight),999999) weight,
                MAX(spec_group) spec_group, CASE NVL(MAX(dbms_lob.GETLENGTH(goods_info)),0)WHEN 0 THEN '' ELSE '1' END as goods_info,
                to_char(MAX(goods_info_date),'yyyy-mm-dd') goods_info_date, MAX(kb_title) kb_title,AVG(info_point1) info_point1,
                AVG(info_point2) info_point2,AVG(info_point3) info_point3, NVL(AVG(info_sum_point),0) info_sum_point, 
                MAX(ca_lcode) ca_lcode,MAX(jobcode) jobcode,MAX(constrain) constrain,max(nvl(google_flag,0)) google_flag,
                MAX(ecatalog_flag) ecatalog_flag,MAX(ecatalog_url) ecatalog_url,MAX(P_PL_NO) P_PL_NO,MAX(P_IMGURL) P_IMGURL,MAX(P_IMGURLFLAG) P_IMGURLFLAG,
                MIN(MALLCNT3) MALLCNT3,MIN(MINPRICE2) MINPRICE2,MIN(MINPRICE3) MINPRICE3,MAX(MINPRICE3) MAXPRICE3,MIN(MINPRICE4) MINPRICE4,MAX(BBS_POINT) BBS_POINT,
                MAX(BBS_POINT_AVG) BBS_POINT_AVG,MAX(BBS_NUM) BBS_NUM
                FROM tbl_goods
        WHERE ca_code like tmp_loop.ca_sub_code || '%'
          AND jobcode > '0' AND constrain IN ('1','5') AND mallcnt > 0
          AND openexpectflag = '0'
          --AND modelno_group is not null
          and sum_popular is not null
        group by ca_code,NVL(modelno_group,modelno);
        
        COMMIT;
        
    END LOOP;
        
    COMMIT;
    
    v_str := 'analyze table tbl_goods_group COMPUTE STATISTICS';
    EXECUTE IMMEDIATE v_str;
    
    v_str := 'analyze index IDX_GOODS_GROUP_FULL COMPUTE STATISTICS';
    EXECUTE IMMEDIATE v_str;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_GROUP_CA_LIST','END');
    COMMIT;    
    
END UDP_GOODS_GROUP_CA_LIST;