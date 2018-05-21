/* *************************************************************************
 * NAME : ASISTEST.UDP_ENURIPC_SPEC
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:21
 *        Modify: 2018-05-04 18:53:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_ENURIPC_SPEC" ( logDate VARCHAR2  ) AS 
v_sqlcode           varchar2(4000) :='';
v_sqlmsg            varchar2(4000) :='';
BEGIN
  declare
   v_cate varchar2(3);
    cursor cur01 is
      select cate_code from tbl_enuripc_product_cate  order by cate_order;
    begin
      open cur01;
        loop
          fetch cur01      
          into v_cate;
          if cur01%notfound
            then
            exit;
          end if;        
          delete TBL_ENURIPC_SPEC where cate_code = v_cate;
          insert into TBL_ENURIPC_SPEC (GPNO,GPSNO,SPECNO,SPEC_CATE_TITLE,SPEC_GROUP_TITLE,SORT1,SORT2,CATE_CODE)
            SELECT A.GPNO ,B.GPSNO,C.SPECNO SPEC_GROUP_SPECNO, A.TITLE SPEC_CATE_TITLE, C.TITLE SPEC_GROUP_TITLE,D.SORTNO , C.SORTNO, v_cate
            FROM TBL_SPEC_CATE A,TBL_SPEC_CATEDETAIL B, TBL_SPEC_GROUP C ,
            (
             select gpno,nvl(sum(click_cnt),0)  AS sortno From 
              (select specno,count(*) as click_cnt from TBL_LIST_KEYWORD_ATT_LOG where ATT_TYPE = 'S' and reg_date >= sysdate-30 group by specno) A 
              right outer join 
              (SELECT A.GPNO , A.TITLE, A.CATE,C.SPECNO SPEC_GROUP_SPECNO 
              FROM TBL_SPEC_CATE A,TBL_SPEC_CATEDETAIL B, TBL_SPEC_GROUP C WHERE A.GPNO = B.GPNO 
              AND B.GPSNO = C.GPSNO AND B.GPNO = C.GPNO AND A.DELFLAG='0' AND B.DELFLAG !='2' AND C.DELFLAG != '2'  
              --AND A.CATE NOT IN ('0903','0904','0906','0907','0911','0912','0913','0920','0923','0930','0931','0937','0805','0513','0514','0526','2406','0704','0710','0711','0232','0233','0234','0235','0237','0304','0305','0363') 
              ORDER BY A.SORTNO , B.SORTNO,C.SORTNO) B 
              on A.specno = B.SPEC_GROUP_SPECNO 
             group by cate,gpno,title order by cate , ROW_NUMBER() OVER(PARTITION BY substr(cate,0,4) ORDER BY nvl(sum(click_cnt),0)  desc )
            ) D
            WHERE  A.GPNO = B.GPNO AND A.GPNO = D.GPNO
            AND B.GPSNO = C.GPSNO AND B.GPNO = C.GPNO AND A.DELFLAG='0' AND B.DELFLAG !='2' AND C.DELFLAG != '2'  
            AND C.SPECNO IN (select SPECNO from tbl_modelno_spec where modelno in (select modelno from TBL_ENURIPC_product where p_cate_code = v_cate and modelno > 0))
            ORDER BY D.SORTNO , C.SORTNO;
          commit;
          
          delete TBL_ENURIPC_FACTORY where cate_code = v_cate;
          insert into TBL_ENURIPC_FACTORY (CATE_CODE,FACTORY,SORTNO)
            select v_cate,a.factory,min(b.sortno) sortno from 
            (select distinct substr(ca_code,0,4) ca_code,factory from tbl_goods where modelno in (
            select modelno from TBL_ENURIPC_product where p_cate_code = v_cate and  nvl(modelno,0) > 0
            )) A,
            (
            select  ca_code ,fb_name,ROW_NUMBER() OVER(PARTITION BY ca_code ORDER BY nvl(sum(click_cnt),0)  desc )  AS sortno From 
            (select substr(ca_code,0,4) as ca_code,fb_name,count(*) as click_cnt from TBL_LIST_KEYWORD_ATT_LOG where ATT_TYPE = 'F' and reg_date >= sysdate-30 group by fb_name,substr(ca_code,0,4)) A
            group by ca_code,fb_name order by ca_code , ROW_NUMBER() OVER(PARTITION BY ca_code,fb_name ORDER BY nvl(sum(click_cnt),0)  desc)
            ) B
            where A.ca_code = b.ca_code and a.factory = b.fb_name group by a.factory order by min(b.sortno) ;        
          commit;
          
       end loop;
      close cur01;
    end;    
    
    delete TBL_ENURIPC_SPEC_MODELNO;
    insert into TBL_ENURIPC_SPEC_MODELNO (specno,modelno)
    select distinct A.specno,c.modelno  from  TBL_ENURIPC_SPEC A, tbl_modelno_spec  B , TBL_ENURIPC_product C
    where c.modelno = b.modelno and b.specno = a.specno    ;
    commit;
    
EXCEPTION
     WHEN OTHERS THEN
       v_sqlcode := SQLCODE;
       v_sqlmsg  := SQLERRM;       
       ROLLBACK;
       insert into TBL_ENURIPC_API_LOG values (logDate,'UDP_ENURIPC_SPEC',sysdate,sysdate,'FAIL','UDP_ENURIPC_SPEC error : errorcode => ' || v_sqlcode || ', ERRMSG => ' || v_sqlmsg,0,'PRODUCT');
       commit;  
       
END UDP_ENURIPC_SPEC;