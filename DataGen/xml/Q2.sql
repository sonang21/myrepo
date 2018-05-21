SELECT /*+ TEMP_TBS_MEMORY*/ tt1.부대부호||';'||to_char(tt1.작성일자,'yyyymmdd')
FROM 
	(SELECT a.작성일자, a.수신부대부호 부대부호, a.dodic dodic
          FROM 보급실적 a, lot제원 d 
         WHERE a.문서식별부호 IN ('5S1', '6S1') 
          AND a.lot = d.lot 
   UNION ALL
          SELECT a.작성일자, a.발신부대부호, a.dodic dodic
          FROM 보급실적 a, lot제원 d 
         WHERE a.문서식별부호 IN ('RZA', 'N30') 
          AND a.lot = d.lot 
   UNION ALL
          SELECT a.작성일자, a.발신부대부호, a.dodic dodic
           FROM 보급실적 a, lot제원 d 
          WHERE a.문서식별부호 IN ('RTA') 
           AND a.lot = d.lot 
   UNION ALL
          SELECT a.작성일자, a.발신부대부호, a.dodic dodic
           FROM 보급실적 a, lot제원 d 
          WHERE a.문서식별부호 IN ('WP2', 'N31') 
           AND a.lot = d.lot 
   UNION ALL
          SELECT a.작성일자, a.발신부대부호, a.dodic dodic
           FROM 보급실적 a, lot제원 d 
          WHERE a.문서식별부호 IN ('ATS') 
           AND a.lot = d.lot 
           AND a.변경구좌부호 IS NULL 
   UNION ALL
           SELECT a.작성일자, a.발신부대부호, a.dodic dodic
           FROM 보급실적 a, lot제원 d 
          WHERE a.문서식별부호 IN ('ATS') 
           AND a.lot = d.lot 
           AND a.구좌부호 IS NULL 
   UNION ALL
          SELECT a.작성일자, a.발신부대부호, a.dodic dodic
          FROM 보급실적 a, lot제원 d 
         WHERE a.문서식별부호 IN ('ATX') 
          AND a.lot = d.lot 
   UNION ALL
          SELECT a.작성일자 , a.발신부대부호, a.dodic dodic
          FROM 보급실적 a left outer join   탄약고재고 e on  ( a.구좌부호 = e.구좌부호 
                                                           AND a.상태부호 = e.상태부호 
                                                           AND a.탄약고번호 = e.탄약고번호 
                                                           AND a.lot = e.lot 
                                                           AND a.발신부대부호 = e.부대부호 
                                                           AND a.dodic = e.dodic ) ,lot제원 d 
         WHERE a.문서식별부호 IN ('ATZ') 
          AND a.lot = d.lot 
   UNION ALL
        SELECT a.작성일자, a.발신부대부호, a.dodic dodic
          FROM 보급실적 a, lot제원 d 
         WHERE a.문서식별부호 = 'Z10' 
          AND a.lot = d.lot 
          AND a.변경구좌부호 IS NULL 
   UNION ALL
          SELECT a.작성일자, a.발신부대부호, a.dodic dodic
          FROM 보급실적 a, lot제원 d 
         WHERE 문서식별부호 = 'Z10' 
          AND a.lot = d.lot 
          AND a.구좌부호 IS NULL 
   UNION ALL
          SELECT a.작성일자, a.수신부대부호, a.dodic dodic
          FROM 보급실적 a, lot제원 d 
         WHERE a.문서식별부호 IN ('RCA') 
          AND a.lot = d.lot 
   limit 100000
         
         ) tt1, 기본제원 bb
WHERE tt1.dodic = bb.dodic 
AND ((NVL (bb.특수품류부호, 'x') <> 'W' 
AND (NVL (bb.포장재료여부, 'N')) <> 'Y' OR bb.포장재료여부 IS NULL)) 
limit 1000
;