SELECT a.�δ��ȣ
			FROM    �δ� A        , 
			        �⺻���� C      , 
			        ������� D      , 
			        �ѹ̿��ջ�_�δ����� z, 
			        �����ڵ����� e    , 
			        (SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1    , 
			                dodic a2     , 
			                ����ȣ a5      , 
			                �ܰ� a4        , 
			                '�����' AS TYPE, 
			                NVL(�����, 0) a3 
			        FROM    �ѹ̿��ջ�_����� 
			         
			        union 
			         
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1    , 
			                dodic a2     , 
			                ����ȣ a5      , 
			                �ܰ� a4        , 
			                'RSR' AS TYPE, 
			                NVL(RSR, 0) a3 
			        FROM    �ѹ̿��ջ�_RSR 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1     , 
			                dodic a2      , 
			                ����ȣ a5       , 
			                �ܰ� a4         , 
			                '�������' AS TYPE, 
			                NVL(�������, 0) a3 
			        FROM    �ѹ̿��ջ�_������� 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1    , 
			                dodic a2     , 
			                ����ȣ a5      , 
			                �ܰ� a4        , 
			                'CSR' AS TYPE, 
			                NVL(CSR, 0) a3 
			        FROM    �ѹ̿��ջ�_CSR 
			        
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1    , 
			                dodic a2     , 
			                ����ȣ a5      , 
			                �ܰ� a4        , 
			                '�ҿ䷮' AS TYPE, 
			                NVL(�ҿ䷮RSR, 0) a3 
			        FROM    �ѹ̿��ջ�_AA�Ҵ� 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1    , 
			                dodic a2     , 
			                ����ȣ a5      , 
			                �ܰ� a4        , 
			                '���뷮' AS TYPE, 
			                NVL(���뷮RSR, 0) a3 
			        FROM    �ѹ̿��ջ�_AA�Ҵ� 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1    , 
			                dodic a2     , 
			                ����ȣ a5      , 
			                �ܰ� a4        , 
			                '�Ҵ緮' AS TYPE, 
			                NVL(�Ҵ緮RSR, 0) a3 
			        FROM    �ѹ̿��ջ�_AA�Ҵ� 
			        union  
			        SELECT 
			                /*+ TEMP_TBS_MEMORY*/ 
			                ���Ϻδ��ȣ a1      , 
			                dodic a2       , 
			                ����ȣ a5        , 
			                �ܰ� a4          , 
			                '�����Ҵ緮' AS TYPE, 
			                NVL(�����RSR, 0) a3 
			        FROM    �ѹ̿��ջ�_AA�Ҵ� 
			        ) B 
			WHERE   a.�δ��ȣ     = b.a1 
			    AND c.dodic    = b.a2 
			    AND b.a5       = d.����ȣ 
			    AND e.�ڵ�       = 'ź���ߺз�' 
			    AND c.ź���ߺз�    = e.�����ڵ� 
			    AND b.a1       = z.���Ϻδ��ȣ 
			    AND (z.aacsr���� = 'AA' 
			     OR z.aacsr���� IS NULL ) 
limit 2000;