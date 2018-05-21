/* *************************************************************************
 * NAME : dbo.tr_asis_goods
 * TYPE : TRIGGER (SQL_TRIGGER)
 * TIME : Create: 2018-04-05 12:17:29.703
 *        Modify: 2018-05-02 15:22:20.847
 *        Backup: 20180521_1739
 ************************************************************************* */

CREATE TRIGGER tr_asis_goods ON asis_goods
    INSTEAD OF INSERT,
               UPDATE,
               DELETE
AS
BEGIN
    RAISERROR( 'This table is read only.', 16, 1 )
    ROLLBACK TRANSACTION
END;