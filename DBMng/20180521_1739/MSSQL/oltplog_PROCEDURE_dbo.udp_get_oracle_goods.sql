/* *************************************************************************
 * NAME : dbo.udp_get_oracle_goods
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-16 18:27:38.537
 *        Modify: 2018-05-16 18:28:53.24
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc [dbo].[udp_get_oracle_goods]
	@cate VARCHAR(4)
as 
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : toodoo / 2016.03.28
	-- 설  명 : 오라클 중분류별 tbl_goods 인기도순 top 150개 복사
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	*/

	BEGIN TRAN
		if (len(@cate)=4)
			begin
				delete from tbl_goods_topn where cate=@cate

				declare @qry  varchar(8000)

				set @qry = 'select '''+@cate+''',modelno,modelnm,sum_popular2,getdate(),factory from openquery(ORADB_144, '
					+ ''' select * from (
							  select 
                                     NVL(MAX(nvl(modelno_group, a.modelno)),0) modelno, min(modelnm) as modelnm
                                   , max((case when modelno_group is null then popular else sum_popular end )) as sum_popular2
                                   , max(factory) as factory
							  from tbl_goods a
                                   inner join tbl_goods_sum b on a.modelno = b.modelno
							  where ca_code like ''''' + @cate + '%'''' 
								and constrain in (''''1'''',''''5'''') 
                                and jobcode>''''0'''' 
                                and mallcnt>0 
                                and minprice>0 
                                and openexpectflag=''''0''''
							  group by nvl(modelno_group,modelno)
							  order by sum_popular2 desc
							)
							where rownum<=150 '')'

				insert into tbl_goods_topn 
				exec(@qry)
			end

	IF @@ERROR<>0
		ROLLBACK TRAN
	ELSE
		COMMIT TRAN



