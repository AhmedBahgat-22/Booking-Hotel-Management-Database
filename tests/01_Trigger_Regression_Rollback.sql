/*
 Regression tests for the developed schema on a FRESH TEST DATABASE
 with synthetic demo seed loaded. This script rolls back all data changes.
 Never run it on the original BookingSystemDB or BookingSystemDB_Dev.
*/
USE [HotelBookingPortfolioDB];
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRY
    IF DB_NAME()<>N'HotelBookingPortfolioDB'
        THROW 53000, 'Wrong test database.', 1;
    IF (SELECT COUNT(*) FROM dbo.Booking)<3
        THROW 53001, 'Load synthetic seed first.', 1;

    BEGIN TRANSACTION;

    DECLARE @AuditBefore int=(SELECT COUNT(*) FROM dbo.Booking_Audit);
    DECLARE @HistoryBefore int=(SELECT COUNT(*) FROM dbo.RoomPrice_History);

    -- Multiple booking updates must produce exactly three audit rows.
    DECLARE @IDs TABLE (Booking_ID int PRIMARY KEY);
    INSERT INTO @IDs
    SELECT TOP (3) Booking_ID FROM dbo.Booking ORDER BY Booking_ID;

    UPDATE b
    SET Status = CASE WHEN b.Status=N'Cancelled' THEN N'Confirmed' ELSE N'Cancelled' END
    FROM dbo.Booking b INNER JOIN @IDs x ON x.Booking_ID=b.Booking_ID;

    IF (SELECT COUNT(*) FROM dbo.Booking_Audit)<>@AuditBefore+3
       OR (SELECT COUNT(*) FROM dbo.Booking_Audit a
           JOIN @IDs i ON a.Booking_ID=i.Booking_ID
           WHERE a.Action_Type='UPDATE')<>3
        THROW 53002, 'Multi-row Booking audit test failed.', 1;

    -- Create then delete a test booking, producing INSERT and DELETE audit rows.
    DECLARE @New TABLE (Booking_ID int PRIMARY KEY);
    INSERT INTO dbo.Booking
      (Customer_ID,Room_ID,CheckInDate,Hotel_ID,PromoCode,CheckOutDate,TotalCost,Status)
    OUTPUT inserted.Booking_ID INTO @New
    SELECT TOP (1) Customer_ID,Room_ID,'2035-06-01',Hotel_ID,NULL,
           '2035-06-05',5000.00,N'Confirmed'
    FROM dbo.Booking ORDER BY Booking_ID;
    IF (SELECT COUNT(*) FROM dbo.Booking_Audit a JOIN @New n
        ON n.Booking_ID=a.Booking_ID WHERE a.Action_Type='INSERT')<>1
       THROW 53003, 'Booking INSERT audit test failed.', 1;
    DELETE b FROM dbo.Booking b JOIN @New n ON n.Booking_ID=b.Booking_ID;
    IF (SELECT COUNT(*) FROM dbo.Booking_Audit a JOIN @New n
        ON n.Booking_ID=a.Booking_ID WHERE a.Action_Type='DELETE')<>1
       THROW 53004, 'Booking DELETE audit test failed.', 1;

    -- A no-op price update must not add a history row.
    UPDATE dbo.RoomType SET BasePrice=BasePrice WHERE TypeCode=N'1BR-APT';
    IF (SELECT COUNT(*) FROM dbo.RoomPrice_History)<>@HistoryBefore
       THROW 53005, 'False price history recorded.', 1;

    -- A two-row price change must add two correct history entries.
    DECLARE @Prices TABLE(TypeCode nvarchar(10) PRIMARY KEY, OldPrice decimal(10,2));
    INSERT INTO @Prices
      SELECT TypeCode,BasePrice FROM dbo.RoomType
      WHERE TypeCode IN (N'1BR-APT',N'2BR-APT');
    IF (SELECT COUNT(*) FROM @Prices)<>2
       THROW 53006, 'Required demo room types not found.', 1;
    UPDATE rt SET BasePrice=rt.BasePrice+10
      FROM dbo.RoomType rt JOIN @Prices p ON p.TypeCode=rt.TypeCode;
    IF (SELECT COUNT(*) FROM dbo.RoomPrice_History h
        JOIN @Prices p ON p.TypeCode=h.Room_TypeCode
        WHERE h.Old_Price=p.OldPrice AND h.New_Price=p.OldPrice+10)<>2
       THROW 53007, 'Multi-row price audit test failed.', 1;

    SELECT 'PASS' AS TestResult,
           'UPDATE 3 bookings + INSERT/DELETE 1 booking + price changes' AS TestedFeatures;
    ROLLBACK TRANSACTION;
    PRINT 'PASS: Regression tests completed; all changes rolled back.';
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO
