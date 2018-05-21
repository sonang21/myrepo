/* *************************************************************************
 * NAME : ASISTEST.UDP_GOODS_GROUP_LIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:25
 *        Modify: 2018-05-04 18:53:43
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_GOODS_GROUP_LIST" 
IS 
 
TYPE lists IS VARRAY(8) OF VARCHAR2(8); 
--ca_mlists lists := lists('0401','0209','1007','0212','0810','0501','1509','1501','1502','1505','2211'); 
ca_mlists lists := lists('0401','0209','0810','1509','1501','1502','1505','2211');
i           NUMBER(2) := 0; 
tmp_start   CHAR(1); 
delete_chk  CHAR(1) := 'N'; 
v_str       VARCHAR2(4000) := ''; 

v_cur_time  NUMBER(2) :=0; 
 
BEGIN 
    --SET SERVEROUTPUT ON  
    --DBMS_OUTPUT.ENABLE; 
    --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......1'); 
    
    --SYS LOG
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_GROUP_LIST','START');
    COMMIT;
    
    SELECT to_number(to_char(sysdate,'HH24')) INTO v_cur_time FROM dual;
    
    IF v_cur_time >= 7 AND v_cur_time <= 21 THEN
        
        SELECT substr(to_char(sysdate, 'HH24:MI:SS'),0,1)  INTO tmp_start FROM DUAL; 
        IF tmp_start = '7' THEN 
            DELETE tbl_goods_group; 
            delete_chk := 'Y'; 
        END IF; 
             
        FOR i IN ca_mlists.FIRST .. ca_mlists.LAST LOOP 
        --WHILE i < 3 LOOP 
        --DBMS_OUTPUT.PUT_LINE('UDP_GOODS_GROUP_LIST start ......' || ca_mlists(i) ||'%'); 
            IF delete_chk = 'N' THEN 
                DELETE tbl_goods_group  WHERE ca_code like ca_mlists(i) || '%'; 
            END IF; 
             
            INSERT INTO tbl_goods_group ( 
                MODELNO_GROUP,CA_CODE,MODELNM,FACTORY,SUM_POPULAR,POPULAR,OPENEXPECTFLAG,SPEC,MINPRICE,MAXPRICE,MALLCNT,C_DATE,IMGCHK,RECOMMEND,KB_NUM, 
                CONDINAME,FACTORY_ETC,RSIFLAG,RSIFLAG2,SUM_SALE_CNT,SALE_CNT,IMGCHK_ROLLING,HEIGHT,WEIGHT,SPEC_GROUP,GOODS_INFO,GOODS_INFO_DATE,KB_TITLE, 
                INFO_POINT1,INFO_POINT2,INFO_POINT3,INFO_SUM_POINT,CA_LCODE,JOBCODE,CONSTRAIN,GOOGLE_FLAG,ecatalog_flag,ecatalog_url,P_PL_NO,P_IMGURL,P_IMGURLFLAG,BRAND,KEYWORD2,
                MALLCNT3,MINPRICE2,MINPRICE3,MAXPRICE3,MINPRICE4,BBS_POINT,BBS_POINT_AVG,BBS_NUM) 
            SELECT NVL(modelno_group,modelno) modelno_group,ca_code,min(modelnm) as modelnm, min(factory) as factory,max(sum_popular) as sum_popular,max(popular) as popular, 
                    min(openexpectflag) as openexpectflag,min(spec) as spec, min(minprice) as minprice, max(minprice) as maxprice,max(mallcnt) as mallcnt, 
                    min(c_date) as c_date,min(imgchk) as imgchk,max(recommend) as recommend, 
                    UDF_KB_CNT_GROUP(MIN(ca_code),MAX(modelno_group),MAX(box_modelnm),MAX(kb_num)) kb_num, 
                    max(condiname) as condiname,max(factory_etc) factory_etc,max(rsiflag) rsiflag , 
                    MAX(rsiflag2) rsiflag2,NVL(max(sum_sale_cnt),0) as sum_sale_cnt,NVL(max(sale_cnt),0) as sale_cnt, 
                    NVL(MAX(imgchk_rolling),0) imgchk_rolling,NVL(MAX(height),0) height,                
                    CASE WHEN substr(ca_code,0,4)='0501' THEN NVL(MAX(weight),0) ELSE NVL(MAX(weight),999999) END weight,                 
                    MAX(spec_group) spec_group, CASE NVL(MAX(dbms_lob.GETLENGTH(goods_info)),0)WHEN 0 THEN '' ELSE '1' END as goods_info, 
                    to_char(MAX(goods_info_date),'yyyy-mm-dd') goods_info_date, MAX(kb_title) kb_title,AVG(info_point1) info_point1, 
                    AVG(info_point2) info_point2,AVG(info_point3) info_point3, NVL(AVG(info_sum_point),0) info_sum_point,  
                    MAX(ca_lcode) ca_lcode,MAX(jobcode) jobcode,MAX(constrain) constrain,max(nvl(google_flag,0)) google_flag, 
                    MAX(ecatalog_flag) ecatalog_flag,MAX(ecatalog_url) ecatalog_url,MAX(P_PL_NO) P_PL_NO,MAX(P_IMGURL) P_IMGURL,MAX(P_IMGURLFLAG) P_IMGURLFLAG, 
                    MAX(BRAND) BRAND,MAX(KEYWORD2) KEYWORD2,
                    MIN(MALLCNT3) MALLCNT3,MIN(MINPRICE2) MINPRICE2,MIN(MINPRICE3) MINPRICE3,MAX(MINPRICE3) MAXPRICE3,MIN(MINPRICE4) MINPRICE4, MAX(BBS_POINT) BBS_POINT, 
                    MAX(BBS_POINT_AVG) BBS_POINT_AVG,MAX(BBS_NUM) BBS_NUM
                    FROM tbl_goods 
            WHERE ca_code like ca_mlists(i) || '%' 
              AND jobcode > '0' AND constrain IN ('1','5') AND mallcnt > 0 
              AND openexpectflag = '0' 
              --AND modelno_group is not null 
              and sum_popular is not null 
            group by ca_code,NVL(modelno_group,modelno); 
             
            COMMIT; 
            --=============================================================================================================================================================== 
            FOR tmp_loop in (SELECT distinct ca_sub_code FROM TBL_GOODS_COPYCATE WHERE ca_code like ca_mlists(i) || '%' AND ca_sub_code NOT LIKE ca_mlists(i) || '%') LOOP 
                IF delete_chk = 'N' THEN 
                    DELETE tbl_goods_group  WHERE ca_code like tmp_loop.ca_sub_code || '%'; 
                END IF; 
         
                INSERT INTO tbl_goods_group ( 
                    MODELNO_GROUP,CA_CODE,MODELNM,FACTORY,SUM_POPULAR,POPULAR,OPENEXPECTFLAG,SPEC,MINPRICE,MAXPRICE,MALLCNT,C_DATE,IMGCHK,RECOMMEND,KB_NUM, 
                    CONDINAME,FACTORY_ETC,RSIFLAG,RSIFLAG2,SUM_SALE_CNT,SALE_CNT,IMGCHK_ROLLING,HEIGHT,WEIGHT,SPEC_GROUP,GOODS_INFO,GOODS_INFO_DATE,KB_TITLE, 
                    INFO_POINT1,INFO_POINT2,INFO_POINT3,INFO_SUM_POINT,CA_LCODE,JOBCODE,CONSTRAIN,GOOGLE_FLAG,ecatalog_flag,ecatalog_url,P_PL_NO,P_IMGURL,P_IMGURLFLAG,BRAND,KEYWORD2,
                    MALLCNT3,MINPRICE2,MINPRICE3,MAXPRICE3,MINPRICE4,BBS_POINT,BBS_POINT_AVG,BBS_NUM
                    ) 
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
                        MAX(BRAND) BRAND,MAX(KEYWORD2) KEYWORD2,
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
             
        END LOOP;    
         
        COMMIT; 
         
        v_str := 'analyze table tbl_goods_group COMPUTE STATISTICS'; 
        EXECUTE IMMEDIATE v_str; 
         
        v_str := 'analyze index IDX_GOODS_GROUP_FULL COMPUTE STATISTICS'; 
        EXECUTE IMMEDIATE v_str; 
   END IF;
     
    --SYS LOG
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_GOODS_GROUP_LIST','END');
    COMMIT;
    
END UDP_GOODS_GROUP_LIST;