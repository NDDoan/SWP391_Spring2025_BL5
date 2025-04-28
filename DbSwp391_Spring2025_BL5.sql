USE [master]
GO
/****** Object:  Database [swp391_spring2025_bl5]    Script Date: 4/23/2025 7:47:01 AM ******/
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
/****** Object:  Table [dbo].[Blogs]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Brands]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Cart]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Cart_Items]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[CategoryPost]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryPost](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ColorOptions]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ColorOptions](
	[color_id] [int] IDENTITY(1,1) NOT NULL,
	[color] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[color_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CpuOptions]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CpuOptions](
	[cpu_id] [int] IDENTITY(1,1) NOT NULL,
	[cpu] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cpu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FeedbackImages]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FeedbackImages](
	[image_id] [int] IDENTITY(1,1) NOT NULL,
	[review_id] [int] NOT NULL,
	[image_url] [nvarchar](500) NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedbacks]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Order_Items]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Payments]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Permissions]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Post]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[post_id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [nvarchar](max) NOT NULL,
	[thumbnail_url] [nvarchar](500) NULL,
	[user_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[created_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[post_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductMedia]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 4/23/2025 7:47:02 AM ******/
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
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVariants]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVariants](
	[variant_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[price] [decimal](18, 2) NOT NULL,
	[stock_quantity] [int] NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[cpu_id] [int] NULL,
	[ram_id] [int] NULL,
	[screen_id] [int] NULL,
	[storage_id] [int] NULL,
	[color_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[variant_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RamOptions]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RamOptions](
	[ram_id] [int] IDENTITY(1,1) NOT NULL,
	[ram] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[user_id] [int] NULL,
	[rating] [int] NULL,
	[comment] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[ScreenOptions]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScreenOptions](
	[screen_id] [int] IDENTITY(1,1) NOT NULL,
	[screen] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[screen_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 4/23/2025 7:47:02 AM ******/
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
	[shipperId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[shipping_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE Shipping
ADD CONSTRAINT FK_Shipping_Order FOREIGN KEY (order_id) REFERENCES [Orders](order_id);

ALTER TABLE Shipping
ADD CONSTRAINT unique_order UNIQUE (order_id);

/****** Object:  Table [dbo].[StorageOptions]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StorageOptions](
	[storage_id] [int] IDENTITY(1,1) NOT NULL,
	[storage] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[storage_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubCategories]    Script Date: 4/23/2025 7:47:02 AM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 4/23/2025 7:47:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[full_name] [nvarchar](100) NULL,
	[Gender] [nvarchar](10) NULL,
	[avatar_url] [nvarchar](255) NULL,
	[phone_number] [nvarchar](15) NULL,
	[address] [nvarchar](255) NULL,
	[role_id] [int] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[is_active] [bit] NULL,
	[password_hash] [nvarchar](255) NULL,
	[is_verified] [bit] NULL,
	[reset_token] [nvarchar](255) NULL,
	[reset_token_expiry] [datetime] NULL,
	[last_login] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Brands] ON 
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (1, N'Apple', N'Apple là tập đoàn công nghệ hàng đầu, nổi tiếng với các sản phẩm như iPhone, iPad, Mac và hệ sinh thái tích hợp phần mềm-hardware độc đáo.', N'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg', CAST(N'2025-04-16T10:05:09.810' AS DateTime), CAST(N'2025-04-16T10:05:09.810' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (2, N'Samsung', N'Samsung là tập đoàn đa ngành của Hàn Quốc, dẫn đầu trong lĩnh vực điện tử tiêu dùng, smartphone và tivi thông minh.', N'https://images.samsung.com/is/image/samsung/assets/vn/about-us/brand/logo/mo/360_197_1.png?$720_N_PNG$', CAST(N'2025-04-16T10:05:21.630' AS DateTime), CAST(N'2025-04-16T10:05:21.630' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (3, N'Microsoft', N'Microsoft là công ty công nghệ đa quốc gia, nổi bật với hệ điều hành Windows, bộ ứng dụng Office và các giải pháp điện toán đám mây.', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBLoZC_9b_6CZT9WsMYzHZ7jFf8oeucvuUMA&s', CAST(N'2025-04-16T10:05:35.443' AS DateTime), CAST(N'2025-04-16T10:05:35.443' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (4, N'Google', N'Google chuyên cung cấp các dịch vụ tìm kiếm, quảng cáo trực tuyến, và các giải pháp đám mây, luôn tiên phong trong đổi mới công nghệ.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/640px-Google_2015_logo.svg.png', CAST(N'2025-04-16T10:05:40.210' AS DateTime), CAST(N'2025-04-16T10:05:40.210' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (5, N'Lenovo', N'Lenovo là nhà sản xuất máy tính hàng đầu đến từ Trung Quốc, nổi tiếng với dòng sản phẩm laptop, máy tính để bàn và thiết bị thông minh.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Lenovo_logo_2015.svg/2560px-Lenovo_logo_2015.svg.png', CAST(N'2025-04-16T10:05:53.447' AS DateTime), CAST(N'2025-04-16T10:05:53.447' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (6, N'Oppo', N'Oppo là thương hiệu điện thoại thông minh nổi bật từ Trung Quốc, được biết đến với thiết kế hiện đại và công nghệ chụp ảnh tiên tiến.', N'https://upload.wikimedia.org/wikipedia/commons/a/a2/OPPO_LOGO_2019.png', CAST(N'2025-04-16T10:05:57.570' AS DateTime), CAST(N'2025-04-16T10:05:57.570' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (7, N'Hp', N'HP (Hewlett-Packard) là một tập đoàn công nghệ toàn cầu chuyên cung cấp các sản phẩm máy tính, máy in và giải pháp CNTT.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/HP_logo_2012.svg/2048px-HP_logo_2012.svg.png', CAST(N'2025-04-16T10:06:17.327' AS DateTime), CAST(N'2025-04-16T10:06:17.327' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (8, N'Dell', N'Dell là thương hiệu máy tính cá nhân và doanh nghiệp uy tín, cung cấp các giải pháp công nghệ cho thị trường toàn cầu.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Dell_Logo.svg/768px-Dell_Logo.svg.png', CAST(N'2025-04-16T10:06:21.013' AS DateTime), CAST(N'2025-04-16T10:06:21.013' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (9, N'Blackberry', N'BlackBerry là một tập đoàn điện tử của Canada chuyên sản xuất, buôn bán các thiết bị di động và giải pháp di động như mẫu điện thoại ăn khách BlackBerry.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Blackberry_Logo.svg/2560px-Blackberry_Logo.svg.png', CAST(N'2025-04-20T17:29:05.873' AS DateTime), CAST(N'2025-04-20T17:29:05.873' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (10, N'Asus', N'AsusTek Computer Inc. là một tập đoàn đa quốc gia có trụ sở chính tại Đài Loan, chuyên sản xuất các mặt hàng điện tử và phần cứng máy tính.', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoa0krfGk78ZWw8Vn-UDhqgBd0Lc8okgAT_aCS9KXlfKQuWLQ9PMPu8em9K198R83UTg&usqp=CAU', CAST(N'2025-04-20T17:30:53.320' AS DateTime), CAST(N'2025-04-20T17:30:53.320' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (11, N'Acer', N'Acer là tập đoàn đa quốc gia về thiết bị điện tử và phần cứng máy tính của Đài Loan', N'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Acer_2011.svg/1024px-Acer_2011.svg.png', CAST(N'2025-04-20T17:31:01.227' AS DateTime), CAST(N'2025-04-20T17:31:01.227' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (12, N'Huawei', N'Huawei, tên đầy đủ là Công ty trách nhiệm hữu hạn kỹ thuật Hoa Vi là một tập đoàn đa quốc gia về thiết bị mạng và viễn thông, có trụ sở chính tại Thâm Quyến, Quảng Đông, Trung Quốc.', N'https://upload.wikimedia.org/wikipedia/en/thumb/0/04/Huawei_Standard_logo.svg/1200px-Huawei_Standard_logo.svg.png', CAST(N'2025-04-20T18:46:58.437' AS DateTime), CAST(N'2025-04-20T18:46:58.437' AS DateTime))
GO
INSERT [dbo].[Brands] ([brand_id], [brand_name], [description], [logo_url], [created_at], [updated_at]) VALUES (13, N'Xiaomi', N'Xiaomi Inc. là một Tập đoàn sản xuất hàng điện tử Trung Quốc có trụ sở tại Thâm Quyến.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Xiaomi_logo_%282021-%29.svg/1024px-Xiaomi_logo_%282021-%29.svg.png', CAST(N'2025-04-20T18:47:13.300' AS DateTime), CAST(N'2025-04-20T18:47:13.300' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Brands] OFF
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (1, N'Computer', N'Là một thiết bị điện tử có khả năng xử lý, lưu trữ và hiển thị thông tin', CAST(N'2025-04-16T06:40:28.980' AS DateTime), CAST(N'2025-04-16T06:40:28.980' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (2, N'Smart Phone', N'Điện thoại thông minh là một thiết bị di động tích hợp nhiều tính năng như gọi điện, nhắn tin, duyệt web, và chạy các ứng dụng.', CAST(N'2025-04-16T06:41:55.090' AS DateTime), CAST(N'2025-04-16T06:41:55.090' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (3, N'Smart Watch', N'Đồng hồ thông minh là một thiết bị đeo tay có thể kết nối với điện thoại thông minh để hiển thị thông báo, theo dõi sức khỏe, và hỗ trợ các tính năng như đo nhịp tim, đếm bước chân, và theo dõi giấc ngủ.', CAST(N'2025-04-16T06:43:07.907' AS DateTime), CAST(N'2025-04-16T06:43:07.907' AS DateTime))
GO
INSERT [dbo].[Categories] ([category_id], [category_name], [description], [created_at], [updated_at]) VALUES (4, N'Talbet', N'Máy tính bảng là một thiết bị điện tử di động có màn hình cảm ứng lớn, thường được sử dụng để đọc sách, xem video, duyệt web, và chơi game', CAST(N'2025-04-16T06:44:27.460' AS DateTime), CAST(N'2025-04-16T06:44:27.460' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoryPost] ON 
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (1, N'Tin Tức Công Nghệ', N'Cập nhật những tin tức mới nhất về thị trường máy tính, laptop và điện thoại.', CAST(N'2025-04-21T14:39:11.497' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (2, N'Đánh Giá Laptop', N'Các bài đánh giá chi tiết về các mẫu laptop mới, so sánh hiệu năng và tính năng.', CAST(N'2025-04-21T14:47:13.210' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (3, N'Thủ Thuật Laptop', N'Hướng dẫn sử dụng, tối ưu hóa và khắc phục các sự cố thường gặp trên laptop.', CAST(N'2025-04-21T14:47:18.017' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (4, N'Đánh Giá Điện Thoại', N'Review các dòng điện thoại thông minh, từ cao cấp đến tầm trung và giá rẻ.
', CAST(N'2025-04-21T14:48:21.790' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (5, N'Thủ Thuật Điện Thoại', N'Mẹo sử dụng, tùy chỉnh và khám phá các tính năng ẩn trên điện thoại.
', CAST(N'2025-04-21T14:48:29.700' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (6, N'Tư Vấn Mua Hàng', N'Lời khuyên và gợi ý lựa chọn Sản phẩm phù hợp với nhu cầu và ngân sách.
', CAST(N'2025-04-21T14:48:51.043' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (7, N'Phụ Kiện', N'Giới thiệu các loại phụ kiện hữu ích và cần thiết cho laptop và điện thoại.', CAST(N'2025-04-21T14:48:57.733' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (8, N'Thủ thuật Máy tính', N'Hướng dẫn sử dụng, tối ưu hóa và khắc phục các sự cố thường gặp trên máy tính.', CAST(N'2025-04-21T14:49:07.917' AS DateTime), NULL, 1)
GO
INSERT [dbo].[CategoryPost] ([category_id], [category_name], [description], [created_at], [updated_at], [is_active]) VALUES (9, N'Đánh giá Máy tính', N'Các bài đánh giá chi tiết về các mẫu máy tính mới, so sánh hiệu năng và tính năng.', CAST(N'2025-04-21T14:49:22.363' AS DateTime), NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[CategoryPost] OFF
GO
SET IDENTITY_INSERT [dbo].[ColorOptions] ON 
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (8, N'Bạc')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (9, N'Đen')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (11, N'Đỏ')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (5, N'Hồng')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (10, N'Nâu')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (12, N'Tím')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (1, N'Trắng')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (6, N'Vàng')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (7, N'Vàng Kim')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (3, N'Xanh da trời')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (2, N'Xanh Dương')
GO
INSERT [dbo].[ColorOptions] ([color_id], [color]) VALUES (4, N'Xanh lá mạ')
GO
SET IDENTITY_INSERT [dbo].[ColorOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[CpuOptions] ON 
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (8, N'AMD Ryzen')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (12, N'Apple A-series')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (9, N'Apple M1')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (11, N'Apple M1 Max')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (10, N'Apple M1 Pro')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (16, N'Exynos')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (18, N'Exynos W-series')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (1, N'Intel Core i3')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (2, N'Intel Core i5')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (3, N'Intel Core i7')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (4, N'Intel Core i9')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (5, N'Intel Core m3')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (6, N'Intel Core m5')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (7, N'Intel Core m7')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (15, N'Snapdragon 6 series')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (14, N'Snapdragon 7 series')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (13, N'Snapdragon 8 series')
GO
INSERT [dbo].[CpuOptions] ([cpu_id], [cpu]) VALUES (17, N'Snapdragon Wear:')
GO
SET IDENTITY_INSERT [dbo].[CpuOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([order_id], [user_id], [order_status], [total_amount], [created_at], [updated_at]) VALUES (1, 2, N'pending', CAST(10.00 AS Decimal(18, 2)), CAST(N'2025-04-21T13:52:13.337' AS DateTime), CAST(N'2025-04-21T13:52:13.337' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Post] ON 
GO
INSERT [dbo].[Post] ([post_id], [title], [content], [thumbnail_url], [user_id], [category_id], [status], [created_at]) VALUES (1, N'Bài Post đầu tiên', N'<h2>Hello&nbsp;</h2><p>Xin chào mọi người</p>', N'uploads/posts/1745221886446_morse.png', 1, 1, N'1', CAST(N'2025-04-21T14:51:26.473' AS DateTime))
GO
INSERT [dbo].[Post] ([post_id], [title], [content], [thumbnail_url], [user_id], [category_id], [status], [created_at]) VALUES (2, N'Đánh giá Laptop Lenovo', N'<p>Chất lượng: 10/10</p><p>Không có nhưng</p>', N'uploads/posts/1745222245855_lenovopost.jpg', 1, 2, N'1', CAST(N'2025-04-21T14:57:25.883' AS DateTime))
GO
INSERT [dbo].[Post] ([post_id], [title], [content], [thumbnail_url], [user_id], [category_id], [status], [created_at]) VALUES (3, N'Hưỡng dẫn tối ưu hiệu năng Samsung galaxy S5', N'<h2>Đừng hỏi đây là 1 bài post</h2><p><a href="https://www.youtube.com/watch?v=Ro_idLCRq6s">https://www.youtube.com/watch?v=Ro_idLCRq6s</a></p>', N'uploads/posts/1745222341678_samsunggalaxys5.jpg', 1, 5, N'0', CAST(N'2025-04-21T14:59:01.703' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductMedia] ON 
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (1, 1, N'https://bizweb.dktcdn.net/thumb/grande/100/512/769/products/ideapad-pro-5-16irh8-ct1-02-copy-eb2c7ef1-1e2c-440f-9ecb-301aa162defa.jpg?v=1714379207693', N'image', 1, CAST(N'2025-04-16T10:59:04.553' AS DateTime), CAST(N'2025-04-16T10:59:04.553' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (2, 1, N'https://youtu.be/DeWeYEW79OM', N'video', 0, CAST(N'2025-04-16T10:59:04.553' AS DateTime), CAST(N'2025-04-16T10:59:04.553' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (3, 1, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-jUL3Pd3BnIEY7QONyhpYRiF5Ys6IcSNw3BVQEKIT3HI90TIbnB_cVL3rQgIKdYbKK-w&usqp=CAU', N'image', 0, CAST(N'2025-04-16T10:59:04.553' AS DateTime), CAST(N'2025-04-16T10:59:04.553' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (4, 1, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9C1q4AF1rPg9AFY1P5ZyfJfaKZnKrQny9Q4Z8epmevVHwlL_Th2gjdt_UtlkxnX-BcOw&usqp=CAU', N'image', 0, CAST(N'2025-04-16T10:59:04.553' AS DateTime), CAST(N'2025-04-16T10:59:04.553' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (5, 1, N'https://rodelag.com/cdn/shop/files/PS0010682_6.png?v=1708725266', N'image', 0, CAST(N'2025-04-16T10:59:04.553' AS DateTime), CAST(N'2025-04-16T10:59:04.553' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (6, 2, N'https://product.hstatic.net/1000359786/product/iphone-16-pro-finish-select-202409-6-9inch_9b775ca8ac634d6587360f54b909ecfd_master.jpg', N'image', 1, CAST(N'2025-04-16T11:00:52.190' AS DateTime), CAST(N'2025-04-16T11:00:52.190' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (7, 2, N'https://youtu.be/r1w2pC8p04U', N'video', 0, CAST(N'2025-04-16T11:00:52.190' AS DateTime), CAST(N'2025-04-16T11:00:52.190' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (8, 2, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSWt0evSIXri-g0QRpg3U3yvoFgE90QsGZHSJrbgNYGz2oJ8C691LdT61swVpPWGEHEWU&usqp=CAU', N'image', 0, CAST(N'2025-04-16T11:00:52.190' AS DateTime), CAST(N'2025-04-16T11:00:52.190' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (9, 2, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkE4xNJJC-_1VAIPWE8QcBXQTIWoivFdMTIchIr5uvZ44IE6Pa1YLhj4LmcQg9-73K2RQ&usqp=CAU', N'image', 0, CAST(N'2025-04-16T11:00:52.190' AS DateTime), CAST(N'2025-04-16T11:00:52.190' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (10, 2, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1P7ac40fa2uA4CZx2LWFSbGVMrRBurIlc0teWZtnYjmAtilDqQSpI2VsJHKBdTllKJD8&usqp=CAU', N'image', 0, CAST(N'2025-04-16T11:00:52.190' AS DateTime), CAST(N'2025-04-16T11:00:52.190' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (11, 3, N'https://www.didongmy.com/vnt_upload/product/08_2024/thumbs/(600x600)_google_pixel_watch_3_black_didongmy_thumb_600x600_1.jpg', N'image', 0, CAST(N'2025-04-16T11:02:24.067' AS DateTime), CAST(N'2025-04-16T11:02:24.067' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (12, 3, N'https://youtu.be/3wGPJaZ17aw', N'video', 0, CAST(N'2025-04-16T11:02:24.067' AS DateTime), CAST(N'2025-04-16T11:02:24.067' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (13, 3, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf5O8eamjQ2UqKSZsaVDCO9PQRdU5doLpF5syxqXpq0ejMwJERDjex9-gYev-Skrnw_Pk&usqp=CAU', N'image', 0, CAST(N'2025-04-16T11:02:24.067' AS DateTime), CAST(N'2025-04-16T11:02:24.067' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (14, 3, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQewZ-HNjmzndMGR6CL__IL68Qs_KK-U2r8Qn0dKUlVaFxn6_WrMvkfEYYqKW6w6QFqDI0&usqp=CAU', N'image', 0, CAST(N'2025-04-16T11:02:24.067' AS DateTime), CAST(N'2025-04-16T11:02:24.067' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (16, 4, N'https://images.samsung.com/is/image/samsung/p6pim/vn/sm-x716bzaexxv/gallery/vn-galaxy-tab-s9-5g-x716-sm-x716bzaexxv-537885551?$684_547_PNG$', N'image', 1, CAST(N'2025-04-16T11:04:01.377' AS DateTime), CAST(N'2025-04-16T11:04:01.377' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (17, 4, N'https://youtu.be/uTosTb5TbDk', N'video', 0, CAST(N'2025-04-16T11:04:01.377' AS DateTime), CAST(N'2025-04-16T11:04:01.377' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (18, 4, N'https://www.abshop.in.th/wp-content/uploads/2024/05/Galaxy-Tab-S9-Graphite-01-1.jpg', N'image', 0, CAST(N'2025-04-16T11:04:01.377' AS DateTime), CAST(N'2025-04-16T11:04:01.377' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (19, 4, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_tsW5xYxs_saFBfy6dV4AKnEmGUHTpTG1qC0KKtXXcsIAAOEVbdGuit0bkQKiBZT3oxA&usqp=CAU', N'image', 0, CAST(N'2025-04-16T11:04:01.377' AS DateTime), CAST(N'2025-04-16T11:04:01.377' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (20, 4, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_HV0Tdrv1Hwjmo7Qkmr0p8S6taAwdp0xMlw&s', N'image', 0, CAST(N'2025-04-16T11:04:01.377' AS DateTime), CAST(N'2025-04-16T11:04:01.377' AS DateTime))
GO
INSERT [dbo].[ProductMedia] ([media_id], [product_id], [media_url], [media_type], [is_primary], [created_at], [updated_at]) VALUES (21, 3, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStwj0c4Dq2IIiy2xoQ9RKo1CsEwhBTUgjziB2tePTVQxceRQR8cGc09W41PdcRwwc8lXQ&usqp=CAU', N'image', 1, CAST(N'2025-04-23T06:32:34.440' AS DateTime), CAST(N'2025-04-23T06:32:34.440' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[ProductMedia] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([product_id], [product_name], [brand_id], [category_id], [description], [created_at], [updated_at]) VALUES (1, N'Laptop Lenovo XYZ', 5, 1, N'Laptop với các phiên bản: CPU i5 & i7, RAM 8GB & 16GB, màn hình 1920 x 1080', CAST(N'2025-04-16T10:22:13.183' AS DateTime), CAST(N'2025-04-16T10:22:13.183' AS DateTime))
GO
INSERT [dbo].[Products] ([product_id], [product_name], [brand_id], [category_id], [description], [created_at], [updated_at]) VALUES (2, N'Iphone 16 Pro Max', 1, 2, N'Iphone 16 Pro Max với các phiên bản: CPU M1, RAM 8GB & 4GB, màn hình 6.9 inch, 128GB và nhiều hơn', CAST(N'2025-04-16T10:42:28.463' AS DateTime), CAST(N'2025-04-16T10:42:28.463' AS DateTime))
GO
INSERT [dbo].[Products] ([product_id], [product_name], [brand_id], [category_id], [description], [created_at], [updated_at]) VALUES (3, N'Google Smart Watch', 4, 3, N'Google Smart Watch tích hợp theo dõi sức khỏe, đo nhịp tim, và thông báo từ smartphone.', CAST(N'2025-04-16T10:45:42.597' AS DateTime), CAST(N'2025-04-16T10:45:42.597' AS DateTime))
GO
INSERT [dbo].[Products] ([product_id], [product_name], [brand_id], [category_id], [description], [created_at], [updated_at]) VALUES (4, N'Samsung Talbet', 2, 4, N'Samsung Tablet với màn hình độ phân giải cao, thích hợp cho giải trí và công việc.', CAST(N'2025-04-16T10:47:20.467' AS DateTime), CAST(N'2025-04-16T10:47:20.467' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductVariants] ON 
GO
INSERT [dbo].[ProductVariants] ([variant_id], [product_id], [price], [stock_quantity], [created_at], [updated_at], [cpu_id], [ram_id], [screen_id], [storage_id], [color_id]) VALUES (1, 1, CAST(18999000.00 AS Decimal(18, 2)), 200, CAST(N'2025-04-23T07:40:37.807' AS DateTime), CAST(N'2025-04-23T07:40:37.807' AS DateTime), 8, 5, 2, 5, 1)
GO
INSERT [dbo].[ProductVariants] ([variant_id], [product_id], [price], [stock_quantity], [created_at], [updated_at], [cpu_id], [ram_id], [screen_id], [storage_id], [color_id]) VALUES (2, 1, CAST(18499000.00 AS Decimal(18, 2)), 300, CAST(N'2025-04-23T07:41:28.220' AS DateTime), CAST(N'2025-04-23T07:41:28.220' AS DateTime), 3, 5, 2, 5, 1)
GO
SET IDENTITY_INSERT [dbo].[ProductVariants] OFF
GO
SET IDENTITY_INSERT [dbo].[RamOptions] ON 
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (5, N'16GB')
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (1, N'1GB')
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (2, N'2GB')
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (6, N'32GB')
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (3, N'4GB')
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (7, N'512MB')
GO
INSERT [dbo].[RamOptions] ([ram_id], [ram]) VALUES (4, N'8GB')
GO
SET IDENTITY_INSERT [dbo].[RamOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (1, N'admin', N'Quy?n qu?n tr? toàn h? th?ng', CAST(N'2025-04-15T22:43:00.293' AS DateTime), CAST(N'2025-04-15T22:43:00.293' AS DateTime))
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (2, N'marketing', N'Quy?n qu?n lý các chi?n d?ch marketing và các n?i dung qu?ng cáo', CAST(N'2025-04-15T22:43:00.293' AS DateTime), CAST(N'2025-04-15T22:43:00.293' AS DateTime))
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (3, N'customer', N'Quy?n c?a khách hàng truy c?p và mua s?m', CAST(N'2025-04-15T22:43:00.293' AS DateTime), CAST(N'2025-04-15T22:43:00.293' AS DateTime))
GO
INSERT [dbo].[Roles] ([role_id], [role_name], [description], [created_at], [updated_at]) VALUES (4, N'Ship', N'La cho shipper', CAST(N'2025-04-17T14:56:41.637' AS DateTime), CAST(N'2025-04-17T14:56:41.637' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[ScreenOptions] ON 
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (3, N'2K 2560 x 1440')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (4, N'4K 3840 x 2160')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (5, N'5 inch')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (6, N'5,5 inch')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (7, N'6 inch')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (8, N'6.5 inch')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (9, N'6.9 inch')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (10, N'7 inch')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (2, N'FULL HD 1920 x 1080')
GO
INSERT [dbo].[ScreenOptions] ([screen_id], [screen]) VALUES (1, N'HD 1366 x 768')
GO
SET IDENTITY_INSERT [dbo].[ScreenOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[Shipping] ON 
GO
INSERT [dbo].[Shipping] ([shipping_id], [order_id], [shipping_address], [shipping_status], [tracking_number], [shipping_date], [estimated_delivery], [delivery_notes], [updated_at], [shipperId]) VALUES (1, 1, N'Ha Noi', N'Delivered', N'10', CAST(N'2025-04-18T00:00:00.000' AS DateTime), CAST(N'2025-04-30T00:00:00.000' AS DateTime), N'oke', CAST(N'2025-04-21T13:58:16.593' AS DateTime), 5)
GO
INSERT [dbo].[Shipping] ([shipping_id], [order_id], [shipping_address], [shipping_status], [tracking_number], [shipping_date], [estimated_delivery], [delivery_notes], [updated_at], [shipperId]) VALUES (2, 1, N'ThaiBinh', N'Pending', N'10', CAST(N'2025-04-22T00:00:00.000' AS DateTime), CAST(N'2025-04-30T00:00:00.000' AS DateTime), N'oke', CAST(N'2025-04-21T00:00:00.000' AS DateTime), 5)
GO
SET IDENTITY_INSERT [dbo].[Shipping] OFF
GO
SET IDENTITY_INSERT [dbo].[StorageOptions] ON 
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (3, N'128GB')
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (6, N'1TB')
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (4, N'256GB')
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (7, N'2TB')
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (1, N'32GB')
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (5, N'500GB')
GO
INSERT [dbo].[StorageOptions] ([storage_id], [storage]) VALUES (2, N'64GB')
GO
SET IDENTITY_INSERT [dbo].[StorageOptions] OFF
GO
SET IDENTITY_INSERT [dbo].[SubCategories] ON 
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (1, N'Pc Window', 1, N'Máy tính PC chạy hệ điều hành Windows là một trong những hệ điều hành phổ biến nhất trên thế giới, đặc biệt trong môi trường làm việc và học tập.', CAST(N'2025-04-16T06:40:28.990' AS DateTime), CAST(N'2025-04-16T06:40:28.990' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (2, N'Laptop', 1, N'Laptop là một loại máy tính xách tay, nhỏ gọn và di động, được trang bị đầy đủ các tính năng của một máy tính để bàn.', CAST(N'2025-04-16T06:40:28.990' AS DateTime), CAST(N'2025-04-16T06:40:28.990' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (3, N'Macbook', 1, N'MacBook là dòng laptop của Apple, nổi bật với thiết kế mỏng nhẹ và tính năng bảo mật cao.', CAST(N'2025-04-16T06:40:28.990' AS DateTime), CAST(N'2025-04-16T06:40:28.990' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (4, N'Android', 2, N'Điện thoại chạy hệ điều hành Android (do Google phát triển) là một trong hai hệ điều hành di động phổ biến nhất trên thế giới.', CAST(N'2025-04-16T06:41:55.093' AS DateTime), CAST(N'2025-04-16T06:41:55.093' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (5, N'Iphone', 2, N'Điện thoại của Apple chạy hệ điều hành iOS. iPhone nổi bật với thiết kế tinh tế, chất lượng build cao, và tính bảo mật mạnh mẽ.', CAST(N'2025-04-16T06:41:55.093' AS DateTime), CAST(N'2025-04-16T06:41:55.093' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (6, N'Cuc gach', 2, N'Đây là những điện thoại cơ bản chỉ phục vụ chức năng gọi điện và nhắn tin.', CAST(N'2025-04-16T06:41:55.093' AS DateTime), CAST(N'2025-04-16T06:41:55.093' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (7, N'Android', 4, N'Máy tính bảng chạy hệ điều hành Android có màn hình cảm ứng lớn, phù hợp cho việc lướt web, xem video, và làm việc.', CAST(N'2025-04-16T06:44:53.530' AS DateTime), CAST(N'2025-04-16T06:44:53.530' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (8, N'IOS Pad', 4, N' iPad là dòng máy tính bảng của Apple, chạy hệ điều hành iPadOS (phát triển từ iOS).', CAST(N'2025-04-16T06:44:53.530' AS DateTime), CAST(N'2025-04-16T06:44:53.530' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (9, N'WatchOS', 3, N'Đây là hệ điều hành của Apple dành cho các đồng hồ thông minh như Apple Watch.', CAST(N'2025-04-16T09:18:40.020' AS DateTime), CAST(N'2025-04-16T09:18:40.020' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (10, N'WearOS', 3, N'WearOS là hệ điều hành dành cho đồng hồ thông minh do Google phát triển.', CAST(N'2025-04-16T09:18:40.020' AS DateTime), CAST(N'2025-04-16T09:18:40.020' AS DateTime))
GO
INSERT [dbo].[SubCategories] ([subcategory_id], [subcategory_name], [category_id], [description], [created_at], [updated_at]) VALUES (11, N'Tizen', 3, N'Tizen là hệ điều hành được phát triển bởi Samsung, chủ yếu sử dụng trên các đồng hồ thông minh của hãng này, như Galaxy Watch.', CAST(N'2025-04-16T09:18:40.020' AS DateTime), CAST(N'2025-04-16T09:18:40.020' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[SubCategories] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([user_id], [email], [full_name], [Gender], [avatar_url], [phone_number], [address], [role_id], [created_at], [updated_at], [is_active], [password_hash], [is_verified], [reset_token], [reset_token_expiry], [last_login]) VALUES (1, N'bardok@gmail.com', N'Bardok Monkey', N'Male', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUXcqu9fIJTDQIzZ3Mhbz2KKF2L94UZsrUnkWnvfsxhv8mGOFcDou_32Q_VFGa9NDzFQ8&usqp=CAU', N'0885559635', N'Saiyan', 1, CAST(N'2025-04-19T07:10:56.650' AS DateTime), CAST(N'2025-04-19T19:52:18.610' AS DateTime), 1, N'$2a$12$vg2q8NYzxQg0PU.q20EmZe6B5ECKKy1ofc3vUYGr4k2HmQEIv59FC', 1, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([user_id], [email], [full_name], [Gender], [avatar_url], [phone_number], [address], [role_id], [created_at], [updated_at], [is_active], [password_hash], [is_verified], [reset_token], [reset_token_expiry], [last_login]) VALUES (2, N'naruto@gmail.com', N'Naruto Uzumaki', N'Male', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_-lUcUOZyn-VWRQCMo0S4FYEwX1ORWvH53FSJlc2V9Twuxy2dewa7TjmlSDj7KwMXfao&usqp=CAU', N'0885559635', N'Lang La', 2, CAST(N'2025-04-20T13:09:23.537' AS DateTime), CAST(N'2025-04-20T13:09:23.630' AS DateTime), 1, N'$2a$12$vg2q8NYzxQg0PU.q20EmZe6B5ECKKy1ofc3vUYGr4k2HmQEIv59FC', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([user_id], [email], [full_name], [Gender], [avatar_url], [phone_number], [address], [role_id], [created_at], [updated_at], [is_active], [password_hash], [is_verified], [reset_token], [reset_token_expiry], [last_login]) VALUES (3, N'kakalot@gmail.com', N'Son goku', N'Male', NULL, N'0456789153', N'Kame island', 3, CAST(N'2025-04-20T13:09:23.537' AS DateTime), CAST(N'2025-04-20T13:09:23.630' AS DateTime), 1, N'$2a$12$vg2q8NYzxQg0PU.q20EmZe6B5ECKKy1ofc3vUYGr4k2HmQEIv59FC', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([user_id], [email], [full_name], [Gender], [avatar_url], [phone_number], [address], [role_id], [created_at], [updated_at], [is_active], [password_hash], [is_verified], [reset_token], [reset_token_expiry], [last_login]) VALUES (4, N'Customer@gmail.com', N'Customer', N'Male', NULL, N'0123456788', N'Customer', 1, CAST(N'2025-04-21T13:29:13.127' AS DateTime), CAST(N'2025-04-21T13:29:13.153' AS DateTime), 1, N'$2a$12$vg2q8NYzxQg0PU.q20EmZe6B5ECKKy1ofc3vUYGr4k2HmQEIv59FC', 0, NULL, NULL, NULL)
GO
INSERT [dbo].[Users] ([user_id], [email], [full_name], [Gender], [avatar_url], [phone_number], [address], [role_id], [created_at], [updated_at], [is_active], [password_hash], [is_verified], [reset_token], [reset_token_expiry], [last_login]) VALUES (5, N'customer2@gmail.com', N'Customer2', N'Male', NULL, N'0123456789', N'Ha Noi', 4, CAST(N'2025-04-21T13:44:02.027' AS DateTime), CAST(N'2025-04-21T13:44:02.033' AS DateTime), 1, N'$2a$12$vg2q8NYzxQg0PU.q20EmZe6B5ECKKy1ofc3vUYGr4k2HmQEIv59FC', 0, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ColorOpt__900DC6E96925CF84]    Script Date: 4/23/2025 7:47:02 AM ******/
ALTER TABLE [dbo].[ColorOptions] ADD UNIQUE NONCLUSTERED 
(
	[color] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CpuOptio__D836E708C2AFD02D]    Script Date: 4/23/2025 7:47:02 AM ******/
ALTER TABLE [dbo].[CpuOptions] ADD UNIQUE NONCLUSTERED 
(
	[cpu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__RamOptio__C2B02CE4ED9D2CC0]    Script Date: 4/23/2025 7:47:02 AM ******/
ALTER TABLE [dbo].[RamOptions] ADD UNIQUE NONCLUSTERED 
(
	[ram] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__ScreenOp__CAA5D583E962D6D0]    Script Date: 4/23/2025 7:47:02 AM ******/
ALTER TABLE [dbo].[ScreenOptions] ADD UNIQUE NONCLUSTERED 
(
	[screen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__StorageO__156FD1D1CF699182]    Script Date: 4/23/2025 7:47:02 AM ******/
ALTER TABLE [dbo].[StorageOptions] ADD UNIQUE NONCLUSTERED 
(
	[storage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E61648B2D28B2]    Script Date: 4/23/2025 7:47:02 AM ******/
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
ALTER TABLE [dbo].[CategoryPost] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[CategoryPost] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[Feedbacks] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [payment_date]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT ('Draft') FOR [status]
GO
ALTER TABLE [dbo].[Post] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ProductMedia] ADD  DEFAULT ((0)) FOR [is_primary]
GO
ALTER TABLE [dbo].[ProductMedia] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ProductMedia] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[ProductVariants] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[SubCategories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[SubCategories] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [is_active]
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
ALTER TABLE [dbo].[FeedbackImages]  WITH CHECK ADD  CONSTRAINT [FK_FeedbackImages_Reviews] FOREIGN KEY([review_id])
REFERENCES [dbo].[Reviews] ([review_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FeedbackImages] CHECK CONSTRAINT [FK_FeedbackImages_Reviews]
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
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_Category] FOREIGN KEY([category_id])
REFERENCES [dbo].[CategoryPost] ([category_id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_Category]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [FK_Post_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [FK_Post_User]
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
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_PV_ColorOptions] FOREIGN KEY([color_id])
REFERENCES [dbo].[ColorOptions] ([color_id])
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_PV_ColorOptions]
GO
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_PV_CpuOptions] FOREIGN KEY([cpu_id])
REFERENCES [dbo].[CpuOptions] ([cpu_id])
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_PV_CpuOptions]
GO
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_PV_RamOptions] FOREIGN KEY([ram_id])
REFERENCES [dbo].[RamOptions] ([ram_id])
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_PV_RamOptions]
GO
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_PV_ScreenOptions] FOREIGN KEY([screen_id])
REFERENCES [dbo].[ScreenOptions] ([screen_id])
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_PV_ScreenOptions]
GO
ALTER TABLE [dbo].[ProductVariants]  WITH CHECK ADD  CONSTRAINT [FK_PV_StorageOptions] FOREIGN KEY([storage_id])
REFERENCES [dbo].[StorageOptions] ([storage_id])
GO
ALTER TABLE [dbo].[ProductVariants] CHECK CONSTRAINT [FK_PV_StorageOptions]
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
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
ALTER TABLE [dbo].[Shipping]  WITH CHECK ADD  CONSTRAINT [fk_shipping_shipper] FOREIGN KEY([shipperId])
REFERENCES [dbo].[Users] ([user_id])
GO
ALTER TABLE [dbo].[Shipping] CHECK CONSTRAINT [fk_shipping_shipper]
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
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[Shipping]  WITH CHECK ADD CHECK  (([shipping_status]='Returned' OR [shipping_status]='Canceled' OR [shipping_status]='Delivered' OR [shipping_status]='Shipped' OR [shipping_status]='Pending'))
GO
USE [master]
GO
ALTER DATABASE [swp391_spring2025_bl5] SET  READ_WRITE 
GO
