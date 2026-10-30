# What changed from the original academic database

The original schema used a composite **Booking** primary key `(Customer_ID, Room_ID, CheckInDate)` and a matching composite **Payment** primary/foreign key. This project was migrated on an **existing development database** `BookingSystemDB_Dev` on October 30, 2026.

- Added `Booking.Booking_ID INT IDENTITY(1,1)` and promoted it to the primary key.
- Added `Payment.Payment_ID INT IDENTITY(1,1)` and promoted it to the primary key.
- Added `Payment.Booking_ID INT NOT NULL` with the checked foreign key `FK_Payment_BookingID`.
- Preserved `(Customer_ID,Room_ID,CheckInDate)` booking uniqueness as `UQ_Booking_LegacyComposite`.
- Kept legacy customer/room/date columns in Payment for historical compatibility. **These legacy values do not automatically synchronize when booking details change.** Applications should rely on `Booking_ID` for joining bookings to payments.
- Added `Booking_Audit.Booking_ID` and updated `trg_Booking_Audit_Log` to use the stable ID to pair `inserted`/`deleted` rows.
- Kept `trg_Monitor_Price_Change` to record actual `BasePrice` updates.
- The primary-key migration was executed in SSMS, and screenshots/results in the conversation showed 50 bookings, 50 payments, valid FK and no mismatch. Those **live data rows were not exported** in the provided schema-only file.

## Migration file versus fresh install

- `database/01_Schema.sql` is the **canonical final schema** for creating a new database. It ALREADY includes all migrated columns, constraints and triggers.
- `migrations/2026_10_30_Final_Keys_Migration.sql` is **historical documentation / one-time migration** for the prior schema of `BookingSystemDB_Dev`. It is NOT part of fresh installation; never rerun it on the completed schema.
- `database/02_Synthetic_Demo_Data.sql` recreates an illustrative 50-booking/50-payment sample (with anonymized customer/contact details), **not an export of existing user records**.

## Scope and caveats

- Audit trigger records insert/update/delete including updates that do not materially change values. It does not retain a full before-and-after snapshot of all booking fields.
- Price trigger detects actual price changes with `TypeCode` assumed stable.
- Payment retains masked payment placeholders in sample data. Never upload unmasked payment identifiers.
- The UML and Report PDFs/images were retained as originally submitted. They may depict the legacy composite keys; the Mermaid architecture diagram in the README reflects the updated design.
- An exported schema script is not an entire `.bak` and does not include live business data.
