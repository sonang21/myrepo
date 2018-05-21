/* *************************************************************************
 * NAME : DBENURI.UDP_ALARM_SAVE_GOODS
 * TYPE : PROCEDURE
 * TIME : Create: 2018-03-28 18:50:00
 *        Modify: 2018-03-28 18:50:04
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PROCEDURE "DBENURI"."UDP_ALARM_SAVE_GOODS" 
AS
BEGIN
    INSERT INTO MOBILE_PUSH_TARGET
    SELECT PUSHID||RNUM            pid,
           MEMBER_ID               enuriid,
           'E'                     pushtype,
           MEMBER_ID||'´ÔÀÇ Âò »óÇ°,,, '||MODELNM||' '||DIFF||'¿ø ³»·È¾î¿ä!!!' ptitle,--and title?
           '('||PRICE1||'->'||PRICE2||') '||MODELNM||' »óÇ°ÀÇ °¡°ÝÀÌ '||DIFF||'¿ø ³»·È¾î¿ä!!!' pmsg,--ios?, and Á¢Èûbody
           '('||PRICE1||'->'||PRICE2||') '||MODELNM||' »óÇ°ÀÇ °¡°ÝÀÌ '||DIFF||'¿ø ³»·È¾î¿ä!!!' pbody,--and ÆîÄ§body
           Nvl(IMG1, 'http://')    img1,
           'http://'               img2,
           'enuri://detail?pushid='||PUSHID||RNUM||'&'||'modelno='||MODELNO               durl,
           'Y'                     sound,
           'N'                     vbr,
           'N'                     del,
           '0'                     status,
           'È«'                    sender,
           SYSDATE,
           SYSDATE                 ins,
           NULL                    upd,
           'B'                     apptype,
           '1001'                  appid
    FROM   (SELECT Lpad(( Row_number()
                            OVER(
                              PARTITION BY A.MEMBER_ID
                              ORDER BY A.MEMBER_ID, A.MODELNO) ), 5, '0') rnum,
                   To_char(SYSDATE, 'YYYYMMDDHH24MISS')                   pushid,
                   A.MEMBER_ID,
                   A.MODELNO,
                   B.MODELNM,
                   B.P_IMGURL                                             img1,
                   Nvl(A.ALARM_MINPRICE, 0)                               price1,
                   B.MINPRICE                                             price2,
                   ( Nvl(A.ALARM_MINPRICE, 0) - B.MINPRICE )              diff
            FROM   TBL_MEMBER_SAVE_GOODS A,
                   TBL_GOODS B
            WHERE  A.MODELNO = B.MODELNO
               AND Nvl(A.ALARM_MINPRICE, 0) <> B.MINPRICE
               AND REG_DATE >= SYSDATE - 30
--               AND A.ALARM_YN = 'Y'
               AND A.MODELNO > 0
               AND B.CATEFLAG > 0
               AND B.MINPRICE > 0
               AND MEMBER_ID IN ( 'sonane45', 'en319', 'ddononi', 'jtj134',
                                  'ksay33', 'cherub1004', 'en644', 'mollarra',
                                  'flyght', 'baegopha1230', 'c1223' )
            GROUP  BY A.MEMBER_ID,
                      A.MODELNO,
                      B.MODELNM,
                      B.P_IMGURL,
                      A.ALARM_MINPRICE,
                      B.MINPRICE
            ORDER  BY A.MEMBER_ID,
                      A.MODELNO) AA;

    UPDATE TBL_MEMBER_SAVE_GOODS A
    SET    ALARM_MINPRICE = (SELECT B.MINPRICE
                             FROM   TBL_GOODS B
                             WHERE  A.MODELNO = B.MODELNO
                                AND Nvl(A.ALARM_MINPRICE, 0) <> B.MINPRICE
                                AND A.REG_DATE >= SYSDATE - 30
--                                AND A.ALARM_YN = 'Y'
                                AND A.MODELNO > 0
                                AND B.CATEFLAG > 0
                                AND B.MINPRICE > 0
                                AND ROWNUM = 1)
--    WHERE  A.ALARM_YN = 'Y'
--       AND A.MODELNO > 0
    WHERE  A.MODELNO > 0
       AND A.MEMBER_ID IN ( 'sonane45', 'en319', 'ddononi', 'jtj134',
                            'ksay33', 'cherub1004', 'en644', 'mollarra',
                            'flyght', 'baegopha1230', 'c1223' );

    COMMIT;
END UDP_ALARM_SAVE_GOODS; 



select * from tbl_goods
where modelno='12209575';


SELECT A.MEMBER_ID, B.MINPRICE
FROM   TBL_MEMBER_SAVE_GOODS A , TBL_GOODS B
WHERE  A.MODELNO = B.MODELNO
       --AND Nvl(A.ALARM_MINPRICE, 0) <> B.MINPRICE
       --AND A.REG_DATE >= SYSDATE - 30
       --AND A.MODELNO > 0
       --AND B.MODELNO = '12209582'
       AND B.CATEFLAG > 0
       --AND B.MINPRICE > 0
       --AND ROWNUM = 1
       and MEMBER_ID='ksay33'