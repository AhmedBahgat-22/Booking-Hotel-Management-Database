/*
  Creates a separate, empty demonstration database.
  Never runs DROP DATABASE or overwrites BookingSystemDB / BookingSystemDB_Dev.
  Run this ONCE before 01_Schema.sql.
*/
USE [master];
GO
IF DB_ID(N'HotelBookingPortfolioDB') IS NOT NULL
BEGIN
    THROW 51001, 'HotelBookingPortfolioDB already exists. Stop here; do not rerun setup.', 1;
END;

EXEC(N'CREATE DATABASE [HotelBookingPortfolioDB]');
PRINT 'Created empty database HotelBookingPortfolioDB.';
GO
