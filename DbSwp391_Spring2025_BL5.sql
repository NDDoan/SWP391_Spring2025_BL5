USE [master]
GO
/****** Object:  Database [swp391_spring2025_bl5]    Script Date: 4/14/2025 10:13:24 PM ******/
CREATE DATABASE [swp391_spring2025_bl5]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'swp391_spring2025_bl5', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\swp391_spring2025_bl5.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'swp391_spring2025_bl5_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\swp391_spring2025_bl5_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [swp391_spring2025_bl5] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [swp391_spring2025_bl5].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ARITHABORT OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET  ENABLE_BROKER 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET  MULTI_USER 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [swp391_spring2025_bl5] SET DB_CHAINING OFF 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [swp391_spring2025_bl5] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [swp391_spring2025_bl5] SET QUERY_STORE = ON
GO
ALTER DATABASE [swp391_spring2025_bl5] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [swp391_spring2025_bl5]
GO
/****** Object:  Table [dbo].[Blogs]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blogs](
	[blog_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[blog_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](255) NULL,
	[logo_url] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cart_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[shipping_address] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart_Items]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart_Items](
	[cart_item_id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[subtotal] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedbacks]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedbacks](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[blog_id] [int] NULL,
	[comment] [nvarchar](500) NULL,
	[rating] [int] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Items]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Items](
	[order_item_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[subtotal] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[order_status] [nvarchar](50) NULL,
	[total_amount] [decimal](18, 2) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[payment_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[payment_method] [nvarchar](50) NULL,
	[payment_status] [nvarchar](50) NULL,
	[amount] [decimal](18, 2) NULL,
	[vnpay_transaction_id] [nvarchar](100) NULL,
	[payment_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[permission_id] [int] IDENTITY(1,1) NOT NULL,
	[permission_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductMedia]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductMedia](
	[media_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[media_url] [nvarchar](255) NOT NULL,
	[media_type] [nvarchar](20) NULL,
	[is_primary] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[media_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](255) NOT NULL,
	[brand_id] [int] NULL,
	[category_id] [int] NULL,
	[description] [nvarchar](max) NULL,
	[discount_percent] [decimal](5, 2) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVariants]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVariants](
	[variant_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[cpu] [nvarchar](100) NULL,
	[ram] [nvarchar](50) NULL,
	[screen] [nvarchar](100) NULL,
	[storage] [nvarchar](50) NULL,
	[color] [nvarchar](50) NULL,
	[price] [decimal](18, 2) NOT NULL,
	[stock_quantity] [int] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[variant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissions](
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[role_id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping](
	[shipping_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[shipping_address] [nvarchar](500) NULL,
	[shipping_status] [nvarchar](50) NULL,
	[tracking_number] [nvarchar](100) NULL,
	[shipping_date] [datetime] NULL,
	[estimated_delivery] [datetime] NULL,
	[delivery_notes] [varchar](500) NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[shipping_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategories]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategories](
	[subcategory_id] [int] IDENTITY(1,1) NOT NULL,
	[subcategory_name] [nvarchar](255) NOT NULL,
	[category_id] [int] NULL,
	[description] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[subcategory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 4/14/2025 10:13:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[google_id] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[full_name] [nvarchar](100) NULL,
	[avatar_url] [nvarchar](255) NULL,
	[phone_number] [nvarchar](15) NULL,
	[address] [nvarchar](255) NULL,
	[role_id] [int] NULL,
	[is_active] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (1, N'Admin', N'Qu?n tr? viên h? th?ng v?i quy?n qu?n lý d?y d?.', CAST(N'2025-04-14T21:58:59.880' AS DateTime), CAST(N'2025-04-14T21:58:59.880' AS DateTime))
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (2, N'User', N'Ngu?i dùng bình thu?ng có quy?n truy c?p vào các s?n ph?m và d?ch v?.', CAST(N'2025-04-14T21:58:59.880' AS DateTime), CAST(N'2025-04-14T21:58:59.880' AS DateTime))
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (3, N'Marketing', N'Qu?n lý các chi?n d?ch marketing và n?i dung.', CAST(N'2025-04-14T21:58:59.880' AS DateTime), CAST(N'2025-04-14T21:58:59.880' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E61644AE00B47]    Script Date: 4/14/2025 10:13:24 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Blogs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Blogs] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Brands] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Brands] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Feedbacks] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [payment_date]
GO
ALTER TABLE [dbo].[ProductMedia] ADD  DEFAULT ((0)) FOR [is_primary]
GO
ALTER TABLE [dbo].[ProductMedia] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ProductMedia] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [discount_percent]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[SubCategories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[SubCategories] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Cart_Items]  WITH CHECK ADD FOREIGN KEY([cart_id])
REFERENCES [dbo].[Cart] ([cart_id])
GO
ALTER TABLE [dbo].[Cart_Items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD FOREIGN KEY([blog_id])
REFERENCES [dbo].[Blogs] ([blog_id])
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[ProductMedia]  WITH CHECK ADD  CONSTRAINT [FK_ProductMedia_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[ProductMedia] CHECK CONSTRAINT [FK_ProductMedia_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Brands] FOREIGN KEY([brand_id])
REFERENCES [dbo].[Brands] ([brand_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Brands]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_ProductVariants_Products] FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_ProductVariants_Products]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD FOREIGN KEY([permission_id])
REFERENCES [dbo].[Permissions] ([permission_id])
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Shipping]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[SubCategories]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[Categories] ([category_id])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Roles] ([role_id])
GO
ALTER TABLE [dbo].[Cart_Items]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[ProductMedia]  WITH CHECK ADD CHECK  (([media_type]='video' OR [media_type]='image'))
GO
ALTER TABLE [dbo].[Shipping]  WITH CHECK ADD CHECK  (([shipping_status]='Returned' OR [shipping_status]='Canceled' OR [shipping_status]='Delivered' OR [shipping_status]='Shipped' OR [shipping_status]='Pending'))
GO
USE [master]
GO
ALTER DATABASE [swp391_spring2025_bl5] SET  READ_WRITE 
GO
