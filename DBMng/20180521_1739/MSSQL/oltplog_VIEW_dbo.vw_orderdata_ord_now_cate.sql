/* *************************************************************************
 * NAME : dbo.vw_orderdata_ord_now_cate
 * TYPE : VIEW (VIEW)
 * TIME : Create: 2018-05-17 12:44:47.733
 *        Modify: 2018-05-17 12:44:47.733
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE view vw_orderdata_ord_now_cate
as  
	select od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
		od_price,od_cnt,pl_no,pl_modelno, isnull(g_category, od_category) as od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
	from 
	(
		select od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
		od_price,od_cnt,pl_no,pl_modelno,od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
		from dbo.tbl_orderdata with (readuncommitted) 
		where shop_vcode not in (55, 536, 5910, 4027)
		union all
		select od_tid,shop_vcode,od_id,od_id_no,od_date,od_goodscode,od_goodsnm,
		od_price,od_cnt,pl_no,pl_modelno,od_category,od_flag,od_jumin_yyyy,od_jumin_sex 
		from dbo.tbl_orderdata_gmarket_auction with (readuncommitted)
	) aa  left outer join  analstore.dbo.goods on pl_modelno = g_modelno 


