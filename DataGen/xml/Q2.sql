SELECT /*+ TEMP_TBS_MEMORY*/ tt1.�δ��ȣ||';'||to_char(tt1.�ۼ�����,'yyyymmdd')
FROM 
	(SELECT a.�ۼ�����, a.���źδ��ȣ �δ��ȣ, a.dodic dodic
          FROM ���޽��� a, lot���� d 
         WHERE a.�����ĺ���ȣ IN ('5S1', '6S1') 
          AND a.lot = d.lot 
   UNION ALL
          SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
          FROM ���޽��� a, lot���� d 
         WHERE a.�����ĺ���ȣ IN ('RZA', 'N30') 
          AND a.lot = d.lot 
   UNION ALL
          SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
           FROM ���޽��� a, lot���� d 
          WHERE a.�����ĺ���ȣ IN ('RTA') 
           AND a.lot = d.lot 
   UNION ALL
          SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
           FROM ���޽��� a, lot���� d 
          WHERE a.�����ĺ���ȣ IN ('WP2', 'N31') 
           AND a.lot = d.lot 
   UNION ALL
          SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
           FROM ���޽��� a, lot���� d 
          WHERE a.�����ĺ���ȣ IN ('ATS') 
           AND a.lot = d.lot 
           AND a.���汸�º�ȣ IS NULL 
   UNION ALL
           SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
           FROM ���޽��� a, lot���� d 
          WHERE a.�����ĺ���ȣ IN ('ATS') 
           AND a.lot = d.lot 
           AND a.���º�ȣ IS NULL 
   UNION ALL
          SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
          FROM ���޽��� a, lot���� d 
         WHERE a.�����ĺ���ȣ IN ('ATX') 
          AND a.lot = d.lot 
   UNION ALL
          SELECT a.�ۼ����� , a.�߽źδ��ȣ, a.dodic dodic
          FROM ���޽��� a left outer join   ź������ e on  ( a.���º�ȣ = e.���º�ȣ 
                                                           AND a.���º�ȣ = e.���º�ȣ 
                                                           AND a.ź����ȣ = e.ź����ȣ 
                                                           AND a.lot = e.lot 
                                                           AND a.�߽źδ��ȣ = e.�δ��ȣ 
                                                           AND a.dodic = e.dodic ) ,lot���� d 
         WHERE a.�����ĺ���ȣ IN ('ATZ') 
          AND a.lot = d.lot 
   UNION ALL
        SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
          FROM ���޽��� a, lot���� d 
         WHERE a.�����ĺ���ȣ = 'Z10' 
          AND a.lot = d.lot 
          AND a.���汸�º�ȣ IS NULL 
   UNION ALL
          SELECT a.�ۼ�����, a.�߽źδ��ȣ, a.dodic dodic
          FROM ���޽��� a, lot���� d 
         WHERE �����ĺ���ȣ = 'Z10' 
          AND a.lot = d.lot 
          AND a.���º�ȣ IS NULL 
   UNION ALL
          SELECT a.�ۼ�����, a.���źδ��ȣ, a.dodic dodic
          FROM ���޽��� a, lot���� d 
         WHERE a.�����ĺ���ȣ IN ('RCA') 
          AND a.lot = d.lot 
   limit 100000
         
         ) tt1, �⺻���� bb
WHERE tt1.dodic = bb.dodic 
AND ((NVL (bb.Ư��ǰ����ȣ, 'x') <> 'W' 
AND (NVL (bb.������Ῡ��, 'N')) <> 'Y' OR bb.������Ῡ�� IS NULL)) 
limit 1000
;