USE [ForumAppDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SearchForumTopic]    Script Date: 01/21/2018 23:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_SearchForumTopic] 

@searchValue nvarchar(50)

AS

-- sp_SearchForumTopic Java

DECLARE @searchVal nvarchar(50)
SET @searchVal = '''' + '%' + UPPER(@searchValue) + '%' + ''''
--PRINT @searchVal

EXEC('SELECT * FROM dbo.ForumTopics WHERE UPPER(ForumTitle) LIKE ' +  @searchVal)
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NULL,
	[Username] [nvarchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([ID], [UserId], [Username]) VALUES (1, N'252d93c0-0f5e-4da3-bc9e-2799de34b632', N'lamidit')
INSERT [dbo].[Users] ([ID], [UserId], [Username]) VALUES (4, N'8a8a8d0d-a91e-4665-8241-dd0379bea343', N'abey')
SET IDENTITY_INSERT [dbo].[Users] OFF
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[FirstName] [nvarchar](256) NULL,
	[LastName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[PhoneNumber] [nvarchar](256) NULL,
	[PhoneNumberConfirmed] [bit] NULL,
	[TwoFactorEnabled] [bit] NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NULL,
	[AccessFailedCount] [int] NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AspNetUsers] ([Id], [FirstName], [LastName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [UserName], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount]) VALUES (N'252d93c0-0f5e-4da3-bc9e-2799de34b632', N'Taofee', N'Lamidi', N'lamidit@yahoo.com', 1, N'ANQVsVPZJ7PfqZNhePVHP51fXPYC8Qa0p2zQKgKSU2dk6sLByciZQteh/JG3GvpH1A==', N'bf96ded9-e267-4049-93fe-bf66c16bda6a', N'lamidit', N'', 1, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [FirstName], [LastName], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [UserName], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8a8a8d0d-a91e-4665-8241-dd0379bea343', N'Solomon', N'Abey', N'abey@netforum.com', 1, N'AFAHYnBplBufmbLKAKytBXmQVy3e6kYqZSEsNPWc75kHzMR/GBkxMej0dUrxIuT7HA==', N'a91d26c7-eed1-4ad7-bb85-5fa5c3f20566', N'abey', N'', 1, 0, NULL, 1, 0)
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsActive] [int] NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name], [Description], [IsActive]) VALUES (N'1', N'User', N'Allowed Users on Forum App', 1)
/****** Object:  Table [dbo].[AspNetMenuRoles]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetMenuRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MenuId] [int] NULL,
	[RoleId] [nvarchar](50) NULL,
	[IsActive] [int] NULL,
 CONSTRAINT [PK_AspNetMenuRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ForumTopics]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ForumTopics](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ForumTitle] [nvarchar](250) NULL,
	[ForumDesc] [nvarchar](500) NULL,
	[PostedBy] [bigint] NULL,
	[DatePosted] [nvarchar](50) NULL,
	[TimePosted] [nvarchar](50) NULL,
 CONSTRAINT [PK_ForumTopics] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ForumTopics] ON
INSERT [dbo].[ForumTopics] ([ID], [ForumTitle], [ForumDesc], [PostedBy], [DatePosted], [TimePosted]) VALUES (1, N'What is better between .NET and Java', N'This is a discusion of issues related to choice of programming language', 1, N'21/01/2018', N'10:50:52AM')
INSERT [dbo].[ForumTopics] ([ID], [ForumTitle], [ForumDesc], [PostedBy], [DatePosted], [TimePosted]) VALUES (2, N'The best platform for mobile application cross platform', N'This topic is to ask developers their opinion on what they think about hybrid or cross platform mobile application development.', 4, N'21-01-2018', N'09:42:52 PM')
INSERT [dbo].[ForumTopics] ([ID], [ForumTitle], [ForumDesc], [PostedBy], [DatePosted], [TimePosted]) VALUES (3, N'The best platform for web application cross platform', N'This is a new topic', 1, N'21-01-2018', N'10:46:14 PM')
SET IDENTITY_INSERT [dbo].[ForumTopics] OFF
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AspNetUserRoles] ON
INSERT [dbo].[AspNetUserRoles] ([Id], [UserId], [RoleId]) VALUES (1, N'252d93c0-0f5e-4da3-bc9e-2799de34b632', N'1')
INSERT [dbo].[AspNetUserRoles] ([Id], [UserId], [RoleId]) VALUES (2, N'8a8a8d0d-a91e-4665-8241-dd0379bea343', N'1')
SET IDENTITY_INSERT [dbo].[AspNetUserRoles] OFF
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TopicReplies]    Script Date: 01/21/2018 23:18:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopicReplies](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ForumTopicFK] [bigint] NULL,
	[RepliedBy] [bigint] NULL,
	[ReplyMessage] [nvarchar](250) NULL,
	[DateReplied] [nvarchar](50) NULL,
	[TimeReplied] [nvarchar](50) NULL,
 CONSTRAINT [PK_TopicReplies] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TopicReplies] ON
INSERT [dbo].[TopicReplies] ([ID], [ForumTopicFK], [RepliedBy], [ReplyMessage], [DateReplied], [TimeReplied]) VALUES (1, 1, 1, N'.Net is far better in terms of availability of resources and online library', N'22/01/2018', N'10:59:01AM')
INSERT [dbo].[TopicReplies] ([ID], [ForumTopicFK], [RepliedBy], [ReplyMessage], [DateReplied], [TimeReplied]) VALUES (4, 1, 4, N'Java is better because most of the library needed are open source', N'22/01/2018', N'10:59:01AM')
INSERT [dbo].[TopicReplies] ([ID], [ForumTopicFK], [RepliedBy], [ReplyMessage], [DateReplied], [TimeReplied]) VALUES (5, 1, 1, N'In my own opinion, I think it is all depends on the task or problem to solve and level of competence in the language.', N'21-20-2018', N'03:20:46 PM')
INSERT [dbo].[TopicReplies] ([ID], [ForumTopicFK], [RepliedBy], [ReplyMessage], [DateReplied], [TimeReplied]) VALUES (6, 2, 1, N'I used xamarin for cross platform since it allows me to use my .NET C# and other library I am already used to. Though better options are welcome', N'21-01-2018', N'10:18:30 PM')
INSERT [dbo].[TopicReplies] ([ID], [ForumTopicFK], [RepliedBy], [ReplyMessage], [DateReplied], [TimeReplied]) VALUES (7, 2, 1, N'Also, there is need for more of this discussion.', N'21-01-2018', N'10:23:33 PM')
INSERT [dbo].[TopicReplies] ([ID], [ForumTopicFK], [RepliedBy], [ReplyMessage], [DateReplied], [TimeReplied]) VALUES (8, 1, 1, N'My contribution to the topic', N'21-01-2018', N'10:45:13 PM')
SET IDENTITY_INSERT [dbo].[TopicReplies] OFF
/****** Object:  StoredProcedure [dbo].[sp_GetForumTopics]    Script Date: 01/21/2018 23:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetForumTopics]

AS


SELECT F.ID, U.Username, ForumTitle, ForumDesc, DatePosted, TimePosted, ISNULL((COUNT(R.ForumTopicFK)),0) ReplyCount
FROM dbo.ForumTopics F LEFT OUTER JOIN dbo.TopicReplies R
ON F.ID = R.ForumTopicFK INNER JOIN Users U ON F.PostedBy = U.ID

GROUP BY F.ID,U.Username, ForumTitle,ForumDesc, DatePosted, TimePosted

--Invalid column name 'PhoneNumber'.
--Invalid column name 'PhoneNumberConfirmed'.
--Invalid column name 'TwoFactorEnabled'.
--Invalid column name 'LockoutEndDateUtc'.
--Invalid column name 'LockoutEnabled'.
--Invalid column name 'AccessFailedCount'.
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForumTopicReply]    Script Date: 01/21/2018 23:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_GetForumTopicReply]

@ForumTopicFK int


AS

-- [sp_GetForumTopicReply] 1


SELECT R.*, U.Username FROM dbo.TopicReplies  R
INNER JOIN Users U ON R.RepliedBy = U.ID
WHERE ForumTopicFK = @ForumTopicFK
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
/****** Object:  ForeignKey [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
/****** Object:  ForeignKey [FK_ForumTopics_Users]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[ForumTopics]  WITH CHECK ADD  CONSTRAINT [FK_ForumTopics_Users] FOREIGN KEY([PostedBy])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[ForumTopics] CHECK CONSTRAINT [FK_ForumTopics_Users]
GO
/****** Object:  ForeignKey [FK_TopicReplies_ForumTopics]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[TopicReplies]  WITH CHECK ADD  CONSTRAINT [FK_TopicReplies_ForumTopics] FOREIGN KEY([ForumTopicFK])
REFERENCES [dbo].[ForumTopics] ([ID])
GO
ALTER TABLE [dbo].[TopicReplies] CHECK CONSTRAINT [FK_TopicReplies_ForumTopics]
GO
/****** Object:  ForeignKey [FK_TopicReplies_Users]    Script Date: 01/21/2018 23:18:35 ******/
ALTER TABLE [dbo].[TopicReplies]  WITH CHECK ADD  CONSTRAINT [FK_TopicReplies_Users] FOREIGN KEY([RepliedBy])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[TopicReplies] CHECK CONSTRAINT [FK_TopicReplies_Users]
GO
