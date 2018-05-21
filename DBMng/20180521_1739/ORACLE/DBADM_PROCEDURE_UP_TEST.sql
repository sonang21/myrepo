/* *************************************************************************
 * NAME : DBADM.UP_TEST
 * TYPE : PROCEDURE
 * TIME : Create: 2018-05-09 12:57:24
 *        Modify: 2018-05-09 13:02:46
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBADM"."UP_TEST" 
IS
     V_CLOB1 CLOB;
     V_CLOB2 CLOB;
     V_CLOB3 CLOB;
     V_CLOB4 CLOB;
     V_CLOB5 CLOB;
     V_CLOB6 CLOB;
     V_CLOB7 CLOB;
     V_CLOB8 CLOB;
     V_CLOB9 CLOB;

BEGIN
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    
    V_CLOB1 := '가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이
                가나다라마바사 ABCDED AAAA BBBB CCCC DDDD ZZZZ 아자차차카타파하 ㅁㄴㅇ리ㅏㅓ;ㅁ넝ㄹ;ㄴㅁㅇ러ㅏㄴㅇ라 오케이';
    


END;
