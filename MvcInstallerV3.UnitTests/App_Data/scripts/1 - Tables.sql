/****** Object:  Table [dbo].[MyBlogTable]    Script Date: 10/29/2011 13:15:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyBlogTable]') AND type in (N'U'))
DROP TABLE [dbo].[MyBlogTable]
GO
/****** Object:  Table [dbo].[MyBlogTable]    Script Date: 10/29/2011 13:15:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyBlogTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MyBlogTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Body] [varchar](max) NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_MyBlogTable] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
