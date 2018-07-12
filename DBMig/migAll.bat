SET LOG_GROUP=%date:~5,2%%date:~8,2%_D01

call mig xmls\analstore.dbo.C_LCATE.xml                         %LOG_GROUP%
call mig xmls\analstore.dbo.C_MCATE.xml                         %LOG_GROUP%
call mig xmls\analstore.dbo.goods_attribute.xml                 %LOG_GROUP%
call mig xmls\analstore.dbo.goods_catalog_attribute.xml         %LOG_GROUP%
call mig xmls\analstore.dbo.GOODS_REFERENCE.xml                 %LOG_GROUP%
call mig xmls\analstore.dbo.goods_reference_monitor.xml         %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_cpg_g_cnt_by_cate.xml           %LOG_GROUP%
call mig xmls\analstore.dbo.TBL_CPG_MIN_PRICE_CNT.xml           %LOG_GROUP%
call mig xmls\analstore.dbo.TBL_CPG_MIN_PRICE_CNT_CASE2.xml     %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_cpg_p_cnt_by_cate.xml           %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_cpg_p_cnt_by_shop.xml           %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_cpg_p_cnt_by_shop_cate.xml      %LOG_GROUP%
call mig xmls\analstore.dbo.TBL_CPG_P_CNT_BY_SHOP_TEMP.xml      %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_cpg_pop_by_shop_cate.xml        %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_mcate_popular_rank.xml          %LOG_GROUP%
call mig xmls\analstore.dbo.TBL_PRICE_SHOP_POPULAR.xml          %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_price_shop_popular_v2.xml       %LOG_GROUP%
call mig xmls\analstore.dbo.tbl_price_shop_popular_v2_agg.xml   %LOG_GROUP%
call mig xmls\analstore.dbo.TMP_GOODS_FOR_GRAPH.xml             %LOG_GROUP%
