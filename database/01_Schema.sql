/*
 Hotel Booking Database — clean schema-only release
 Target: HotelBookingPortfolioDB (a NEW database; not the original or Dev instance)
 Requirements: Microsoft SQL Server 2022 / SSMS

 STEP 1: run database/00_Create_Database.sql and check that it succeeds.
 STEP 2: run this script ONCE on the freshly created, EMPTY database.
 STEP 3: run database/02_Verify_Schema.sql.

 No personal data is inserted. Do not run against a database holding valuable data.
 This schema is derived from the supplied SSMS export. It has not been
 independently executed against a live SQL Server in this environment.
*/
USE [HotelBookingPortfolioDB];
GO

/****** Object:  Table [dbo].[Booking]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[Customer_ID] [int] NOT NULL,
	[Room_ID] [int] NOT NULL,
	[CheckInDate] [date] NOT NULL,
	[Hotel_ID] [int] NOT NULL,
	[PromoCode] [nvarchar](20) NULL,
	[CheckOutDate] [date] NOT NULL,
	[TotalCost] [decimal](10, 2) NOT NULL,
	[Status] [nvarchar](20) NULL,
	[LengthOfStay]  AS (datediff(day,[CheckInDate],[CheckOutDate])),
	[Booking_ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Booking] PRIMARY KEY CLUSTERED 
(
	[Booking_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Booking_LegacyComposite] UNIQUE NONCLUSTERED 
(
	[Customer_ID] ASC,
	[Room_ID] ASC,
	[CheckInDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Booking_Audit]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking_Audit](
	[Audit_ID] [int] IDENTITY(1,1) NOT NULL,
	[Booking_Customer_ID] [int] NULL,
	[Booking_Room_ID] [int] NULL,
	[Booking_CheckIn] [date] NULL,
	[Old_Status] [nvarchar](20) NULL,
	[New_Status] [nvarchar](20) NULL,
	[Old_TotalCost] [decimal](10, 2) NULL,
	[New_TotalCost] [decimal](10, 2) NULL,
	[Action_Type] [varchar](10) NULL,
	[Action_Date] [datetime] NULL,
	[User_Name] [nvarchar](100) NULL,
	[Booking_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Audit_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryISO] [nvarchar](3) NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL,
	[PhonePrefix] [nvarchar](10) NOT NULL,
	[Continent] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CountryISO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Currency]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Currency](
	[CurrencyCode] [nvarchar](3) NOT NULL,
	[Symbol] [nvarchar](5) NOT NULL,
	[ExchangeRateToUSD] [decimal](10, 4) NOT NULL,
	[LastUpdateTimestamp] [datetime] NULL,
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[CurrencyCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Customer_ID] [int] IDENTITY(1,1) NOT NULL,
	[TierLevel] [int] NULL,
	[PreferredLangCode] [nvarchar](2) NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[DateOfBirth] [date] NOT NULL,
	[CurrentAge]  AS (datediff(year,[DateOfBirth],getdate())),
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Email] UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Destination]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destination](
	[DestinationCode] [nvarchar](10) NOT NULL,
	[CountryISO] [nvarchar](3) NOT NULL,
	[CityName] [nvarchar](100) NOT NULL,
	[RegionName] [nvarchar](100) NULL,
	[ThumbnailImage] [varbinary](max) NULL,
 CONSTRAINT [PK_Destination] PRIMARY KEY CLUSTERED 
(
	[DestinationCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facility]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facility](
	[FacilityCode] [nvarchar](10) NOT NULL,
	[Icon] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Category] [nvarchar](50) NULL,
	[CostType] [nvarchar](20) NULL,
	[OperationalHours] [nvarchar](50) NULL,
 CONSTRAINT [PK_Facility] PRIMARY KEY CLUSTERED 
(
	[FacilityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GeniusTier]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GeniusTier](
	[TierLevel] [int] NOT NULL,
	[LevelName] [nvarchar](50) NOT NULL,
	[DiscountRate] [decimal](5, 2) NOT NULL,
 CONSTRAINT [PK_GeniusTier] PRIMARY KEY CLUSTERED 
(
	[TierLevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[Hotel_ID] [int] IDENTITY(1,1) NOT NULL,
	[DestinationCode] [nvarchar](10) NOT NULL,
	[CountryISO] [nvarchar](3) NOT NULL,
	[CurrencyCode] [nvarchar](3) NOT NULL,
	[Address_Street] [nvarchar](150) NULL,
	[Address_City] [nvarchar](100) NULL,
	[Address_State] [nvarchar](100) NULL,
	[Address_PostalCode] [nvarchar](20) NULL,
	[Address_Country] [nvarchar](100) NULL,
	[HotelName] [nvarchar](150) NOT NULL,
	[StarRating] [int] NULL,
	[CheckInTime] [time](7) NOT NULL,
	[TaxPercentage] [decimal](5, 2) NULL,
 CONSTRAINT [PK_Hotel] PRIMARY KEY CLUSTERED 
(
	[Hotel_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hotel_Facilities]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel_Facilities](
	[Hotel_ID] [int] NOT NULL,
	[FacilityCode] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_HotelFacilities] PRIMARY KEY CLUSTERED 
(
	[Hotel_ID] ASC,
	[FacilityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LangCode] [nvarchar](2) NOT NULL,
	[LanguageName] [nvarchar](50) NOT NULL,
	[TextDirection] [nvarchar](3) NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LangCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[Customer_ID] [int] NOT NULL,
	[Room_ID] [int] NOT NULL,
	[CheckInDate] [date] NOT NULL,
	[CardMaskedNumber] [nvarchar](20) NOT NULL,
	[CardExpiry] [nvarchar](5) NOT NULL,
	[CardType] [nvarchar](20) NULL,
	[PaymentDate] [datetime] NULL,
	[AmountPaid] [decimal](10, 2) NOT NULL,
	[PaymentStatus] [nvarchar](20) NULL,
	[Booking_ID] [int] NOT NULL,
	[Payment_ID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[Payment_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Policy]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Policy](
	[Hotel_ID] [int] NOT NULL,
	[PolicyName] [nvarchar](50) NOT NULL,
	[RefundPercentage] [decimal](5, 2) NULL,
	[DeadlineHours] [int] NULL,
	[EnforcementLevel] [nvarchar](20) NULL,
	[ViolationFine] [decimal](10, 2) NULL,
	[GuestInstruction] [nvarchar](max) NULL,
 CONSTRAINT [PK_Policy] PRIMARY KEY CLUSTERED 
(
	[Hotel_ID] ASC,
	[PolicyName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromoCode] [nvarchar](20) NOT NULL,
	[Hotel_ID] [int] NOT NULL,
	[DiscountValue] [decimal](10, 2) NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[PromoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Review]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[Customer_ID] [int] NOT NULL,
	[Hotel_ID] [int] NOT NULL,
	[ReviewDate] [date] NOT NULL,
	[CleanlinessScore] [int] NULL,
	[StaffScore] [int] NULL,
	[ComfortScore] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[AverageScore]  AS ((([CleanlinessScore]+[StaffScore])+[ComfortScore])/(3.0)),
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC,
	[Hotel_ID] ASC,
	[ReviewDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[Room_ID] [int] IDENTITY(1,1) NOT NULL,
	[Hotel_ID] [int] NOT NULL,
	[TypeCode] [nvarchar](10) NOT NULL,
	[FloorNumber] [int] NULL,
	[RoomNumber_Visual] [nvarchar](20) NOT NULL,
	[IsCleaned] [bit] NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[Room_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomPrice_History]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomPrice_History](
	[History_ID] [int] IDENTITY(1,1) NOT NULL,
	[Room_TypeCode] [nvarchar](10) NULL,
	[Old_Price] [decimal](10, 2) NULL,
	[New_Price] [decimal](10, 2) NULL,
	[Change_Date] [datetime] NULL,
	[Changed_By] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[History_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[TypeCode] [nvarchar](10) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL,
	[BasePrice] [decimal](10, 2) NOT NULL,
	[MaxOccupancy] [int] NOT NULL,
 CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED 
(
	[TypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Booking] ADD  DEFAULT ('Confirmed') FOR [Status]
GO
ALTER TABLE [dbo].[Booking_Audit] ADD  DEFAULT (getdate()) FOR [Action_Date]
GO
ALTER TABLE [dbo].[Booking_Audit] ADD  DEFAULT (suser_sname()) FOR [User_Name]
GO
ALTER TABLE [dbo].[Currency] ADD  DEFAULT (getdate()) FOR [LastUpdateTimestamp]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT ((1)) FOR [TierLevel]
GO
ALTER TABLE [dbo].[GeniusTier] ADD  DEFAULT ((0.00)) FOR [DiscountRate]
GO
ALTER TABLE [dbo].[Hotel] ADD  DEFAULT ((0.14)) FOR [TaxPercentage]
GO
ALTER TABLE [dbo].[Payment] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[Review] ADD  DEFAULT (getdate()) FOR [ReviewDate]
GO
ALTER TABLE [dbo].[Room] ADD  DEFAULT ((1)) FOR [IsCleaned]
GO
ALTER TABLE [dbo].[RoomPrice_History] ADD  DEFAULT (getdate()) FOR [Change_Date]
GO
ALTER TABLE [dbo].[RoomPrice_History] ADD  DEFAULT (suser_sname()) FOR [Changed_By]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Customer]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Hotel] FOREIGN KEY([Hotel_ID])
REFERENCES [dbo].[Hotel] ([Hotel_ID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Hotel]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Promo] FOREIGN KEY([PromoCode])
REFERENCES [dbo].[Promotion] ([PromoCode])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Promo]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_Booking_Room] FOREIGN KEY([Room_ID])
REFERENCES [dbo].[Room] ([Room_ID])
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_Booking_Room]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Lang] FOREIGN KEY([PreferredLangCode])
REFERENCES [dbo].[Language] ([LangCode])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Lang]
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Tier] FOREIGN KEY([TierLevel])
REFERENCES [dbo].[GeniusTier] ([TierLevel])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Tier]
GO
ALTER TABLE [dbo].[Destination]  WITH CHECK ADD  CONSTRAINT [FK_Destination_Country] FOREIGN KEY([CountryISO])
REFERENCES [dbo].[Country] ([CountryISO])
GO
ALTER TABLE [dbo].[Destination] CHECK CONSTRAINT [FK_Destination_Country]
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD  CONSTRAINT [FK_Hotel_Country] FOREIGN KEY([CountryISO])
REFERENCES [dbo].[Country] ([CountryISO])
GO
ALTER TABLE [dbo].[Hotel] CHECK CONSTRAINT [FK_Hotel_Country]
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD  CONSTRAINT [FK_Hotel_Currency] FOREIGN KEY([CurrencyCode])
REFERENCES [dbo].[Currency] ([CurrencyCode])
GO
ALTER TABLE [dbo].[Hotel] CHECK CONSTRAINT [FK_Hotel_Currency]
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD  CONSTRAINT [FK_Hotel_Destination] FOREIGN KEY([DestinationCode])
REFERENCES [dbo].[Destination] ([DestinationCode])
GO
ALTER TABLE [dbo].[Hotel] CHECK CONSTRAINT [FK_Hotel_Destination]
GO
ALTER TABLE [dbo].[Hotel_Facilities]  WITH CHECK ADD  CONSTRAINT [FK_HF_Facility] FOREIGN KEY([FacilityCode])
REFERENCES [dbo].[Facility] ([FacilityCode])
GO
ALTER TABLE [dbo].[Hotel_Facilities] CHECK CONSTRAINT [FK_HF_Facility]
GO
ALTER TABLE [dbo].[Hotel_Facilities]  WITH CHECK ADD  CONSTRAINT [FK_HF_Hotel] FOREIGN KEY([Hotel_ID])
REFERENCES [dbo].[Hotel] ([Hotel_ID])
GO
ALTER TABLE [dbo].[Hotel_Facilities] CHECK CONSTRAINT [FK_HF_Hotel]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_BookingID] FOREIGN KEY([Booking_ID])
REFERENCES [dbo].[Booking] ([Booking_ID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_BookingID]
GO
ALTER TABLE [dbo].[Policy]  WITH CHECK ADD  CONSTRAINT [FK_Policy_Hotel] FOREIGN KEY([Hotel_ID])
REFERENCES [dbo].[Hotel] ([Hotel_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Policy] CHECK CONSTRAINT [FK_Policy_Hotel]
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [FK_Promo_Hotel] FOREIGN KEY([Hotel_ID])
REFERENCES [dbo].[Hotel] ([Hotel_ID])
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [FK_Promo_Hotel]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Customer]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Hotel] FOREIGN KEY([Hotel_ID])
REFERENCES [dbo].[Hotel] ([Hotel_ID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Hotel]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Hotel] FOREIGN KEY([Hotel_ID])
REFERENCES [dbo].[Hotel] ([Hotel_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Hotel]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Type] FOREIGN KEY([TypeCode])
REFERENCES [dbo].[RoomType] ([TypeCode])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Type]
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD CHECK  (([Status]='Completed' OR [Status]='Cancelled' OR [Status]='Confirmed'))
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [CK_Dates] CHECK  (([CheckOutDate]>[CheckInDate]))
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [CK_Dates]
GO
ALTER TABLE [dbo].[Currency]  WITH CHECK ADD CHECK  (([ExchangeRateToUSD]>(0)))
GO
ALTER TABLE [dbo].[Facility]  WITH CHECK ADD CHECK  (([CostType]='Surcharge' OR [CostType]='Complimentary'))
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD CHECK  (([StarRating]>=(1) AND [StarRating]<=(5)))
GO
ALTER TABLE [dbo].[Language]  WITH CHECK ADD CHECK  (([TextDirection]='RTL' OR [TextDirection]='LTR'))
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD CHECK  (([PaymentStatus]='Failed' OR [PaymentStatus]='Success'))
GO
ALTER TABLE [dbo].[Policy]  WITH CHECK ADD CHECK  (([RefundPercentage]>=(0) AND [RefundPercentage]<=(100)))
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [CK_Promo_Dates] CHECK  (([EndDate]>=[StartDate]))
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [CK_Promo_Dates]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD CHECK  (([CleanlinessScore]>=(1) AND [CleanlinessScore]<=(10)))
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD CHECK  (([ComfortScore]>=(1) AND [ComfortScore]<=(10)))
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD CHECK  (([StaffScore]>=(1) AND [StaffScore]<=(10)))
GO
ALTER TABLE [dbo].[RoomType]  WITH CHECK ADD CHECK  (([BasePrice]>=(0)))
GO
ALTER TABLE [dbo].[RoomType]  WITH CHECK ADD CHECK  (([MaxOccupancy]>(0)))
GO
/****** Object:  Trigger [dbo].[trg_Booking_Audit_Log]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   TRIGGER [dbo].[trg_Booking_Audit_Log]
ON [dbo].[Booking]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Booking_Audit
    (
        Booking_ID,
        Booking_Customer_ID,
        Booking_Room_ID,
        Booking_CheckIn,
        Old_Status,
        New_Status,
        Old_TotalCost,
        New_TotalCost,
        Action_Type,
        Action_Date,
        User_Name
    )
    SELECT
        COALESCE(i.Booking_ID, d.Booking_ID),
        COALESCE(i.Customer_ID, d.Customer_ID),
        COALESCE(i.Room_ID, d.Room_ID),
        COALESCE(i.CheckInDate, d.CheckInDate),

        d.Status,
        i.Status,

        d.TotalCost,
        i.TotalCost,

        CASE
            WHEN d.Booking_ID IS NULL THEN 'INSERT'
            WHEN i.Booking_ID IS NULL THEN 'DELETE'
            ELSE 'UPDATE'
        END,

        GETDATE(),
        SUSER_SNAME()

    FROM inserted AS i
    FULL OUTER JOIN deleted AS d
        ON i.Booking_ID = d.Booking_ID;
END;
GO
ALTER TABLE [dbo].[Booking] ENABLE TRIGGER [trg_Booking_Audit_Log]
GO
/****** Object:  Trigger [dbo].[trg_Monitor_Price_Change]    Script Date: 10/30/2026 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- الإنشاء
CREATE TRIGGER [dbo].[trg_Monitor_Price_Change]
ON [dbo].[RoomType]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- التأكد إن التعديل حصل في عمود السعر BasePrice
    IF UPDATE(BasePrice)
    BEGIN
        INSERT INTO [dbo].[RoomPrice_History] ([Room_TypeCode], [Old_Price], [New_Price])
        SELECT 
            d.[TypeCode], 
            d.[BasePrice], -- السعر القديم
            i.[BasePrice]  -- السعر الجديد
        FROM deleted d
        INNER JOIN inserted i ON d.[TypeCode] = i.[TypeCode]
        WHERE d.[BasePrice] <> i.[BasePrice]; -- شرط للتأكد إن السعر اتغير فعلاً
    END
END;
GO
ALTER TABLE [dbo].[RoomType] ENABLE TRIGGER [trg_Monitor_Price_Change]
GO
