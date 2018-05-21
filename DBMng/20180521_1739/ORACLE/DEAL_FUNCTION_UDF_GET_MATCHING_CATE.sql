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
        if V_DIVISION = '����Ʈ^���෹�� > ����Ʈ^���෹��' then
          if INSTR(V_PRODNAME,'���') > 0 OR INSTR(V_PRODNAME,'�۷���') > 0 OR INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'�Ͽ콺') > 0 OR INSTR(V_PRODNAME,'�Խ�Ʈ') > 0 OR INSTR(V_PRODNAME,'ķ��') > 0 then
            if INSTR(V_ADDRESS,'����') > 0 OR  INSTR(V_ADDRESS,'���') > 0 OR   INSTR(V_ADDRESS,'��õ') > 0 then
              v_cate := 'C218';
            elsif INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C219';
            elsif INSTR(V_ADDRESS,'��û') > 0 OR INSTR(V_ADDRESS,'�泲') > 0 OR INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C220';              
            elsif INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'�λ�') > 0 OR INSTR(V_ADDRESS,'�뱸') > 0 then
              v_cate := 'C285';
            elsif INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C286';
            elsif INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C214';
            end if;
          elsif INSTR(V_PRODNAME,'ȣ��') > 0 OR INSTR(V_PRODNAME,'hotel') > 0 OR INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'����Ʈ') > 0 OR INSTR(V_PRODNAME,'��������') > 0 then
            if INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C142';
            elsif INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'��õ') > 0  then
              v_cate := 'C280';
            elsif INSTR(V_ADDRESS,'��û') > 0 OR INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C216';
            elsif INSTR(V_ADDRESS,'�λ�') > 0 then
              v_cate := 'C281';
            elsif INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'�뱸') > 0 OR INSTR(V_ADDRESS,'���') > 0 then
              v_cate := 'C217';
            elsif INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C283';
            elsif INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C214';
            end if;
          elsif INSTR(V_PRODNAME,'����/������') > 0 OR INSTR(V_PRODNAME,'hotel') > 0 OR INSTR(V_PRODNAME,'������ũ/����') > 0 OR INSTR(V_PRODNAME,'�����') > 0 then
            if INSTR(V_ADDRESS,'����') > 0 OR  INSTR(V_ADDRESS,'���') > 0 OR   INSTR(V_ADDRESS,'��õ') > 0 then
              v_cate := 'C221';
            elsif INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C222';
            elsif INSTR(V_ADDRESS,'��û') > 0 OR INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'�泲') > 0 OR INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'�λ�') > 0 OR INSTR(V_ADDRESS,'�뱸') > 0 OR INSTR(V_ADDRESS,'����')> 0 OR INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C223';
            elsif INSTR(V_ADDRESS,'����') > 0 then
              v_cate := 'C215';
            end if;            
          end if;
        elsif V_DIVISION = '����/Ű�� >���з� > Ű��/����' then
          if INSTR(V_ADDRESS,'����') > 0 OR  INSTR(V_ADDRESS,'���') > 0 OR   INSTR(V_ADDRESS,'��õ') > 0 then
            v_cate := 'C215';
          elsif  INSTR(V_ADDRESS,'�λ�') > 0 OR INSTR(V_ADDRESS,'�泲') > 0 then
            v_cate := 'C228';
          elsif  INSTR(V_ADDRESS,'�뱸') > 0 OR INSTR(V_ADDRESS,'���') > 0 OR INSTR(V_ADDRESS,'���') > 0 then
            v_cate := 'C227';            
          elsif  INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'��û') > 0 OR INSTR(V_ADDRESS,'����') > 0 then
            v_cate := 'C226';                        
          elsif  INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 OR INSTR(V_ADDRESS,'����') > 0 then
            v_cate := 'C244';                                    
          end if;
        end if;
      end if;
      
      IF v_cate = '' OR v_cate is null  THEN
        if V_SHOPNAME = 'wemakeprice' then
          if V_DIVISION = '��ǰ/�ǰ� > ����/����' then
            if INSTR(V_SECTION1,'Ŀ��/����') > 0 OR  INSTR(V_SECTION2,'��/Ƽ��') > 0 then
              v_cate := 'C312';          
            elsif INSTR(V_SECTION2,'����/����') > 0 OR  INSTR(V_SECTION1,'����/�Ｎ��ǰ') > 0 then
              v_cate := 'C201';          
            end if;
          elsif  V_DIVISION = '�м���ȭ > �ð�/�Ȱ�/���' then
            if INSTR(V_SECTION3,'�мǽð�') > 0 OR  INSTR(V_SECTION3,'�귣��ð�') > 0 then
              v_cate := 'C112';          
            elsif INSTR(V_SECTION3,'���') > 0 OR  INSTR(V_SECTION3,'����/������') > 0 then
              v_cate := 'C256';          
            elsif INSTR(V_SECTION2,'���̿���/���۶�') > 0 then
              v_cate := 'C208';     
            elsif INSTR(V_SECTION2,'���Ǽ�����/����') > 0 then
              v_cate := 'C111';     
            end if;
          elsif  V_DIVISION = '�����Ƿ� > �ƿ���/����' then
            if INSTR(V_SECTION3,'����/����') > 0 then
              v_cate := 'C274';     
            end if;
          elsif  V_DIVISION = '��Ƽ > ����ũ��/Ŭ��¡' then
            if INSTR(V_SECTION2,'����ȭ��ǰ') > 0 then
              v_cate := 'C119';     
            end if;            
          elsif  V_DIVISION = '��Ƽ > ���/�ٵ�' then
            if INSTR(V_SECTION2,'����ɾ�') > 0 OR INSTR(V_SECTION2,'��Ÿ�ϸ�') > 0 then
              v_cate := 'C151';     
            elsif INSTR(V_SECTION2,'�ٵ��ɾ�') > 0 OR INSTR(V_SECTION2,'�ٵ�μ�/�ڵ�ũ��') > 0  then
              v_cate := 'C120';
            elsif INSTR(V_SECTION3,'���Ͼ�Ʈ') > 0 then
              v_cate := 'C152';              
            end if;                        
          elsif  V_DIVISION = '��Ȱ/�ֹ� > �ǰ�/��Ʈ/����' then
            if INSTR(V_SECTION1,'�ǰ�/�Ƿ��ǰ') > 0 OR INSTR(V_SECTION3,'��Ȱ��ȭ') > 0 then
              v_cate := 'C259';     
            elsif INSTR(V_SECTION2,'�����е����/���ȿ�ǰ') > 0 then
              v_cate := 'C136';
            end if;                           
          elsif  V_DIVISION = '������/�ƿ����� > ����/����' then
            if INSTR(V_SECTION2,'��������ȭ') > 0 then
              v_cate := 'C250';     
            elsif INSTR(V_SECTION2,'�������Ƿ�') > 0 then
              v_cate := 'C113';
            end if;
          elsif  V_DIVISION = '��ǰ/�ǰ� > �ǰ�/���̾�Ʈ' then
            if INSTR(V_SECTION2,'���̾�Ʈ��ǰ') > 0 OR INSTR(V_SECTION3,'�ｺ������') > 0 then
              v_cate := 'C314';     
            elsif INSTR(V_SECTION2,'�ǰ���ǰ') > 0 OR INSTR(V_SECTION3,'�ֽ�/��ä����') > 0 then
              v_cate := 'C124';              
            elsif INSTR(V_SECTION2,'ȫ��/�λ�') > 0 then
              v_cate := 'C313';      
            end if;
          elsif  V_DIVISION = '����Ʈ^���� > ����Ʈ^����' then
            if INSTR(V_SECTION2,'�ٵ��ɾ�') > 0 then
              v_cate := 'C120';     
            elsif INSTR(V_SECTION3,'��Ų/�μ�') > 0 then
              v_cate := 'C118';              
            elsif INSTR(V_SECTION3,'����') > 0 then
              v_cate := 'C325';                                          
            elsif INSTR(V_SECTION3,'���ĵ�') > 0 then
              v_cate := 'C130';                   
            end if;
          elsif  V_DIVISION = '����Ʈ^�мǺ�Ƽ > ����Ʈ^�мǺ�Ƽ' then
            if INSTR(V_SECTION3,'��Ų/�μ�') > 0 then
              v_cate := 'C118';     
            end if;
          elsif  V_DIVISION = '������/�ƿ����� > ����/����' then
            if INSTR(V_SECTION3,'��ȭ��Ÿ') > 0 then
              v_cate := 'C250';     
            elsif INSTR(V_SECTION2,'����') > 0 then
              v_cate := 'C252';                                 
            end if;            
          end if;
        elsif V_SHOPNAME = 'oclock' then
          if  V_DIVISION = '�����Ƿ�>������' then
            if INSTR(V_PRODNAME,'Ƽ����') > 0 OR INSTR(V_PRODNAME,'���콺') > 0 OR INSTR(V_PRODNAME,'�ĵ�') > 0 OR INSTR(V_PRODNAME,'��Ʈ') > 0 OR INSTR(V_PRODNAME,'������') > 0 then
              v_cate := 'C105';
            elsif INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'Ʈ���̴�') > 0 then
              v_cate := 'C273';
            elsif INSTR(V_PRODNAME,'����') > 0  OR INSTR(V_PRODNAME,'��Ʈ') > 0 then  
              v_cate := 'C274';
            elsif INSTR(V_PRODNAME,'�ƿ���') > 0  OR INSTR(V_PRODNAME,'����') > 0  OR INSTR(V_PRODNAME,'��Ʈ') > 0 OR INSTR(V_PRODNAME,'�е�') > 0 then  
              v_cate := 'C275';
            end if;
          elsif  V_DIVISION = '�����Ƿ�>������' then
            if INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'�����') > 0 OR INSTR(V_PRODNAME,'��Ʈ') > 0 OR INSTR(V_PRODNAME,'��Ʈ') > 0 OR INSTR(V_PRODNAME,'������') > 0 then
              v_cate := 'C106';
            elsif INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'��Ű��') > 0 then
              v_cate := 'C270';
            elsif INSTR(V_PRODNAME,'���ǽ�') > 0  OR INSTR(V_PRODNAME,'ġ��') > 0 OR INSTR(V_PRODNAME,'��ĿƮ') > 0 OR INSTR(V_PRODNAME,'����') > 0 OR INSTR(V_PRODNAME,'��Ʈ') > 0 then  
              v_cate := 'C272';
            elsif INSTR(V_PRODNAME,'�ƿ���') > 0  OR INSTR(V_PRODNAME,'����') > 0  OR INSTR(V_PRODNAME,'��Ʈ') > 0 OR INSTR(V_PRODNAME,'�е�') > 0 then  
              v_cate := 'C272';
            elsif INSTR(V_PRODNAME,'��Ÿŷ') > 0  OR INSTR(V_PRODNAME,'���뽺') > 0   then  
              v_cate := 'C111';              
            elsif INSTR(V_PRODNAME,'����') > 0 then  
              v_cate := 'C110';                            
            end if;  
          end if;
        end if;
      end if;
  END IF;
  RETURN v_cate;
END;