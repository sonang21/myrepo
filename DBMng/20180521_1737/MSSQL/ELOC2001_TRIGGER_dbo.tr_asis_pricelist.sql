/* *************************************************************************
 * NAME : dbo.tr_asis_pricelist
 * TYPE : TRIGGER (SQL_TRIGGER)
 * TIME : Create: 2018-04-05 12:17:03.773
 *        Modify: 2018-05-02 15:22:20.823
 *        Backup: 20180521_1737
 ************************************************************************* */

CREATE TRIGGER tr_asis_pricelist ON asis_pricelist
    INSTEAD OF INSERT,
               UPDATE,
               DELETE
AS
BEGIN
    RAISERROR( 'This table is read only.', 16, 1 )
    ROLLBACK TRANSACTION
END;
