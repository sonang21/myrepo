/* *************************************************************************
 * NAME : dbo.udp_goods_chk_missing_ins
 * TYPE : PROCEDURE (SQL_STORED_PROCEDURE)
 * TIME : Create: 2018-05-20 15:20:30.597
 *        Modify: 2018-05-20 15:20:30.597
 *        Backup: 20180521_1739
 ************************************************************************* */

create proc udp_goods_chk_missing_ins
as begin
	SET NOCOUNT ON 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    truncate table goods_chk_missing_value

    insert into goods_chk_missing_value(g_modelno, regdate)
    select a.g_modelno, getdate()
      from goods a  with (readuncommitted)
           inner join goods_sum b with (readuncommitted) on a.g_modelno = b.g_modelno
    where 
	    left(g_category, 2) <> ('93') 
    and g_jobcode > '0' 
    and g_mallcnt > 0
    and 
    (

	    (
		    g_constrain = '1' and ( -- 일반
			    ltrim(rtrim(isnull(g_modelnm, ''))) = '' 
			    or ltrim(rtrim(isnull(g_factory, ''))) = '' 
			    or ltrim(rtrim(isnull(g_brand, ''))) = '' 
			    or ltrim(rtrim(isnull(g_spec2, ''))) = '' 
			    or isnull(maker_id, 0) = 0 
			    or isnull(brand_id, 0) = 0
		    )
	    )
	    or 	
	    (
		    g_constrain = '5' and ( -- 유사상품
			    ltrim(rtrim(isnull(g_modelnm, ''))) = '' 
			    or ltrim(rtrim(isnull(g_factory, ''))) = ''
		    )
	    )
    )
    option (maxdop 1)
end