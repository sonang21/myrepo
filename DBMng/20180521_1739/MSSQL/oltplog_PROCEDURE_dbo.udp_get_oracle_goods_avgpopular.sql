/* *************************************************************************
 * NAME : dbo.udp_get_oracle_goods_avgpopular
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-16 18:31:23.82
 *        Modify: 2018-05-16 18:31:23.82
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_get_oracle_goods_avgpopular
	@cate VARCHAR(4)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : toodoo / 2016.04.01
	-- 설  명 : 오라클 중분류별 tbl_goods 인기도 20-50위 평균
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	*/

		if (len(@cate)=4)
			begin

				declare @qry  varchar(8000)

				set @qry = 'select popular2 from openquery(ORADB_144, '
					+ '''select cast(avg(popular2) as int) popular2
						from (
							select rownum rnum,popular2
							from (
							select 
                                   NVL(MAX(nvl(modelno_group, a.modelno)),0) modelno
                                 , max((case when modelno_group is null then popular else sum_popular end )) as popular2
						      from tbl_goods a
                                   inner join tbl_goods_sum b on a.modelno = b.modelno
							where ca_code like ''''' + @cate + '%''''
								and constrain in (''''1'''',''''5'''') 
                                and jobcode>''''0'''' 
                                and mallcnt>0 
                                and minprice>0 
                                and openexpectflag=''''0''''
							group by nvl(modelno_group,modelno)
							order by popular2 desc
							)
						)
						where rnum>=20 and rnum<=50 '')'
				exec(@qry)

			end

