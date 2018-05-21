SELECT /*+ TEMP_TBS_MEMORY*/ k.발신부대부호||';'||k.수신부대부호||';' ||to_char(k.작성일자,'yyyymmdd')
		FROM 
		 (SELECT /*+ TEMP_TBS_MEMORY*/ DISTINCT
		         a.문서번호 문서번호                          , 
		         a.문서식별부호 문서식별부호                      , 
		         a.발신부대부호 발신부대부호                      , 
		         c.부대약칭명 발신부대명                        , 
		         a.수신부대부호 수신부대부호                      , 
		         d.부대약칭명 수신부대명                        , 
		         a.dodic dodic                        , 
		         e.탄종명 탄종명                            , 
		         a.구좌부호 구좌부호                          , 
		         a.단위 단위                              , 
		         a.작성일자  , 
		         a.조치예정일, 
		         a.조치부호 조치부호                          , 
		         a.비고 비고 
		 FROM    청구조치 a ,
		         
		                 부대 c           , 
		                 부대 d           , 
		                 기본제원 e 
		 WHERE  a.발신부대부호                      = c.부대부호 
		     AND a.수신부대부호                      = d.부대부호 
		     AND a.dodic                       = e.dodic 
		 UNION 
		 SELECT 
		         /*+ TEMP_TBS_MEMORY*/ DISTINCT
		         a.문서번호 문서번호                        , 
		         a.문서식별부호 문서식별부호                    , 
		         a.발신부대부호 발신부대부호                    , 
		         c.부대약칭명 발신부대명                      , 
		         a.수신부대부호 수신부대부호                    , 
		         d.부대약칭명 수신부대명                      , 
		         a.dodic dodic                      , 
		         e.탄종명 탄종명                          , 
		         a.구좌부호 구좌부호                        , 
		         a.단위 단위                            , 
		         a.작성일자, 
		         '' 조치예정일                           , 
		         '' 조치부호                            , 
		         '' 비고 
		 FROM    대여청구 a ,
		         부대 c           , 
		                 부대 d           , 
		                 기본제원 e 
		 WHERE a.발신부대부호                      = c.부대부호 
		     AND a.수신부대부호                      = d.부대부호 
		     AND a.dodic                       = e.dodic 
		 
		 ) k 
limit 1000;