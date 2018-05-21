SELECT a.부대부호||';'||a.마감일
FROM lot별재산 a,
     기본제원 b,
     부대 c,
     세부코드제원 d,
     재고번호제원 e,
     lot제원 g
WHERE d.코드 = '탄약중분류'
  AND d.세부코드 = a.탄약중분류
  AND c.부대부호 = a.부대부호
  AND b.dodic = e.dodic
  AND b.dodic = a.dodic
  --AND (a.부대부호 = ?)
  AND c.시설편성구분 = 'S'
  AND a.lot = g.lot
  AND g.재고번호 = e.재고번호
  --AND a.마감일 = ? //데이터 출력을 위해 범위조건으로 변겅
LIMIT 1000
;

