/* *************************************************************************
 * NAME : ASISTEST.QUEST_SOO_USER_MANAGER
 * TYPE : PACKAGE
 * TIME : Create: 2018-05-04 18:33:38
 *        Modify: 2018-05-07 13:11:13
 *        Backup: 20180521_1739
 ************************************************************************* */


  CREATE OR REPLACE PACKAGE "ASISTEST"."QUEST_SOO_USER_MANAGER" 
IS
--
-- This package contains routines for user management, mostly for QCO
--
-- Person      Date    Comments
-- ---------   ------  -----------------------------------------------
-- Han B Xie   May2001 Created.

    PROCEDURE grant_user    (user_p VARCHAR2);
    PROCEDURE revoke_user   (user_p VARCHAR2);
    FUNCTION  validate_user (user_p VARCHAR2) RETURN INTEGER;

END; -- QUEST_SOO_USER_MANAGER;
