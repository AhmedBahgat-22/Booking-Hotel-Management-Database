/*
  SYNTHETIC DEMO DATA (fresh HotelBookingPortfolioDB only)
  Adapted from the original academic sample INSERT statements.
  Customer identities/contact details replaced with synthetic placeholders.
  Payment card identifiers replaced with TEST-ONLY masked placeholders.
  Do NOT use with BookingSystemDB or BookingSystemDB_Dev.
  This is NOT a dump of the user's live 50-record database.
  Run once AFTER 00_Create_Database.sql and 01_Schema.sql.
  The booking audit trigger will record seed INSERT events (50 rows).
*/
USE [HotelBookingPortfolioDB];
GO
SET NOCOUNT ON;
SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;
    IF DB_NAME() <> N'HotelBookingPortfolioDB'
        THROW 52001, 'Wrong database selected.', 1;
    IF EXISTS (SELECT 1 FROM dbo.Booking)
       OR EXISTS (SELECT 1 FROM dbo.Customer)
       OR EXISTS (SELECT 1 FROM dbo.Country)
        THROW 52002, 'This seed is for a new, empty database only.', 1;

    -- Country seed data

    INSERT INTO dbo.Country (CountryISO, CountryName, PhonePrefix, Continent) VALUES
('EG', 'Egypt', '+20', 'Africa'), ('SA', 'Saudi Arabia', '+966', 'Asia'), ('AE', 'United Arab Emirates', '+971', 'Asia'), ('US', 'United States', '+1', 'North America'), ('GB', 'United Kingdom', '+44', 'Europe'),
('FR', 'France', '+33', 'Europe'), ('IT', 'Italy', '+39', 'Europe'), ('DE', 'Germany', '+49', 'Europe'), ('ES', 'Spain', '+34', 'Europe'), ('TR', 'Turkey', '+90', 'Asia'),
('JP', 'Japan', '+81', 'Asia'), ('CN', 'China', '+86', 'Asia'), ('IN', 'India', '+91', 'Asia'), ('BR', 'Brazil', '+55', 'South America'), ('CA', 'Canada', '+1', 'North America'),
('RU', 'Russia', '+7', 'Europe'), ('ZA', 'South Africa', '+27', 'Africa'), ('AU', 'Australia', '+61', 'Australia'), ('KR', 'South Korea', '+82', 'Asia'), ('MX', 'Mexico', '+52', 'North America'),
('ID', 'Indonesia', '+62', 'Asia'), ('MY', 'Malaysia', '+60', 'Asia'), ('SG', 'Singapore', '+65', 'Asia'), ('TH', 'Thailand', '+66', 'Asia'), ('VN', 'Vietnam', '+84', 'Asia'),
('PH', 'Philippines', '+63', 'Asia'), ('PK', 'Pakistan', '+92', 'Asia'), ('BD', 'Bangladesh', '+880', 'Asia'), ('NG', 'Nigeria', '+234', 'Africa'), ('KE', 'Kenya', '+254', 'Africa'),
('MA', 'Morocco', '+212', 'Africa'), ('DZ', 'Algeria', '+213', 'Africa'), ('TN', 'Tunisia', '+216', 'Africa'), ('LB', 'Lebanon', '+961', 'Asia'), ('JO', 'Jordan', '+962', 'Asia'),
('KW', 'Kuwait', '+965', 'Asia'), ('OM', 'Oman', '+968', 'Asia'), ('QA', 'Qatar', '+974', 'Asia'), ('BH', 'Bahrain', '+973', 'Asia'), ('GR', 'Greece', '+30', 'Europe'),
('PT', 'Portugal', '+351', 'Europe'), ('SE', 'Sweden', '+46', 'Europe'), ('CH', 'Switzerland', '+41', 'Europe'), ('AT', 'Austria', '+43', 'Europe'), ('BE', 'Belgium', '+32', 'Europe'),
('NL', 'Netherlands', '+31', 'Europe'), ('DK', 'Denmark', '+45', 'Europe'), ('NO', 'Norway', '+47', 'Europe'), ('FI', 'Finland', '+358', 'Europe'), ('NZ', 'New Zealand', '+64', 'Australia');

    -- Currency seed data

    INSERT INTO dbo.Currency (CurrencyCode, Symbol, ExchangeRateToUSD, LastUpdateTimestamp) VALUES
('USD', '$', 1.00, '2026-01-21 08:00:00'), 
('EUR', '€', 0.92, '2026-01-21 08:05:30'), 
('GBP', '£', 0.79, '2026-01-21 08:10:15'), 
('JPY', '¥', 150.12, '2026-01-20 23:45:00'), 
('EGP', '£', 48.50, '2026-01-21 09:30:00'),
('SAR', 'SR', 3.75, '2026-01-21 09:00:00'), 
('AED', 'DH', 3.67, '2026-01-21 09:15:00'), 
('AUD', '$', 1.52, '2026-01-20 22:00:00'), 
('CAD', '$', 1.35, '2026-01-20 21:30:00'), 
('CHF', 'Fr', 0.88, '2026-01-21 07:45:00'),
('CNY', '¥', 7.19, '2026-01-21 06:00:00'), 
('SEK', 'kr', 10.33, '2026-01-21 07:30:00'), 
('NZD', '$', 1.63, '2026-01-20 20:00:00'), 
('MXN', '$', 17.05, '2026-01-20 18:00:00'), 
('SGD', '$', 1.34, '2026-01-21 05:00:00'),
('HKD', '$', 7.82, '2026-01-21 04:30:00'), 
('NOK', 'kr', 10.51, '2026-01-21 07:15:00'), 
('KRW', 'W', 1330.50, '2026-01-21 03:00:00'), 
('TRY', 'TL', 30.55, '2026-01-21 08:30:00'), 
('RUB', 'P', 91.20, '2026-01-21 06:45:00'),
('INR', 'R', 83.04, '2026-01-21 05:30:00'), 
('BRL', 'R$', 4.95, '2026-01-20 17:00:00'), 
('ZAR', 'R', 18.90, '2026-01-21 06:15:00'), 
('DKK', 'kr', 6.89, '2026-01-21 07:50:00'), 
('PLN', 'zl', 3.96, '2026-01-21 07:40:00'),
('THB', 'B', 35.50, '2026-01-21 04:00:00'), 
('IDR', 'Rp', 15600.0, '2026-01-21 03:30:00'), 
('HUF', 'Ft', 355.20, '2026-01-21 07:20:00'), 
('CZK', 'Kc', 23.50, '2026-01-21 07:10:00'), 
('ILS', 'S', 3.62, '2026-01-21 08:20:00'),
('CLP', '$', 960.00, '2026-01-20 16:00:00'), 
('PHP', 'P', 56.10, '2026-01-21 02:00:00'), 
('KWD', 'KD', 0.31, '2026-01-21 09:10:00'), 
('QAR', 'QR', 3.64, '2026-01-21 09:05:00'), 
('BHD', 'BD', 0.38, '2026-01-21 09:12:00'),
('OMR', 'OR', 0.38, '2026-01-21 09:08:00'), 
('JOD', 'JD', 0.71, '2026-01-21 08:50:00'), 
('LBP', 'L', 89000.0, '2026-01-21 08:40:00'), 
('MAD', 'dh', 10.05, '2026-01-21 08:00:00'), 
('TND', 'DT', 3.12, '2026-01-21 08:10:00'),
('DZD', 'DA', 134.50, '2026-01-21 08:15:00'), 
('KES', 'KS', 145.20, '2026-01-21 06:30:00'), 
('NGN', 'N', 1500.00, '2026-01-21 05:45:00'), 
('VND', 'd', 24500.0, '2026-01-21 03:15:00'), 
('MYR', 'RM', 4.77, '2026-01-21 02:45:00'),
('PKR', 'Rs', 279.10, '2026-01-21 05:15:00'), 
('BDT', 'Tk', 110.00, '2026-01-21 04:45:00'), 
('LKR', 'Rs', 310.50, '2026-01-21 05:00:00'), 
('COP', '$', 3900.00, '2026-01-20 15:00:00'), 
('PEN', 'S/', 3.82, '2026-01-20 15:30:00');

    -- Language seed data

    INSERT INTO dbo.Language (LangCode, LanguageName, TextDirection) VALUES
('EN', 'English', 'LTR'), ('AR', 'Arabic', 'RTL'), ('FR', 'French', 'LTR'), ('DE', 'German', 'LTR'), ('ES', 'Spanish', 'LTR'),
('IT', 'Italian', 'LTR'), ('TR', 'Turkish', 'LTR'), ('JA', 'Japanese', 'LTR'), ('ZH', 'Chinese', 'LTR'), ('RU', 'Russian', 'LTR'),
('PT', 'Portuguese', 'LTR'), ('KO', 'Korean', 'LTR'), ('HI', 'Hindi', 'LTR'), ('ID', 'Indonesian', 'LTR'), ('NL', 'Dutch', 'LTR'),
('SV', 'Swedish', 'LTR'), ('NO', 'Norwegian', 'LTR'), ('DA', 'Danish', 'LTR'), ('FI', 'Finnish', 'LTR'), ('EL', 'Greek', 'LTR'),
('HE', 'Hebrew', 'RTL'), ('PL', 'Polish', 'LTR'), ('CS', 'Czech', 'LTR'), ('HU', 'Hungarian', 'LTR'), ('RO', 'Romanian', 'LTR'),
('BG', 'Bulgarian', 'LTR'), ('SK', 'Slovak', 'LTR'), ('SL', 'Slovenian', 'LTR'), ('HR', 'Croatian', 'LTR'), ('SR', 'Serbian', 'LTR'),
('UK', 'Ukrainian', 'LTR'), ('TH', 'Thai', 'LTR'), ('VI', 'Vietnamese', 'LTR'), ('MS', 'Malay', 'LTR'), ('TL', 'Tagalog', 'LTR'),
('FA', 'Persian', 'RTL'), ('UR', 'Urdu', 'RTL'), ('BN', 'Bengali', 'LTR'), ('TA', 'Tamil', 'LTR'), ('TE', 'Telugu', 'LTR'),
('ML', 'Malayalam', 'LTR'), ('KN', 'Kannada', 'LTR'), ('MR', 'Marathi', 'LTR'), ('GU', 'Gujarati', 'LTR'), ('PA', 'Punjabi', 'LTR'),
('SW', 'Swahili', 'LTR'), ('AF', 'Afrikaans', 'LTR'), ('IS', 'Icelandic', 'LTR'), ('ET', 'Estonian', 'LTR'), ('LV', 'Latvian', 'LTR');

    -- GeniusTier seed data

    INSERT INTO dbo.GeniusTier (TierLevel, LevelName, DiscountRate) VALUES
(1, 'Member', 0), (2, 'Bronze', 2), (3, 'Bronze Plus', 3), (4, 'Bronze Elite', 4), (5, 'Bronze Star', 5),
(6, 'Silver', 6), (7, 'Silver Plus', 7), (8, 'Silver Elite', 8), (9, 'Silver Star', 9), (10, 'Silver Premier', 10),
(11, 'Gold', 11), (12, 'Gold Plus', 12), (13, 'Gold Elite', 13), (14, 'Gold Star', 14), (15, 'Gold Premier', 15),
(16, 'Platinum', 16), (17, 'Platinum Plus', 17), (18, 'Platinum Elite', 18), (19, 'Platinum Star', 19), (20, 'Platinum Premier', 20),
(21, 'Diamond', 21), (22, 'Diamond Plus', 22), (23, 'Diamond Elite', 23), (24, 'Diamond Star', 24), (25, 'Diamond Premier', 25),
(26, 'Emerald', 26), (27, 'Sapphire', 27), (28, 'Ruby', 28), (29, 'Titanium', 29), (30, 'Ambassador', 30),
(31, 'Royal', 31), (32, 'Imperial', 32), (33, 'Presidential', 33), (34, 'Globalist', 34), (35, 'Adventurer', 35),
(36, 'Explorer', 36), (37, 'Discoverer', 37), (38, 'Voyager', 38), (39, 'Globe Trotter', 39), (40, 'Jet Setter', 40),
(41, 'VIP 1', 41), (42, 'VIP 2', 42), (43, 'VIP 3', 43), (44, 'VIP 4', 44), (45, 'VIP 5', 45),
(46, 'Elite VIP', 46), (47, 'Lifetime Bronze', 47), (48, 'Lifetime Silver', 48), (49, 'Lifetime Gold', 49), (50, 'Lifetime Platinum', 50);

    -- RoomType seed data

    INSERT INTO dbo.RoomType (TypeCode, TypeName, BasePrice, MaxOccupancy) VALUES
('SGL-STD', 'Standard Single', 50, 1), ('DBL-STD', 'Standard Double', 70, 2), ('TWN-STD', 'Standard Twin', 70, 2), ('TRP-STD', 'Standard Triple', 90, 3), ('DBL-DLX', 'Deluxe Double', 100, 2),
('TWN-DLX', 'Deluxe Twin', 100, 2), ('KNG-DLX', 'Deluxe King', 120, 2), ('QUN-DLX', 'Deluxe Queen', 110, 2), ('STE-JNR', 'Junior Suite', 150, 2), ('STE-EXEC', 'Executive Suite', 200, 3),
('STE-PRES', 'Presidential Suite', 500, 4), ('STE-ROY', 'Royal Suite', 800, 5), ('FAM-STD', 'Family Room Standard', 130, 4), ('FAM-DLX', 'Family Room Deluxe', 160, 5), ('STD-APT', 'Studio Apartment', 110, 2),
('1BR-APT', '1 Bedroom Apartment', 140, 3), ('2BR-APT', '2 Bedroom Apartment', 180, 5), ('PENT', 'Penthouse', 1000, 6), ('BUNG-GV', 'Bungalow Garden View', 150, 2), ('BUNG-SV', 'Bungalow Sea View', 200, 2),
('VIL-1BR', 'Private Villa 1BR', 300, 2), ('VIL-2BR', 'Private Villa 2BR', 450, 4), ('VIL-POOL', 'Villa with Pool', 600, 4), ('CAB-SGL', 'Single Cabin', 40, 1), ('CAB-DBL', 'Double Cabin', 60, 2),
('POD-SGL', 'Sleeping Pod', 30, 1), ('DORM-4', 'Dormitory 4-Bed', 20, 1), ('DORM-6', 'Dormitory 6-Bed', 15, 1), ('ACC-SGL', 'Accessible Single', 50, 1), ('ACC-DBL', 'Accessible Double', 70, 2),
('CON-RM', 'Connecting Room', 140, 4), ('BUS-SGL', 'Business Single', 80, 1), ('BUS-DBL', 'Business Double', 110, 2), ('HON-STE', 'Honeymoon Suite', 250, 2), ('COR-STE', 'Corner Suite', 180, 2),
('LOFT', 'City Loft', 130, 2), ('DUPLEX', 'Duplex Room', 160, 3), ('ECO-SGL', 'Eco-Friendly Single', 45, 1), ('ECO-DBL', 'Eco-Friendly Double', 65, 2), ('GLAMP', 'Glamping Tent', 120, 2),
('TREE', 'Treehouse', 180, 2), ('BOAT', 'Houseboat Cabin', 150, 2), ('CAVE', 'Cave Room', 140, 2), ('IGLOO', 'Glass Igloo', 400, 2), ('RYOKAN', 'Japanese Ryokan', 200, 3),
('MURPHY', 'Murphy Bed Room', 55, 2), ('BSMT', 'Budget Basement', 35, 2), ('ATTIC', 'Cozy Attic', 60, 2), ('PATIO', 'Patio Room', 95, 2), ('TERR', 'Terrace Suite', 220, 2);

    -- Facility seed data

    INSERT INTO dbo.Facility (FacilityCode, Icon, Description, Category, CostType, OperationalHours) VALUES
('WF-FREE', 'wifi', 'High-Speed WiFi', 'Internet', 'Complimentary', '24/7'),
('POOL-OUT', 'pool', 'Outdoor Pool', 'Wellness', 'Complimentary', '07:00 - 19:00'),
('POOL-IN', 'pool', 'Heated Indoor Pool', 'Wellness', 'Complimentary', '06:00 - 22:00'),
('GYM-24', 'gym', '24h Fitness Center', 'Wellness', 'Complimentary', '24/7'),
('SPA-FULL', 'spa', 'Full Service Spa', 'Wellness', 'Surcharge', '10:00 - 22:00'),
('PARK-VAL', 'car', 'Valet Parking', 'Transport', 'Surcharge', '24/7'),
('PARK-SEL', 'car', 'Self Parking', 'Transport', 'Complimentary', '24/7'),
('REST-MAIN', 'food', 'Main Restaurant', 'Dining', 'Surcharge', '06:30 - 23:00'),
('BAR-ROOF', 'drink', 'Rooftop Bar', 'Dining', 'Surcharge', '17:00 - 02:00'),
('CAFE-LOB', 'coffee', 'Lobby Cafe', 'Dining', 'Surcharge', '08:00 - 00:00'),
('ROOM-SVC', 'bell', '24h Room Service', 'Services', 'Surcharge', '24/7'),
('BKFST', 'food', 'Buffet Breakfast', 'Dining', 'Surcharge', '06:30 - 10:30'),
('LNDRY', 'wash', 'Laundry Service', 'Services', 'Surcharge', '08:00 - 20:00'),
('DRY-CLN', 'shirt', 'Dry Cleaning', 'Services', 'Surcharge', '08:00 - 18:00'),
('IRON', 'iron', 'Ironing Service', 'Services', 'Surcharge', 'On Request'),
('CONC', 'key', 'Concierge Service', 'Services', 'Complimentary', '24/7'),
('LUG-STR', 'bag', 'Luggage Storage', 'Services', 'Complimentary', '24/7'),
('CURR-EX', 'money', 'Currency Exchange', 'Services', 'Complimentary', '24/7'),
('ATM', 'atm', 'ATM on site', 'Services', 'Complimentary', '24/7'),
('RECEP-24', 'clock', '24h Front Desk', 'Services', 'Complimentary', '24/7'),
('AIR-CON', 'fan', 'Air Conditioning', 'Room', 'Complimentary', '24/7'),
('HEAT', 'fire', 'Central Heating', 'Room', 'Complimentary', '24/7'),
('MINIBAR', 'drink', 'Minibar', 'Room', 'Surcharge', '24/7'),
('SAFE', 'lock', 'In-room Safe', 'Room', 'Complimentary', '24/7'),
('TV-SMART', 'tv', 'Smart TV with Netflix', 'Room', 'Complimentary', '24/7'),
('BALCONY', 'view', 'Private Balcony', 'Room', 'Complimentary', '24/7'),
('KETTLE', 'tea', 'Electric Kettle', 'Room', 'Complimentary', '24/7'),
('COFFEE', 'bean', 'Nespresso Machine', 'Room', 'Complimentary', '24/7'),
('HAIR-DRY', 'dryer', 'Hairdryer', 'Room', 'Complimentary', '24/7'),
('BATH-TUB', 'bath', 'Bathtub', 'Room', 'Complimentary', '24/7'),
('SHOWER', 'rain', 'Rain Shower', 'Room', 'Complimentary', '24/7'),
('TOILET', 'wc', 'Bidet', 'Room', 'Complimentary', '24/7'),
('DESK', 'work', 'Work Desk', 'Room', 'Complimentary', '24/7'),
('VIEW-SEA', 'sea', 'Sea View', 'Room', 'Complimentary', '24/7'),
('VIEW-CTY', 'city', 'City View', 'Room', 'Complimentary', '24/7'),
('MEET-RM', 'meet', 'Meeting Rooms', 'Business', 'Surcharge', '08:00 - 20:00'),
('BIZ-CTR', 'pc', 'Business Center', 'Business', 'Complimentary', '24/7'),
('BANQ', 'party', 'Banquet Hall', 'Business', 'Surcharge', 'On Booking'),
('FAX', 'print', 'Fax/Photocopying', 'Business', 'Surcharge', '24/7'),
('AIR-SHTL', 'bus', 'Airport Shuttle', 'Transport', 'Surcharge', 'On Schedule'),
('CAR-RENT', 'key', 'Car Rental', 'Transport', 'Surcharge', '09:00 - 18:00'),
('BIKE-RNT', 'bike', 'Bicycle Rental', 'Transport', 'Surcharge', '08:00 - 18:00'),
('KIDS-CLB', 'toy', 'Kids Club', 'Family', 'Complimentary', '09:00 - 18:00'),
('GAME-RM', 'game', 'Game Room', 'Family', 'Complimentary', '10:00 - 22:00'),
('BABY-SIT', 'baby', 'Babysitting', 'Family', 'Surcharge', 'On Request'),
('PETS', 'dog', 'Pet Friendly', 'General', 'Surcharge', '24/7'),
('NO-SMK', 'smoke', 'Non-Smoking Rooms', 'General', 'Complimentary', '24/7'),
('SMK-AREA', 'cig', 'Designated Smoking Area', 'General', 'Complimentary', '24/7'),
('LIFT', 'up', 'Elevator', 'General', 'Complimentary', '24/7'),
('DIS-ACC', 'wheel', 'Wheelchair Accessible', 'General', 'Complimentary', '24/7');

    -- Destination seed data

    INSERT INTO dbo.Destination (DestinationCode, CountryISO, CityName, RegionName, ThumbnailImage) VALUES
('CAI', 'EG', 'Cairo', 'Cairo Gov', 0x89504E470D0A1A0A), 
('SHM', 'EG', 'Sharm El Sheikh', 'South Sinai', 0x89504E470D0A1A0A), 
('HRG', 'EG', 'Hurghada', 'Red Sea', 0x89504E470D0A1A0A), 
('ALX', 'EG', 'Alexandria', 'Alexandria Gov', 0x89504E470D0A1A0A), 
('LXR', 'EG', 'Luxor', 'Luxor Gov', 0x89504E470D0A1A0A),
('RUH', 'SA', 'Riyadh', 'Riyadh Prov', 0x89504E470D0A1A0A), 
('JED', 'SA', 'Jeddah', 'Makkah Prov', 0x89504E470D0A1A0A), 
('DMM', 'SA', 'Dammam', 'Eastern Prov', 0x89504E470D0A1A0A), 
('MED', 'SA', 'Madinah', 'Al Madinah', 0x89504E470D0A1A0A), 
('MEC', 'SA', 'Makkah', 'Makkah Prov', 0x89504E470D0A1A0A),
('DXB', 'AE', 'Dubai', 'Dubai', 0x89504E470D0A1A0A), 
('AUH', 'AE', 'Abu Dhabi', 'Abu Dhabi', 0x89504E470D0A1A0A), 
('SHJ', 'AE', 'Sharjah', 'Sharjah', 0x89504E470D0A1A0A), 
('LON', 'GB', 'London', 'Greater London', 0x89504E470D0A1A0A), 
('MAN', 'GB', 'Manchester', 'North West', 0x89504E470D0A1A0A),
('PAR', 'FR', 'Paris', 'Île-de-France', 0x89504E470D0A1A0A), 
('NCE', 'FR', 'Nice', 'Provence', 0x89504E470D0A1A0A), 
('LYO', 'FR', 'Lyon', 'Auvergne', 0x89504E470D0A1A0A), 
('ROM', 'IT', 'Rome', 'Lazio', 0x89504E470D0A1A0A), 
('MIL', 'IT', 'Milan', 'Lombardy', 0x89504E470D0A1A0A),
('VEN', 'IT', 'Venice', 'Veneto', 0x89504E470D0A1A0A), 
('BER', 'DE', 'Berlin', 'Berlin', 0x89504E470D0A1A0A), 
('MUC', 'DE', 'Munich', 'Bavaria', 0x89504E470D0A1A0A), 
('FRA', 'DE', 'Frankfurt', 'Hesse', 0x89504E470D0A1A0A), 
('BCN', 'ES', 'Barcelona', 'Catalonia', 0x89504E470D0A1A0A),
('MAD', 'ES', 'Madrid', 'Madrid', 0x89504E470D0A1A0A), 
('SVQ', 'ES', 'Seville', 'Andalusia', 0x89504E470D0A1A0A), 
('IST', 'TR', 'Istanbul', 'Marmara', 0x89504E470D0A1A0A), 
('AYT', 'TR', 'Antalya', 'Mediterranean', 0x89504E470D0A1A0A), 
('ANK', 'TR', 'Ankara', 'Central Anatolia', 0x89504E470D0A1A0A),
('TOK', 'JP', 'Tokyo', 'Kanto', 0x89504E470D0A1A0A), 
('OSA', 'JP', 'Osaka', 'Kansai', 0x89504E470D0A1A0A), 
('PEK', 'CN', 'Beijing', 'North China', 0x89504E470D0A1A0A), 
('SHA', 'CN', 'Shanghai', 'East China', 0x89504E470D0A1A0A), 
('DEL', 'IN', 'New Delhi', 'Delhi', 0x89504E470D0A1A0A),
('BOM', 'IN', 'Mumbai', 'Maharashtra', 0x89504E470D0A1A0A), 
('RIO', 'BR', 'Rio de Janeiro', 'Rio', 0x89504E470D0A1A0A), 
('SAO', 'BR', 'Sao Paulo', 'Sao Paulo', 0x89504E470D0A1A0A), 
('NYC', 'US', 'New York', 'New York', 0x89504E470D0A1A0A), 
('LAX', 'US', 'Los Angeles', 'California', 0x89504E470D0A1A0A),
('MIA', 'US', 'Miami', 'Florida', 0x89504E470D0A1A0A), 
('LAS', 'US', 'Las Vegas', 'Nevada', 0x89504E470D0A1A0A), 
('CHI', 'US', 'Chicago', 'Illinois', 0x89504E470D0A1A0A), 
('TOR', 'CA', 'Toronto', 'Ontario', 0x89504E470D0A1A0A), 
('SYD', 'AU', 'Sydney', 'NSW', 0x89504E470D0A1A0A),
('MEL', 'AU', 'Melbourne', 'Victoria', 0x89504E470D0A1A0A), 
('SEL', 'KR', 'Seoul', 'Capital Area', 0x89504E470D0A1A0A), 
('MEX', 'MX', 'Mexico City', 'CDMX', 0x89504E470D0A1A0A), 
('DPS', 'ID', 'Bali', 'Bali', 0x89504E470D0A1A0A), 
('BKK', 'TH', 'Bangkok', 'Central', 0x89504E470D0A1A0A),
('LIV', 'GB', 'Liverpool', 'Merseyside', 0x89504E470D0A1A0A);

    -- Hotel seed data

    INSERT INTO dbo.Hotel (DestinationCode, CountryISO, CurrencyCode, HotelName, StarRating, CheckInTime, TaxPercentage, Address_Street, Address_City, Address_State, Address_PostalCode, Address_Country) VALUES
('CAI', 'EG', 'EGP', 'Ramses Hilton', 5, '15:00', 0.14, '1115 Corniche El Nil', 'Cairo', 'Cairo Governorate', '11511', 'Egypt'),
('CAI', 'EG', 'EGP', 'Fairmont Nile City', 5, '15:00', 0.14, 'Corniche El Nil', 'Cairo', 'Cairo Governorate', '11311', 'Egypt'),
('SHM', 'EG', 'EGP', 'Rixos Sharm El Sheikh', 5, '14:00', 0.14, 'Nabq Bay', 'Sharm', 'South Sinai', '46619', 'Egypt'),
('HRG', 'EG', 'EGP', 'Steigenberger ALDAU Beach', 5, '14:00', 0.14, 'Yussif Afifi Road', 'Hurghada', 'Red Sea', '84511', 'Egypt'),
('ALX', 'EG', 'EGP', 'Steigenberger Cecil Hotel', 4, '14:00', 0.14, 'Saad Zaghloul Sq', 'Alexandria', 'Alexandria', '21521', 'Egypt'),
('RUH', 'SA', 'SAR', 'Narcissus Hotel & Spa', 5, '16:00', 0.15, 'Olaya Street', 'Riyadh', 'Riyadh Province', '11564', 'Saudi Arabia'),
('RUH', 'SA', 'SAR', 'Ritz-Carlton Riyadh', 5, '15:00', 0.15, 'Al Hada Area', 'Riyadh', 'Riyadh Province', '11491', 'Saudi Arabia'),
('JED', 'SA', 'SAR', 'Rosewood Jeddah', 5, '15:00', 0.15, 'Corniche Street', 'Jeddah', 'Makkah Province', '21424', 'Saudi Arabia'),
('JED', 'SA', 'SAR', 'Waldorf Astoria Qasr Al Sharq', 5, '16:00', 0.15, 'North Corniche', 'Jeddah', 'Makkah Province', '21462', 'Saudi Arabia'),
('MEC', 'SA', 'SAR', 'Fairmont Makkah Clock Royal', 5, '16:00', 0.15, 'King Abdul Aziz Endowment', 'Makkah', 'Makkah Province', '24231', 'Saudi Arabia'),
('MED', 'SA', 'SAR', 'Oberoi Madina', 5, '16:00', 0.15, 'Abizar Road', 'Madinah', 'Al Madinah', '42311', 'Saudi Arabia'),
('DXB', 'AE', 'AED', 'Atlantis, The Palm', 5, '15:00', 0.05, 'Palm Jumeirah', 'Dubai', 'Dubai', '00000', 'United Arab Emirates'),
('DXB', 'AE', 'AED', 'Burj Al Arab Jumeirah', 5, '15:00', 0.05, 'Jumeirah Beach', 'Dubai', 'Dubai', '74147', 'United Arab Emirates'),
('DXB', 'AE', 'AED', 'Armani Hotel Dubai', 5, '15:00', 0.05, 'Burj Khalifa', 'Dubai', 'Dubai', '88888', 'United Arab Emirates'),
('AUH', 'AE', 'AED', 'Emirates Palace Mandarin Oriental', 5, '15:00', 0.05, 'West Corniche', 'Abu Dhabi', 'Abu Dhabi', '39999', 'United Arab Emirates'),
('LON', 'GB', 'GBP', 'The Savoy', 5, '15:00', 0.20, 'Strand', 'London', 'Greater London', 'WC2R 0EU', 'United Kingdom'),
('LON', 'GB', 'GBP', 'The Ritz London', 5, '15:00', 0.20, '150 Piccadilly', 'London', 'Greater London', 'W1J 9BR', 'United Kingdom'),
('MAN', 'GB', 'GBP', 'The Midland', 4, '15:00', 0.20, 'Peter Street', 'Manchester', 'Greater Manchester', 'M60 2DS', 'United Kingdom'),
('PAR', 'FR', 'EUR', 'Le Meurice', 5, '15:00', 0.10, '228 Rue de Rivoli', 'Paris', 'Île-de-France', '75001', 'France'),
('PAR', 'FR', 'EUR', 'Hôtel Plaza Athénée', 5, '15:00', 0.10, '25 Avenue Montaigne', 'Paris', 'Île-de-France', '75008', 'France'),
('NCE', 'FR', 'EUR', 'Hotel Negresco', 5, '15:00', 0.10, 'Promenade des Anglais', 'Nice', 'Provence-Alpes-Côte dAzur', '06000', 'France'),
('ROM', 'IT', 'EUR', 'Hotel Hassler Roma', 5, '14:00', 0.10, 'Piazza Trinità dei Monti', 'Rome', 'Lazio', '00187', 'Italy'),
('MIL', 'IT', 'EUR', 'Armani Hotel Milano', 5, '15:00', 0.10, 'Via Manzoni 31', 'Milan', 'Lombardy', '20121', 'Italy'),
('VEN', 'IT', 'EUR', 'The Gritti Palace', 5, '15:00', 0.10, 'Campo S.Maria Del Giglio', 'Venice', 'Veneto', '30124', 'Italy'),
('BER', 'DE', 'EUR', 'Hotel Adlon Kempinski', 5, '15:00', 0.07, 'Unter den Linden', 'Berlin', 'Berlin', '10117', 'Germany'),
('MUC', 'DE', 'EUR', 'Bayerischer Hof', 5, '15:00', 0.07, 'Promenadeplatz', 'Munich', 'Bavaria', '80333', 'Germany'),
('BCN', 'ES', 'EUR', 'W Barcelona', 5, '15:00', 0.10, 'Plaça de la Rosa dels Vents', 'Barcelona', 'Catalonia', '08039', 'Spain'),
('MAD', 'ES', 'EUR', 'Mandarin Oriental Ritz', 5, '15:00', 0.10, 'Plaza de la Lealtad', 'Madrid', 'Madrid', '28014', 'Spain'),
('IST', 'TR', 'TRY', 'Pera Palace Hotel', 5, '14:00', 0.08, 'Mesrutiyet Caddesi', 'Istanbul', 'Marmara', '34430', 'Turkey'),
('IST', 'TR', 'TRY', 'Ciragan Palace Kempinski', 5, '14:00', 0.08, 'Ciragan Caddesi', 'Istanbul', 'Marmara', '34349', 'Turkey'),
('AYT', 'TR', 'TRY', 'The Land of Legends Kingdom', 5, '14:00', 0.08, 'Kadriye Mahallesi', 'Antalya', 'Mediterranean', '07500', 'Turkey'),
('TOK', 'JP', 'JPY', 'Park Hyatt Tokyo', 5, '15:00', 0.10, 'Shinjuku', 'Tokyo', 'Tokyo Prefecture', '163-1055', 'Japan'),
('PEK', 'CN', 'CNY', 'The Peninsula Beijing', 5, '14:00', 0.06, 'Goldfish Lane', 'Beijing', 'Beijing', '100006', 'China'),
('DEL', 'IN', 'INR', 'The Imperial New Delhi', 5, '14:00', 0.18, 'Janpath Lane', 'New Delhi', 'Delhi', '110001', 'India'),
('NYC', 'US', 'USD', 'The Plaza', 5, '15:00', 0.08, '5th Avenue', 'New York', 'New York', '10019', 'USA'),
('NYC', 'US', 'USD', 'St. Regis New York', 5, '15:00', 0.08, 'Two East 55th St', 'New York', 'New York', '10022', 'USA'),
('LAX', 'US', 'USD', 'Beverly Hills Hotel', 5, '15:00', 0.08, 'Sunset Boulevard', 'Los Angeles', 'California', '90210', 'USA'),
('MIA', 'US', 'USD', 'Fontainebleau Miami Beach', 5, '16:00', 0.08, 'Collins Ave', 'Miami', 'Florida', '33140', 'USA'),
('LAS', 'US', 'USD', 'The Bellagio', 5, '15:00', 0.08, 'Las Vegas Blvd', 'Las Vegas', 'Nevada', '89109', 'USA'),
('CHI', 'US', 'USD', 'The Langham', 5, '15:00', 0.08, 'North Wabash Ave', 'Chicago', 'Illinois', '60611', 'USA'),
('SYD', 'AU', 'AUD', 'Park Hyatt Sydney', 5, '15:00', 0.10, 'Hickson Road', 'Sydney', 'New South Wales', '2000', 'Australia'),
('RIO', 'BR', 'BRL', 'Copacabana Palace', 5, '14:00', 0.05, 'Atlantica Avenue', 'Rio', 'Rio de Janeiro', '22021-001', 'Brazil'),
('TOR', 'CA', 'CAD', 'Fairmont Royal York', 4, '15:00', 0.13, 'Front Street West', 'Toronto', 'Ontario', 'M5J 1E3', 'Canada'),
('SEL', 'KR', 'KRW', 'The Shilla Seoul', 5, '15:00', 0.10, 'Dongho-ro', 'Seoul', 'Seoul', '04605', 'South Korea'),
('MEX', 'MX', 'MXN', 'Gran Hotel Ciudad de Mexico', 5, '15:00', 0.16, 'Av. 16 de Septiembre', 'Mexico City', 'CDMX', '06000', 'Mexico'),
('DPS', 'ID', 'IDR', 'The St. Regis Bali Resort', 5, '15:00', 0.11, 'Nusa Dua', 'Bali', 'Bali', '80363', 'Indonesia'),
('BKK', 'TH', 'THB', 'Mandarin Oriental Bangkok', 5, '14:00', 0.07, 'Charoen Krung Road', 'Bangkok', 'Bangkok', '10500', 'Thailand'),
('LXR', 'EG', 'EGP', 'Sofitel Winter Palace', 5, '14:00', 0.14, 'Corniche El Nile', 'Luxor', 'Luxor Governorate', '85951', 'Egypt'),
('DMM', 'SA', 'SAR', 'Kempinski Al Othman', 5, '14:00', 0.15, 'King Saud Road', 'Al Khobar', 'Eastern Province', '31952', 'Saudi Arabia'),
('LIV', 'GB', 'GBP', 'Titanic Hotel Liverpool', 4, '15:00', 0.20, 'Regent Road', 'Liverpool', 'Merseyside', 'L3 0AN', 'United Kingdom');

    -- Customer seed data

    INSERT INTO dbo.Customer (TierLevel, PreferredLangCode, FirstName, MiddleName, LastName, EmailAddress, Phone, DateOfBirth) VALUES
      (1, 'EN', 'Demo', NULL, 'Guest01', 'guest01@example.invalid', NULL, '1990-01-01'),
      (2, 'EN', 'Demo', NULL, 'Guest02', 'guest02@example.invalid', NULL, '1990-01-01'),
      (3, 'EN', 'Demo', NULL, 'Guest03', 'guest03@example.invalid', NULL, '1990-01-01'),
      (4, 'EN', 'Demo', NULL, 'Guest04', 'guest04@example.invalid', NULL, '1990-01-01'),
      (5, 'EN', 'Demo', NULL, 'Guest05', 'guest05@example.invalid', NULL, '1990-01-01'),
      (6, 'EN', 'Demo', NULL, 'Guest06', 'guest06@example.invalid', NULL, '1990-01-01'),
      (7, 'EN', 'Demo', NULL, 'Guest07', 'guest07@example.invalid', NULL, '1990-01-01'),
      (8, 'EN', 'Demo', NULL, 'Guest08', 'guest08@example.invalid', NULL, '1990-01-01'),
      (9, 'EN', 'Demo', NULL, 'Guest09', 'guest09@example.invalid', NULL, '1990-01-01'),
      (10, 'EN', 'Demo', NULL, 'Guest10', 'guest10@example.invalid', NULL, '1990-01-01'),
      (11, 'EN', 'Demo', NULL, 'Guest11', 'guest11@example.invalid', NULL, '1990-01-01'),
      (12, 'EN', 'Demo', NULL, 'Guest12', 'guest12@example.invalid', NULL, '1990-01-01'),
      (13, 'EN', 'Demo', NULL, 'Guest13', 'guest13@example.invalid', NULL, '1990-01-01'),
      (14, 'EN', 'Demo', NULL, 'Guest14', 'guest14@example.invalid', NULL, '1990-01-01'),
      (15, 'EN', 'Demo', NULL, 'Guest15', 'guest15@example.invalid', NULL, '1990-01-01'),
      (16, 'EN', 'Demo', NULL, 'Guest16', 'guest16@example.invalid', NULL, '1990-01-01'),
      (17, 'EN', 'Demo', NULL, 'Guest17', 'guest17@example.invalid', NULL, '1990-01-01'),
      (18, 'EN', 'Demo', NULL, 'Guest18', 'guest18@example.invalid', NULL, '1990-01-01'),
      (19, 'EN', 'Demo', NULL, 'Guest19', 'guest19@example.invalid', NULL, '1990-01-01'),
      (20, 'EN', 'Demo', NULL, 'Guest20', 'guest20@example.invalid', NULL, '1990-01-01'),
      (21, 'EN', 'Demo', NULL, 'Guest21', 'guest21@example.invalid', NULL, '1990-01-01'),
      (22, 'EN', 'Demo', NULL, 'Guest22', 'guest22@example.invalid', NULL, '1990-01-01'),
      (23, 'EN', 'Demo', NULL, 'Guest23', 'guest23@example.invalid', NULL, '1990-01-01'),
      (24, 'EN', 'Demo', NULL, 'Guest24', 'guest24@example.invalid', NULL, '1990-01-01'),
      (25, 'EN', 'Demo', NULL, 'Guest25', 'guest25@example.invalid', NULL, '1990-01-01'),
      (26, 'EN', 'Demo', NULL, 'Guest26', 'guest26@example.invalid', NULL, '1990-01-01'),
      (27, 'EN', 'Demo', NULL, 'Guest27', 'guest27@example.invalid', NULL, '1990-01-01'),
      (28, 'EN', 'Demo', NULL, 'Guest28', 'guest28@example.invalid', NULL, '1990-01-01'),
      (29, 'EN', 'Demo', NULL, 'Guest29', 'guest29@example.invalid', NULL, '1990-01-01'),
      (30, 'EN', 'Demo', NULL, 'Guest30', 'guest30@example.invalid', NULL, '1990-01-01'),
      (31, 'EN', 'Demo', NULL, 'Guest31', 'guest31@example.invalid', NULL, '1990-01-01'),
      (32, 'EN', 'Demo', NULL, 'Guest32', 'guest32@example.invalid', NULL, '1990-01-01'),
      (33, 'EN', 'Demo', NULL, 'Guest33', 'guest33@example.invalid', NULL, '1990-01-01'),
      (34, 'EN', 'Demo', NULL, 'Guest34', 'guest34@example.invalid', NULL, '1990-01-01'),
      (35, 'EN', 'Demo', NULL, 'Guest35', 'guest35@example.invalid', NULL, '1990-01-01'),
      (36, 'EN', 'Demo', NULL, 'Guest36', 'guest36@example.invalid', NULL, '1990-01-01'),
      (37, 'EN', 'Demo', NULL, 'Guest37', 'guest37@example.invalid', NULL, '1990-01-01'),
      (38, 'EN', 'Demo', NULL, 'Guest38', 'guest38@example.invalid', NULL, '1990-01-01'),
      (39, 'EN', 'Demo', NULL, 'Guest39', 'guest39@example.invalid', NULL, '1990-01-01'),
      (40, 'EN', 'Demo', NULL, 'Guest40', 'guest40@example.invalid', NULL, '1990-01-01'),
      (41, 'EN', 'Demo', NULL, 'Guest41', 'guest41@example.invalid', NULL, '1990-01-01'),
      (42, 'EN', 'Demo', NULL, 'Guest42', 'guest42@example.invalid', NULL, '1990-01-01'),
      (43, 'EN', 'Demo', NULL, 'Guest43', 'guest43@example.invalid', NULL, '1990-01-01'),
      (44, 'EN', 'Demo', NULL, 'Guest44', 'guest44@example.invalid', NULL, '1990-01-01'),
      (45, 'EN', 'Demo', NULL, 'Guest45', 'guest45@example.invalid', NULL, '1990-01-01'),
      (46, 'EN', 'Demo', NULL, 'Guest46', 'guest46@example.invalid', NULL, '1990-01-01'),
      (47, 'EN', 'Demo', NULL, 'Guest47', 'guest47@example.invalid', NULL, '1990-01-01'),
      (48, 'EN', 'Demo', NULL, 'Guest48', 'guest48@example.invalid', NULL, '1990-01-01'),
      (49, 'EN', 'Demo', NULL, 'Guest49', 'guest49@example.invalid', NULL, '1990-01-01'),
      (50, 'EN', 'Demo', NULL, 'Guest50', 'guest50@example.invalid', NULL, '1990-01-01');

    -- Policy seed data

    INSERT INTO dbo.Policy (Hotel_ID, PolicyName, RefundPercentage, DeadlineHours, EnforcementLevel, ViolationFine, GuestInstruction) VALUES
(1, 'Free Cancellation 24h', 100.00, 24, 'Flexible', 0.00, 'Cancel via App anytime before deadline.'),
(2, 'Non-Refundable', 0.00, 0, 'Strict', 0.00, 'No changes allowed after booking.'),
(3, 'Standard 48h', 50.00, 48, 'Moderate', 25.00, 'Call reception for changes.'),
(4, 'Resort Policy', 0.00, 72, 'Strict', 100.00, 'Full charge applies for late cancel.'),
(5, 'Flexible Rate', 100.00, 18, 'Flexible', 0.00, 'Self-service cancellation available.'),
(6, 'Business Flex', 100.00, 12, 'Flexible', 0.00, 'Modify booking up to 12h prior.'),
(7, 'Advance Purchase', 0.00, 0, 'Strict', 50.00, 'Pre-paid only, no refunds.'),
(8, 'Semi-Flex', 50.00, 24, 'Moderate', 20.00, '50% refund if canceled 24h before.'),
(9, 'Royal Suite Pol', 0.00, 168, 'Strict', 500.00, 'Strict 7-day notice required.'),
(10, 'Hajj Season Pol', 0.00, 720, 'Strict', 200.00, 'Special season rules apply.'),
(11, 'Ramadan Standard', 50.00, 48, 'Moderate', 50.00, 'Cancel before Iftar time 48h prior.'),
(12, 'Palm Flex', 100.00, 24, 'Flexible', 0.00, 'Free cancellation for members.'),
(13, 'Luxury NonRef', 0.00, 0, 'Strict', 150.00, 'Booking is final upon payment.'),
(14, 'High Floor Pol', 80.00, 24, 'Moderate', 30.00, 'Small fee applies for late changes.'),
(15, 'Palace Std', 100.00, 48, 'Flexible', 0.00, 'Cancel online or via phone.'),
(16, 'London Saver', 0.00, 0, 'Strict', 0.00, 'Non-refundable discount rate.'),
(17, 'Piccadilly Flex', 100.00, 24, 'Flexible', 0.00, 'Full refund within window.'),
(18, 'Weekend Rate', 50.00, 24, 'Moderate', 40.00, 'Weekend rules: 50% penalty.'),
(19, 'Parisian Flex', 100.00, 24, 'Flexible', 0.00, 'Annulation gratuite.'),
(20, 'Fashion Week Pol', 0.00, 168, 'Strict', 300.00, 'High demand period, strict policy.'),
(21, 'Riviera Relax', 100.00, 48, 'Flexible', 0.00, 'Cancel via user dashboard.'),
(22, 'Roman Hol', 90.00, 24, 'Flexible', 10.00, '10% admin fee for cancellations.'),
(23, 'Milano Biz', 100.00, 24, 'Flexible', 0.00, 'Ideal for business travelers.'),
(24, 'Venice Canal', 0.00, 48, 'Strict', 100.00, 'Boat transfer fee is non-refundable.'),
(25, 'Berlin Basic', 100.00, 18, 'Flexible', 0.00, 'Standard EU cancellation rights.'),
(26, 'Oktoberfest Pol', 0.00, 336, 'Strict', 250.00, 'Festival period: No Refunds.'),
(27, 'Barca Beach', 50.00, 72, 'Moderate', 45.00, 'Moderate policy for sea view rooms.'),
(28, 'Madrid City', 100.00, 24, 'Flexible', 0.00, 'Free cancellation up to 1 day before.'),
(29, 'Bosphorus Flex', 100.00, 24, 'Flexible', 0.00, 'Flexible for international guests.'),
(30, 'Ottoman Splendor', 50.00, 48, 'Moderate', 60.00, 'Contact guest services to modify.'),
(31, 'Legends Access', 0.00, 72, 'Strict', 0.00, 'Theme park tickets non-refundable.'),
(32, 'Tokyo Tower', 100.00, 24, 'Flexible', 0.00, 'Easy cancel via JP app.'),
(33, 'Forbidden City', 80.00, 48, 'Moderate', 20.00, 'Visa denial refund exception.'),
(34, 'Delhi Heritage', 100.00, 24, 'Flexible', 0.00, 'Namaste, flexible cancellation.'),
(35, 'Central Park View', 50.00, 48, 'Moderate', 75.00, 'High demand location penalty.'),
(36, 'Fifth Ave Flex', 100.00, 24, 'Flexible', 0.00, 'Shopping season flex rule.'),
(37, 'Sunset Blvd', 0.00, 24, 'Strict', 150.00, 'Celebrity suite strict policy.'),
(38, 'Miami Vice', 50.00, 72, 'Moderate', 100.00, 'Spring break special rules.'),
(39, 'Casino Rate', 0.00, 0, 'Strict', 0.00, 'Comped rooms are final.'),
(40, 'Windy City Flex', 100.00, 24, 'Flexible', 0.00, 'Business friendly cancellation.'),
(41, 'Opera House', 100.00, 48, 'Flexible', 0.00, 'View guaranteed if not canceled.'),
(42, 'Carnival Pol', 0.00, 336, 'Strict', 500.00, 'Carnival packages are fixed.'),
(43, 'Maple Leaf', 100.00, 24, 'Flexible', 0.00, 'Winter storm exception applies.'),
(44, 'Seoul Soul', 90.00, 24, 'Flexible', 15.00, 'Small transaction fee applies.'),
(45, 'Zocalo Std', 100.00, 24, 'Flexible', 0.00, 'Cancelacion gratuita.'),
(46, 'Bali Zen', 50.00, 168, 'Moderate', 50.00, 'Retreat deposit forfeited.'),
(47, 'Thai Silk', 100.00, 24, 'Flexible', 0.00, 'Sawasdee, free cancellation.'),
(48, 'Nile Cruise Pol', 0.00, 168, 'Strict', 200.00, 'Cruise schedule is fixed.'),
(49, 'Khobar Biz', 100.00, 24, 'Flexible', 0.00, 'Corporate rate flexible.'),
(50, 'Anfield Match', 0.00, 72, 'Strict', 150.00, 'Match day tickets non-refundable.');

    -- Hotel_Facilities seed data

    INSERT INTO dbo.Hotel_Facilities (Hotel_ID, FacilityCode) VALUES
(1, 'POOL-OUT'), (2, 'SPA-FULL'), (3, 'VIEW-SEA'), (4, 'KIDS-CLB'), (5, 'BAR-ROOF'),
(6, 'SPA-FULL'), (7, 'POOL-IN'), (8, 'VIEW-SEA'), (9, 'ROOM-SVC'), (10, 'CONC'),
(11, 'AIR-SHTL'), (12, 'KIDS-CLB'), (13, 'AIR-SHTL'), (14, 'ATM'), (15, 'ATM'),
(16, 'CAFE-LOB'), (17, 'ROOM-SVC'), (18, 'SPA-FULL'), (19, 'VIEW-CTY'), (20, 'BIZ-CTR'),
(21, 'VIEW-SEA'), (22, 'BALCONY'), (23, 'GYM-24'), (24, 'AIR-SHTL'), (25, 'BIZ-CTR'),
(26, 'BAR-ROOF'), (27, 'POOL-OUT'), (28, 'REST-MAIN'), (29, 'SPA-FULL'), (30, 'POOL-OUT'),
(31, 'KIDS-CLB'), (32, 'BAR-ROOF'), (33, 'CAFE-LOB'), (34, 'GYM-24'), (35, 'CONC'),
(36, 'ROOM-SVC'), (37, 'POOL-OUT'), (38, 'BAR-ROOF'), (39, 'BAR-ROOF'), (40, 'VIEW-SEA'),
(41, 'CONC'), (42, 'POOL-OUT'), (43, 'AIR-SHTL'), (44, 'BAR-ROOF'), (45, 'CONC'),
(46, 'POOL-OUT'), (47, 'VIEW-SEA'), (48, 'PARK-VAL'), (49, 'BIZ-CTR'), (50, 'GYM-24');

    -- Room seed data

    INSERT INTO dbo.Room (Hotel_ID, TypeCode, FloorNumber, RoomNumber_Visual) VALUES
(1, 'DBL-DLX', 12, '1205'), (2, 'STE-JNR', 8, '810'), (3, 'FAM-DLX', 1, '101A'), (4, 'STE-EXEC', 5, '5001'), (5, 'SGL-STD', 3, '305'),
(6, 'STE-ROY', 15, '1501'), (7, 'DBL-DLX', 4, '420'), (8, 'STE-JNR', 10, '1010'), (9, 'STE-PRES', 18, '1888'), (10, 'TWN-STD', 11, '1120'),
(11, 'KNG-DLX', 7, '715'), (12, 'STE-ROY', 22, 'Royal Bridge'), (13, 'STE-PRES', 25, '2501'), (14, 'DBL-DLX', 6, '605'), (15, 'STE-PRES', 8, 'Palace 1'),
(16, 'STE-JNR', 4, '412'), (17, 'KNG-DLX', 3, '305'), (18, 'DBL-STD', 2, '220'), (19, 'STE-EXEC', 5, '510'), (20, 'STE-ROY', 8, '801'),
(21, 'DBL-DLX', 3, '309'), (22, 'TRP-STD', 2, '202'), (23, 'KNG-DLX', 5, '505'), (24, 'STE-JNR', 3, 'Canal-1'), (25, 'SGL-STD', 4, '404'),
(26, 'DBL-STD', 3, '315'), (27, 'STE-EXEC', 20, '2020'), (28, 'KNG-DLX', 6, '612'), (29, 'DBL-DLX', 4, '418'), (30, 'STE-ROY', 2, 'Sultan 1'),
(31, 'FAM-DLX', 1, 'L-105'), (32, 'KNG-DLX', 45, '4509'), (33, 'STE-JNR', 8, '808'), (34, 'DBL-STD', 2, '210'), (35, 'STE-PRES', 12, '1201'),
(36, 'STE-EXEC', 15, '1515'), (37, 'BUNG-GV', 1, 'B-05'), (38, 'STE-JNR', 10, '1020'), (39, 'KNG-DLX', 20, '2050'), (40, 'DBL-DLX', 9, '905'),
(41, 'STE-EXEC', 4, '401'), (42, 'DBL-DLX', 5, '505'), (43, 'KNG-DLX', 14, '1402'), (44, 'TWN-DLX', 11, '1111'), (45, 'DBL-STD', 3, '303'),
(46, 'VIL-POOL', 1, 'V-08'), (47, 'STE-JNR', 12, '1212'), (48, 'STE-ROY', 2, 'Nile-1'), (49, 'KNG-DLX', 7, '707'), (50, 'TWN-STD', 4, '415');

    -- Promotion seed data

    INSERT INTO dbo.Promotion (PromoCode, Hotel_ID, DiscountValue, StartDate, EndDate) VALUES
('SUMMER-EG', 1, 20.0, '2026-06-01', '2026-08-31'), ('NILE-VIEW', 2, 15.0, '2026-01-01', '2026-12-31'), ('RED-SEA-OFFER', 3, 25.0, '2026-05-01', '2026-09-30'), ('FAMILY-FUN', 4, 10.0, '2026-06-15', '2026-09-15'), ('ALEX-WINTER', 5, 30.0, '2026-12-01', '2027-02-28'),
('RIYADH-SEASON', 6, 20.0, '2026-10-01', '2026-12-31'), ('ROYAL-STAY', 7, 10.0, '2026-01-01', '2026-12-31'), ('JEDDAH-WKD', 8, 15.0, '2026-02-01', '2026-05-01'), ('LUX-ESCAPE', 9, 20.0, '2026-03-01', '2026-06-01'), ('RAMADAN-MK', 10, 5.0, '2026-02-15', '2026-03-15'),
('MADINA-PEACE', 11, 10.0, '2026-01-01', '2026-12-31'), ('DUBAI-SHOP', 12, 15.0, '2026-01-01', '2026-01-31'), ('BURJ-EXP', 13, 5.0, '2026-06-01', '2026-08-31'), ('ARMANI-LIFE', 14, 10.0, '2026-09-01', '2026-12-31'), ('ABUDHABI-GP', 15, 20.0, '2026-11-20', '2026-11-30'),
('LONDON-CALL', 16, 15.0, '2026-07-01', '2026-08-31'), ('RITZ-AFTERNOON', 17, 10.0, '2026-04-01', '2026-06-30'), ('MANCHESTER-UTD', 18, 15.0, '2026-08-15', '2027-05-15'), ('PARIS-ROMANCE', 19, 20.0, '2026-02-10', '2026-02-20'), ('FASHION-WK', 20, 10.0, '2026-09-25', '2026-10-05'),
('NICE-SUMMER', 21, 15.0, '2026-07-01', '2026-08-31'), ('ROMAN-HOLIDAY', 22, 10.0, '2026-05-01', '2026-06-30'), ('MILAN-SHOP', 23, 15.0, '2026-01-05', '2026-02-28'), ('VENICE-CARN', 24, 20.0, '2026-02-01', '2026-02-15'), ('BERLIN-WALL', 25, 10.0, '2026-11-01', '2026-11-30'),
('OKTOBERFEST', 26, 5.0, '2026-09-20', '2026-10-05'), ('BARCA-SUN', 27, 20.0, '2026-06-01', '2026-09-30'), ('MADRID-ART', 28, 15.0, '2026-04-01', '2026-06-01'), ('IST-TULIP', 29, 20.0, '2026-04-01', '2026-04-30'), ('BOSPHORUS', 30, 10.0, '2026-05-01', '2026-10-31'),
('ANTALYA-SUN', 31, 25.0, '2026-06-01', '2026-09-30'), ('CHERRY-BLSM', 32, 20.0, '2026-03-20', '2026-04-10'), ('GOLDEN-WK', 33, 10.0, '2026-10-01', '2026-10-07'), ('DIWALI-DLH', 34, 15.0, '2026-11-01', '2026-11-15'), ('NYC-XMAS', 35, 10.0, '2026-12-15', '2026-12-31'),
('STREGIS-NY', 36, 10.0, '2026-01-01', '2026-03-31'), ('LA-OSCARS', 37, 25.0, '2026-02-20', '2026-03-05'), ('MIAMI-SPRING', 38, 20.0, '2026-03-01', '2026-04-15'), ('VEGAS-BABY', 39, 30.0, '2026-07-01', '2026-08-31'), ('WINDY-CITY', 40, 15.0, '2026-05-01', '2026-09-01'),
('SYDNEY-NYE', 41, 10.0, '2026-12-28', '2027-01-02'), ('RIO-CARNIVAL', 42, 5.0, '2026-02-10', '2026-02-20'), ('TIFF-TORONTO', 43, 15.0, '2026-09-05', '2026-09-15'), ('SEOUL-VIBE', 44, 20.0, '2026-04-01', '2026-05-31'), ('MEXICO-IND', 45, 15.0, '2026-09-10', '2026-09-20'),
('BALI-RETREAT', 46, 25.0, '2026-01-10', '2026-03-31'), ('SONGKRAN', 47, 20.0, '2026-04-10', '2026-04-16'), ('WINTER-LUX', 48, 20.0, '2026-11-01', '2027-02-28'), ('KHOBAR-WK', 49, 10.0, '2026-01-01', '2026-12-31'), ('LIVERPOOL-FC', 50, 10.0, '2026-08-01', '2027-05-31');

    -- Booking seed data

    INSERT INTO dbo.Booking (Customer_ID, Room_ID, CheckInDate, Hotel_ID, PromoCode, CheckOutDate, TotalCost, Status) VALUES
(1, 1, '2026-05-01', 1, 'SUMMER-EG', '2026-05-05', 4000.00, 'Confirmed'), 
(2, 2, '2026-06-10', 2, 'NILE-VIEW', '2026-06-15', 12000.00, 'Confirmed'),
(3, 3, '2026-07-01', 3, 'RED-SEA-OFFER', '2026-07-07', 15000.00, 'Confirmed'),
(4, 4, '2026-08-12', 4, 'FAMILY-FUN', '2026-08-16', 8500.00, 'Completed'),
(5, 5, '2026-09-05', 5, 'ALEX-WINTER', '2026-09-08', 3200.00, 'Cancelled'),
(6, 6, '2026-10-20', 6, 'RIYADH-SEASON', '2026-10-25', 18000.00, 'Confirmed'),
(7, 7, '2026-11-11', 7, 'ROYAL-STAY', '2026-11-14', 10500.00, 'Confirmed'),
(8, 8, '2026-12-01', 8, 'JEDDAH-WKD', '2026-12-05', 14000.00, 'Confirmed'),
(9, 9, '2026-01-05', 9, 'LUX-ESCAPE', '2026-01-10', 25000.00, 'Completed'),
(10, 10, '2026-03-20', 10, 'RAMADAN-MK', '2026-03-25', 9000.00, 'Confirmed'),
(11, 11, '2026-04-15', 11, 'MADINA-PEACE', '2026-04-20', 8000.00, 'Confirmed'),
(12, 12, '2026-02-10', 12, 'DUBAI-SHOP', '2026-02-15', 35000.00, 'Confirmed'),
(13, 13, '2026-05-20', 13, 'BURJ-EXP', '2026-05-25', 45000.00, 'Confirmed'),
(14, 14, '2026-09-30', 14, 'ARMANI-LIFE', '2026-10-02', 7500.00, 'Completed'),
(15, 15, '2026-11-25', 15, 'ABUDHABI-GP', '2026-11-30', 22000.00, 'Confirmed'),
(16, 16, '2026-06-01', 16, 'LONDON-CALL', '2026-06-05', 5000.00, 'Confirmed'),
(17, 17, '2026-07-15', 17, 'RITZ-AFTERNOON', '2026-07-20', 6000.00, 'Confirmed'),
(18, 18, '2026-08-01', 18, 'MANCHESTER-UTD', '2026-08-03', 450.00, 'Completed'),
(19, 19, '2026-02-14', 19, 'PARIS-ROMANCE', '2026-02-16', 3000.00, 'Completed'),
(20, 20, '2026-09-28', 20, 'FASHION-WK', '2026-10-02', 9500.00, 'Confirmed'),
(21, 21, '2026-07-10', 21, 'NICE-SUMMER', '2026-07-17', 4200.00, 'Confirmed'),
(22, 22, '2026-05-15', 22, 'ROMAN-HOLIDAY', '2026-05-18', 3500.00, 'Confirmed'),
(23, 23, '2026-01-10', 23, 'MILAN-SHOP', '2026-01-14', 4000.00, 'Completed'),
(24, 24, '2026-02-05', 24, 'VENICE-CARN', '2026-02-10', 8000.00, 'Confirmed'),
(25, 25, '2026-11-05', 25, 'BERLIN-WALL', '2026-11-10', 2500.00, 'Confirmed'),
(26, 26, '2026-09-22', 26, 'OKTOBERFEST', '2026-09-26', 3000.00, 'Confirmed'),
(27, 27, '2026-06-20', 27, 'BARCA-SUN', '2026-06-25', 5500.00, 'Confirmed'),
(28, 28, '2026-04-05', 28, 'MADRID-ART', '2026-04-10', 4800.00, 'Confirmed'),
(29, 29, '2026-04-15', 29, 'IST-TULIP', '2026-04-20', 2200.00, 'Confirmed'),
(30, 30, '2026-05-25', 30, 'BOSPHORUS', '2026-05-30', 6000.00, 'Confirmed'),
(31, 31, '2026-07-20', 31, 'ANTALYA-SUN', '2026-07-27', 18000.00, 'Confirmed'),
(32, 32, '2026-03-25', 32, 'CHERRY-BLSM', '2026-03-30', 500000.00, 'Confirmed'),
(33, 33, '2026-10-01', 33, 'GOLDEN-WK', '2026-10-05', 12000.00, 'Confirmed'),
(34, 34, '2026-11-05', 34, 'DIWALI-DLH', '2026-11-08', 45000.00, 'Confirmed'),
(35, 35, '2026-12-20', 35, 'NYC-XMAS', '2026-12-26', 8000.00, 'Confirmed'),
(36, 36, '2026-01-05', 36, 'STREGIS-NY', '2026-01-10', 6500.00, 'Completed'),
(37, 37, '2026-02-25', 37, 'LA-OSCARS', '2026-02-28', 3500.00, 'Confirmed'),
(38, 38, '2026-03-10', 38, 'MIAMI-SPRING', '2026-03-15', 7000.00, 'Confirmed'),
(39, 39, '2026-07-04', 39, 'VEGAS-BABY', '2026-07-07', 2500.00, 'Confirmed'),
(40, 40, '2026-05-10', 40, 'WINDY-CITY', '2026-05-15', 4000.00, 'Confirmed'),
(41, 41, '2026-12-30', 41, 'SYDNEY-NYE', '2027-01-03', 6000.00, 'Confirmed'),
(42, 42, '2026-02-12', 42, 'RIO-CARNIVAL', '2026-02-18', 15000.00, 'Completed'),
(43, 43, '2026-09-10', 43, 'TIFF-TORONTO', '2026-09-14', 3500.00, 'Confirmed'),
(44, 44, '2026-04-10', 44, 'SEOUL-VIBE', '2026-04-15', 2000000.00, 'Confirmed'),
(45, 45, '2026-09-15', 45, 'MEXICO-IND', '2026-09-18', 5000.00, 'Confirmed'),
(46, 46, '2026-01-15', 46, 'BALI-RETREAT', '2026-01-22', 15000000.00, 'Confirmed'),
(47, 47, '2026-04-12', 47, 'SONGKRAN', '2026-04-16', 30000.00, 'Confirmed'),
(48, 48, '2026-11-01', 48, 'WINTER-LUX', '2026-11-05', 20000.00, 'Confirmed'),
(49, 49, '2026-12-01', 49, 'KHOBAR-WK', '2026-12-05', 4000.00, 'Confirmed'),
(50, 50, '2026-08-10', 50, 'LIVERPOOL-FC', '2026-08-12', 800.00, 'Confirmed');

    -- Payment seed data

    INSERT INTO dbo.Payment
       (Customer_ID, Room_ID, CheckInDate, CardMaskedNumber, CardExpiry,
        CardType, AmountPaid, PaymentStatus, Booking_ID)
    SELECT v.Customer_ID, v.Room_ID, v.CheckInDate,
           v.CardMaskedNumber, v.CardExpiry, v.CardType,
           v.AmountPaid, v.PaymentStatus, b.Booking_ID
    FROM (VALUES

(1, 1, '2026-05-01', '****-0000', '12/28', 'Visa', 4000.00, 'Success'), (2, 2, '2026-06-10', '****-0000', '09/29', 'MasterCard', 12000.00, 'Success'),
(3, 3, '2026-07-01', '****-0000', '05/30', 'Amex', 15000.00, 'Success'), (4, 4, '2026-08-12', '****-0000', '08/27', 'Visa', 8500.00, 'Success'),
(5, 5, '2026-09-05', '****-0000', '11/26', 'MasterCard', 0.00, 'Failed'), (6, 6, '2026-10-20', '****-0000', '01/28', 'Visa', 18000.00, 'Success'),
(7, 7, '2026-11-11', '****-0000', '02/29', 'Visa', 10500.00, 'Success'), (8, 8, '2026-12-01', '****-0000', '03/30', 'MasterCard', 14000.00, 'Success'),
(9, 9, '2026-01-05', '****-0000', '04/27', 'Amex', 25000.00, 'Success'), (10, 10, '2026-03-20', '****-0000', '05/26', 'Visa', 9000.00, 'Success'),
(11, 11, '2026-04-15', '****-0000', '06/28', 'MasterCard', 8000.00, 'Success'), (12, 12, '2026-02-10', '****-0000', '07/29', 'Visa', 35000.00, 'Success'),
(13, 13, '2026-05-20', '****-0000', '08/30', 'Visa', 45000.00, 'Success'), (14, 14, '2026-09-30', '****-0000', '09/27', 'MasterCard', 7500.00, 'Success'),
(15, 15, '2026-11-25', '****-0000', '10/26', 'Amex', 22000.00, 'Success'), (16, 16, '2026-06-01', '****-0000', '11/28', 'Visa', 5000.00, 'Success'),
(17, 17, '2026-07-15', '****-0000', '12/29', 'MasterCard', 6000.00, 'Success'), (18, 18, '2026-08-01', '****-0000', '01/30', 'Visa', 450.00, 'Success'),
(19, 19, '2026-02-14', '****-0000', '02/27', 'Visa', 3000.00, 'Success'), (20, 20, '2026-09-28', '****-0000', '03/26', 'MasterCard', 9500.00, 'Success'),
(21, 21, '2026-07-10', '****-0000', '04/28', 'Amex', 4200.00, 'Success'), (22, 22, '2026-05-15', '****-0000', '05/29', 'Visa', 3500.00, 'Success'),
(23, 23, '2026-01-10', '****-0000', '06/30', 'MasterCard', 4000.00, 'Success'), (24, 24, '2026-02-05', '****-0000', '07/27', 'Visa', 8000.00, 'Success'),
(25, 25, '2026-11-05', '****-0000', '08/26', 'Visa', 2500.00, 'Success'), (26, 26, '2026-09-22', '****-0000', '09/28', 'MasterCard', 3000.00, 'Success'),
(27, 27, '2026-06-20', '****-0000', '10/29', 'Amex', 5500.00, 'Success'), (28, 28, '2026-04-05', '****-0000', '11/30', 'Visa', 4800.00, 'Success'),
(29, 29, '2026-04-15', '****-0000', '12/27', 'MasterCard', 2200.00, 'Success'), (30, 30, '2026-05-25', '****-0000', '01/26', 'Visa', 6000.00, 'Success'),
(31, 31, '2026-07-20', '****-0000', '02/28', 'Visa', 18000.00, 'Success'), (32, 32, '2026-03-25', '****-0000', '03/29', 'MasterCard', 500000.00, 'Success'),
(33, 33, '2026-10-01', '****-0000', '04/30', 'Amex', 12000.00, 'Success'), (34, 34, '2026-11-05', '****-0000', '05/27', 'Visa', 45000.00, 'Success'),
(35, 35, '2026-12-20', '****-0000', '06/26', 'MasterCard', 8000.00, 'Success'), (36, 36, '2026-01-05', '****-0000', '07/28', 'Visa', 6500.00, 'Success'),
(37, 37, '2026-02-25', '****-0000', '08/29', 'Visa', 3500.00, 'Success'), (38, 38, '2026-03-10', '****-0000', '09/30', 'MasterCard', 7000.00, 'Success'),
(39, 39, '2026-07-04', '****-0000', '10/27', 'Amex', 2500.00, 'Success'), (40, 40, '2026-05-10', '****-0000', '11/26', 'Visa', 4000.00, 'Success'),
(41, 41, '2026-12-30', '****-0000', '12/28', 'MasterCard', 6000.00, 'Success'), (42, 42, '2026-02-12', '****-0000', '01/29', 'Visa', 15000.00, 'Success'),
(43, 43, '2026-09-10', '****-0000', '02/30', 'Visa', 3500.00, 'Success'), (44, 44, '2026-04-10', '****-0000', '03/27', 'MasterCard', 2000000.00, 'Success'),
(45, 45, '2026-09-15', '****-0000', '04/26', 'Amex', 5000.00, 'Success'), (46, 46, '2026-01-15', '****-0000', '05/28', 'Visa', 15000000.00, 'Success'),
(47, 47, '2026-04-12', '****-0000', '06/29', 'MasterCard', 30000.00, 'Success'), (48, 48, '2026-11-01', '****-0000', '07/30', 'Visa', 20000.00, 'Success'),
(49, 49, '2026-12-01', '****-0000', '08/27', 'Visa', 4000.00, 'Success'), (50, 50, '2026-08-10', '****-0000', '09/26', 'MasterCard', 800.00, 'Success')

    ) AS v(Customer_ID, Room_ID, CheckInDate, CardMaskedNumber,
           CardExpiry, CardType, AmountPaid, PaymentStatus)
    INNER JOIN dbo.Booking AS b
      ON b.Customer_ID = v.Customer_ID
     AND b.Room_ID = v.Room_ID
     AND b.CheckInDate = v.CheckInDate;

    -- Review seed data

    INSERT INTO dbo.Review (Customer_ID, Hotel_ID, ReviewDate, CleanlinessScore, StaffScore, ComfortScore, Comment) VALUES
(1, 1, '2026-05-06', 9, 10, 8, N'Great view of the Nile, very clean.'), (2, 2, '2026-06-16', 10, 9, 10, N'Luxury at its best. Loved the spa.'),
(3, 3, '2026-07-08', 8, 7, 9, N'Good resort but food variety was limited.'), (4, 4, '2026-08-17', 10, 10, 10, N'Perfect for families, kids loved the pool.'),
(5, 5, '2026-09-09', 7, 8, 6, N'Historic building but rooms need update.'), (6, 6, '2026-10-26', 10, 10, 10, N'Excellent service in Riyadh.'),
(7, 7, '2026-11-15', 9, 9, 9, N'Very grand hotel, amazing lobby.'), (8, 8, '2026-12-06', 10, 10, 10, N'Best view of the Red Sea in Jeddah.'),
(9, 9, '2026-01-11', 8, 9, 8, N'Very luxurious but expensive.'), (10, 10, '2026-03-26', 10, 10, 10, N'So close to Haram, perfect location.'),
(11, 11, '2026-04-21', 9, 8, 9, N'Peaceful stay, very helpful staff.'), (12, 12, '2026-02-16', 10, 9, 10, N'The waterpark access is a huge plus.'),
(13, 13, '2026-05-26', 10, 10, 10, N'Once in a lifetime experience!'), (14, 14, '2026-10-03', 9, 9, 9, N'Stylish and modern, located in Burj Khalifa.'),
(15, 15, '2026-12-01', 10, 10, 10, N'Gold cappuccino was interesting.'), (16, 16, '2026-06-06', 8, 10, 9, N'Classic British elegance.'),
(17, 17, '2026-07-21', 10, 10, 10, N'High tea was delightful.'), (18, 18, '2026-08-04', 7, 6, 7, N'Room was small but location is great.'),
(19, 19, '2026-02-17', 9, 10, 9, N'Romantic vibe, view of Eiffel Tower.'), (20, 20, '2026-10-03', 10, 10, 10, N'Very chic and fashionable.'),
(21, 21, '2026-07-18', 8, 8, 8, N'Nice hotel on the Promenade.'), (22, 22, '2026-05-19', 10, 10, 10, N'Right above the Spanish Steps!'),
(23, 23, '2026-01-15', 9, 9, 9, N'Minimalist design, very comfortable.'), (24, 24, '2026-02-11', 10, 9, 10, N'Breakfast on the terrace was magical.'),
(25, 25, '2026-11-11', 10, 10, 10, N'Located right at Brandenburg Gate.'), (26, 26, '2026-09-27', 8, 8, 8, N'Good beer garden nearby.'),
(27, 27, '2026-06-26', 9, 8, 9, N'Iconic building on the beach.'), (28, 28, '2026-04-11', 10, 10, 10, N'Beautifully renovated palace.'),
(29, 29, '2026-04-21', 10, 9, 10, N'Agatha Christie room was amazing.'), (30, 30, '2026-05-31', 9, 10, 9, N'Infinity pool on the Bosphorus is wow.'),
(31, 31, '2026-07-28', 10, 9, 10, N'Kids paradise with the theme park.'), (32, 32, '2026-03-31', 10, 10, 10, N'Lost in Translation vibes.'),
(33, 33, '2026-10-06', 9, 8, 9, N'Walking distance to Forbidden City.'), (34, 34, '2026-11-09', 8, 9, 8, N'Colonial charm in New Delhi.'),
(35, 35, '2026-12-27', 10, 10, 10, N'Afternoon tea at The Palm Court is a must.'), (36, 36, '2026-01-11', 9, 10, 9, N'Butler service was exceptional.'),
(37, 37, '2026-02-28', 10, 9, 10, N'Old Hollywood glamour.'), (38, 38, '2026-03-16', 8, 7, 8, N'Party vibe, pool was crowded.'),
(39, 39, '2026-07-08', 10, 10, 10, N'Fountains show view from room was epic.'), (40, 40, '2026-05-16', 9, 9, 9, N'Architecture tour was great.'),
(41, 41, '2027-01-04', 10, 10, 10, N'Best view of the Opera House.'), (42, 42, '2026-02-19', 9, 8, 9, N'Right on Copacabana beach!'),
(43, 43, '2026-09-15', 8, 9, 8, N'Very convenient for the train station.'), (44, 44, '2026-04-16', 10, 10, 10, N'Traditional Korean hospitality.'),
(45, 45, '2026-09-19', 9, 8, 9, N'Stained glass ceiling is breathtaking.'), (46, 46, '2026-01-23', 10, 10, 10, N'Private villa with pool was heaven.'),
(47, 47, '2026-04-17', 10, 10, 10, N'Service is unmatched here.'), (48, 48, '2026-11-06', 9, 9, 9, N'Garden is beautiful, very historic.'),
(49, 49, '2026-12-06', 8, 9, 8, N'Good for business trips in Khobar.'), (50, 50, '2026-08-13', 9, 10, 9, N'Converted warehouse, very cool design.');


    -- A failed mapping should prevent the seed from being committed.
    IF (SELECT COUNT_BIG(*) FROM dbo.Booking) <> 50
       OR (SELECT COUNT_BIG(*) FROM dbo.Payment) <> 50
       OR EXISTS (
            SELECT 1 FROM dbo.Payment AS p
            LEFT JOIN dbo.Booking AS b ON p.Booking_ID=b.Booking_ID
            WHERE b.Booking_ID IS NULL
               OR p.Customer_ID<>b.Customer_ID
               OR p.Room_ID<>b.Room_ID
               OR p.CheckInDate<>b.CheckInDate
       )
       THROW 52003, 'Seed validation failed. All changes will be rolled back.', 1;

    COMMIT TRANSACTION;
    PRINT 'Synthetic demo seed completed (50 bookings, 50 payments).';
    SELECT 'Booking' AS TableName, COUNT(*) AS TotalRows FROM dbo.Booking
    UNION ALL SELECT 'Payment', COUNT(*) FROM dbo.Payment
    UNION ALL SELECT 'Booking_Audit', COUNT(*) FROM dbo.Booking_Audit;
END TRY
BEGIN CATCH
    IF XACT_STATE()<>0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO
