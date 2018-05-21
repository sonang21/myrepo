/* *************************************************************************
 * NAME : ES_APP.UDF_CATEGORY_SUB
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-30 16:43:52
 *        Modify: 2018-03-30 16:43:52
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "ES_APP"."UDF_CATEGORY_SUB" 
(
  IN_CATEGORY IN VARCHAR2,
  IN_SUBSTR IN NUMBER
) RETURN VARCHAR2 AS 
    V_CATEGORY VARCHAR2(2000) := '';
BEGIN
    
    ---- �ϳ��� ������ ����
    SELECT REGEXP_REPLACE(LISTAGG( CATEGORY || ' ' ) WITHIN GROUP(ORDER BY CATEGORY),'([^ ]+)( \1)*( |$)', '\1\3') AS CATEGORY INTO V_CATEGORY
    FROM (
        -- �� CATEGORY���� �Ķ���Ͱ� ũ�� ���� (��/��/�� ��) �� ���·� �籸�� �� �ߺ�����
        SELECT DISTINCT SUBSTR(CATEGORY,0,IN_SUBSTR)  AS CATEGORY
        FROM (
            -- �Ķ���ͷ� �Ѿ�� CATEGORY ���� ���������� �и�
            SELECT DISTINCT TRIM(REGEXP_SUBSTR(CATEGORY, '[^ ]+', 1, LEVEL))  CATEGORY
            FROM ( SELECT IN_CATEGORY AS CATEGORY FROM DUAL )
            CONNECT BY INSTR(CATEGORY, ' ', 1, LEVEL -1) > 0
            )
        WHERE LENGTH(CATEGORY) >= IN_SUBSTR
        )
    ;
    
    RETURN V_CATEGORY;

END UDF_CATEGORY_SUB;