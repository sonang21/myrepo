/* *************************************************************************
 * NAME : dbo.vw_pricelist_del_data
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2016-07-26 14:44:18.793
 *        Modify: 2016-07-26 14:44:18.793
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE view vw_pricelist_del_data
--with schemabinding
as 
	select pl_no, pl_vcode, pl_goodscode, pl_goodscode_cs, pl_goodsnm, pl_modelno, pl_copyplno, pl_category, pl_price, pl_url from  analsdw.dbo.pricelist_del_data_to_20150630
	union all
	select pl_no, pl_vcode, pl_goodscode, pl_goodscode_cs, pl_goodsnm, pl_modelno, pl_copyplno, pl_category, pl_price, pl_url from  analsdw.dbo.pricelist_del_data_to_20151015
	union all
	select pl_no, pl_vcode, pl_goodscode, pl_goodscode_cs, pl_goodsnm, pl_modelno, pl_copyplno, pl_category, pl_price, pl_url from  analsdw.dbo.pricelist_del_data_to_20160715
	union all
	select pl_no, pl_vcode, pl_goodscode, pl_goodscode_cs, pl_goodsnm, pl_modelno, pl_copyplno, pl_category, pl_price, pl_url from  analsdw.dbo.pricelist_del_data
	

