SELECT a.부대부호
			FROM    부대 A        , 
			        기본제원 C      , 
			        장비제원 D      , 
			        한미연합사_부대적용 z, 
			        세부코드제원 e    , 
			        (SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1    , 
			                dodic a2     , 
			                장비부호 a5      , 
			                단계 a4        , 
			                '무기수' AS TYPE, 
			                NVL(무기수, 0) a3 
			        FROM    한미연합사_무기수 
			         
			        union 
			         
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1    , 
			                dodic a2     , 
			                장비부호 a5      , 
			                단계 a4        , 
			                'RSR' AS TYPE, 
			                NVL(RSR, 0) a3 
			        FROM    한미연합사_RSR 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1     , 
			                dodic a2      , 
			                장비부호 a5       , 
			                단계 a4         , 
			                '적용비율' AS TYPE, 
			                NVL(적용비율, 0) a3 
			        FROM    한미연합사_적용비율 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1    , 
			                dodic a2     , 
			                장비부호 a5      , 
			                단계 a4        , 
			                'CSR' AS TYPE, 
			                NVL(CSR, 0) a3 
			        FROM    한미연합사_CSR 
			        
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1    , 
			                dodic a2     , 
			                장비부호 a5      , 
			                단계 a4        , 
			                '소요량' AS TYPE, 
			                NVL(소요량RSR, 0) a3 
			        FROM    한미연합사_AA할당 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1    , 
			                dodic a2     , 
			                장비부호 a5      , 
			                단계 a4        , 
			                '가용량' AS TYPE, 
			                NVL(가용량RSR, 0) a3 
			        FROM    한미연합사_AA할당 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1    , 
			                dodic a2     , 
			                장비부호 a5      , 
			                단계 a4        , 
			                '할당량' AS TYPE, 
			                NVL(할당량RSR, 0) a3 
			        FROM    한미연합사_AA할당 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                예하부대부호 a1      , 
			                dodic a2       , 
			                장비부호 a5        , 
			                단계 a4          , 
			                '정당할당량' AS TYPE, 
			                NVL(무기당RSR, 0) a3 
			        FROM    한미연합사_AA할당 
			        ) B 
			WHERE   a.부대부호     = b.a1 
			    AND c.dodic    = b.a2 
			    AND b.a5       = d.장비부호 
			    AND e.코드       = '탄약중분류' 
			    AND c.탄약중분류    = e.세부코드 
			    AND b.a1       = z.예하부대부호 
			    AND (z.aacsr적용 = 'AA' 
			     OR z.aacsr적용 IS NULL ) 
limit 2000;