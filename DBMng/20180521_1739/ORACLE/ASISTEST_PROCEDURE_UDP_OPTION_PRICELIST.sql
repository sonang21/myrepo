/* *************************************************************************
 * NAME : ASISTEST.UDP_OPTION_PRICELIST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:29
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_OPTION_PRICELIST" 
IS
 
 --CURSOR cur_pl_no IS
 --  SELECT pl_no
 --    FROM TBL_PRICELIST p1
 --   WHERE option_flag = '1'
 --   AND rownum =1 ;
 
 v_pl_no_tmp            tbl_pricelist.pl_no%TYPE := 0;
 i_count                NUMBER := 0;
 
BEGIN
 --DBMS_OUTPUT.ENABLE;
 --DBMS_OUTPUT.PUT_LINE('UDP_DEL_PRICELIST start ......');

 i_count := 0;
 
 --OPEN cur_pl_no;
 --LOOP

   --FETCH cur_pl_no INTO v_pl_no_tmp;
   --EXIT WHEN cur_pl_no%NOTFOUND;

        --UPDATE TBL_PRICELIST SET option_flag = null WHERE PL_NO = v_pl_no_tmp;
     UPDATE TBL_PRICELIST SET option_flag = null 
        WHERE option_flag = '1' 
        AND pl_no IN (select distinct pl_no from tbl_pricelist_option 
                      where to_char(regdate,'YYYYMMDD') <= to_char(sysdate-2,'YYYYMMDD'));
        --AND NVL(option_flag,'0') <> '1';     
     COMMIT;
     
     UPDATE TBL_PRICELIST SET option_flag = null 
        WHERE NVL(option_flag,'0') = '1' 
        AND pl_no IN (select distinct pl_no from tbl_pricelist_option 
                      where to_char(regdate,'YYYYMMDD') <= to_char(sysdate-2,'YYYYMMDD') and model_proc_cnt in (1000,2000)) ;
        --AND NVL(option_flag,'0') <> '1';     
     COMMIT;
     

 --END LOOP;
 --CLOSE cur_pl_no;

 --COMMIT;
 
 DELETE /*+ APPEND NOLOGGING */ TBL_PRICELIST_OPTION3;
 COMMIT;
 
 INSERT INTO /*+ APPEND NOLOGGING */ TBL_PRICELIST_OPTION3 (PL_NO,OPTION_NAME,OPTION_SUB_NAME,OPTION_PRICE,ORDER_BY,USE_FLAG)
 SELECT PL_NO,OPTION_NAME,OPTION_SUB_NAME,OPTION_PRICE,ORDER_BY,USE_FLAG FROM TBL_PRICELIST_OPTION2;
 COMMIT;
 
 DELETE /*+ APPEND NOLOGGING */ TBL_PRICELIST_OPTION2;
 COMMIT;
 
 INSERT INTO /*+ APPEND NOLOGGING */ TBL_PRICELIST_OPTION2 (PL_NO,OPTION_NAME,OPTION_SUB_NAME,OPTION_PRICE,ORDER_BY,USE_FLAG) 
 SELECT PL_NO,OPTION_NAME,OPTION_SUB_NAME,OPTION_PRICE,ORDER_BY,USE_FLAG FROM TBL_PRICELIST_OPTION 
    WHERE (NVL(MODEL_PROC_CNT,1000) <= 200 OR NVL(MODEL_PROC_CNT,1000) = 2000);
 COMMIT;
 
 DELETE /*+ APPEND NOLOGGING */ TBL_PRICELIST_OPTION where to_char(regdate,'YYYYMMDD') <= to_char(sysdate-2,'YYYYMMDD');
 COMMIT;
 
 --DELETE /*+ APPEND NOLOGGING */ TBL_PRICELIST_OPTION where to_char(regdate,'YYYYMMDD') <= to_char(sysdate-2,'YYYYMMDD') and model_proc_cnt in (1000,2000);
 --COMMIT;
 
 
 UPDATE TBL_PRICELIST SET option_flag = null WHERE NVL(option_flag,'0') = '1' AND pl_no NOT IN (select distinct pl_no from tbl_pricelist_option);
 COMMIT;
 
 /*=====================================================================================================*/
 DELETE /*+ APPEND NOLOGGING */ copy_tbl_pricelist_option2 
 COMMIT;
 
 insert into copy_tbl_pricelist_option2
 select distinct b.PL_NO,b.OPTION_NAME,b.OPTION_SUB_NAME,b.OPTION_PRICE,b.ORDER_BY
 from(
  select pl_no, max(max_order_by) max_order_by
  from
  (
    select pl_no
    ,     option_name
    ,     rank() over(partition by pl_no order by max(order_by)) as rank
    ,     max(order_by) max_order_by
    ,     nvl(max(use_flag),'0') as no_use
    from tbl_pricelist_option2
    group by pl_no, option_name
  ) c
  where rank<2 -- 상위 1개 옵션만 사용
  group by pl_no
  having max(no_use)='0' or min(no_use) = '0'
  )  a inner join tbl_pricelist_option2 b on a.pl_no = b.pl_no and a.max_order_by >= b.order_by
  where b.option_name <> '추가상품' and b.option_name <> '사은품선택';
 
 COMMIT;
 
 
 DELETE /*+ APPEND NOLOGGING */ tbl_pricelist_option2;
 COMMIT;

 insert into tbl_pricelist_option2 (PL_NO,OPTION_NAME,OPTION_SUB_NAME,OPTION_PRICE,ORDER_BY,USE_FLAG) select PL_NO,OPTION_NAME,OPTION_SUB_NAME,OPTION_PRICE,ORDER_BY,'' from copy_tbl_pricelist_option2;
 COMMIT;
 
 udp_pricelist_option_diff_ins;
 COMMIT;

 
END UDP_OPTION_PRICELIST;