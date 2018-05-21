/* *************************************************************************
 * NAME : ES_APP.UDF_MODEL_FACTORY_ALL
 * TYPE : FUNCTION
 * TIME : Create: 2018-04-05 10:19:08
 *        Modify: 2018-04-05 10:19:08
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_MODEL_FACTORY_ALL" 
(
    IN_MODEL_FACTORY IN VARCHAR2
)
RETURN VARCHAR2 AS 
    OUT_MODEL_FACTORY VARCHAR2(2000) := '';
    V_PATTERN VARCHAR2(100) := '[a-zA-Z|0-9]+[-|.|_|a-zA-Z|0-9]*[a-zA-Z|0-9]+';
BEGIN
    
    -- 오라클에서 기본적으로 &를 Define 구분자로 사용하며, 해당문자열이 대체될 수가 있어서, define 모드 해제가 필요하다.
    --SET DEFINE OFF;
    
    -- 여러 행을 하나의 행으로 통합(space 구분자)
    SELECT 
        REGEXP_REPLACE(LISTAGG( MODEL_FACTORY_ALL || ' ' ) WITHIN GROUP(ORDER BY MODEL_FACTORY_ALL),'([^ ]+)( \1)*( |$)', '\1\3') AS MODEL_FACTORY_ALL INTO OUT_MODEL_FACTORY
    FROM (
        -- 패턴에 맞는 문자열 구하기.
        SELECT
            DISTINCT REGEXP_SUBSTR(MODEL_FACTORY, V_PATTERN, 1, LEVEL) AS MODEL_FACTORY_ALL
        FROM (
            SELECT
                IN_MODEL_FACTORY AS MODEL_FACTORY 
            FROM DUAL
            WHERE 1=1
            )
        WHERE 2=2
        CONNECT BY LEVEL <= LENGTH(REGEXP_REPLACE(MODEL_FACTORY, V_PATTERN)) + 1
        )
    WHERE 3=3
    ;
    
    RETURN OUT_MODEL_FACTORY;
    
END UDF_MODEL_FACTORY_ALL;