Create database Dreamhome
Go
USE [Dreamhome]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[branchNo] [varchar](4) NOT NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[postcode] [varchar](50) NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[branchNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[ClientNo] [varchar](4) NOT NULL,
	[fname] [varchar](50) NULL,
	[lname] [varchar](50) NULL,
	[telno] [varchar](50) NULL,
	[prefType] [varchar](50) NULL,
	[maxrent] [int] NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrivateOwner]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrivateOwner](
	[ownerno] [varchar](4) NOT NULL,
	[fname] [varchar](50) NULL,
	[lname] [varchar](50) NULL,
	[address] [varchar](50) NULL,
	[telno] [varchar](50) NULL,
 CONSTRAINT [PK_PrivateOwner] PRIMARY KEY CLUSTERED 
(
	[ownerno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PropertyForRent]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropertyForRent](
	[PropertyNo] [varchar](4) NOT NULL,
	[street] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[postcode] [varchar](50) NULL,
	[type] [varchar](50) NULL,
	[rooms] [int] NULL,
	[rent] [int] NULL,
	[StaffNo] [varchar](4) NULL,
	[branchNo] [varchar](4) NULL,
 CONSTRAINT [PK_PropertyForRent] PRIMARY KEY CLUSTERED 
(
	[PropertyNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registration](
	[clientno] [varchar](4) NOT NULL,
	[branchno] [varchar](4) NOT NULL,
	[staffno] [varchar](4) NULL,
	[datejoined] [date] NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[clientno] ASC,
	[branchno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[Staffno] [varchar](4) NOT NULL,
	[fname] [varchar](50) NULL,
	[lname] [varchar](50) NULL,
	[position] [varchar](50) NULL,
	[gender] [varchar](1) NULL,
	[dob] [date] NULL,
	[salary] [int] NULL,
	[branchno] [varchar](4) NULL,
 CONSTRAINT [PK_Staff] PRIMARY KEY CLUSTERED 
(
	[Staffno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[viewing]    Script Date: 11-Jun-21 3:44:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[viewing](
	[Clientno] [varchar](4) NOT NULL,
	[propertyno] [varchar](4) NOT NULL,
	[viewdate] [date] NULL,
	[comment] [varchar](50) NULL,
 CONSTRAINT [PK_viewing] PRIMARY KEY CLUSTERED 
(
	[Clientno] ASC,
	[propertyno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Branch] ([branchNo], [street], [city], [postcode]) VALUES (N'B002', N'56 Clover Dr', N'London', N'NW10 6EU')
INSERT [dbo].[Branch] ([branchNo], [street], [city], [postcode]) VALUES (N'B003', N'163 Main St', N'Glasgow', N'G11 9QX')
INSERT [dbo].[Branch] ([branchNo], [street], [city], [postcode]) VALUES (N'B004', N'32 Manse Rd ', N'Bristol', N'BS99 1NZ')
INSERT [dbo].[Branch] ([branchNo], [street], [city], [postcode]) VALUES (N'B005', N'22 Deer Rd', N'London', N'SW1 4EH')
INSERT [dbo].[Branch] ([branchNo], [street], [city], [postcode]) VALUES (N'B007', N'16 Argy11 St', N'Aberdeen', N'AB2 3SU')
INSERT [dbo].[Client] ([ClientNo], [fname], [lname], [telno], [prefType], [maxrent]) VALUES (N'CR56', N'Aline', N'Stewart', N'0141-848-1825', N'Flat', 350)
INSERT [dbo].[Client] ([ClientNo], [fname], [lname], [telno], [prefType], [maxrent]) VALUES (N'CR62', N'Mary', N'Tregear', N'01224-19670', N'Flat', 600)
INSERT [dbo].[Client] ([ClientNo], [fname], [lname], [telno], [prefType], [maxrent]) VALUES (N'CR74', N'Mike', N'Ritchie', N'01475-392178', N'House', 750)
INSERT [dbo].[Client] ([ClientNo], [fname], [lname], [telno], [prefType], [maxrent]) VALUES (N'CR76', N'John', N'Kay', N'0207-774-5632', N'Flat', 425)
INSERT [dbo].[Client] ([ClientNo], [fname], [lname], [telno], [prefType], [maxrent]) VALUES (N'CR90', N'bob', N'alex', N'0333-333-3333', N'flat', 200)
INSERT [dbo].[PrivateOwner] ([ownerno], [fname], [lname], [address], [telno]) VALUES (N'CO40', N'Tina', N'Murphy', N'63 Well St, Glasgow G42', N'0141-943-1728')
INSERT [dbo].[PrivateOwner] ([ownerno], [fname], [lname], [address], [telno]) VALUES (N'CO46', N'Joe', N'Keogh', N'2 Fregus Dr, Aberdeen AB2 75X', N'01224-861212')
INSERT [dbo].[PrivateOwner] ([ownerno], [fname], [lname], [address], [telno]) VALUES (N'CO87', N'Carol', N'Farrel', N'6 Achary St, Glasgow G32 9DX', N'0141-357-7419')
INSERT [dbo].[PrivateOwner] ([ownerno], [fname], [lname], [address], [telno]) VALUES (N'CO93', N'Tony', N'Shaw', N'12 Park Pl, Glasgow G4 0QR', N'0141-225-7025')
INSERT [dbo].[PropertyForRent] ([PropertyNo], [street], [city], [postcode], [type], [rooms], [rent], [StaffNo], [branchNo]) VALUES (N'PA14', N'16 Holhead', N'Aberdeen', N'AB7 5SU', N'House', 6, 650, N'SA9', N'B007')
INSERT [dbo].[PropertyForRent] ([PropertyNo], [street], [city], [postcode], [type], [rooms], [rent], [StaffNo], [branchNo]) VALUES (N'PG16', N'5 Novar Dr', N'Glasgow', N'G12 9AX', N'Flat', 4, 450, N'SG14', N'B003')
INSERT [dbo].[PropertyForRent] ([PropertyNo], [street], [city], [postcode], [type], [rooms], [rent], [StaffNo], [branchNo]) VALUES (N'PG21', N'18 Dale Rd', N'Glasgow', N'G12', N'House', 5, 200, N'SG37', N'B003')
INSERT [dbo].[PropertyForRent] ([PropertyNo], [street], [city], [postcode], [type], [rooms], [rent], [StaffNo], [branchNo]) VALUES (N'PG36', N'2 Manor Rd', N'Glasgow', N'G32 4QX', N'Flat', 3, 375, N'SG37', N'B003')
INSERT [dbo].[PropertyForRent] ([PropertyNo], [street], [city], [postcode], [type], [rooms], [rent], [StaffNo], [branchNo]) VALUES (N'PG4', N'6 Lawrence St', N'Glasgow', N'G11 9QX', N'Flat', 3, 350, NULL, N'B003')
INSERT [dbo].[PropertyForRent] ([PropertyNo], [street], [city], [postcode], [type], [rooms], [rent], [StaffNo], [branchNo]) VALUES (N'PL94', N'6 Argyll St', N'London', N'NW2', N'Flat', 4, 400, N'SL41', N'B005')
INSERT [dbo].[Registration] ([clientno], [branchno], [staffno], [datejoined]) VALUES (N'CR56', N'B003', N'SG37', CAST(N'2003-04-11' AS Date))
INSERT [dbo].[Registration] ([clientno], [branchno], [staffno], [datejoined]) VALUES (N'CR62', N'B007', N'SA9', CAST(N'2003-03-07' AS Date))
INSERT [dbo].[Registration] ([clientno], [branchno], [staffno], [datejoined]) VALUES (N'CR74', N'B003', N'SG37', CAST(N'2002-11-16' AS Date))
INSERT [dbo].[Registration] ([clientno], [branchno], [staffno], [datejoined]) VALUES (N'CR76', N'B005', N'SL41', CAST(N'2004-01-02' AS Date))
INSERT [dbo].[Staff] ([Staffno], [fname], [lname], [position], [gender], [dob], [salary], [branchno]) VALUES (N'SA9', N'Mary', N'Howe', N'Assistant', N'F', CAST(N'1970-02-19' AS Date), 14322, N'B007')
INSERT [dbo].[Staff] ([Staffno], [fname], [lname], [position], [gender], [dob], [salary], [branchno]) VALUES (N'SG14', N'David', N'Ford', N'Supervisor', N'M', CAST(N'1958-03-24' AS Date), 27000, N'B003')
INSERT [dbo].[Staff] ([Staffno], [fname], [lname], [position], [gender], [dob], [salary], [branchno]) VALUES (N'SG37', N'Ann', N'Beech', N'Assistant', N'F', CAST(N'1960-11-10' AS Date), 18000, N'B003')
INSERT [dbo].[Staff] ([Staffno], [fname], [lname], [position], [gender], [dob], [salary], [branchno]) VALUES (N'SG5', N'Susan', N'Brand', N'Manager', N'F', CAST(N'1940-06-03' AS Date), 36000, N'B003')
INSERT [dbo].[Staff] ([Staffno], [fname], [lname], [position], [gender], [dob], [salary], [branchno]) VALUES (N'SL21', N'John', N'White', N'Manager', N'M', CAST(N'1945-10-01' AS Date), 45000, N'B005')
INSERT [dbo].[Staff] ([Staffno], [fname], [lname], [position], [gender], [dob], [salary], [branchno]) VALUES (N'SL41', N'Julie', N'Lee', N'Assistance', N'F', CAST(N'1965-06-13' AS Date), 13500, N'B005')
INSERT [dbo].[viewing] ([Clientno], [propertyno], [viewdate], [comment]) VALUES (N'CR56', N'PA14', CAST(N'2004-05-24' AS Date), N'too small')
INSERT [dbo].[viewing] ([Clientno], [propertyno], [viewdate], [comment]) VALUES (N'CR56', N'PG36', CAST(N'2004-05-14' AS Date), NULL)
INSERT [dbo].[viewing] ([Clientno], [propertyno], [viewdate], [comment]) VALUES (N'CR56', N'PG4', CAST(N'2004-05-26' AS Date), NULL)
INSERT [dbo].[viewing] ([Clientno], [propertyno], [viewdate], [comment]) VALUES (N'CR62', N'PA14', CAST(N'2004-05-14' AS Date), N'no dining room')
INSERT [dbo].[viewing] ([Clientno], [propertyno], [viewdate], [comment]) VALUES (N'CR76', N'PG4', CAST(N'2004-04-20' AS Date), N'too remote')
ALTER TABLE [dbo].[PropertyForRent]  WITH CHECK ADD  CONSTRAINT [FK_PropertyForRent_Branch] FOREIGN KEY([branchNo])
REFERENCES [dbo].[Branch] ([branchNo])
GO
ALTER TABLE [dbo].[PropertyForRent] CHECK CONSTRAINT [FK_PropertyForRent_Branch]
GO
ALTER TABLE [dbo].[PropertyForRent]  WITH CHECK ADD  CONSTRAINT [FK_PropertyForRent_Staff] FOREIGN KEY([StaffNo])
REFERENCES [dbo].[Staff] ([Staffno])
GO
ALTER TABLE [dbo].[PropertyForRent] CHECK CONSTRAINT [FK_PropertyForRent_Staff]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Branch] FOREIGN KEY([branchno])
REFERENCES [dbo].[Branch] ([branchNo])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Branch]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Client] FOREIGN KEY([clientno])
REFERENCES [dbo].[Client] ([ClientNo])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Client]
GO
ALTER TABLE [dbo].[Registration]  WITH CHECK ADD  CONSTRAINT [FK_Registration_Staff] FOREIGN KEY([staffno])
REFERENCES [dbo].[Staff] ([Staffno])
GO
ALTER TABLE [dbo].[Registration] CHECK CONSTRAINT [FK_Registration_Staff]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_Staff_Branch] FOREIGN KEY([branchno])
REFERENCES [dbo].[Branch] ([branchNo])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_Staff_Branch]
GO
ALTER TABLE [dbo].[viewing]  WITH CHECK ADD  CONSTRAINT [FK_viewing_Client] FOREIGN KEY([Clientno])
REFERENCES [dbo].[Client] ([ClientNo])
GO
ALTER TABLE [dbo].[viewing] CHECK CONSTRAINT [FK_viewing_Client]
GO
ALTER TABLE [dbo].[viewing]  WITH CHECK ADD  CONSTRAINT [FK_viewing_PropertyForRent] FOREIGN KEY([propertyno])
REFERENCES [dbo].[PropertyForRent] ([PropertyNo])
GO
ALTER TABLE [dbo].[viewing] CHECK CONSTRAINT [FK_viewing_PropertyForRent]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [CK_Staff] CHECK  (([salary]<(50000)))
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [CK_Staff]
GO
