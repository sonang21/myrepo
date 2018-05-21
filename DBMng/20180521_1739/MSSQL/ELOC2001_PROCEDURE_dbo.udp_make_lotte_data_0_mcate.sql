/* *************************************************************************
 * NAME : dbo.udp_make_lotte_data_0_mcate
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2011-06-21 17:06:51.76
 *        Modify: 2018-05-07 16:54:49.997
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_make_lotte_data_0_mcate
as 
begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2011-06-21
	-- ��  �� : �Ե����� ���� ������ �����
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:			��������:
	-------------------------------------------------
	*/

	-- ------------------------------
	-- �⺻ ������ ���ϱ� -- 2:24
	-- �ʿ��� ��ü�� ��ǰ���� copy
	-- ------------------------------
		if object_id('tmp_shop_agg_base') is not null
			drop table tmp_shop_agg_base


		create table tmp_shop_agg_base
		(
			pl_vcode int not null
		,	min_price money not null
		,	modelno int not null
		,	mcate char(4) not null
		,	scate char(6) not null
		,	factory nvarchar(50) not null
		,	pl_goodscode varchar(50) null
		)


		declare @vcode int
		declare cur_vcode cursor fast_forward for
		(
			select 49 as vcode union all
			select 663 union all
			select 57 union all
			select 47 union all
			select 75 union all
			select 806
		)

		open cur_vcode
		fetch next from cur_vcode into @vcode
		while @@fetch_status =0
		begin

			insert 
              into tmp_shop_agg_base
			select pl_vcode
                 , min_price
                 , pl_modelno
                 , left(g_category, 4) as mcate
                 , left(g_category, 6) as scate
                 , replace(g.g_factory, char(9), ' ')
			     , case when pl_vcode=49 then pl_goodscode else null end
			  from ( select 
                          pl_vcode
                          , min(pl_price) as min_price
                          , pl_modelno
                          , max(pl_goodscode) pl_goodscode
			         from pricelist
			        where pl_vcode = @vcode
			          and pl_modelno  > 0
				      and pl_status in ('0','1','2', '8', '9')
				      and pl_esstockflag='0'
				      and isnull(option_flag2,'0')='0'  -- �ɼ��ʼ� ��ǰ ����
				      and pl_srvflag = '0' -- ���ۺ�(r)�� ����
				    group by pl_vcode
                           , pl_modelno ) p 
                    inner join goods g on g.g_modelno = pl_modelno
                    inner join goods_sum s on g.g_modelno = s.g_modelno
			--select top 1 g_modelno from goods with (readuncommitted)
			  where g.g_jobcode > '0' 
                and g.g_constrain = '1' 
                and s.g_mallcnt > 0 
                and s.g_minprice > 0
  			    and g.g_category not like '1471%' 
                and g.g_category not like '1472%' 
                and g.g_category not like '1473%' 
                and g.g_category not like '90%'

			fetch next from cur_vcode into @vcode
		end
		close cur_vcode
		deallocate cur_vcode

		-- ����ó��
		/*
		�����~
		�Ե����� �����ؼ� ��û �帳�ϴ�.,

		�ڼ��� �κ� �����ִ� ���� ã�� �˰ڽ��ϴ�.

		*�ߺз� 14�з�, 90�з� ����
		*3�� �����Ϳ��� ������ �� "�Ҹ�, ȣȯ" ������ ����
		*�� ���� ��ĭ���� ������ ������ ����
		*/
		delete 
          from tmp_shop_agg_base 
         where FACTORY in ('�Ҹ�','ȣȯ','','[�Ҹ�]','[ȣȯ]','(ȣȯ��ü)') 
            or factory is null
end