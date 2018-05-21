SELECT /*+ TEMP_TBS_MEMORY*/ 
       tt1.발신부대||';'||TO_CHAR (tt1.일자, 'yyyymmdd')||';'||tt1.문서식별부호||';'||tt1.lot||';'||tt1.dodic
                    FROM 
                            (SELECT a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대,
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    '' 구좌유형           , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('5T1', 'E10', 'EBA', 'EDA', 'EUA', 'EZA') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 부대부호     , 
                                    a.수신부대부호,
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    b.신탄약고번호 탄약고번호    , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    b.변경구좌부호 변경구좌     , 
                                    b.구좌전환유형 구좌유형     , 
                                    b.단위 단위           , 
                                    NVL (b.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (b.현재고, 0) 재고 , 
                                    b.문서번호 문서         , 
                                    b.관련문서번호 관련문서     , 
                                    b.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    보급실적 b, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('GTA') 
                                AND a.문서번호    = b.문서번호 
                                AND a.lot     = d.lot 
                                AND b.구좌부호   IS NULL 
                                AND a.변경구좌부호 IS NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.신탄약고번호 탄약고번호    , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('ATS') 
                                AND a.목적부호    = 'AT2' 
                                AND a.lot     = d.lot 
                                AND a.구좌부호   IS NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('ATS') 
                                AND a.목적부호    = 'AT2' 
                                AND a.lot     = d.lot 
                                AND a.변경구좌부호 IS NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a 
                                    LEFT OUTER JOIN 재산증감 e 
                                    ON ( a.문서번호    = e.문서번호 
                                        AND a.일련번호 = e.일련번호) , 
                                            lot제원 d 
                            WHERE   a.문서식별부호 IN ('H1Z') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.수신부대부호 부대부호     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('5S1', '6S1') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('N30') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('WP2') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('N31') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.수신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('RCA') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('ATX') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호  IN ('ATZ') 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    b.상태부호 구좌부호       , 
                                    a.상태부호 변경구좌       , 
                                    a.구좌부호 구좌유형       , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    보급실적 b, 
                                    lot제원 d 
                            WHERE   a.문서식별부호  = 'Z10' 
                                AND a.lot     = d.lot 
                                AND a.문서번호    = b.문서번호 
                                AND a.변경구좌부호 IS NULL 
                                AND b.구좌부호   IS NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    b.신탄약고번호 탄약고번호    , 
                                    b.상태부호 상태부호       , 
                                    a.상태부호 구좌부호       , 
                                    b.상태부호 변경구좌       , 
                                    b.변경구좌부호 구좌유형     , 
                                    b.단위 단위           , 
                                    NVL (b.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (b.현재고, 0) 재고 , 
                                    b.문서번호 문서         , 
                                    b.관련문서번호 관련문서     , 
                                    b.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    보급실적 b, 
                                    lot제원 d 
                            WHERE   a.문서식별부호  = 'Z10' 
                                AND a.lot     = d.lot 
                                AND a.문서번호    = b.문서번호 
                                AND a.변경구좌부호 IS NULL 
                                AND b.구좌부호   IS NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    b.변경구좌부호 구좌부호     , 
                                    a.구좌부호 변경구좌       , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    보급실적 b, 
                                    lot제원 d 
                            WHERE   a.문서식별부호                                        IN ('GTA') 
                                AND a.문서번호    = b.문서번호 
                                AND a.lot     = d.lot 
                                AND a.변경구좌부호 IS NULL 
                                AND b.구좌부호   IS NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.발신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    a.구좌부호 구좌부호       , 
                                    a.변경구좌부호 변경구좌     , 
                                    a.구좌전환유형 구좌유형     , 
                                    a.단위 단위           , 
                                    0 증감수량            , 
                                    NVL (a.수량, 0) 감소수량, 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호                                        IN ('GTA') 
                                AND a.lot     = d.lot 
                                AND a.구좌부호   IS NOT NULL 
                                AND a.변경구좌부호 IS NOT NULL 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.수신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    '' 구좌유형           , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호  = 'RZA' 
                                AND a.lot     = d.lot 
                            UNION ALL 
                            SELECT  a.작성일자 일자         , 
                                    a.문서식별부호 문서식별부호   , 
                                    a.수신부대부호 발신부대     , 
                                    a.수신부대부호 수신부대     , 
                                    a.dodic dodic     , 
                                    a.lot lot         , 
                                    d.재고번호 재고번호       , 
                                    a.탄약고번호 탄약고번호     , 
                                    a.상태부호 상태부호       , 
                                    '' 구좌부호           , 
                                    a.구좌부호 변경구좌       , 
                                    '' 구좌유형           , 
                                    a.단위 단위           , 
                                    NVL (a.수량, 0) 증감수량, 
                                    0 감소수량            , 
                                    NVL (a.현재고, 0) 재고 , 
                                    a.문서번호 문서         , 
                                    a.관련문서번호 관련문서     , 
                                    a.일련번호 일련번호 
                            FROM    보급실적 a, 
                                    lot제원 d 
                            WHERE   a.문서식별부호 IN ('RAA', 'RBA', 'RDA', 'REA', 'RUA') 
                                AND a.lot     = d.lot 
                            LIMIT 5000
                            ) tt1       , 
                            기본제원 bb     , 
                            (SELECT 세부코드, 
                                    세부코드명 
                            FROM    세부코드제원 
                            WHERE   코드 = '문서식별부호' 
                            ) c , 
                            부대 d, 
                            부대 e 
                    WHERE tt1.문서식별부호              = c.세부코드 
                        AND tt1.발신부대                = d.부대부호 
                        AND tt1.수신부대                = e.부대부호 
                        AND tt1.dodic               = bb.dodic 
                        AND ((NVL (bb.특수품류부호, 'x') <> 'W' 
                        AND (NVL (bb.포장재료여부, 'N')) <> 'Y' 
                         OR bb.포장재료여부              IS NULL)) 
                    LIMIT 1000