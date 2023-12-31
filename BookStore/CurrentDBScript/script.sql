USE [master]
GO
/****** Object:  Database [BookStore-25-2-2023_Delta]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE DATABASE [BookStore-25-2-2023_Delta]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStore-25-2-2023_Delta', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BookStore-25-2-2023_Delta.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStore-25-2-2023_Delta_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BookStore-25-2-2023_Delta_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStore-25-2-2023_Delta].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET  MULTI_USER 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET QUERY_STORE = ON
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BookStore-25-2-2023_Delta]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[City] [nvarchar](max) NULL,
	[Discriminator] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[PostalCode] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[StreetAddress] [nvarchar](max) NULL,
	[CompanyId] [int] NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[DisplayOrder] [int] NOT NULL,
	[CreateDateTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[StreetAddress] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[PostalCode] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoverTypes]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoverTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CoverTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[ISBN] [nvarchar](max) NOT NULL,
	[Author] [nvarchar](max) NOT NULL,
	[ListPrice] [float] NOT NULL,
	[Price] [float] NOT NULL,
	[Price50] [float] NOT NULL,
	[Price100] [float] NOT NULL,
	[ImageUrl] [nvarchar](max) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[CoverTypeID] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ShoppingCarts]    Script Date: 7/24/2023 2:50:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShoppingCarts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[ApplicationUserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_ShoppingCarts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230612183446_Add Category to Database', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230612200211_Description column added to categories table', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230612200556_Description column removed from categories table', N'7.0.5')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230621182817_Add CoverType To Db', N'7.0.7')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230621202632_Add Product To Db', N'7.0.7')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230715142247_AddIdentityToDb', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230715144520_extendIdentityUser', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230715145949_addCompanyToDb', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230718095520_addCompanyIdToUser', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230719072838_addShoppingCartToDb', N'7.0.9')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20230719100742_AddingApplicationUserIdColumnToShoppingCart', N'7.0.9')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'4aca584f-9be2-4d8d-96f7-ba0f119845e9', N'Individual', N'INDIVIDUAL', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'55b1fedf-e5c3-4183-b21c-32b6ce3cde16', N'Company', N'COMPANY', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'88bcacec-2145-462f-bd36-c97411b89a62', N'Admin', N'ADMIN', NULL)
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'f0377dcb-2553-47c2-86d0-5faf7fabb7da', N'Employee', N'EMPLOYEE', NULL)
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'155eceab-0794-4e16-8686-716eb68a859f', N'4aca584f-9be2-4d8d-96f7-ba0f119845e9')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'9573fbf4-e2ce-4c2b-8376-afd013f243dd', N'55b1fedf-e5c3-4183-b21c-32b6ce3cde16')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'98aa46f5-76c7-4de7-8376-f49ea4071a0d', N'88bcacec-2145-462f-bd36-c97411b89a62')
GO
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [City], [Discriminator], [Name], [PostalCode], [State], [StreetAddress], [CompanyId]) VALUES (N'0ae03384-8f99-49dd-b910-9850765d9ab5', N'test1@bookstore.com', N'TEST1@BOOKSTORE.COM', N'test1@bookstore.com', N'TEST1@BOOKSTORE.COM', 0, N'AQAAAAIAAYagAAAAEHcPrJBeQ8TmNUFcpfnD6nHk43XVPeC2AgVyva9avT/+0mYc5IvoI2mh2JbRUgAFqA==', N'GGK2PJUTMFALZG2PFC6DWQ74MVF3JAIG', N'8a7ca657-7e69-4dcb-914e-8eda338286f5', NULL, 0, 0, NULL, 1, 0, NULL, N'IdentityUser', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [City], [Discriminator], [Name], [PostalCode], [State], [StreetAddress], [CompanyId]) VALUES (N'155eceab-0794-4e16-8686-716eb68a859f', N'customer@bookstore.com', N'CUSTOMER@BOOKSTORE.COM', N'customer@bookstore.com', N'CUSTOMER@BOOKSTORE.COM', 0, N'AQAAAAIAAYagAAAAEJYt7WVBK/mFHHC5BaO/TvVySWMKLDh56+jwh7Hu7ZTPYHXIaWCzy81WwIgWHxm0uw==', N'2WUSROLUGAW7JEDMTFNTLDFMNOQ42UZN', N'ef90a64e-bff5-407e-9a4d-e7c24514103c', N'230489209', 0, 0, NULL, 1, 0, N'New York', N'ApplicationUser', N'Custoemr Sparky', N'23902', N'NY', N'123 Wells St.', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [City], [Discriminator], [Name], [PostalCode], [State], [StreetAddress], [CompanyId]) VALUES (N'9573fbf4-e2ce-4c2b-8376-afd013f243dd', N'companyuser@bookstore.com', N'COMPANYUSER@BOOKSTORE.COM', N'companyuser@bookstore.com', N'COMPANYUSER@BOOKSTORE.COM', 0, N'AQAAAAIAAYagAAAAEFlZwmdYfdhVuqQeHUyf+guzCdFIQTEhfMEnYSr0mU5nSSx/LudJK3/komqQIC6y1g==', N'TRBJNSLY5FNOF54BINH3WYD73EPRWRFX', N'e62e8a15-65de-4be6-bf82-3edc8bc53416', N'0230489209', 0, 0, NULL, 1, 0, N'New York', N'ApplicationUser', N'Custoemr Sparky', N'23902', N'NY', N'123 Wells St.', 1)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [City], [Discriminator], [Name], [PostalCode], [State], [StreetAddress], [CompanyId]) VALUES (N'98aa46f5-76c7-4de7-8376-f49ea4071a0d', N'admin@bookstore.com', N'ADMIN@BOOKSTORE.COM', N'admin@bookstore.com', N'ADMIN@BOOKSTORE.COM', 0, N'AQAAAAIAAYagAAAAELCFOS3Ybb5A0dQrKW+VFdxagR/WHTmlznysmrxHwO42x1LK0uTRouXF8As8FOQh/A==', N'WH3RPMM5RX73V7R3JSFAT5UM44CQNVMT', N'b4679161-aeca-4350-9b3d-85482f7b0907', N'01227095997', 0, 0, NULL, 1, 0, N'Giza', N'ApplicationUser', N'Tarek Mamdouh', N'11511', N'Giza', N'2 Mamdouh Mostafa St. tawabeq Fiesal', NULL)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount], [City], [Discriminator], [Name], [PostalCode], [State], [StreetAddress], [CompanyId]) VALUES (N'fcee9884-5afd-408b-9d89-48c78d34ddd9', N'test@bookstore.com', N'TEST@BOOKSTORE.COM', N'test@bookstore.com', N'TEST@BOOKSTORE.COM', 0, N'AQAAAAIAAYagAAAAEJeAHWFSMgOU3dMSCQ5lTvyADR3x4UfVdzuwcX4ipkN9WGXsMUUvwQT5R6yjasly9w==', N'KEUREHIMJIAA2HT3L7RX6LQPAZ4O5N6U', N'37ae8256-a4f5-43f3-af01-461cda2282be', N'0678677767676', 0, 0, NULL, 1, 0, NULL, N'IdentityUser', NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (10, N'Light Stories', 12, CAST(N'2023-06-17T23:02:40.4883551' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (12, N'Night  is Dark', 9, CAST(N'2023-06-17T22:36:50.7051397' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (14, N'Dark Dark Dark category', 12, CAST(N'2023-06-17T23:29:01.3505495' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (15, N'Dreams', 13, CAST(N'2023-06-18T20:00:07.7002963' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (16, N'Action', 7, CAST(N'2023-07-12T22:40:40.6915141' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (17, N'Fiction', 12, CAST(N'2023-07-12T23:15:12.1023323' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (18, N'Romance', 13, CAST(N'2023-07-12T23:15:23.4832178' AS DateTime2))
INSERT [dbo].[Categories] ([Id], [Name], [DisplayOrder], [CreateDateTime]) VALUES (19, N'Fantasy', 14, CAST(N'2023-07-12T23:15:38.6702194' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
SET IDENTITY_INSERT [dbo].[Companies] ON 

INSERT [dbo].[Companies] ([Id], [Name], [StreetAddress], [City], [State], [PostalCode], [PhoneNumber]) VALUES (1, N'Sparky LLC', N'123 South St', N'Chicago', N'NY', N'59039', N'8893038320')
INSERT [dbo].[Companies] ([Id], [Name], [StreetAddress], [City], [State], [PostalCode], [PhoneNumber]) VALUES (3, N'Matrixx Dnt LLC', N'333 Main St..', N'Chicago', N'IL', N'39844', N'293903029')
SET IDENTITY_INSERT [dbo].[Companies] OFF
GO
SET IDENTITY_INSERT [dbo].[CoverTypes] ON 

INSERT [dbo].[CoverTypes] ([Id], [Name]) VALUES (1, N'Cheap Cloth Cover')
INSERT [dbo].[CoverTypes] ([Id], [Name]) VALUES (2, N'Expensive Cover')
INSERT [dbo].[CoverTypes] ([Id], [Name]) VALUES (4, N'Carton Cover')
SET IDENTITY_INSERT [dbo].[CoverTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Title], [Description], [ISBN], [Author], [ListPrice], [Price], [Price50], [Price100], [ImageUrl], [CategoryId], [CoverTypeID]) VALUES (1004, N'Fortune of Time', N'Time is important and it''s your fortune at your life. This book focuses on investing your skills to get money and not wasting your time !!', N'112233223', N'Abby Muscles', 17, 20, 19, 18, N'\images\products\1960ab1b-99d7-446e-a06a-dcaf9c47e2de.jpg', 16, 2)
INSERT [dbo].[Products] ([Id], [Title], [Description], [ISBN], [Author], [ListPrice], [Price], [Price50], [Price100], [ImageUrl], [CategoryId], [CoverTypeID]) VALUES (1005, N'Giant and the elves', N'Giant and the elves story for kids.', N'33333333343', N'Julian Phantom', 35, 40, 38, 36, N'\images\products\fcbd8893-c3df-4d9a-94d4-a6ce49618ed7.png', 17, 1)
INSERT [dbo].[Products] ([Id], [Title], [Description], [ISBN], [Author], [ListPrice], [Price], [Price50], [Price100], [ImageUrl], [CategoryId], [CoverTypeID]) VALUES (1006, N'9 Ways to get rid of spiders', N'9 Ways to get rid of spiders .. very effective and non toxic detailed ways', N'333334343323', N'Button Charles', 12, 25, 21, 18, N'\images\products\965a7b79-8db7-41a9-b7ce-7dfdf88eeba8.PNG', 18, 4)
INSERT [dbo].[Products] ([Id], [Title], [Description], [ISBN], [Author], [ListPrice], [Price], [Price50], [Price100], [ImageUrl], [CategoryId], [CoverTypeID]) VALUES (1007, N'Symbols of the Jungle', N'Symbols of the Jungle.. with a projections from our real life !!!', N'1112203920', N'Taylor Smith', 25, 50, 45, 35, N'\images\products\904bddeb-053d-4626-a738-399b6a250887.PNG', 18, 2)
INSERT [dbo].[Products] ([Id], [Title], [Description], [ISBN], [Author], [ListPrice], [Price], [Price50], [Price100], [ImageUrl], [CategoryId], [CoverTypeID]) VALUES (1008, N'Deep Web', N'Deep Web .. and the crime dark world.', N'1110009993', N'James Atwa', 53, 70, 60, 58, N'\images\products\02f9259f-fe4d-4618-a71b-88c504a6251c.jpg', 19, 2)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[ShoppingCarts] ON 

INSERT [dbo].[ShoppingCarts] ([Id], [ProductId], [Count], [ApplicationUserId]) VALUES (1, 1006, 5, N'9573fbf4-e2ce-4c2b-8376-afd013f243dd')
INSERT [dbo].[ShoppingCarts] ([Id], [ProductId], [Count], [ApplicationUserId]) VALUES (2, 1007, 2, N'9573fbf4-e2ce-4c2b-8376-afd013f243dd')
INSERT [dbo].[ShoppingCarts] ([Id], [ProductId], [Count], [ApplicationUserId]) VALUES (5, 1006, 37, N'98aa46f5-76c7-4de7-8376-f49ea4071a0d')
INSERT [dbo].[ShoppingCarts] ([Id], [ProductId], [Count], [ApplicationUserId]) VALUES (7, 1006, 30, N'155eceab-0794-4e16-8686-716eb68a859f')
SET IDENTITY_INSERT [dbo].[ShoppingCarts] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUsers_CompanyId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUsers_CompanyId] ON [dbo].[AspNetUsers]
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CategoryId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CategoryId] ON [dbo].[Products]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Products_CoverTypeID]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_Products_CoverTypeID] ON [dbo].[Products]
(
	[CoverTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ShoppingCarts_ApplicationUserId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCarts_ApplicationUserId] ON [dbo].[ShoppingCarts]
(
	[ApplicationUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ShoppingCarts_ProductId]    Script Date: 7/24/2023 2:50:04 AM ******/
CREATE NONCLUSTERED INDEX [IX_ShoppingCarts_ProductId] ON [dbo].[ShoppingCarts]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetUsers] ADD  DEFAULT (N'') FOR [Discriminator]
GO
ALTER TABLE [dbo].[ShoppingCarts] ADD  DEFAULT (N'') FOR [ApplicationUserId]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsers_Companies_CompanyId] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUsers] CHECK CONSTRAINT [FK_AspNetUsers_Companies_CompanyId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories_CategoryId]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_CoverTypes_CoverTypeID] FOREIGN KEY([CoverTypeID])
REFERENCES [dbo].[CoverTypes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_CoverTypes_CoverTypeID]
GO
ALTER TABLE [dbo].[ShoppingCarts]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCarts_AspNetUsers_ApplicationUserId] FOREIGN KEY([ApplicationUserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingCarts] CHECK CONSTRAINT [FK_ShoppingCarts_AspNetUsers_ApplicationUserId]
GO
ALTER TABLE [dbo].[ShoppingCarts]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCarts_Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ShoppingCarts] CHECK CONSTRAINT [FK_ShoppingCarts_Products_ProductId]
GO
USE [master]
GO
ALTER DATABASE [BookStore-25-2-2023_Delta] SET  READ_WRITE 
GO
