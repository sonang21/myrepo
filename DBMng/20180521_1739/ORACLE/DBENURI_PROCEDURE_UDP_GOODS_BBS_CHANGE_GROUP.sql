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
 NGIT ���� �ݿ� - �迵�� 20180426
*/
IS
    v_bbs_num                   NUMBER(8) := 0;
    v_bbs_point                 NUMBER(8) := 0;
    v_bbs_point_avg             NUMBER(6,2) := 0;
    
-- modelno_group�� ����Ǵ� ��� tbl_goods�� ��ǰ�� ���� ������Ʈ
-- TBL_GOOD�� TBL_GOODS_BBS�� ������Ʈ �� �� modelno ������ �� ���ν���ȣ��
BEGIN

        -- 1. ������ �׷�� ���� ����
        --    �׷���� �ִ� ��츸 ���: ���� �� �׷���� ���� ���� 2���� ������Ʈ ��
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

        -- 2. ������ �׷�� ���� ����
        -- 2.1 �׷�𵨷� ����� ���
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
        -- 2.2 �׷���� ���ŵ� ���
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
