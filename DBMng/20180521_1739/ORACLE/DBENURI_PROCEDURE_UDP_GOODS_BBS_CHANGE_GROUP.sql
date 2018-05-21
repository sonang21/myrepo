/* *************************************************************************
 * NAME : DBENURI.UDP_GOODS_BBS_CHANGE_GROUP
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 16:51:57
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_GOODS_BBS_CHANGE_GROUP" 
(
    v_modelno IN tbl_goods.modelno%TYPE,
    v_modelno_group_old IN tbl_goods.modelno_group%TYPE,
    v_modelno_group_new IN tbl_goods.modelno_group%TYPE
)
/*
 NGIT 수정 반영 - 김영원 20180426
*/
IS
    v_bbs_num                   NUMBER(8) := 0;
    v_bbs_point                 NUMBER(8) := 0;
    v_bbs_point_avg             NUMBER(6,2) := 0;
    
-- modelno_group이 변경되는 경우 tbl_goods의 상품평 정보 업데이트
-- TBL_GOOD와 TBL_GOODS_BBS를 업데이트 한 후 modelno 단위로 본 프로시저호출
BEGIN

        -- 1. 변경전 그룹모델 기준 재계산
        --    그룹모델이 있는 경우만 고려: 변경 전 그룹모델이 없는 경우는 2에서 업데이트 됨
        IF v_modelno_group_old is not null THEN
            SELECT	COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) 
            INTO v_bbs_num,v_bbs_point_avg,v_bbs_point 
            FROM TBL_GOODS_BBS 
            WHERE modelno_group = v_modelno_group_old
            AND delflag='N';
                            
            UPDATE TBL_GOODS_SUM SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
             WHERE modelno in (select s.modelno from TBL_GOODS s where s.modelno_group = v_modelno_group_old);
            
            COMMIT;
        END IF;
            
    v_bbs_num                    := 0;
    v_bbs_point                  := 0;
    v_bbs_point_avg              := 0;

        -- 2. 변경후 그룹모델 기준 재계산
        -- 2.1 그룹모델로 변경된 경우
        IF v_modelno_group_new is not null THEN
            SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) 
            INTO v_bbs_num,v_bbs_point_avg,v_bbs_point 
            FROM TBL_GOODS_BBS 
            WHERE (modelno_group = v_modelno_group_new)
            AND delflag='N';
                            
            UPDATE TBL_GOODS_SUM SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
             WHERE modelno in (select s.modelno from TBL_GOODS s where s.modelno_group = v_modelno_group_new);
            
            COMMIT;
        
        ELSE        
        -- 2.2 그룹모델이 제거된 경우
            SELECT COUNT(*), NVL(AVG(case when point=0 then null else point end),0), SUM(NVL(point,0)) 
            INTO v_bbs_num,v_bbs_point_avg,v_bbs_point 
            FROM TBL_GOODS_BBS 
            WHERE (modelno = v_modelno)
            AND delflag='N';
                            
            UPDATE TBL_GOODS_SUM SET BBS_NUM=v_bbs_num, BBS_POINT=v_bbs_point, BBS_POINT_AVG=v_bbs_point_avg
            WHERE modelno = v_modelno;
            
            COMMIT;
                    
        END IF;
        
END UDP_GOODS_BBS_CHANGE_GROUP;
