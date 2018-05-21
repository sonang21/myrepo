/* *************************************************************************
 * NAME : dbo.udp_goods_aircon_title
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2014-05-23 11:30:07.19
 *        Modify: 2018-05-03 17:23:34.437
 *        Backup: 20180521_1737
 ************************************************************************* */


CREATE proc udp_goods_aircon_title
as 
	set nocount on 
	--set transaction isolation level read uncommitted
	-- ----------------------------------------------
	-- 작성자 : wookki25 / 2014-05-23
	-- 설  명 : 에어컨 상품창 좌우구분 타이틀 관리
	-- ----------------------------------------------
	-- ----------------------------------------------
	-- 수정내역
	-- ----------------------------------------------
	/* 
	수정일:			수정자:			수정내용:
	-------------------------------------------------
	*/

	--delete openquery(oradb, 'select modelno, flag from tbl_modelno_aircon') 
	--select @@rowcount

	insert openquery(oradb, 'select modelno, flag from tbl_modelno_aircon') 
	select a.g_modelno
		, case 
			when is_multi=1 and is_inverter is null then '1' 
			when is_multi=1 and is_inverter=1 then '2'
			when is_multi=0 and is_inverter is null then '3'
			when is_multi=0 and is_inverter=1 then '4'
		end
	from 
	(select distinct g_modelno, case when attribute_element_id in (1,2) then 1 else 0 end as is_multi from goods_catalog_attribute with(readuncommitted) where attribute_id = 191292 and attribute_element_id in (1,2,6,4) and del_yn = 'N') a
		left outer join 
	(select distinct g_modelno, 1 as is_inverter from goods_catalog_attribute with(readuncommitted) where attribute_id = 195999 and del_yn = 'N') b
	on a.g_modelno = b.g_modelno
