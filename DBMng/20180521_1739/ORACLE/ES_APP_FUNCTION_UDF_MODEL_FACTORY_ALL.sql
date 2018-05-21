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
    
    -- ����Ŭ���� �⺻������ &�� Define �����ڷ� ����ϸ�, �ش繮�ڿ��� ��ü�� ���� �־, define ��� ������ �ʿ��ϴ�.
    --SET DEFINE OFF;
    
    -- ���� ���� �ϳ��� ������ ����(space ������)
    SELECT 
        REGEXP_REPLACE(LISTAGG( MODEL_FACTORY_ALL || ' ' ) WITHIN GROUP(ORDER BY MODEL_FACTORY_ALL),'([^ ]+)( \1)*( |$)', '\1\3') AS MODEL_FACTORY_ALL INTO OUT_MODEL_FACTORY
    FROM (
        -- ���Ͽ� �´� ���ڿ� ���ϱ�.
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