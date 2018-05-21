/* *************************************************************************
 * NAME : ASISTEST.UDP_LEFTNRIGHT_MODELNO
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:26
 *        Modify: 2018-05-04 18:53:44
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_LEFTNRIGHT_MODELNO" 
IS 

 
BEGIN 
 --DBMS_OUTPUT.ENABLE; 
 --DBMS_OUTPUT.PUT_LINE('11 ......'); 
 
 merge into TBL_CHECK_INFO_MODEL d
    using(
	select modelno
	from tbl_goods
	where ca_code like '2115%' and CA_LCODE ='21' and cateflag='0'
	and modelnm like '%[¹«·áÀåÂø%'
	) s on (d.modelno = s.modelno and d.flag='0' and d.job_type='2')
when not matched then
	insert (d.modelno, d.regdate, d.flag, d.job_type)
	values(s.modelno, sysdate, '0','2');
    
COMMIT;

--
--select count(*) from TBL_CHECK_INFO_MODEL where flag = '0' and job_type='2';


delete TBL_CHECK_INFO_MODEL d where not exists (select 1 from tbl_goods s where CA_LCODE ='21' and cateflag='0' and modelnm like '%[¹«·áÀåÂø%' and d.modelno = s.modelno and rownum=1) and job_type='2';

COMMIT;
 
END UDP_LEFTNRIGHT_MODELNO;