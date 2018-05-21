SELECT k.발신부대부호||';'||k.수신부대부호||';'||to_char(k.작성일자,'YYYYMMDD')    
FROM 
    (SELECT a.문서번호 문서번호               , 
            a.일련번호 일련번호               , 
            a.문서식별부호 문서식별부호           , 
            a.발신부대부호 발신부대부호           , 
            b.부대약칭명 발신부대약칭명           , 
            a.수신부대부호 수신부대부호           , 
            c.부대약칭명 수신부대약칭명           , 
            a.dodic dodic             , 
            e.탄종명 탄종명                 , 
            a.목적부호 목적부호               , 
            a.lot lot                 , 
            '' 제조년도                   , 
            a.단위 단위                   , 
            TO_CHAR (NVL (a.수량, 0)) 수량, 
            a.장비부호 장비부호               , 
            a.등록번호 등록번호               , 
            a.포신번호 포신번호               , 
            a.용도부호 용도부호               , 
            a.청구사유 청구사유 
           ,a.작성일자
    FROM    view_탄약보급소모거래문서 a, 
            부대 b             , 
            부대 c             , 
            기본제원 e 
    WHERE   a.발신부대부호                        = b.부대부호 
        AND a.수신부대부호                        = c.부대부호 
        AND a.dodic                         = e.dodic 
    ) k 
    LEFT OUTER JOIN 
            (SELECT 세부코드, 
                    세부코드명 
            FROM    세부코드제원 
            WHERE   코드 = '사용목적부호' 
            ) l 
    ON (k.목적부호 = l.세부코드) 
    LEFT OUTER JOIN 
            (SELECT 세부코드, 
                    세부코드명 
            FROM    세부코드제원 
            WHERE   코드 = '용도부호' 
            ) m 
    ON (k.용도부호 = m.세부코드) 
    LEFT OUTER JOIN 장비제원 n 
    ON (k.장비부호 = n.장비부호) 
    LEFT OUTER JOIN 탄약소모거래 p 
    ON ( k.문서번호    = p.문서번호 
        AND k.일련번호 = p.일련번호) 
ORDER BY k.dodic, 
    k.문서번호
limit 1000;