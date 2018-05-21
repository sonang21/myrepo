/* *************************************************************************
 * NAME : DBENURI.UDP_LEFTNRIGHT_MODELNO
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-16 10:52:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_LEFTNRIGHT_MODELNO" 
IS 
/*
 NGIT 수정 반영 - 김영원 20180502
*/
BEGIN 
 
 merge into TBL_CHECK_INFO_MODEL d
 using (select a.modelno
	           from tbl_goods a
          	where a.ca_code like '2115%' 
	            and a.modelnm like '%[무료장착%'
	      ) s 
    on (d.modelno = s.modelno and d.flag='0' and d.job_type='2')
  when not matched then
	   insert (d.modelno, d.regdate, d.flag, d.job_type)
	   values (s.modelno, sysdate, '0','2');

COMMIT;

delete TBL_CHECK_INFO_MODEL d
 where not exists (select 1
                     from tbl_goods a
                   	where a.ca_code like '21%'
                      and a.modelnm like '%[무료장착%'
                      and d.modelno = a.modelno 
                      and rownum=1)
   and d.job_type='2';

COMMIT;
 
END UDP_LEFTNRIGHT_MODELNO;
