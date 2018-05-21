/* *************************************************************************
 * NAME : dbo.udp_cj_cate_attr_sub_sel
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2017-03-15 16:48:18.73
 *        Modify: 2018-05-03 17:23:35.953
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_cj_cate_attr_sub_sel
	@cj_ca_code char(6)
AS  begin
	set nocount on 
	set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- �ۼ��� : wookki25 / 2017.03.14
	-- ��   �� : cj �Ӽ� ������.�Һз� �󼼼Ӽ�
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- ��������
	-- ----------------------------------------------
	/* 
	������:			������:				��������:
	-------------------------------------------------
	*/
	select c.attr_sub_code, c.attr_sub_name
	from tbl_cj_cate_attr_main a 
		inner join tbl_cj_attr_main_sub  b on a.attr_main_code = b.attr_main_code
		inner join tbl_cj_attr_sub c on b.attr_sub_code = c.attr_sub_code
	where a.cj_ca_code = @cj_ca_code
	order by 1 asc
end