-- DROP TABLE DQ_ADM.TB_DQM_RULES2 PURGE;
CREATE TABLE DQ_ADM.TB_DQM_RULES2
(
    RULE_ID         VARCHAR2(20) NOT NULL,   -- ��ĢID
    RULE_TYPE       VARCHAR2(50),            -- ��Ģ����
    LCLS_NM         VARCHAR2(100),           -- ��з�
    MCLS_NM         VARCHAR2(100),           -- �ߺз�
    TGT_DB_NM       VARCHAR2(50),            -- ���DB
    TGT_TAB_NM      VARCHAR2(50),            -- ������̺�
    TGT_COL_NM      VARCHAR2(50),            -- ����÷�
    TGT_TAB_KO_NM   VARCHAR2(200),           -- ������̺��
    TGT_COL_KO_NM   VARCHAR2(200),           -- ����÷���
    CMP_DB_NM       VARCHAR2(50),            -- ��DB
    CMP_TAB_NM      VARCHAR2(50),            -- �����̺�
    CMP_TAB_KO_NM   VARCHAR2(200),           -- �����̺��
    RULE_DFN        VARCHAR2(1000),          -- ��Ģ����
    VRFY_DFN        VARCHAR2(1000),          -- �������
    ERR_PROC_DFN    VARCHAR2(1000),          -- ó������
    DB_N1_CONN_NM   VARCHAR2(30),            -- DB1�����
    RULE_N1_SQL     VARCHAR2(4000),          -- ����1SQL
    DB_N2_CONN_NM   VARCHAR2(30),            -- DB2�����
    RULE_N2_SQL     VARCHAR2(4000),          -- ����2SQL
    ERR_SAV_TAB_NM  VARCHAR2(30),            -- �����������̺��
    CYCLE           VARCHAR2(10),            -- �ֱ�
    RMK             VARCHAR2(200),           -- ���
    USE_YN          VARCHAR2(1),             -- ��뿩��
    FST_INSRT_DTM   DATE,                    -- �����Է��Ͻ�
    FST_INSRTR_ID   VARCHAR2(20),            -- �����Է���ID
    LST_MDFY_DTM    DATE,                    -- ���������Ͻ�
    LST_MDFYR_ID    VARCHAR2(20)             -- ����������ID
)
TABLESPACE NPIMS_DQ_DAT01;

CREATE UNIQUE INDEX DQ_ADM.PK_TB_DQM_RULES2
ON DQ_ADM.TB_DQM_RULES2 (RULE_ID) 
TABLESPACE NPIMS_DQ_DAT01;

ALTER TABLE DQ_ADM.TB_DQM_RULES2
ADD CONSTRAINT PK_TB_DQM_RULES2 PRIMARY KEY (RULE_ID);

COMMENT ON TABLE DQ_ADM.TB_DQM_RULES2 IS '������Ģ';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_ID         IS '��ĢID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_TYPE       IS '��Ģ����';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.LCLS_NM         IS '��з�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.MCLS_NM         IS '�ߺз�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_DB_NM       IS '���DB';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_TAB_NM      IS '������̺�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_COL_NM      IS '����÷�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_TAB_KO_NM   IS '������̺��';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.TGT_COL_KO_NM   IS '����÷���';

COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CMP_DB_NM       IS '��DB';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CMP_TAB_NM      IS '�����̺�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CMP_TAB_KO_NM   IS '�����̺��';

COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_DFN        IS '��Ģ����';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.VRFY_DFN        IS '�������';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.ERR_PROC_DFN    IS 'ó������';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.DB_N1_CONN_NM   IS 'DB1�����';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_N1_SQL     IS '����1SQL';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.DB_N2_CONN_NM   IS 'DB2�����';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RULE_N2_SQL     IS '����2SQL';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.ERR_SAV_TAB_NM  IS '�����������̺��';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.CYCLE           IS '�ֱ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.RMK             IS '���';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.USE_YN          IS '��뿩��';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.FST_INSRT_DTM   IS '�����Է��Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.FST_INSRTR_ID   IS '�����Է���ID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.LST_MDFY_DTM    IS '���������Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULES2.LST_MDFYR_ID    IS '����������ID';


-- DROP TABLE DQ_ADM.TB_DQM_ERR_DAT PURGE;
CREATE TABLE DQ_ADM.TB_DQM_ERR_DAT
(
    LOG_ID          VARCHAR2(30) NOT NULL,   -- LOGID(PK)
    SEQ             NUMBER(10)   NOT NULL,   -- �Ϸù�ȣ(PK), (-1:��Ī, 0:Ÿ��, 1~:������))         
    RULE_ID         VARCHAR2(20) NOT NULL,   -- ��ĢID
    LOG_DTM         DATE         NOT NULL,   -- �α��Ͻ�
    TG_DB_NM        VARCHAR2(50),            -- ���DB
    TAB_NM          VARCHAR2(50),            -- ������̺�
    COL_NM          VARCHAR2(50),            -- ����÷�
    VAL01            VARCHAR2(1000),          -- ��01
    VAL02            VARCHAR2(1000),          -- ��02
    VAL03            VARCHAR2(1000),          -- ��03
    VAL04            VARCHAR2(1000),          -- ��04
    VAL05            VARCHAR2(1000),          -- ��05
    VAL06            VARCHAR2(1000),          -- ��06
    VAL07            VARCHAR2(1000),          -- ��07
    VAL08            VARCHAR2(1000),          -- ��08
    VAL09            VARCHAR2(1000),          -- ��09
    VAL10            VARCHAR2(1000),          -- ��10
    VAL11            VARCHAR2(1000),          -- ��11
    VAL12            VARCHAR2(1000),          -- ��12
    VAL13            VARCHAR2(1000),          -- ��13
    VAL14            VARCHAR2(1000),          -- ��14
    VAL15            VARCHAR2(1000),          -- ��15
    VAL16            VARCHAR2(1000),          -- ��16
    VAL17            VARCHAR2(1000),          -- ��17
    VAL18            VARCHAR2(1000),          -- ��18
    VAL19            VARCHAR2(1000),          -- ��19
    VAL20            VARCHAR2(1000),          -- ��20
    VAL21            VARCHAR2(1000),          -- ��21
    VAL22            VARCHAR2(1000),          -- ��22
    VAL23            VARCHAR2(1000),          -- ��23
    VAL24            VARCHAR2(1000),          -- ��24
    VAL25            VARCHAR2(1000),          -- ��25
    VAL26            VARCHAR2(1000),          -- ��26
    VAL27            VARCHAR2(1000),          -- ��27
    VAL28            VARCHAR2(1000),          -- ��28
    VAL29            VARCHAR2(1000),          -- ��29
    VAL30            VARCHAR2(1000)          -- ��30
) 
TABLESPACE NPIMS_DQ_DAT01;

ALTER TABLE DQ_ADM.TB_DQM_ERR_DAT ADD CONSTRAINT PK_DBM_ERR_DAT
   PRIMARY KEY(LOG_ID, SEQ)
   USING INDEX TABLESPACE NPIMS_DQ_DAT01;

COMMENT ON TABLE DQ_ADM.TB_DQM_ERR_DAT    IS '��������������';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.LOG_ID     IS 'LOGID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.SEQ        IS '�Ϸù�ȣ';      
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.RULE_ID    IS '��ĢID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.LOG_DTM    IS 'LOG�Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.TG_DB_NM   IS '���DB';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.TAB_NM     IS '������̺�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.COL_NM     IS '����÷�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL01      IS '��01';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL02      IS '��02';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL03      IS '��03';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL04      IS '��04';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL05      IS '��05';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL06      IS '��06';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL07      IS '��07';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL08      IS '��08';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL09      IS '��09';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL10      IS '��10';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL11      IS '��11';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL12      IS '��12';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL13      IS '��13';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL14      IS '��14';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL15      IS '��15';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL16      IS '��16';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL17      IS '��17';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL18      IS '��18';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL19      IS '��19';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL20      IS '��20';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL21      IS '��21';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL22      IS '��22';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL23      IS '��23';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL24      IS '��24';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL25      IS '��25';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL26      IS '��26';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL27      IS '��27';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL28      IS '��28';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL29      IS '��29';
COMMENT ON COLUMN DQ_ADM.TB_DQM_ERR_DAT.VAL30      IS '��30';



-- DROP TABLE DQ_ADM.TB_DQM_RULE_LOGS PURGE;

CREATE TABLE DQ_ADM.TB_DQM_RULE_LOGS (
      LOG_ID                                       VARCHAR2(30)      NOT NULL
    , RULE_ID                                      VARCHAR2(10)      NOT NULL
    , LOG_DTM                                      DATE              NOT NULL
    , VRFY_RSLT                                    VARCHAR2(10)
    , SQL_N1_RSLT                                  VARCHAR2(100)
    , SQL_N2_RSLT                                  VARCHAR2(100)
    , ERR_CD                                       VARCHAR2(100)
    , ERR_MSG                                      VARCHAR2(1000)
    , PROC_STTS                                    VARCHAR2(50)
    , STTS_DTM                                     DATE
    , STRT_DTM                                     DATE
    , END_DTM                                      DATE
    , RMK                                          VARCHAR2(2000)
) TABLESPACE NPIMS_DQ_DAT01;

ALTER TABLE DQ_ADM.TB_DQM_RULE_LOGS
    ADD CONSTRAINT PK_DQM_RULE_LOGS PRIMARY KEY (LOG_ID) 
    USING INDEX TABLESPACE NPIMS_DQ_DAT01;


COMMENT ON TABLE DQ_ADM.TB_DQM_RULE_LOGS                                  IS '�����α�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.LOG_ID                          IS '�α�ID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.RULE_ID                         IS '��ĢID';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.LOG_DTM                         IS '�α��Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.VRFY_RSLT                       IS '������';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.SQL_N2_RSLT                     IS 'SQL1���';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.SQL_N2_RSLT                     IS 'SQL2���';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.ERR_CD                          IS '�����ڵ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.ERR_MSG                         IS '�����޽���';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.PROC_STTS                       IS '�������';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.STTS_DTM                        IS '�����Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.STRT_DTM                        IS '�����Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.END_DTM                         IS '�����Ͻ�';
COMMENT ON COLUMN DQ_ADM.TB_DQM_RULE_LOGS.RMK                             IS '���';
