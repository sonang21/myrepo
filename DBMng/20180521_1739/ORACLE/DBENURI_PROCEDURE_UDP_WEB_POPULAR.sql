/* *************************************************************************
 * NAME : DBENURI.UDP_WEB_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-05-16 13:22:10
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_WEB_POPULAR" 
IS

 v_pl_no   tbl_pricelist_webpopular.pl_no%TYPE := 0;
 v_point   tbl_pricelist_webpopular.point%TYPE := 0;
 v_point_add   tbl_pricelist_webpopular.point_add%TYPE := 0; -- 20160610 LSM
 i_count      NUMBER := 0;
 
CURSOR cur_webpopular IS
--SELECT /*+ parallel(g1 4) */ distinct modelno_group
SELECT pl_no,nvl(point,0),nvl(point_add,0) -- 20160610 LSM
FROM tbl_pricelist_webpopular;
--v_totcnt     NUMBER := 0;
 
BEGIN

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_WEB_POPULAR','START');
    COMMIT;
    
  i_count := 0;

  OPEN cur_webpopular;
  LOOP

    FETCH cur_webpopular INTO v_pl_no,v_point,v_point_add;
    EXIT WHEN cur_webpopular%NOTFOUND;

    BEGIN
      UPDATE TBL_PRICELIST SET popular = v_point, popular2 = v_point_add  WHERE pl_no=v_pl_no;   
        
      EXCEPTION WHEN OTHERS THEN
      COMMIT;
      
      i_count := i_count + 1;
      
    END;
    
    IF i_count = 100 THEN
      COMMIT;
      i_count := 0;
    END IF;
    
 END LOOP;
 CLOSE cur_webpopular;
 COMMIT;
  
 --========================================================================
 --데이타 초기화
 --========================================================================
 -- tbl_pricelist_webpopular에 없는 값들은 모두 0으로 초기화 함

 i_count := 0;
 FOR tmp_loop in 
    (SELECT pl_no   
     FROM tbl_pricelist 
     WHERE pl_no NOT IN (SELECT pl_no FROM tbl_pricelist_webpopular) AND popular2>0   -- 20160818 LSM 추가
    )
 LOOP
  
      BEGIN 

       UPDATE TBL_PRICELIST SET popular = null , popular2 = 0 
       WHERE pl_no = tmp_loop.pl_no;

       EXCEPTION WHEN OTHERS THEN
       COMMIT;
       
       i_count := i_count + 1;
      
      END;
    
      IF i_count = 100 THEN
      	COMMIT;
       	i_count := 0;
      END IF;
      
 END LOOP;
 
 COMMIT;
 
 
    -- admin에서의 조회를 위해 tbl_pricelist_webpopular에 카테고리 코드 넣음(20160819 LSM)
    /*
    merge into tbl_pricelist_webpopular wp
    using(
        select pl_no, ca_code
        from tbl_pricelist
        ) pl
    on (wp.pl_no = pl.pl_no)
    when matched then
        update set ca_code = pl.ca_code;
        
    commit;
    */
    
    -- 쿼리 변경-내용동일(20170710 LSM)
    update /*+bypass_ujvc*/
    (select a.pl_no , b.pl_no as pl_pl_no
            , a.ca_code, b.ca_code as pl_ca_code
     from dbenuri.tbl_pricelist_webpopular a
        left outer join dbenuri.tbl_pricelist b on a.pl_no = b.pl_no
     where NVL(A.CA_CODE,CHR(0)) <> NVL(B.CA_CODE,CHR(0))   
    )
    set ca_code = pl_ca_code;
    
    COMMIT;
    
    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_WEB_POPULAR','END');
    COMMIT;

END UDP_WEB_POPULAR;
