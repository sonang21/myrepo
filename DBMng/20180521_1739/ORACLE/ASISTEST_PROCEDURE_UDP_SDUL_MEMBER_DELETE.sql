/* *************************************************************************
 * NAME : ASISTEST.UDP_SDUL_MEMBER_DELETE
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:30
 *        Modify: 2018-05-04 18:53:45
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_SDUL_MEMBER_DELETE" (V_ENURI_USER_ID IN VARCHAR2) IS
  v_eleven_id VARCHAR2(50) :='';
  v_interpark_id VARCHAR2(50) :='';
  v_auction_id VARCHAR2(50) :='';
  v_gmarket_id VARCHAR2(50) :='';
  v_eleven_master_page VARCHAR2(500) :='';
  v_interpark_master_page VARCHAR2(500) :='';
  v_auction_master_page VARCHAR2(500) :='';
  v_gmarket_master_page VARCHAR2(500) :='';

BEGIN

  begin
    SELECT nvl(eleven_id,'') eleven_id, nvl(interpark_id,'') interpark_id, nvl(auction_id, '') auction_id, nvl(gmarket_id,'') gmarket_id, nvl(eleven_master_page, '') eleven_master_page, nvl(interpark_master_page, '') interpark_master_page, nvl(auction_master_page, '') auction_master_page, nvl(gmarket_master_page, '') gmarket_master_page into v_eleven_id, v_interpark_id, v_auction_id, v_gmarket_id, v_eleven_master_page, v_interpark_master_page, v_auction_master_page, v_gmarket_master_page 
    FROM TBL_SDUL_MEMBER WHERE ENURI_USER_ID = V_ENURI_USER_ID;
    
    exception
    when no_data_found then null;
    when others then
    null;
  end;

  -- sdul 회원 탈퇴 로그
  INSERT INTO TBL_SDUL_MEMBER_DEL_LOG(ENURI_USER_ID, ELEVEN_ID, INTERPARK_ID, AUCTION_ID, GMARKET_ID, ELEVEN_MASTER_PAGE, INTERPARK_MASTER_PAGE, AUCTION_MASTER_PAGE, GMARKET_MASTER_PAGE, DELETE_DATE)
  VALUES (V_ENURI_USER_ID, v_eleven_id, v_interpark_id, v_auction_id, v_gmarket_id, v_eleven_master_page, v_interpark_master_page, v_auction_master_page, v_gmarket_master_page, sysdate);
  
  -- SUDL 회원정보 업데이트
  UPDATE tbl_sdul_member SET bid_status='', INTERPARK_ID = '', AUCTION_ID = '', GMARKET_ID = '',  ELEVEN_ID = '', GSESTORE_ID = '',  NATEMALL_ID = '',  GMARKET_MASTER_PAGE = '', ELEVEN_MASTER_PAGE= '', AUCTION_MASTER_PAGE = '',  INTERPARK_MASTER_PAGE = '', AUCTION_POWERSEL ='', GMARKET_POWERSEL = '', ELEVEN_POWERSEL='', INTERPARK_POWERSEL =''
  WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 상품테이블의 bid_flag 업데이트
  UPDATE tbl_sdul_powerseller SET powersel_status=5
  WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- sdul 상품테이블 삭제
  DELETE tbl_sdul_goods WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 상위입찰 상품테이블 삭제
  DELETE tbl_bid_user_goods WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 상위입찰 테이블 삭제
  DELETE tbl_bid_goods_exp WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 상위입찰 찜상품 테이블 삭제
  DELETE tbl_bid_user_zzim WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 상위입찰 효과보고서 테이블 삭제
  DELETE tbl_bid_report WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 상품테이블의 bid_flag 업데이트
  UPDATE tbl_pricelist SET bid_flag='' WHERE pl_no in (SELECT pl_no FROM tbl_bid_goods_exp WHERE enuri_user_id= V_ENURI_USER_ID);
  
  -- 판매자 광고 문구 테이블 삭제
  DELETE tbl_sad_goods WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 판매자 광고 찜상품 테이블 삭제
  DELETE tbl_sad_user_zzim WHERE enuri_user_id = V_ENURI_USER_ID;
  
  -- 판매자 광고 효과보고서 테이블 삭제
  DELETE tbl_sad_report WHERE enuri_user_id = V_ENURI_USER_ID;
  
  COMMIT;
  
END UDP_SDUL_MEMBER_DELETE;