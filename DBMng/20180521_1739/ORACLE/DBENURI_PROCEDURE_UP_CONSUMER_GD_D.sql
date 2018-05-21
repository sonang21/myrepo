/* *************************************************************************
 * NAME : DBENURI.UP_CONSUMER_GD_D
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-17 15:41:10
 *        Modify: 2018-05-17 15:45:53
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UP_CONSUMER_GD_D" ( in_goods IN goods_type )
is

/******************************************************************************
**  Name: up_consumer_gd_d
**  Desc: Consumer에서 신규 모델 정보 반영 시 연관 테이블에 데이터 생성 프로세스
**
**  Called by: 호출 프로그램 또는 모듈
**
**  Parameters:
**     Input                         Output
**     ----------                    -----------
**     in_goods: 모델 데이터셋      출력변수: 변수설명
**
**  Example : 실행 예시 (exec up_consumer_gd_d(v1))
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018.05.14   SSH              프로시져 신규 생성
*******************************************************************************/

begin

  DELETE
    FROM dbenuri.tbl_goods
   WHERE MODELNO = in_goods.model_no;
  

  DELETE
    FROM dbenuri.tbl_goods_sum
   WHERE MODELNO = in_goods.model_no;

 
  DELETE
    FROM dbenuri.tbl_cate_goods
   WHERE MODELNO = in_goods.model_no;


exception
  when others then
  null;
end;