/* *************************************************************************
 * NAME : dbo.UDP_GOODS_COPY
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-16 18:09:54.84
 *        Modify: 2018-05-16 18:09:54.84
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE  procedure [dbo].[UDP_GOODS_COPY]
AS
BEGIN
	
	truncate table tbl_goods_copy 

	INSERT INTO TBL_GOODS_COPY VALUES ('0000',0,'00000000')

	insert into tbl_goods_copy (ADD_CA_CODE, MODELNO, CA_CODE)	
	select add_ca_code, cast(modelno as int) modelno, ca_code from 
	openquery(ORADB,
	'select 
		--count(z.modelno)
		y.add_ca_code, to_char(z.modelno) modelno, z.ca_code
	from TBL_GOODS z, 
		(select e.ca_code, e.add_ca_code
		from 
			(select decode(c.c_level, 3, c.ca_code||''00'', c.ca_code) ca_code, substr(d.ca_code,1,4) add_ca_code
			from 
				(
				select a.ca_code, a.ca_code2 pre_ca_code, a.c_level 
				from TBL_CATEGORY a, TBL_CATEGORY b 
				where a.ca_code2 = b.ca_code2 and b.c_seqno>0 and b.c_level=2 and a.c_level>2
				union
				select a.ca_code, a.ca_code3 pre_ca_code, a.c_level 
				from TBL_CATEGORY a, TBL_CATEGORY b 
				where a.ca_code2 = b.ca_code2 and b.c_seqno>0 and b.c_level=2 and a.c_level>2
				union
				select a.ca_code, a.ca_code pre_ca_code, a.c_level 
				from TBL_CATEGORY a, TBL_CATEGORY b 
				where a.ca_code2 = b.ca_code2 and b.c_seqno>0 and b.c_level=2 and a.c_level>2
				) c,
				(select ca_sub_code, ca_code 
				from TBL_GOODS_COPYCATE 
				union 
				select ca_code ca_sub_code, ca_code 
				from TBL_GOODS_COPYCATE) d
			where c.pre_ca_code = d.ca_sub_code
			group by decode(c.c_level, 3, c.ca_code||''00'', c.ca_code), substr(d.ca_code,1,4)
			) e,
			tbl_category f
		where e.add_ca_code = f.ca_code and f.c_knowbox=''1''
		) y
	where z.ca_code = y.ca_code
	union
	select substr(c.ca_code,0,4), to_char(c.modelno) modelno, c.ca_code 
    from tbl_goods a
         inner join tbl_cate_goods c on a.modelno = c.modelno
	')

END

