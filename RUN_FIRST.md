# START HERE — Developed Project

This is the **developed SQL Server version**, not the original academic schema.

1. Open Microsoft SQL Server Management Studio (SSMS).
2. Open and run **`database/00_Create_Database.sql`** on a development/test server. It creates `HotelBookingPortfolioDB` and will refuse to overwrite an existing DB.
3. Then run `database/01_Schema.sql` and confirm successful completion.
4. Optionally run `database/02_Synthetic_Demo_Data.sql` (creates synthetic sample rows), then `database/03_Verify_Database.sql`.
5. Optionally run the rollback-only regression test `tests/01_Trigger_Regression_Rollback.sql`.
6. After testing, initialize Git in THIS folder and push to a new GitHub repository.

Do not run `migrations/2026_10_30_Final_Keys_Migration.sql` for a fresh setup. It is a historical one-time conversion file for an existing development database.

The actual 50 live Booking and 50 Payment records are **not present** in the supplied schema-only export. The optional seed recreates illustrative data with synthetic customer identities; it is **not** a copy of the user's live records.
