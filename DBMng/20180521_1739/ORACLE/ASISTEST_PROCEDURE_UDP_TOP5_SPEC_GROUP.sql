/* *************************************************************************
 * NAME : ASISTEST.UDP_TOP5_SPEC_GROUP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-04 18:53:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_TOP5_SPEC_GROUP" 
is
   type array_t is varray(33) of varchar2(4);
   
   v_cate              VARCHAR2(4) :='';
   v_gpno              NUMBER := 0;
   v_cnt               NUMBER := 0; 
   array_spec array_t;
   i_count      NUMBER := 0;
begin
  --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_TOP5_SPEC_GROUP','START');
  COMMIT;
    
   i_count := 0;
   array_spec := array_t('0201','0353','0502','0352','0234','0237','0504','0513','0404','0401','0402','0405','1007','0609','0418','0304','2113','0908','0501','2117','0211','0710','0318','0602','0305','0705','0601','1004','0357','0420','2115','0530','0506');
   for i in 1..array_spec.count loop
    DELETE TBL_TOP5_SPEC_GROUP WHERE CA_CODE = array_spec(i);        
    for tmp_loop in (
        select cate , gpno , s_cnt  from (
        select cate , gpno, sum(cnt) s_cnt from (
        SELECT A.CATE , A.GPNO , SPECNO SPEC_GROUP_SPECNO,C.TITLE SPEC_GROUP_TITLE
        ,
        (
        select count(*) from tbl_goods where ca_code like array_spec(i) || '%' and ca_lcode = substr(array_spec(i),1,2) and modelno in (
        select modelno from tbl_modelno_spec where  tbl_modelno_spec.specno = C.SPECNO
        ) and JOBCODE > 0 AND CONSTRAIN = '1' AND MALLCNT > 0 AND OPENEXPECTFLAG = '0' AND CATEFLAG = '0'
        ) cnt
    
        FROM TBL_SPEC_CATE A,TBL_SPEC_CATEDETAIL B, TBL_SPEC_GROUP C WHERE A.CATE = array_spec(i) AND A.GPNO = B.GPNO 
        AND B.GPSNO = C.GPSNO AND B.GPNO = C.GPNO AND A.DELFLAG='0' AND B.DELFLAG !='2' AND C.DELFLAG != '2'  ORDER BY cnt desc
        ) group by gpno, cate order by sum(cnt) desc
        ) where rownum <6
      )loop
      
      begin
          v_cate := tmp_loop.cate;
          v_gpno := tmp_loop.gpno;
          v_cnt := tmp_loop.s_cnt;           
          
          INSERT INTO TBL_TOP5_SPEC_GROUP (CA_CODE,GPNO,CNT) VALUES(v_cate,v_gpno,v_cnt);
           
           EXCEPTION WHEN OTHERS THEN
           COMMIT;
           
           i_count := i_count + 1;
           
      end ;
    
      IF i_count = 10 THEN
      	COMMIT;
       	i_count := 0;
      END IF;
    end loop;
   end loop;

  COMMIT;
  
  --sys log
  INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_TOP5_SPEC_GROUP','END');
  COMMIT;
    
END UDP_TOP5_SPEC_GROUP;