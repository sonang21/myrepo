/* *************************************************************************
 * NAME : dbo.view_cate3
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2016-12-09 19:25:48.283
 *        Modify: 2018-05-02 15:22:22.893
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE view [dbo].[view_cate3]
as
	-- ----------------------------------
	-- wookki25 / 2016.12.09
	-- 분류정보 확인 / 오라클처럼
	-- ----------------------------------

	-- 대분류
	select 
		ca_code = rtrim(ltrim(cl_lcode))
		, c_level = 1
		, c_name = replace(replace(cl_name, char(13),''), char(10),'')		
		, c_seqno = l.cl_seqno
		, cl_name = replace(replace(cl_name, char(13), ''), char(10), '')
		, cm_name = null
		, cs_name = null
		, cd_name = null
	from c_lcate l with (readuncommitted)

	union all

	-- 중분류
	select 
		ca_code = rtrim(ltrim(cm_lcode)) + rtrim(ltrim(cm_mcode))
		, c_level = 2
		, c_name = replace(replace(cm_name, char(13),''), char(10),'')		
		, c_seqno = m.cm_seqno
		, cl_name = replace(replace(cl_name, char(13), ''), char(10), '')
		, cm_name = replace(replace(cm_name, char(13), ''), char(10), '')
		, cs_name = null
		, cd_name = null
	from c_mcate m with (readuncommitted)
			inner join c_lcate l with (readuncommitted) on cm_lcode = cl_lcode
	
	union all

	-- 소분류
	select 
		ca_code = rtrim(ltrim(cs_lcode)) + rtrim(ltrim(cs_mcode))  + rtrim(ltrim(cs_scode))
		, c_level = 3
		, c_name = replace(replace(cs_name, char(13),''), char(10),'')		
		, c_seqno = s.cs_seqno
		, cl_name = replace(replace(cl_name, char(13), ''), char(10), '')
		, cm_name = replace(replace(cm_name, char(13), ''), char(10), '')
		, cs_name = replace(replace(cs_name, char(13), ''), char(10), '')
		, cd_name = null
	from c_scate s with (readuncommitted)
			inner join c_lcate l with (readuncommitted) on cs_lcode = cl_lcode
			inner join c_mcate m with (readuncommitted) on cs_lcode = cm_lcode and cs_mcode = cm_mcode

	union all

	-- 미분류
	select 
		ca_code = rtrim(ltrim(cd_lcode)) + rtrim(ltrim(cd_mcode))  + rtrim(ltrim(cd_scode)) + rtrim(ltrim(cd_dcode))
		, c_level = 4
		, c_name = replace(replace(cd_name, char(13),''), char(10),'')		
		, c_seqno = d.cd_seqno
		, cl_name = replace(replace(cl_name, char(13), ''), char(10), '')
		, cm_name = replace(replace(cm_name, char(13), ''), char(10), '')
		, cs_name = replace(replace(cs_name, char(13), ''), char(10), '')
		, cd_name = replace(replace(cd_name, char(13), ''), char(10), '')		
	from c_dcate d with (readuncommitted)
			inner join c_lcate l with (readuncommitted) on cd_lcode = cl_lcode
			inner join c_mcate m with (readuncommitted) on cd_lcode = cm_lcode and cd_mcode = cm_mcode
			inner join c_scate s with (readuncommitted) on cd_lcode = cs_lcode and cd_mcode = cs_mcode and cd_scode = cs_scode