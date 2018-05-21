/* *************************************************************************
 * NAME : ASISTEST.UDP_AUTO_SUM_POPULAR
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-04 18:33:15
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "ASISTEST"."UDP_AUTO_SUM_POPULAR" 
IS


BEGIN
    --set serveroutput on;
    --DBMS_OUTPUT.ENABLE;
    --DBMS_OUTPUT.PUT_LINE('UDP_SUM_POPULAR start ......');

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_AUTO_SUM_POPULAR','START');
    COMMIT;
    
    -- AUTO_SPEC 인기도 계산
    FOR tmp_loop in (SELECT A.modelno_no,count(*) cnt,trunc(max(A.regdate)-min(A.regdate))+1 daydiff FROM TBL_AUTO_POPULAR_LOG A,TBL_AUTO_SPEC B
        WHERE A.MODELNO_NO = B.MODELNO
        AND (B.SERVICE_YN = 'Y' or B.SERVICE_YN = 'S')
        AND A.regdate >= to_char(sysdate-30,'YYYYMMDD') AND A.regdate < to_char(sysdate,'YYYYMMDD') GROUP BY A.modelno_no) LOOP

        BEGIN
            UPDATE TBL_AUTO_SPEC SET POPULAR = trunc(tmp_loop.cnt/tmp_loop.daydiff) WHERE modelno=tmp_loop.modelno_no;
            EXCEPTION WHEN OTHERS THEN
            COMMIT;
        END;

    END LOOP;
    COMMIT;


    -- 제조사 인기도 계산
    FOR tmp_loop in (SELECT maker,sum(popular) point FROM TBL_AUTO_SPEC WHERE (SERVICE_YN = 'Y' or SERVICE_YN = 'S') GROUP BY maker) LOOP

        BEGIN
            DELETE /*+ APPEND NOLOGGING t */ TBL_AUTO_MAKER_POPULAR t WHERE maker=tmp_loop.maker AND m_date=to_char(sysdate-1,'YYYYMMDD');
            INSERT INTO TBL_AUTO_MAKER_POPULAR(maker,m_date,m_point) VALUES(tmp_loop.maker,to_char(sysdate-1,'YYYYMMDD'),tmp_loop.point);
            UPDATE TBL_AUTO_MAKER SET POPULAR = tmp_loop.point WHERE maker=tmp_loop.maker;
            EXCEPTION WHEN OTHERS THEN
            COMMIT;
        END;

    END LOOP;
    COMMIT;

    -- 차량명 인기도 계산
    FOR tmp_loop in (SELECT maker,auto_name,sum(popular) point FROM TBL_AUTO_SPEC WHERE (SERVICE_YN = 'Y' or SERVICE_YN = 'S') GROUP BY maker,auto_name) LOOP

        BEGIN
            DELETE /*+ APPEND NOLOGGING t */ TBL_AUTO_NAME_POPULAR t WHERE maker=tmp_loop.maker AND auto_name=tmp_loop.auto_name AND n_date=to_char(sysdate-1,'YYYYMMDD');
            INSERT INTO TBL_AUTO_NAME_POPULAR(maker,auto_name,n_date,n_point) VALUES(tmp_loop.maker,tmp_loop.auto_name,to_char(sysdate-1,'YYYYMMDD'),tmp_loop.point);
            UPDATE TBL_AUTO_NAME SET POPULAR = tmp_loop.point WHERE maker=tmp_loop.maker AND auto_name=tmp_loop.auto_name;
        EXCEPTION WHEN OTHERS THEN
            COMMIT;
        END;

    END LOOP;
    COMMIT;

    -- 그룹 인기도 계산
    FOR tmp_loop in (SELECT A.ag_no2,sum(A.popular) point FROM TBL_AUTO_SPEC A, TBL_AUTO_GROUP B
                    WHERE A.AG_NO2=B.AG_NO AND (A.SERVICE_YN = 'Y' or A.SERVICE_YN = 'S') GROUP BY A.ag_no2) LOOP

        BEGIN
            DELETE /*+ APPEND NOLOGGING t */ TBL_AUTO_GROUP_POPULAR t WHERE ag_no=tmp_loop.ag_no2 AND ag_date=to_char(sysdate-1,'YYYYMMDD');
            INSERT INTO TBL_AUTO_GROUP_POPULAR(ag_no,ag_date,g_point) VALUES(tmp_loop.ag_no2,to_char(sysdate-1,'YYYYMMDD'),tmp_loop.point);
            UPDATE TBL_AUTO_GROUP SET POPULAR = tmp_loop.point WHERE ag_no=tmp_loop.ag_no2;
            EXCEPTION WHEN OTHERS THEN
            COMMIT;
        END;

    END LOOP;
    COMMIT;

    -- 스타일 인기도 계산
    FOR tmp_loop in (SELECT A.as_no,sum(c.g_point) point FROM TBL_AUTO_STYLE A, TBL_AUTO_STYLE_GROUP B, TBL_AUTO_GROUP_POPULAR C
                    WHERE A.AS_NO=B.AS_NO AND B.AG_NO=C.AG_NO GROUP BY A.as_no) LOOP

        BEGIN
            DELETE /*+ APPEND NOLOGGING t */ TBL_AUTO_STYLE_POPULAR t WHERE as_no=tmp_loop.as_no AND as_date=to_char(sysdate-1,'YYYYMMDD');
            INSERT INTO TBL_AUTO_STYLE_POPULAR(as_no,as_date,s_point) VALUES(tmp_loop.as_no,to_char(sysdate-1,'YYYYMMDD'),tmp_loop.point);
            UPDATE TBL_AUTO_STYLE SET POPULAR = tmp_loop.point WHERE as_no=tmp_loop.as_no;
            EXCEPTION WHEN OTHERS THEN
            COMMIT;
        END;

    END LOOP;
    COMMIT;

    DELETE /*+ APPEND NOLOGGING t */ TBL_AUTO_POPULAR_LOG t WHERE regdate < sysdate-30;
    COMMIT;

    -- 인기순위계산
    FOR tmp_loop in (select rownum ranking,popular,modelno from (select modelno,popular from tbl_auto_spec WHERE (SERVICE_YN = 'Y' or SERVICE_YN = 'S') order by popular desc, modelno desc)) LOOP

        BEGIN
            UPDATE TBL_AUTO_SPEC SET RANKING_ALL = tmp_loop.ranking WHERE modelno=tmp_loop.modelno;
            EXCEPTION WHEN OTHERS THEN
            COMMIT;
        END;

    END LOOP;
    COMMIT;

    --sys log
    INSERT INTO TBL_SYS_PROC_LOG (NAME, STATUS) VALUES ('UDP_AUTO_SUM_POPULAR','END');
    COMMIT;
    
END UDP_AUTO_SUM_POPULAR;