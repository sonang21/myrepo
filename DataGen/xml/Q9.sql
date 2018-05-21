SELECT /*+ TEMP_TBS_MEMORY*/ a.수신부대부호||';'||a.발신부대부호||';'||TO_CHAR (a.작성일자, 'yyyymmdd')
 FROM 지상탄수령 a, 기본제원 b, 부대 c, 부대 d 
 WHERE a.dodic = b.dodic 
 AND a.문서식별부호 IN ('5S1', '6S1') 
 AND a.수신부대부호 = c.부대부호 
 AND a.발신부대부호 = d.부대부호 
limit 1000;