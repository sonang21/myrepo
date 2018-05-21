/* *************************************************************************
 * NAME : DBENURI.UDP_UPDATE_CARCOUNSELING_BOARD
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:01
 *        Modify: 2018-03-28 18:50:03
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_UPDATE_CARCOUNSELING_BOARD" 
IS

BEGIN
    UPDATE tbl_car_counseling_board SET cb_delflag = 'Y' WHERE trunc(cb_buydate,'dd') < trunc(sysdate,'dd') and cb_reply = '0';
    commit;
END UDP_UPDATE_CARCOUNSELING_BOARD;