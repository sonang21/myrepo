/* *************************************************************************
 * NAME : dbo.udp_cjtbl_cj_goods_attr_sub_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-16 09:03:37.37
 *        Modify: 2018-05-03 17:23:34.377
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE proc udp_cjtbl_cj_goods_attr_sub_sel
	@goodscode  varchar(10)
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2017.03.14
	-- 설   명 : cj 속성 컨설팅.상품코에 매칭된 속성 릿흐트
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:				수정내용:
	-------------------------------------------------
	*/
	select b.attr_sub_code, e.attr_main_name+' : '+f.attr_sub_name 
	from tbl_cj_goods a
		inner join tbl_cj_goods_attr_sub b on a.goodscode = b.goodscode -- goods에 매핑된 sub
		inner join tbl_cj_attr_main_sub c on b.attr_sub_code = c.attr_sub_code -- main_code
		inner join tbl_cj_cate_attr_main d on a.cj_ca_code4_job = d.cj_ca_code  and c.attr_main_code = d.attr_main_code
		inner join tbl_cj_attr_main e on d.attr_main_code = e.attr_main_code
		inner join tbl_cj_attr_sub  f on b.attr_sub_code = f.attr_sub_code
	where a.goodscode = @goodscode
	order by e.attr_main_name asc, b.attr_sub_code asc
end

