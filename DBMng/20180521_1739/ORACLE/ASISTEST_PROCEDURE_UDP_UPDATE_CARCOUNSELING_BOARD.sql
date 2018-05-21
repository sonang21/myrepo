/* *************************************************************************
 * NAME : ASISTEST.UDP_UPDATE_CARCOUNSELING_BOARD
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:32
 *        Modify: 2018-05-07 13:11:16
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_UPDATE_CARCOUNSELING_BOARD" 
IS

BEGIN
    UPDATE tbl_car_counseling_board SET cb_delflag = 'Y' WHERE trunc(cb_buydate,'dd') < trunc(sysdate,'dd') and cb_reply = '0';
    commit;
END UDP_UPDATE_CARCOUNSELING_BOARD;