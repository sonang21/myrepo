SELECT /*+ TEMP_TBS_MEMORY*/ a.���źδ��ȣ||';'||a.�߽źδ��ȣ||';'||TO_CHAR (a.�ۼ�����, 'yyyymmdd')
 FROM ����ź���� a, �⺻���� b, �δ� c, �δ� d 
 WHERE a.dodic = b.dodic 
 AND a.�����ĺ���ȣ IN ('5S1', '6S1') 
 AND a.���źδ��ȣ = c.�δ��ȣ 
 AND a.�߽źδ��ȣ = d.�δ��ȣ 
limit 1000;