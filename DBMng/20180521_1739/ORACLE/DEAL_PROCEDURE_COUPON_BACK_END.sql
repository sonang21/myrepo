/* *************************************************************************
 * NAME : DEAL.COUPON_BACK_END
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DEAL"."COUPON_BACK_END" 
 
( 
T_PASSWORD IN D4_COUPON.MB_ID%TYPE 
) 
---------------------------------------------------------------------------------------------------------------------- 
-- File Name : COUPON_BACK_END 
-- Version      : 1.0 
-- Writen Date  : 2014-11-20 
-- Author    : Kwon Sung Won 
-- Program ID  : COUPON_BACK_END 
-- Comments : update coupon_end with d4_coupon/update coupon_back with d4_coupon_end 
----------------------------------------------------------------------------------------------------------------------  
IS 
 
chk_err_fg varchar2(1); 
o_err_msg varchar2(100); 
 
BEGIN 
 
if (T_PASSWORD = 'YES') then 
   delete D4_COUPON_END where cp_coupon_end < to_char(sysdate-7,'YYYY-MM-DD');
   delete D4_COUPON_back where cp_coupon_end < to_char(sysdate-7,'YYYY-MM-DD');
   delete d4_coupon_back  WHERE to_date(substr(cp_limitdate,1,10),'yyyy-mm-dd') <  to_date(to_char((ADD_MONTHS(SYSDATE, -2)),'yyyy-mm-dd'),'yyyy-mm-dd'); 
-- d4_coupon_back series insert 
   INSERT INTO d4_coupon_back SELECT * FROM d4_coupon_end WHERE to_date(substr(cp_limitdate,1,10),'yyyy-mm-dd') <  to_date(to_char((ADD_MONTHS(SYSDATE, -1)),'yyyy-mm-dd'),'yyyy-mm-dd'); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error1 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   INSERT INTO d4_coupon_back_loc SELECT * FROM d4_coupon_end_loc WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error2 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   INSERT INTO d4_coupon_back_cate SELECT * FROM d4_coupon_end_cate WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error3 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   INSERT INTO d4_coupon_back_shop SELECT * FROM d4_coupon_end_shop WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error4 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
/*   INSERT INTO d4_momsClick_back SELECT * FROM d4_momsClick_end WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error5 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if;*/ 
    
-- d4_coupon_end series delete 
   DELETE FROM d4_coupon_end WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error1 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   DELETE FROM d4_coupon_end_loc WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error2 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   DELETE FROM d4_coupon_end_cate WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error3 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   DELETE FROM d4_coupon_end_shop WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error4 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
/*   DELETE FROM d4_momsClick_end WHERE cp_id IN (SELECT cp_id FROM d4_coupon_back); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error5 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if;*/ 
     
-- d4_coupon_end series insert 
   INSERT INTO d4_coupon_end SELECT * FROM d4_coupon a WHERE to_date(substr(a.cp_limitdate,1,10),'yyyy-mm-dd') < to_date(to_char(SYSDATE,'yyyy-mm-dd'),'yyyy-mm-dd') 
                                                                              and not exists (select 1 from d4_coupon_end b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error6 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   INSERT INTO d4_coupon_end_loc SELECT * FROM d4_coupon_loc a WHERE cp_id IN (SELECT cp_id FROM d4_coupon_end) 
                                                                                         and not exists (select 1 from d4_coupon_end_loc b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error7 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   INSERT INTO d4_coupon_end_cate SELECT * FROM d4_coupon_cate a WHERE cp_id IN (SELECT cp_id FROM d4_coupon_end) 
                                                                                         and not exists (select 1 from d4_coupon_end_cate b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error8 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   INSERT INTO d4_coupon_end_shop SELECT * FROM d4_coupon_shop a WHERE cp_id IN (SELECT cp_id FROM d4_coupon_end) 
                                                                                         and not exists (select 1 from d4_coupon_end_shop b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'insert error9 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
/*   INSERT INTO d4_momsClick_end SELECT * FROM d4_momsClick a WHERE cp_id IN (SELECT cp_id FROM d4_coupon_end) 
                                                                                      and not exists (select 1 from d4_momsClick_end b where a.cp_id = b.cp_id);  
   if (sqlcode < 0) then 
      o_err_msg := 'insert error10 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if;*/ 
    
-- d4_coupon series delete 
   DELETE FROM d4_coupon a WHERE exists (SELECT 1 FROM d4_coupon_end b where a.cp_id = b.cp_id);   
   if (sqlcode < 0) then 
      o_err_msg := 'delete error6 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   DELETE FROM d4_coupon_loc a WHERE exists (SELECT 1 FROM d4_coupon_end b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error7 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   DELETE FROM d4_coupon_cate a WHERE exists (SELECT 1 FROM d4_coupon_end b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error8 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
   DELETE FROM d4_coupon_shop a WHERE exists (SELECT 1 FROM d4_coupon_end b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error9 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if; 
/*   DELETE FROM d4_momsClick a WHERE exists (SELECT 1 FROM d4_coupon_end b where a.cp_id = b.cp_id); 
   if (sqlcode < 0) then 
      o_err_msg := 'delete error10 : ' || sqlcode || ')'; 
      chk_err_fg := '1'; 
   end if;*/ 
end if; 
 
if (chk_err_fg = '1') then 
  dbms_output.put_line(o_err_msg || ' : ' || chk_err_fg); 
  rollback; 
else 
  dbms_output.put_line('COUPON_BACK_END SP EXCUTED SUCCESSSFULLY!!');  
  commit;      
end if; 
 
EXCEPTION 
 
WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE( T_PASSWORD || ' ' || 'register is failed!'); 
 
ROLLBACK; 
 
END;