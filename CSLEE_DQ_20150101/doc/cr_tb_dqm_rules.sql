-- DDL Script was generated by Orange for ORACLE
-- using session 'DBADM@NPIMSSTD' on '2014/11/25 10:36:12'.

drop TABLE DQ_ADM.TB_DQM_RULES2 purge;

CREATE TABLE DQ_ADM.TB_DQM_RULES2
(
    RULE_ID         VARCHAR2(20) NOT NULL,
    RULE_TYPE       VARCHAR2(50),
    LCLS_NM         VARCHAR2(100),
    MCLS_NM         VARCHAR2(100),
    TGT_DB_NM       VARCHAR2(50),
    TGT_TAB_NM      VARCHAR2(50),
    TGT_COL_NM      VARCHAR2(50),
    TGT_TAB_KO_NM   VARCHAR2(200),
    TGT_COL_KO_NM   VARCHAR2(200),
    CMP_DB_NM       VARCHAR2(50),
    CMP_TAB_NM      VARCHAR2(1000),
    CMP_TAB_KO_NM   VARCHAR2(2000),
    RULE_DFN        VARCHAR2(1000),
    VRFY_DFN        VARCHAR2(1000),
    ERR_PROC_DFN    VARCHAR2(1000),
    DB_N1_CONN_NM   VARCHAR2(30),
    RULE_N1_SQL     CLOB, --VARCHAR2(4000),
    DB_N2_CONN_NM   VARCHAR2(30),
    RULE_N2_SQL     CLOB, --VARCHAR2(4000),
    ERR_SAV_TAB_NM  VARCHAR2(30),
    CYCLE           VARCHAR2(10),
    RMK             VARCHAR2(200),
    USE_YN          VARCHAR2(1),
    FST_INSRT_DTM   DATE,
    FST_INSRTR_ID   VARCHAR2(20),
    LST_MDFY_DTM    DATE,
    LST_MDFYR_ID    VARCHAR2(20)
)
TABLESPACE NPIMS_DQ_DAT01
STORAGE
(
    INITIAL 64K
    NEXT 1M
)
NOCOMPRESS;

ALTER TABLE DQ_ADM.TB_DQM_RULES2
ADD CONSTRAINT PK_TB_DQM_RULES2 PRIMARY KEY (RULE_ID);

COMMENT ON TABLE DQ_ADM.TB_DQM_RULES2 IS '검증규칙';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_ID IS '규칙ID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_TYPE IS '규칙유형';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.LCLS_NM IS '대분류';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.MCLS_NM IS '중분류';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_DB_NM IS '대상DB';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_TAB_NM IS '대상테이블';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_COL_NM IS '대상컬럼';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_TAB_KO_NM IS '대상테이블명';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_COL_KO_NM IS '대상컬럼명';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CMP_DB_NM IS '비교DB';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CMP_TAB_NM IS '비교테이블';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CMP_TAB_KO_NM IS '비교테이블명';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_DFN IS '규칙정의';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.VRFY_DFN IS '검증방법';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.ERR_PROC_DFN IS '처리사항';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.DB_N1_CONN_NM IS 'DB1연결명';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_N1_SQL IS '검증1SQL';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.DB_N2_CONN_NM IS 'DB2연결명';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_N2_SQL IS '검증2SQL';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.ERR_SAV_TAB_NM IS '오류저장테이블명';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CYCLE IS '주기';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RMK IS '비고';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.USE_YN IS '사용여부';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.FST_INSRT_DTM IS '최초입력일시';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.FST_INSRTR_ID IS '최초입력자ID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.LST_MDFY_DTM IS '최종수정일시';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.LST_MDFYR_ID IS '최종수정자ID';