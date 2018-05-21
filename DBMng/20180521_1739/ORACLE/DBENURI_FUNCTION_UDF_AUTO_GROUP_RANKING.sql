/* *************************************************************************
 * NAME : DBENURI.UDF_AUTO_GROUP_RANKING
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 18:49:59
 *        Modify: 2018-04-19 18:32:42
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DBENURI"."UDF_AUTO_GROUP_RANKING" (v_ag_no NUMBER)
RETURN int AS
    i_rank     NUMBER := 0;

BEGIN

    select rank  INTO i_rank from (
		select rownum rank,ag_no,popular from
		(
			select a.ag_no, NVL(a.popular,0)  popular from  tbl_auto_group a,tbl_auto_style_group b, tbl_auto_style c
			where c.as_no in
				(
				select c1.as_no from tbl_auto_group a1,tbl_auto_style_group b1, tbl_auto_style c1
				where  a1.ag_no=b1.ag_no
				and    b1.as_no=c1.as_no
				and    a1.ag_no=v_ag_no
				)
			and  a.ag_no=b.ag_no
			and  b.as_no=c.as_no
			and a.ag_no in (select ag_no2 from tbl_auto_spec where service_yn = 'Y' or service_yn = 'S')
			order by popular desc, ag_no desc
		)
	)
	where ag_no=v_ag_no;
    
    RETURN i_rank;

END;

 