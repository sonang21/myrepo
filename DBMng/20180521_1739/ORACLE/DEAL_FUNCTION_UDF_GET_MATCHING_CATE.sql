/* *************************************************************************
 * NAME : DEAL.UDF_GET_MATCHING_CATE
 * TYPE : FUNCTION
 * TIME : Create: 2018-03-28 15:35:55
 *        Modify: 2018-03-28 15:35:55
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE FUNCTION "DEAL"."UDF_GET_MATCHING_CATE" (V_DIVISION IN VARCHAR2 , V_SHOPNAME IN VARCHAR2 , V_PRODNAME IN VARCHAR2 , V_ADDRESS IN VARCHAR2,V_SECTION1 IN VARCHAR2,V_SECTION2 IN VARCHAR2,V_SECTION3 IN VARCHAR2 ) RETURN VARCHAR2 AS 
v_cate  VARCHAR2(255) := '';
BEGIN
  begin
    SELECT cate into v_cate from d4_keyword_cate where instr(V_DIVISION,keyword) > 0 and rownum = 1;
  EXCEPTION WHEN OTHERS THEN
    v_cate := '';
  end;
  
  IF v_cate = '' OR v_cate is null  THEN
      if V_SHOPNAME = 'wemakeprice' then
        if V_DIVISION = '베스트^여행레저 > 베스트^여행레저' then
          if INSTR(V_PRODNAME,'펜션') > 0 OR INSTR(V_PRODNAME,'글램핑') > 0 OR INSTR(V_PRODNAME,'숙박') > 0 OR INSTR(V_PRODNAME,'하우스') > 0 OR INSTR(V_PRODNAME,'게스트') > 0 OR INSTR(V_PRODNAME,'캠핑') > 0 then
            if INSTR(V_ADDRESS,'서울') > 0 OR  INSTR(V_ADDRESS,'경기') > 0 OR   INSTR(V_ADDRESS,'인천') > 0 then
              v_cate := 'C218';
            elsif INSTR(V_ADDRESS,'강원') > 0 then
              v_cate := 'C219';
            elsif INSTR(V_ADDRESS,'충청') > 0 OR INSTR(V_ADDRESS,'충남') > 0 OR INSTR(V_ADDRESS,'충북') > 0 OR INSTR(V_ADDRESS,'대전') > 0 OR INSTR(V_ADDRESS,'세종') > 0 then
              v_cate := 'C220';              
            elsif INSTR(V_ADDRESS,'경상') > 0 OR INSTR(V_ADDRESS,'부산') > 0 OR INSTR(V_ADDRESS,'대구') > 0 then
              v_cate := 'C285';
            elsif INSTR(V_ADDRESS,'전라') > 0 OR INSTR(V_ADDRESS,'광주') > 0 then
              v_cate := 'C286';
            elsif INSTR(V_ADDRESS,'제주') > 0 then
              v_cate := 'C214';
            end if;
          elsif INSTR(V_PRODNAME,'호텔') > 0 OR INSTR(V_PRODNAME,'hotel') > 0 OR INSTR(V_PRODNAME,'숙박') > 0 OR INSTR(V_PRODNAME,'리조트') > 0 OR INSTR(V_PRODNAME,'레지던스') > 0 then
            if INSTR(V_ADDRESS,'서울') > 0 then
              v_cate := 'C142';
            elsif INSTR(V_ADDRESS,'경기') > 0 OR INSTR(V_ADDRESS,'인천') > 0  then
              v_cate := 'C280';
            elsif INSTR(V_ADDRESS,'충청') > 0 OR INSTR(V_ADDRESS,'대전') > 0 OR INSTR(V_ADDRESS,'강원') > 0 then
              v_cate := 'C216';
            elsif INSTR(V_ADDRESS,'부산') > 0 then
              v_cate := 'C281';
            elsif INSTR(V_ADDRESS,'경상') > 0 OR INSTR(V_ADDRESS,'대구') > 0 OR INSTR(V_ADDRESS,'울산') > 0 then
              v_cate := 'C217';
            elsif INSTR(V_ADDRESS,'전라') > 0 OR INSTR(V_ADDRESS,'광주') > 0 then
              v_cate := 'C283';
            elsif INSTR(V_ADDRESS,'제주') > 0 then
              v_cate := 'C214';
            end if;
          elsif INSTR(V_PRODNAME,'레져/레포츠') > 0 OR INSTR(V_PRODNAME,'hotel') > 0 OR INSTR(V_PRODNAME,'워터파크/스파') > 0 OR INSTR(V_PRODNAME,'입장권') > 0 then
            if INSTR(V_ADDRESS,'서울') > 0 OR  INSTR(V_ADDRESS,'경기') > 0 OR   INSTR(V_ADDRESS,'인천') > 0 then
              v_cate := 'C221';
            elsif INSTR(V_ADDRESS,'강원') > 0 then
              v_cate := 'C222';
            elsif INSTR(V_ADDRESS,'충청') > 0 OR INSTR(V_ADDRESS,'충북') > 0 OR INSTR(V_ADDRESS,'충남') > 0 OR INSTR(V_ADDRESS,'대전') > 0 OR INSTR(V_ADDRESS,'세종') > 0 OR INSTR(V_ADDRESS,'경상') > 0 OR INSTR(V_ADDRESS,'부산') > 0 OR INSTR(V_ADDRESS,'대구') > 0 OR INSTR(V_ADDRESS,'전라')> 0 OR INSTR(V_ADDRESS,'광주') > 0 then
              v_cate := 'C223';
            elsif INSTR(V_ADDRESS,'제주') > 0 then
              v_cate := 'C215';
            end if;            
          end if;
        elsif V_DIVISION = '컬쳐/키즈 >대학로 > 키즈/전시' then
          if INSTR(V_ADDRESS,'서울') > 0 OR  INSTR(V_ADDRESS,'경기') > 0 OR   INSTR(V_ADDRESS,'인천') > 0 then
            v_cate := 'C215';
          elsif  INSTR(V_ADDRESS,'부산') > 0 OR INSTR(V_ADDRESS,'경남') > 0 then
            v_cate := 'C228';
          elsif  INSTR(V_ADDRESS,'대구') > 0 OR INSTR(V_ADDRESS,'경북') > 0 OR INSTR(V_ADDRESS,'울산') > 0 then
            v_cate := 'C227';            
          elsif  INSTR(V_ADDRESS,'대전') > 0 OR INSTR(V_ADDRESS,'충청') > 0 OR INSTR(V_ADDRESS,'강원') > 0 then
            v_cate := 'C226';                        
          elsif  INSTR(V_ADDRESS,'광주') > 0 OR INSTR(V_ADDRESS,'전라') > 0 OR INSTR(V_ADDRESS,'제주') > 0 then
            v_cate := 'C244';                                    
          end if;
        end if;
      end if;
      
      IF v_cate = '' OR v_cate is null  THEN
        if V_SHOPNAME = 'wemakeprice' then
          if V_DIVISION = '식품/건강 > 과자/음료' then
            if INSTR(V_SECTION1,'커피/음료') > 0 OR  INSTR(V_SECTION2,'차/티백') > 0 then
              v_cate := 'C312';          
            elsif INSTR(V_SECTION2,'과자/간식') > 0 OR  INSTR(V_SECTION1,'가공/즉석식품') > 0 then
              v_cate := 'C201';          
            end if;
          elsif  V_DIVISION = '패션잡화 > 시계/안경/쥬얼리' then
            if INSTR(V_SECTION3,'패션시계') > 0 OR  INSTR(V_SECTION3,'브랜드시계') > 0 then
              v_cate := 'C112';          
            elsif INSTR(V_SECTION3,'쥬얼리') > 0 OR  INSTR(V_SECTION3,'순금/돌반지') > 0 then
              v_cate := 'C256';          
            elsif INSTR(V_SECTION2,'아이웨어/선글라스') > 0 then
              v_cate := 'C208';     
            elsif INSTR(V_SECTION2,'헤어악세서리/가발') > 0 then
              v_cate := 'C111';     
            end if;
          elsif  V_DIVISION = '남성의류 > 아우터/정장' then
            if INSTR(V_SECTION3,'바지/팬츠') > 0 then
              v_cate := 'C274';     
            end if;
          elsif  V_DIVISION = '뷰티 > 메이크업/클렌징' then
            if INSTR(V_SECTION2,'색조화장품') > 0 then
              v_cate := 'C119';     
            end if;            
          elsif  V_DIVISION = '뷰티 > 헤어/바디' then
            if INSTR(V_SECTION2,'헤어케어') > 0 OR INSTR(V_SECTION2,'헤어스타일링') > 0 then
              v_cate := 'C151';     
            elsif INSTR(V_SECTION2,'바디케어') > 0 OR INSTR(V_SECTION2,'바디로션/핸드크림') > 0  then
              v_cate := 'C120';
            elsif INSTR(V_SECTION3,'네일아트') > 0 then
              v_cate := 'C152';              
            end if;                        
          elsif  V_DIVISION = '생활/주방 > 건강/매트/공구' then
            if INSTR(V_SECTION1,'건강/의료용품') > 0 OR INSTR(V_SECTION3,'생활잡화') > 0 then
              v_cate := 'C259';     
            elsif INSTR(V_SECTION2,'디지털도어락/보안용품') > 0 then
              v_cate := 'C136';
            end if;                           
          elsif  V_DIVISION = '스포츠/아웃도어 > 시즌/레저' then
            if INSTR(V_SECTION2,'스포츠잡화') > 0 then
              v_cate := 'C250';     
            elsif INSTR(V_SECTION2,'스포츠의류') > 0 then
              v_cate := 'C113';
            end if;
          elsif  V_DIVISION = '식품/건강 > 건강/다이어트' then
            if INSTR(V_SECTION2,'다이어트식품') > 0 OR INSTR(V_SECTION3,'헬스보충제') > 0 then
              v_cate := 'C314';     
            elsif INSTR(V_SECTION2,'건강식품') > 0 OR INSTR(V_SECTION3,'주스/과채음료') > 0 then
              v_cate := 'C124';              
            elsif INSTR(V_SECTION2,'홍삼/인삼') > 0 then
              v_cate := 'C313';      
            end if;
          elsif  V_DIVISION = '베스트^쇼핑 > 베스트^쇼핑' then
            if INSTR(V_SECTION2,'바디케어') > 0 then
              v_cate := 'C120';     
            elsif INSTR(V_SECTION3,'스킨/로션') > 0 then
              v_cate := 'C118';              
            elsif INSTR(V_SECTION3,'의자') > 0 then
              v_cate := 'C325';                                          
            elsif INSTR(V_SECTION3,'스탠드') > 0 then
              v_cate := 'C130';                   
            end if;
          elsif  V_DIVISION = '베스트^패션뷰티 > 베스트^패션뷰티' then
            if INSTR(V_SECTION3,'스킨/로션') > 0 then
              v_cate := 'C118';     
            end if;
          elsif  V_DIVISION = '스포츠/아웃도어 > 시즌/레저' then
            if INSTR(V_SECTION3,'잡화기타') > 0 then
              v_cate := 'C250';     
            elsif INSTR(V_SECTION2,'수영') > 0 then
              v_cate := 'C252';                                 
            end if;            
          end if;
        elsif V_SHOPNAME = 'oclock' then
          if  V_DIVISION = '여성의류>여성복' then
            if INSTR(V_PRODNAME,'티셔츠') > 0 OR INSTR(V_PRODNAME,'블라우스') > 0 OR INSTR(V_PRODNAME,'후드') > 0 OR INSTR(V_PRODNAME,'니트') > 0 OR INSTR(V_PRODNAME,'스웨터') > 0 then
              v_cate := 'C105';
            elsif INSTR(V_PRODNAME,'바지') > 0 OR INSTR(V_PRODNAME,'트레이닝') > 0 then
              v_cate := 'C273';
            elsif INSTR(V_PRODNAME,'정장') > 0  OR INSTR(V_PRODNAME,'수트') > 0 then  
              v_cate := 'C274';
            elsif INSTR(V_PRODNAME,'아우터') > 0  OR INSTR(V_PRODNAME,'자켓') > 0  OR INSTR(V_PRODNAME,'코트') > 0 OR INSTR(V_PRODNAME,'패딩') > 0 then  
              v_cate := 'C275';
            end if;
          elsif  V_DIVISION = '남성의류>남성복' then
            if INSTR(V_PRODNAME,'남방') > 0 OR INSTR(V_PRODNAME,'셔츠') > 0 OR INSTR(V_PRODNAME,'가디건') > 0 OR INSTR(V_PRODNAME,'니트') > 0 OR INSTR(V_PRODNAME,'니트') > 0 OR INSTR(V_PRODNAME,'스웨터') > 0 then
              v_cate := 'C106';
            elsif INSTR(V_PRODNAME,'바지') > 0 OR INSTR(V_PRODNAME,'스키니') > 0 then
              v_cate := 'C270';
            elsif INSTR(V_PRODNAME,'원피스') > 0  OR INSTR(V_PRODNAME,'치마') > 0 OR INSTR(V_PRODNAME,'스커트') > 0 OR INSTR(V_PRODNAME,'정장') > 0 OR INSTR(V_PRODNAME,'수트') > 0 then  
              v_cate := 'C272';
            elsif INSTR(V_PRODNAME,'아우터') > 0  OR INSTR(V_PRODNAME,'자켓') > 0  OR INSTR(V_PRODNAME,'코트') > 0 OR INSTR(V_PRODNAME,'패딩') > 0 then  
              v_cate := 'C272';
            elsif INSTR(V_PRODNAME,'스타킹') > 0  OR INSTR(V_PRODNAME,'레깅스') > 0   then  
              v_cate := 'C111';              
            elsif INSTR(V_PRODNAME,'가방') > 0 then  
              v_cate := 'C110';                            
            end if;  
          end if;
        end if;
      end if;
  END IF;
  RETURN v_cate;
END;