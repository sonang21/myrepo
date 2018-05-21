/* *************************************************************************
 * NAME : DBENURI.UDP_CATE_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-05-15 13:19:40
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_CATE_GOODS" 
is
/*
 NGIT 수정 반영 - 김영원 20180423
*/
/******************************************************************************
**  Name: UDP_CATE_GOODS
**  Desc: MCSS에서 쇼핑몰명 = "11번가" 형태 = "카탈外압축" 시 사용하는 TEMP 데이터 생성
**        보통 AM 06:30 에 호출됨
**
**  Called by: http://100.100.100.229:8080/offer/MCSS_11st/data_extract_batch.jsp
**
**  Parameters:
**     Input                        Output
**     ----------                   -----------
**
**
**  Example : 실행 예시 (exec UDP_CATE_GOODS;)
*******************************************************************************
**  Change History
*******************************************************************************
**  Date:         Author:         Description:
**  --------      --------        -------------------------------------
**  2018-03-12    김 영원         김형준 수석님 요청으로
**                                ELOC2001(164 MS-SQL)에서 건건히 TBL_GOODS를 조회하던 방식에서
**                                템프로 한번에 전송하는 방식으로 바꿈
**  2018-03-15    김 영원         김형준 수석님 요청으로
**                                TMPT_MCSS_GOODS 을 20개 hash partition으로 생성
******************************************************************************
*/
  l_sql varchar2(4000);
begin

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_CATE_GOODS','START');
  commit;

  begin
    execute immediate ('drop table TMPT_MCSS_CATEGORY purge');
  exception
    when others then
      if sqlcode != -942 then
        raise;
      end if;
  end;

  begin
    execute immediate ('drop table TMPT_MCSS_GOODS purge');
  exception
    when others then
      if sqlcode != -942 then
        raise;
      end if;
  end;

  l_sql := 'CREATE TABLE TMPT_MCSS_CATEGORY AS
            WITH RECURSIVECATE(CA_CODE, C_NAME, C_LEVEL, C_SEQNO, C_CODE_FULL, C_NAME_FULL, PARENT_CODE, IS_FINAL_DEPTH) AS (
            SELECT CA_CODE, C_NAME, C_LEVEL, C_SEQNO
                 , SUBSTR(A.CA_CODE, (A.C_LEVEL * 2) - 1, 2) AS C_CODE_FULL
                 , C_NAME AS C_NAME_FULL
                 , '''' AS PARENT_CODE
                 , (CASE WHEN A.C_LEVEL = 4 THEN ''Y'' WHEN EXISTS(SELECT ''Y'' FROM TBL_CATEGORY C WHERE C.CA_CODE LIKE A.CA_CODE || ''%'' AND C.C_LEVEL > A.C_LEVEL AND C.C_SEQNO > 0 AND C.C_NAME IS NOT NULL AND INSTR(C.CA_CODE, '' '') = 0 AND INSTR(
            UPPER(C.CA_CODE), ''XX'') = 0 AND INSTR(UPPER(C.C_NAME), ''TEMP'') = 0 AND INSTR(UPPER(C.C_NAME), ''BLANK'') = 0) THEN '' '' ELSE ''Y'' END) IS_FINAL_DEPTH
               FROM TBL_CATEGORY A
               WHERE C_LEVEL = 1 AND A.C_SEQNO > 0 AND A.C_NAME IS NOT NULL AND INSTR(A.CA_CODE, '' '') = 0 AND INSTR(UPPER(A.CA_CODE), ''XX'') = 0 AND INSTR(UPPER(A.C_NAME), ''TEMP'') = 0 AND INSTR(UPPER(A.C_NAME), ''BLANK'') = 0
                 AND CA_CODE1 IN (''02'', ''03'', ''04'', ''05'', ''06'', ''07'', ''08'', ''09'', ''10'', ''12'', ''14'', ''15'', ''16'', ''18'', ''21'', ''22'', ''24'', ''93'')
               UNION ALL
               SELECT A.CA_CODE, A.C_NAME, A.C_LEVEL, A.C_SEQNO
                 , B.C_CODE_FULL || ''^'' || SUBSTR(A.CA_CODE, (A.C_LEVEL * 2) - 1, 2)  AS C_CODE_FULL
                 , B.C_NAME_FULL || ''^'' || A.C_NAME  AS C_NAME_FULL
                 , B.CA_CODE PARENT_CODE
                 , (CASE WHEN A.C_LEVEL = 4 THEN ''Y'' WHEN EXISTS(SELECT ''Y'' FROM TBL_CATEGORY C WHERE C.CA_CODE LIKE A.CA_CODE || ''%'' AND C.C_LEVEL > A.C_LEVEL AND C.C_SEQNO > 0 AND C.C_NAME IS NOT NULL AND INSTR(C.CA_CODE, '' '') = 0 AND INSTR(
            UPPER(C.CA_CODE), ''XX'') = 0 AND INSTR(UPPER(C.C_NAME), ''TEMP'') = 0 AND INSTR(UPPER(C.C_NAME), ''BLANK'') = 0) THEN '' '' ELSE ''Y'' END) IS_FINAL_DEPTH
               FROM TBL_CATEGORY A
                INNER JOIN RECURSIVECATE B ON A.CA_CODE LIKE B.CA_CODE || ''%'' AND A.C_LEVEL =  B.C_LEVEL + 1
               WHERE A.C_SEQNO > 0 AND A.C_NAME IS NOT NULL AND INSTR(A.CA_CODE, '' '') = 0 AND INSTR(UPPER(A.CA_CODE), ''XX'') = 0 AND INSTR(UPPER(A.C_NAME), ''TEMP'') = 0 AND INSTR(UPPER(A.C_NAME), ''BLANK'') = 0
              )
              SELECT CA_CODE, C_NAME, C_LEVEL, C_SEQNO, C_CODE_FULL, C_NAME_FULL, NVL(PARENT_CODE, '' '') PARENT_CODE, IS_FINAL_DEPTH
              FROM RECURSIVECATE ';
   -- dbms_output.put_line(l_sql);
   execute immediate (l_sql);

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_CATE_GOODS','RUNNING');
  commit;

  l_sql := 'CREATE TABLE TMPT_MCSS_GOODS  partition by hash(mod_20) partitions 20  AS
            SELECT A.MODELNO, A.CA_CODE, A.MODELNO_GROUP, A.MODELNM, A.CONDINAME, A.FACTORY, A.BRAND, A.CONSTRAIN, A.IMGCHK3, B.MALLCNT, B.MINPRICE, B.MAXPRICE, B.AVGPRICE, A.SPEC, A.KEYWORD2, A.FUNC, B.POPULAR, A.C_DATE, A.MODDATE, mod(rownum, 20) as mod_20
              FROM TBL_GOODS A, TBL_GOODS_SUM B, 
                   (SELECT DISTINCT CATEGORY
                      FROM (
                       SELECT CA_CODE || ''000000'' CATEGORY
                       FROM TMPT_MCSS_CATEGORY A
                       WHERE A.C_LEVEL = 1
                       UNION ALL
                       SELECT CA_CODE || ''0000'' CATEGORY
                       FROM TMPT_MCSS_CATEGORY A
                       WHERE A.C_LEVEL = 2
                       UNION ALL
                       SELECT CA_CODE || ''00'' CATEGORY
                       FROM TMPT_MCSS_CATEGORY A
                       WHERE A.C_LEVEL = 3
                       UNION ALL
                       SELECT CA_CODE CATEGORY
                       FROM TMPT_MCSS_CATEGORY
                       WHERE C_LEVEL = 4  ) A
                   ) CA
             WHERE A.MODELNO = B.MODELNO
               AND A.CA_CODE = CA.CATEGORY
               AND B.MALLCNT > 0 AND A.JOBCODE > ''0'' AND A.CONSTRAIN IN (''1'',''5'')';
  -- dbms_output.put_line(l_sql);
  execute immediate (l_sql);

  insert into TBL_SYS_PROC_LOG (name, status) values ('UDP_CATE_GOODS','END');
  commit;

end UDP_CATE_GOODS;
