CREATE DATABASE [ProjectOnline]
GO
USE [ProjectOnline]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillID] [varchar](16) NOT NULL,
	[CusID] [int] NOT NULL,
	[DateOrder] [date] NOT NULL,
	[TransportPrice] [decimal](18, 2) NOT NULL,
	[TotalPayment] [decimal](18, 2) NOT NULL,
	[ShippingName] [varchar](50) NOT NULL,
	[Status] [varchar](50) NULL,
	[TypeBill] [varchar](50) NOT NULL,
	[CreditCardID] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryProduct]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryProduct](
	[CateID] [varchar](2) NOT NULL,
	[CateName] [varchar](50) NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CusID] [int] IDENTITY(1,1) NOT NULL,
	[CusName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Phone] [varchar](11) NOT NULL,
	[Image] [varchar](max) NULL,
	[Address] [varchar](100) NOT NULL,
 CONSTRAINT [PK__Customer__2F187130525DE136] PRIMARY KEY CLUSTERED 
(
	[CusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetailBill]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetailBill](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [varchar](7) NOT NULL,
	[BillID] [varchar](16) NOT NULL,
	[Amount] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_DetailBill] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Salary] [decimal](18, 2) NOT NULL,
	[Phone] [varchar](12) NOT NULL,
	[Position] [int] NOT NULL,
 CONSTRAINT [PK__Employee__7AD04FF128BDB529] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [varchar](16) NOT NULL,
	[CusID] [int] NOT NULL,
	[BillID] [varchar](16) NOT NULL,
	[DateOrder] [date] NOT NULL,
	[Stt] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[PositionID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [varchar](7) NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[Amount] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Image] [varchar](max) NOT NULL,
	[Detail] [varchar](max) NULL,
	[Warranty] [int] NOT NULL,
	[Status] [bit] NOT NULL,
	[CateProduct] [varchar](2) NOT NULL,
 CONSTRAINT [PK__Product__B40CC6EDA89C2000] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WareHouse]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WareHouse](
	[WareHouseID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [varchar](7) NOT NULL,
	[AmountInput] [int] NOT NULL,
	[DateInput] [date] NOT NULL,
 CONSTRAINT [PK__WareHous__69FF80986A8F2303] PRIMARY KEY CLUSTERED 
(
	[WareHouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'0Rnk5J3N', 25, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(5.50 AS Decimal(18, 2)), N'G', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'5cw8LNBu', 25, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'6x0gDWpv', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'B', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'7exlv9sm', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'B', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'7gV2ZMZW', 72, CAST(N'2022-05-07' AS Date), CAST(2.00 AS Decimal(18, 2)), CAST(10.20 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'7se0EAZd', 74, CAST(N'2022-05-07' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(4.10 AS Decimal(18, 2)), N'B', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'7yQYBJ7Z', 68, CAST(N'2022-05-07' AS Date), CAST(0.00 AS Decimal(18, 2)), CAST(8.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'AFpo7i9D', 23, CAST(N'2022-05-04' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(4.50 AS Decimal(18, 2)), N'B', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'BbSDsMhr', 75, CAST(N'2022-05-07' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(9.50 AS Decimal(18, 2)), N'B', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'c79fnqZK', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'G', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'cGhwuSWG', 23, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'K', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'e1OCOpk1', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(5.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'e9ZYUCcI', 27, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'Edemr1DF', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'F0WFnFIp', 69, CAST(N'2022-05-07' AS Date), CAST(2.00 AS Decimal(18, 2)), CAST(6.50 AS Decimal(18, 2)), N'B', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'f7wQDsDl', 23, CAST(N'2022-05-06' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'FAnn4PEB', 25, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'FxCW5AAg', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'V', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'I2jcqg5n', 27, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'IfncHdGE', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'B', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'inmO5aQk', 75, CAST(N'2022-05-07' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(4.00 AS Decimal(18, 2)), N'V', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'iqLbCXsf', 72, CAST(N'2022-05-07' AS Date), CAST(2.00 AS Decimal(18, 2)), CAST(13.00 AS Decimal(18, 2)), N'B', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'n0JHdagV', 25, CAST(N'2022-05-06' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.50 AS Decimal(18, 2)), N'G', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'nnD6Qq5y', 1, CAST(N'2022-04-29' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)), N'V', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'oTQfvjBm', 75, CAST(N'2022-05-07' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(38.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'pE2TTVFH', 72, CAST(N'2022-05-07' AS Date), CAST(2.00 AS Decimal(18, 2)), CAST(10.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'pHEJYpin', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'phlj8os1', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'pvSZAIOk', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), N'G', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'SDyqLvtl', 72, CAST(N'2022-05-07' AS Date), CAST(2.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'K', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'SnA0UiBl', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(11.00 AS Decimal(18, 2)), N'V', N'Unpaid', N'COD', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'TUPr9b6A', 74, CAST(N'2022-05-07' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(6.70 AS Decimal(18, 2)), N'B', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'UQOVZNfy', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)), N'K', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'VuT4yfOt', 25, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'G', N'Refunded', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'X3WOmUdS', 27, CAST(N'2022-05-05' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.50 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'XbIcdHkq', 75, CAST(N'2022-05-07' AS Date), CAST(0.00 AS Decimal(18, 2)), CAST(42.00 AS Decimal(18, 2)), N'G', N'Paid', N'PayPal', NULL)
INSERT [dbo].[Bill] ([BillID], [CusID], [DateOrder], [TransportPrice], [TotalPayment], [ShippingName], [Status], [TypeBill], [CreditCardID]) VALUES (N'Z0OnH30h', 1, CAST(N'2022-04-30' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)), N'B', N'Unpaid', N'COD', NULL)
GO
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'1w', N'Student', 1)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'BK', N'Book', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'BP', N'Backpacks', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'C1', N'Cushions', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'C4', N'Cards', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'CD', N'Candles', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'HF', N'hihi', 1)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'kL', N'Home Decor', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'Qy', N'Decor', 1)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'TB', N'Tote Bags', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'U6', N'Lighting', 0)
INSERT [dbo].[CategoryProduct] ([CateID], [CateName], [Status]) VALUES (N'WA', N'Wall Art', 0)
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (1, N'Quyen Nguyen', N'quyennguyen.qn587@gmail.com', N'd41d8cd98f00b204e9800998ecf8427e', N'0582511721', NULL, N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (2, N'Quyen Nguyen', N'festivals212@gmail.com', N'd41d8cd98f00b204e9800998ecf8427e', N'0384667079', NULL, N'HN')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (23, N'VY', N'123@gmail.com', N'25f9e794323b453885f5181f1b624d0b', N'0369852147', NULL, N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (25, N'Quyen', N'123@gmail.com', N'25f9e794323b453885f5181f1b624d0b', N'0358436730', N'd38bc6a1-ceca-4a12-83fa-9d3cc3bf9785.jpg', N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (27, N'VY', N'123@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'0321496587', NULL, N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (68, N'Quyen Nguyen', N'quyennguyen.qn587@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'0985867123', NULL, N'?p Chà Và - xã Vinh Kim - huy?n C?u Ngang - t?nh Trà Vinh')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (69, N'Phu', N'quyennguyen.qn587@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'0384679214', NULL, N'HN')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (70, N'Jenzert', N'quyennguyen.qn587@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'0398654123', NULL, N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (71, N'Quyen Nguyen', N'quyennguyen.qn587@gmail.com', N'd41d8cd98f00b204e9800998ecf8427e', N'01215632148', NULL, N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (72, N'Quyen', N'quyennguyen.qn587@gmail.com', N'acc4cfc0773695795955f187d86342c3', N'0965867312', N'f0fe162a-c48d-43d3-8d18-c88ed69c870d.jpg', N'HN')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (73, N'Tu Quyen', N'123@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'01214383597', NULL, N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (74, N'Tu Quyen', N'quyennguyen.qn587@gmail.com', N'e35cf7b66449df565f93c607d5a81d09', N'0346835228', N'5adf1649-6073-4a00-815d-4444564fa8bf.jpg', N'TPHCM')
INSERT [dbo].[Customer] ([CusID], [CusName], [Email], [Password], [Phone], [Image], [Address]) VALUES (75, N'Lâm Thanh Phú', N'thanhphu322001@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'0976600723', N'0eb4f1d6-9f68-462d-a756-26b2f7c96d56.jfif', N'TPHCM')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[DetailBill] ON 

INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (19, N'MKJI456', N'AFpo7i9D', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (20, N'KLJIOP5', N'AFpo7i9D', 2, CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (21, N'MKJI456', N'0Rnk5J3N', 3, CAST(1.50 AS Decimal(18, 2)), CAST(4.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (22, N'KLJIOP5', N'I2jcqg5n', 2, CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (23, N'MKJI456', N'e9ZYUCcI', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (24, N'MKJI456', N'X3WOmUdS', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (25, N'MKJI456', N'cGhwuSWG', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (26, N'MKJI456', N'VuT4yfOt', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (27, N'MKJI456', N'5cw8LNBu', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (28, N'KLJIOP5', N'5cw8LNBu', 1, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (29, N'MKJI456', N'FAnn4PEB', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (30, N'KLJIOP5', N'FAnn4PEB', 1, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (31, N'MKJI456', N'f7wQDsDl', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (32, N'KLJIOP5', N'f7wQDsDl', 1, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (33, N'MKJI456', N'n0JHdagV', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (34, N'KLJIOP5', N'n0JHdagV', 1, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (35, N'MKJI456', N'F0WFnFIp', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (36, N'KLJIOP5', N'F0WFnFIp', 3, CAST(1.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (37, N'VLtqaC4', N'iqLbCXsf', 6, CAST(1.50 AS Decimal(18, 2)), CAST(9.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (38, N'KLJIOP5', N'iqLbCXsf', 2, CAST(1.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (39, N'bQHchkL', N'SDyqLvtl', 1, CAST(1.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (40, N'VLtqaC4', N'pE2TTVFH', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (41, N'S288LTB', N'pE2TTVFH', 1, CAST(7.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (42, N'S288LTB', N'7gV2ZMZW', 1, CAST(7.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (43, N'LOP3457', N'7gV2ZMZW', 1, CAST(1.20 AS Decimal(18, 2)), CAST(1.20 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (44, N'LOP3457', N'TUPr9b6A', 1, CAST(1.20 AS Decimal(18, 2)), CAST(1.20 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (45, N'MKJI456', N'TUPr9b6A', 3, CAST(1.50 AS Decimal(18, 2)), CAST(4.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (46, N'fxCgtkL', N'7se0EAZd', 1, CAST(1.70 AS Decimal(18, 2)), CAST(1.70 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (47, N'gKGRQkL', N'7se0EAZd', 2, CAST(0.70 AS Decimal(18, 2)), CAST(1.40 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (48, N'VLtqaC4', N'7yQYBJ7Z', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (49, N'S288LTB', N'7yQYBJ7Z', 1, CAST(7.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (50, N'0knH6U6', N'XbIcdHkq', 3, CAST(12.00 AS Decimal(18, 2)), CAST(36.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (51, N'DUdmqCD', N'XbIcdHkq', 3, CAST(2.00 AS Decimal(18, 2)), CAST(6.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (52, N'VLtqaC4', N'inmO5aQk', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (53, N'MKJI456', N'inmO5aQk', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (54, N'VLtqaC4', N'BbSDsMhr', 1, CAST(1.50 AS Decimal(18, 2)), CAST(1.50 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (55, N'S288LTB', N'BbSDsMhr', 1, CAST(7.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (56, N'VLtqaC4', N'oTQfvjBm', 20, CAST(1.50 AS Decimal(18, 2)), CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[DetailBill] ([ID], [ProductID], [BillID], [Amount], [Price], [TotalPrice]) VALUES (57, N'S288LTB', N'oTQfvjBm', 1, CAST(7.00 AS Decimal(18, 2)), CAST(7.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[DetailBill] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeID], [EmployeeName], [UserName], [Password], [Salary], [Phone], [Position]) VALUES (2, N'Quyen', N'Quin', N'fcea920f7412b5da7be0cf42b8c93759', CAST(500.00 AS Decimal(18, 2)), N'0384667079', 2)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeName], [UserName], [Password], [Salary], [Phone], [Position]) VALUES (6, N'Vie', N'Vy', N'25f9e794323b453885f5181f1b624d0b', CAST(400.00 AS Decimal(18, 2)), N'0582511721', 1)
INSERT [dbo].[Employee] ([EmployeeID], [EmployeeName], [UserName], [Password], [Salary], [Phone], [Position]) VALUES (12, N'ris', N'ris@123', N'e10adc3949ba59abbe56e057f20f883e', CAST(500.00 AS Decimal(18, 2)), N'0374667079', 1)
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'0Rnk5J3NMKJI456G', 25, N'0Rnk5J3N', CAST(N'2022-05-05' AS Date), N'Confirmed')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'5cw8LNBuMKJI456G', 25, N'5cw8LNBu', CAST(N'2022-05-05' AS Date), N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'6x0gDWpv60cXlU6B', 1, N'6x0gDWpv', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'7exlv9sm0K7XBU6B', 1, N'7exlv9sm', CAST(N'2022-04-30' AS Date), N'Confirmed')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'7gV2ZMZWS288LTBG', 72, N'7gV2ZMZW', CAST(N'2022-05-07' AS Date), N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'7se0EAZdfxCgtkLB', 74, N'7se0EAZd', CAST(N'2022-05-07' AS Date), N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'7yQYBJ7ZVLtqaC4G', 68, N'7yQYBJ7Z', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'AFpo7i9DMKJI456B', 23, N'AFpo7i9D', CAST(N'2022-05-04' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'BbSDsMhrVLtqaC4B', 75, N'BbSDsMhr', CAST(N'2022-05-07' AS Date), N'Delivered')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'c79fnqZK0K7XBU6G', 1, N'c79fnqZK', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'cGhwuSWGMKJI456K', 23, N'cGhwuSWG', CAST(N'2022-05-05' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'e1OCOpk160cXlU6G', 1, N'e1OCOpk1', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'e9ZYUCcIMKJI456G', 27, N'e9ZYUCcI', CAST(N'2022-05-05' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'Edemr1DF60cXlU6G', 1, N'Edemr1DF', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'F0WFnFIpMKJI456B', 69, N'F0WFnFIp', CAST(N'2022-05-07' AS Date), N'Confirmed')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'f7wQDsDlMKJI456G', 23, N'f7wQDsDl', CAST(N'2022-05-06' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'FAnn4PEBMKJI456G', 25, N'FAnn4PEB', CAST(N'2022-05-05' AS Date), N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'FxCW5AAg60cXlU6V', 1, N'FxCW5AAg', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'I2jcqg5nKLJIOP5G', 27, N'I2jcqg5n', CAST(N'2022-05-05' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'IfncHdGE0K7XBU6B', 1, N'IfncHdGE', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'inmO5aQkVLtqaC4V', 75, N'inmO5aQk', CAST(N'2022-05-07' AS Date), N'Confirmed')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'iqLbCXsfVLtqaC4B', 72, N'iqLbCXsf', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'n0JHdagVMKJI456G', 25, N'n0JHdagV', CAST(N'2022-05-06' AS Date), N'Confirmed')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'oTQfvjBmVLtqaC4G', 75, N'oTQfvjBm', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'pE2TTVFHVLtqaC4G', 72, N'pE2TTVFH', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'pHEJYpin60cXlU6G', 1, N'pHEJYpin', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'phlj8os160cXlU6G', 1, N'phlj8os1', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'pvSZAIOk60cXlU6G', 1, N'pvSZAIOk', CAST(N'2022-04-30' AS Date), N'Delivering')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'SDyqLvtlbQHchkLK', 72, N'SDyqLvtl', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'TUPr9b6ALOP3457B', 74, N'TUPr9b6A', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'UQOVZNfy0K7XBU6K', 1, N'UQOVZNfy', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'VuT4yfOtMKJI456G', 25, N'VuT4yfOt', CAST(N'2022-05-05' AS Date), N'Canceled')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'X3WOmUdSMKJI456G', 27, N'X3WOmUdS', CAST(N'2022-05-05' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'XbIcdHkq0knH6U6G', 75, N'XbIcdHkq', CAST(N'2022-05-07' AS Date), N'Wait for confirmation')
INSERT [dbo].[Orders] ([OrderID], [CusID], [BillID], [DateOrder], [Stt]) VALUES (N'Z0OnH30h0K7XBU6B', 1, N'Z0OnH30h', CAST(N'2022-04-30' AS Date), N'Wait for confirmation')
GO
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([PositionID], [PositionName]) VALUES (1, N'employee')
INSERT [dbo].[Position] ([PositionID], [PositionName]) VALUES (2, N'admin')
SET IDENTITY_INSERT [dbo].[Position] OFF
GO
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'0knH6U6', N'Usb Extra Long Curtain Lights', 50, CAST(12.00 AS Decimal(18, 2)), N'1683866-01-2224508416.jpg', N'Double the length of our regular lights, these Extra Long Curtain Lights are here to bring to life all your mood lighting vibes. Drape over your bed frame, curtain rod, bedframe, fireplace or wherever your heart desires to level up your hang out space.', 6, 1, N'U6')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'0peWe1w', N'Hi', 0, CAST(12.00 AS Decimal(18, 2)), N'download225458211.jfif', N'dfghjkl', 1, 1, N'1w')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'bQHchkL', N'Acrylic Vase 2', 70, CAST(1.00 AS Decimal(18, 2)), N'1684436-06-3223040894.jpg', N'Acrylic Shaped Vase
Available in multiple colours & shapes
Perfect to brighten up any space
Does not include plant/flowers
Composition
Main: 100% Acrylic.', 0, 1, N'kL')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'DUdmqCD', N'Mini Shaped Candle', 30, CAST(2.00 AS Decimal(18, 2)), N'1684268-13-2220751408.jpg', N'Shaped Mini Candle
Parraffin Wax
Various styles and shapes available
Composition
Main: 95% Wax, 5% Cotton.
Ingredients
Parraffin Wax', 0, 1, N'CD')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'fxCgtkL', N'Tiny Planter With Plant', 99, CAST(1.70 AS Decimal(18, 2)), N'1684113-18-2222657490.jpg', N'Made from Cement
Includes non removeable fake plant
Available in a range of colours
Composition
Main: 80% Cement, 20% Plastic.', 0, 1, N'kL')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'gKGRQkL', N'Acrylic Vase', 198, CAST(0.70 AS Decimal(18, 2)), N'1684436-01-4222932430.jpg', N'Acrylic Shaped Vase
Available in multiple colours & shapes
Perfect to brighten up any space
Does not include plant/flowers
Composition
Main: 100% Acrylic.', 0, 1, N'kL')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'hiZXQCD', N'Mini Shaped Candle', 30, CAST(2.20 AS Decimal(18, 2)), N'1684268-14-2220927741.jpg', N'Shaped Mini Candle
Parraffin Wax
Various styles and shapes available
Composition
Main: 95% Wax, 5% Cotton.
Ingredients
Parraffin Wax', 0, 1, N'CD')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'KLJIOP5', N'A4 Campus Notebook Recycled', 13, CAST(1.00 AS Decimal(18, 2)), N'145668-256-2.jpg', N'Separate your subjects and keep all of your notes, doodles, clippings and worksheets in the one fresh notebook. Fitted out with in-house designs, tabbed (and pocketed) subject dividers & spiral bound for easy tear away. 100% recycled & recyclable pages!', 0, 1, N'BK')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'KUbI6U6', N'Usb Premium Peg Lights', 0, CAST(12.00 AS Decimal(18, 2)), N'1684262-01-1224707496.jpg', N'USB operated peg lights
Multi coloured changing lights
Runs automatically from jump, fade, waves & twinkle light modes
Contains button on USB plug to regulate different colour & light modes
18 Colours
Pegs to hang photos -3m Leading USB cable', 6, 1, N'U6')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'LOP3457', N'Floor Cushion', 49, CAST(1.20 AS Decimal(18, 2)), N'1684080-13-2.jpg', N'Attentional all floor people, we got the cush for you! Our Floor Cushions are thick and soft for booty comfort, firm for easy upright or storage and have a built in handle for sliding your guests around on it . . . I mean, carrying it to the next room.', 0, 1, N'C1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'MKJI456', N'Floor Cushion 2', 18, CAST(1.50 AS Decimal(18, 2)), N'1684080-11-2.jpg', N'Attentional all floor people, we got the cush for you! Our Floor Cushions are thick and soft for booty comfort, firm for easy upright or storage and have a built in handle for sliding your guests around on it . . . I mean, carrying it to the next room.', 0, 1, N'C1')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'S288LTB', N'Art Tote Bag', 53, CAST(7.00 AS Decimal(18, 2)), N'1684454-14-2222049416.jpg', N'The perfect tote bag for the vlogger, artist, yogi and uni student alike. An  tote bag  ideal for your on-the-go tech gadgets and travel essentials.', 0, 1, N'TB')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'sGv8LU6', N'Micro Light Box', 0, CAST(8.00 AS Decimal(18, 2)), N'143707-02-1223154970.jpg', N'Our classic light box just got super micro and super cute! 
Available in 3 shapes - cloud, rectangle and speech bubbles. They''re perfect for any mini statement!', 6, 1, N'U6')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Amount], [Price], [Image], [Detail], [Warranty], [Status], [CateProduct]) VALUES (N'VLtqaC4', N'Gudetama Funny Birthday Card', 59, CAST(1.50 AS Decimal(18, 2)), N'136807-652-2225023297.jpg', N'Pick a card, any card! We have the right card for every occasion.
Don''t get stuck without a card, grab one now! Or two!', 0, 1, N'C4')
GO
SET IDENTITY_INSERT [dbo].[WareHouse] ON 

INSERT [dbo].[WareHouse] ([WareHouseID], [ProductID], [AmountInput], [DateInput]) VALUES (1, N'0knH6U6', 21, CAST(N'2022-05-07' AS Date))
INSERT [dbo].[WareHouse] ([WareHouseID], [ProductID], [AmountInput], [DateInput]) VALUES (2, N'0peWe1w', -1, CAST(N'2022-05-07' AS Date))
SET IDENTITY_INSERT [dbo].[WareHouse] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unique_Phone]    Script Date: 5/8/2022 8:48:02 PM ******/
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [unique_Phone] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__5C7E359EEC3C8FA4]    Script Date: 5/8/2022 8:48:02 PM ******/
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [UQ__Customer__5C7E359EEC3C8FA4] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Employee__5C7E359E6474978D]    Script Date: 5/8/2022 8:48:02 PM ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [UQ__Employee__5C7E359E6474978D] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK__Bill__CusID__286302EC] FOREIGN KEY([CusID])
REFERENCES [dbo].[Customer] ([CusID])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK__Bill__CusID__286302EC]
GO
ALTER TABLE [dbo].[DetailBill]  WITH CHECK ADD FOREIGN KEY([BillID])
REFERENCES [dbo].[Bill] ([BillID])
GO
ALTER TABLE [dbo].[DetailBill]  WITH CHECK ADD  CONSTRAINT [FK__DetailBil__Produ__2C3393D0] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[DetailBill] CHECK CONSTRAINT [FK__DetailBil__Produ__2C3393D0]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK__Employee__Positi__3F466844] FOREIGN KEY([Position])
REFERENCES [dbo].[Position] ([PositionID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK__Employee__Positi__3F466844]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([BillID])
REFERENCES [dbo].[Bill] ([BillID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK__Orders__CusID__30F848ED] FOREIGN KEY([CusID])
REFERENCES [dbo].[Customer] ([CusID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK__Orders__CusID__30F848ED]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK__Product__CatePro__31EC6D26] FOREIGN KEY([CateProduct])
REFERENCES [dbo].[CategoryProduct] ([CateID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK__Product__CatePro__31EC6D26]
GO
ALTER TABLE [dbo].[WareHouse]  WITH CHECK ADD  CONSTRAINT [FK__WareHouse__Produ__32E0915F] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[WareHouse] CHECK CONSTRAINT [FK__WareHouse__Produ__32E0915F]
GO
/****** Object:  Trigger [dbo].[trg_WareHouse]    Script Date: 5/8/2022 8:48:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_WareHouse] 
ON [dbo].[WareHouse]
AFTER INSERT AS BEGIN
declare @Amount int;
declare @proid varchar(7);
Set @Amount = (SELECT AmountInput FROM inserted )
Set @proid = (Select ProductID from inserted)
UPDATE Product SET Amount = Amount + @Amount where ProductID = @proid
END
GO
ALTER TABLE [dbo].[WareHouse] ENABLE TRIGGER [trg_WareHouse]
GO
