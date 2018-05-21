select /*+ USE_NL(a,b)  USE_NL(a,f) INDEX(f, IX_LOT제원_01)  TEMP_TBS_MEMORY */  
  distinct a.부대부호
from 탄약고재고 a, 기본제원 b, 부대 c, 재고번호제원 e, lot제원 f 
where a.부대부호 = c.부대부호 
and a.dodic = b.dodic 
and a.lot = f.lot 
and a.수량 <> 0 
and f.재고번호 = e.재고번호 
and b.dodic = e.dodic 
and ((nvl(b.특수품류부호,'x') <> 'W' and (nvl(b.포장재료여부,'N') <> 'Y' or b.포장재료여부 is null))) 
limit 1000
;