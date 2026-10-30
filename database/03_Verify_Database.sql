/* Read-only verification for the developed SQL Server database.
   Works with empty schema and optional demo seed.
   Expected: 18 tables, 19 FK constraints, 2 triggers.
*/
USE [HotelBookingPortfolioDB];
GO
SELECT DB_NAME() AS DatabaseName,
       (SELECT COUNT(*) FROM sys.tables WHERE is_ms_shipped=0) AS Tables,
       (SELECT COUNT(*) FROM sys.foreign_keys) AS ForeignKeys,
       (SELECT COUNT(*) FROM sys.triggers WHERE parent_class=1 AND is_ms_shipped=0) AS Triggers;
GO
SELECT OBJECT_NAME(kc.parent_object_id) AS TableName,
       kc.name AS ConstraintName, c.name AS PrimaryKeyColumn
FROM sys.key_constraints kc
JOIN sys.index_columns ic ON ic.object_id=kc.parent_object_id
  AND ic.index_id=kc.unique_index_id AND ic.key_ordinal=1
JOIN sys.columns c ON c.object_id=ic.object_id AND c.column_id=ic.column_id
WHERE kc.type='PK' AND OBJECT_NAME(kc.parent_object_id) IN ('Booking','Payment');
GO
SELECT fk.name AS ForeignKeyName, fk.is_disabled, fk.is_not_trusted,
       OBJECT_NAME(fk.parent_object_id) AS FromTable,
       OBJECT_NAME(fk.referenced_object_id) AS ToTable
FROM sys.foreign_keys fk WHERE fk.name='FK_Payment_BookingID';
GO
SELECT 'Booking' AS TableName,COUNT(*) AS TotalRows FROM dbo.Booking
UNION ALL SELECT 'Payment',COUNT(*) FROM dbo.Payment
UNION ALL SELECT 'Booking_Audit',COUNT(*) FROM dbo.Booking_Audit
UNION ALL SELECT 'RoomPrice_History',COUNT(*) FROM dbo.RoomPrice_History;
GO
SELECT COUNT(*) AS PaymentMappingMismatches
FROM dbo.Payment p LEFT JOIN dbo.Booking b ON b.Booking_ID=p.Booking_ID
WHERE b.Booking_ID IS NULL
   OR p.Customer_ID<>b.Customer_ID
   OR p.Room_ID<>b.Room_ID
   OR p.CheckInDate<>b.CheckInDate;
GO
SELECT t.name AS TriggerName, OBJECT_NAME(t.parent_id) AS ParentTable,
       CASE WHEN t.is_disabled=0 THEN 'Enabled' ELSE 'Disabled' END AS Status
FROM sys.triggers t WHERE t.name IN ('trg_Booking_Audit_Log','trg_Monitor_Price_Change');
GO
