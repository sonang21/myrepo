select /*+ USE_NL(a,b)  USE_NL(a,f) INDEX(f, IX_LOT����_01)  TEMP_TBS_MEMORY */  
  distinct a.�δ��ȣ
from ź������ a, �⺻���� b, �δ� c, ����ȣ���� e, lot���� f 
where a.�δ��ȣ = c.�δ��ȣ 
and a.dodic = b.dodic 
and a.lot = f.lot 
and a.���� <> 0 
and f.����ȣ = e.����ȣ 
and b.dodic = e.dodic 
and ((nvl(b.Ư��ǰ����ȣ,'x') <> 'W' and (nvl(b.������Ῡ��,'N') <> 'Y' or b.������Ῡ�� is null))) 
limit 1000
;