/* *************************************************************************
 * NAME : dbo.udp_cm_monitor_chkeck_list_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-20 11:25:26.873
 *        Modify: 2018-05-20 11:25:26.873
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE proc udp_cm_monitor_chkeck_list_ins
as
begin
	-- ----------------------------------------------------------------------------------
	-- �ۼ��� : wookki25 // 2015.06.24
	-- ��  �� : üũ ��� �Է�
	-- ----------------------------------------------------------------------------------	
	-- ----------------------------------------------------------------------------------
	-- ������:		������:		��������:
	-- ----------------------------------------------------------------------------------
	-- 2015.06.30	wookki25	ó�� : ������ �����Ⱓ 3���� ó��
	--                          ���� : 
	--							���� : ������. �׸��� ������ �����Ⱓ�� 3������ �������ּ���! �����մϴ�~!
	-- ----------------------------------------------------------------------------------
	set nocount on
	set transaction isolation level  read uncommitted

	-- �ӽ����̺� ����
	select item_no, modelno, modelnm, category, category_nm into #tbl_cm_monitor_chkeck_list from tbl_cm_monitor_chkeck_list where 1=0


	--delete from tbl_cm_monitor_chkeck_list where item_no = 1 and regdate = '2015-06-30'

	-- �󼼹��� �ߺ� ����Ʈ
	insert into #tbl_cm_monitor_chkeck_list(item_no, modelno, modelnm, category)
	select 1, g_modelno, g_modelnm, g_category
	from openquery(elocdb, '
	select a.g_modelno, a.g_modelnm, a.g_category
	  from goods a 
           inner join eloc2001.dbo.goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
           inner join ( select 
                               left(g_category,4) as g_category, g_factory
		                  from eloc2001.dbo.goods a with (readuncommitted)
                               inner join eloc2001.dbo.goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
		                 where g_jobcode <> ''0''
		                   and g_mallcnt > 0
		                   and g_constrain not in (''5'')
		                 group by left(g_category,4), g_factory
		                having count(*) > 1 and count(distinct g_refid) > 1 and min(g_refid) = 0 ) c on a.g_category like c.g_category+''%'' 
                                                                                                    and a.g_factory = c.g_factory 
                                                                                                    and a.g_refid = 0 
                                                                                                    and b.g_mallcnt > 0
	 where g_modelnm is not null and a.g_factory <> ''[�Ҹ�]''
	   and g_constrain not in (''5'')
	   and a.g_category not like ''9[35]%''
	')

	-- �̹��� ���� �� ����Ʈ : �������� ���� '��,��,��' ������ �Է�
	insert into #tbl_cm_monitor_chkeck_list(item_no, modelno, modelnm, category)
	select 2, g_modelno, g_modelnm, g_category 
      from tbl_img_error_model 
     where run_date >= case when datepart(weekday, getdate()) = 2 then cast(getdate()-3 as date)  else cast(getdate() as date) end 
       and run_date < cast(getdate()+1 as date)


	-- �ڰ����� �з��� �߰��� �� + blank �з��� �߰��� ��
	insert into #tbl_cm_monitor_chkeck_list(item_no, modelno, modelnm, category)
	select item_no, modelno, modelnm, ca_code 
	from openquery(oradb, '
	    select 
	           case when c_name =''blank'' then 4 else 3 end as item_no
	         , a.modelno
	         , a.modelnm
	         , a.ca_code
	      from tbl_goods a 
               inner join tbl_goods_sum b on a.modelno = b.modelno
               inner join tbl_cate_goods c on a.modelno = c.modelno
               inner join ( select ca_code, c_name 
                              from tbl_category 
                             where (c_level=3 or c_level=4) 
                               and cateflag not in (''1'',''2'') 
                               and c_name in (''�ڰ�����'',''blank'')) d on c.ca_code = d.ca_code
	     where jobcode = ''1'' 
           and mallcnt > 0            
           and constrain <> ''5''')


	-- ��>0 ����
	insert into #tbl_cm_monitor_chkeck_list(item_no, modelno, modelnm, category)
	select 5, g_modelno, g_modelnm, g_category
	from openquery(elocdb, '
	    select 
               g_category,a.g_modelno, g_modelnm 
	      from eloc2001.dbo.goods_chk_missing_value a 
               inner join goods b on a.g_modelno = b.g_modelno
	     where regdate >= case when datepart(weekday, getdate()) = 2 then cast(getdate()-3 as date)  else cast(getdate() as date) end 
           and regdate < cast(getdate()+1 as date)		
	')


	-- ��ÿ��� ��ǰ 590 ����
	insert into #tbl_cm_monitor_chkeck_list(item_no, modelno, modelnm, category)
	select 6, modelno, modelnm, ca_code d
	from openquery(oradb, '
		select a.ca_code, a.modelno, modelnm
		  from tbl_pricelist p 
               inner join tbl_goods a on p.modelno = a.modelno
               inner join tbl_goods_sum b on a.modelno = b.modelno
		 where shop_code = 590
		   and status < ''3'' 
           and p.modelno > 0 
           and srvflag = ''0''
		   and (mallcnt>1 or c_date<= sysdate)

        union all

		select a.ca_code, a.modelno, modelnm
		  from tbl_pricelist p
               inner join tbl_goods a on p.modelno = a.modelno
               inner join tbl_goods_sum b on a.modelno = b.modelno
		 where shop_code = 590
		   and mallcnt = 1 
		   and c_date> sysdate 
		   and not exists( select modelno from tbl_open_expect_category oec where oec_delflag in (''0'', ''1'') and oec.modelno = p.modelno )

		union all

		select a.ca_code, a.modelno, modelnm
		  from tbl_pricelist p
               inner join tbl_goods a on p.modelno = a.modelno
               inner join tbl_goods_sum b on a.modelno = b.modelno
			   inner join tbl_open_expect_category d on d.modelno = a.modelno
		 where shop_code = 590
		   and mallcnt = 0 
		   and oec_delflag = ''0'' 
		   and c_date> sysdate  
		')


	-- ���� �߰��� temp �з�
	insert into #tbl_cm_monitor_chkeck_list(item_no, category)
	select 7, ca_code 
	from openquery(oradb, '
		SELECT ca_code , nvl(c_fullname, c_name) category_nm
		  FROM tbl_category e 
		 WHERE ( (c_level=3 or c_level=4)  and c_name = ''temp'')   
		   and cateflag not in (''1'',''2'') 
		   and nvl(c_fullname, c_name) <> ''temp_�ڰ�����''
		   and exists (select modelno 
                         from tbl_goods a 
                        where rownum=1 
                          and constrain = ''1'') 
		 order by ca_code')



	-- ���з��� �ƴѵ� ���� �߰��� �з�'
	insert into #tbl_cm_monitor_chkeck_list(item_no, category)
	select 8, ca_code 
	from openquery(elocdb, '
		select cs_name, ca_code, c_flag
		from (
				select cs_lcode+cs_mcode+cs_scode as ca_code, cs_name, cs_flag as c_flag 
                  from eloc2001.dbo.c_scate with (readuncommitted) 
                 where cs_flag in (''0'', ''2'') 

				union all 

				select cd_lcode+cd_mcode+cd_scode+cd_dcode as ca_code, cd_name, cd_flag as c_flag 
                  from eloc2001.dbo.c_dcate with (readuncommitted) 
                 where cd_flag in (''0'', ''2'') 
			) a 
		where exists (
            select top 1 b.g_modelno 
              from eloc2001.dbo.goods b 
                   inner join eloc2001.dbo.goods_sum c on b.g_modelno = c.g_modelno
             where b.g_category like a.ca_code+''%'' and g_constrain = ''1'' and g_mallcnt>0) 
	')


	if (select max(regdate) from tbl_cm_monitor_chkeck_list) = cast(getdate() as date) begin	
		-- �Ϸ�ó��

		-- �𵨹�ȣ ����
		update a
		set is_end = 1
		from tbl_cm_monitor_chkeck_list a
		where not exists( select top 1 1 from #tbl_cm_monitor_chkeck_list b where a.item_no=b.item_no and a.modelno = b.modelno )
		and item_no in (1,3,4,5,6)
		and regdate = cast(getdate() as date)


		-- �з��ڵ� ����
		update a
		set is_end = 1
		from tbl_cm_monitor_chkeck_list a
		where not exists( select top 1 1 from #tbl_cm_monitor_chkeck_list b where a.item_no=b.item_no and a.category = b.category )
		and item_no in (7,8)
		and regdate = cast(getdate() as date)

	end else begin
		-- �Է�ó��
		insert into tbl_cm_monitor_chkeck_list(item_no, modelno, modelnm, category, category_nm)
		select item_no, modelno, modelnm, category, category_nm
		from #tbl_cm_monitor_chkeck_list
	end

	-- �з��� �Է�
	select * into #dcate_name from openquery(elocdb, 'select cd_lcode+cd_mcode+cd_scode+cd_dcode dcate, cd_name, cd_flag from eloc2001.dbo.c_dcate')

	update a
	set category_nm = cd_name
	from tbl_cm_monitor_chkeck_list a inner join #dcate_name b
	on dcate = category
	where regdate = cast(getdate() as date)
	and category_nm is null
	

	-- mm_id �ϰ� �Է�
	update a
	set mm_id = mmc_id
	from tbl_cm_monitor_chkeck_list a inner join (select max(mmc_id) mmc_id, left(mmc_category,4) mmc_category from mm_category where mmc_category like '____%' group by left(mmc_category,4)) b
	on mmc_category = left(category,4)
	where regdate = cast(getdate() as date)
	and mm_id is null

	-- mm_nm �ϰ� �Է�
	update a
	set mm_nm = b.mm_nm
	from tbl_cm_monitor_chkeck_list a inner join mm_enuri b
	on a.mm_id = b.mm_id
	where regdate = cast(getdate() as date)
	and a.mm_nm is null


	-- ������ �����Ⱓ 3���� ó��
	delete from tbl_cm_monitor_chkeck_list  where regdate < dateadd(m, -3, getdate())	
end
