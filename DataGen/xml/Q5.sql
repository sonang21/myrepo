SELECT a.�δ��ȣ||';'||a.������
FROM lot����� a,
     �⺻���� b,
     �δ� c,
     �����ڵ����� d,
     ����ȣ���� e,
     lot���� g
WHERE d.�ڵ� = 'ź���ߺз�'
  AND d.�����ڵ� = a.ź���ߺз�
  AND c.�δ��ȣ = a.�δ��ȣ
  AND b.dodic = e.dodic
  AND b.dodic = a.dodic
  --AND (a.�δ��ȣ = ?)
  AND c.�ü������� = 'S'
  AND a.lot = g.lot
  AND g.����ȣ = e.����ȣ
  --AND a.������ = ? //������ ����� ���� ������������ ����
LIMIT 1000
;

