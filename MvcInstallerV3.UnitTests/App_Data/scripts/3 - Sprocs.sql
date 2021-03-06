USE [MyCoolDb]
GO
/****** Object:  StoredProcedure [dbo].[AddData]    Script Date: 10/29/2011 13:31:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddData]
GO
/****** Object:  StoredProcedure [dbo].[AddData]    Script Date: 10/29/2011 13:31:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		King Wilder
-- Create date: October 29, 2011
-- Description:	Test sproc
-- =============================================
CREATE PROCEDURE [dbo].[AddData] 
	-- Add the parameters for the stored procedure here
	@name varchar = '''', 
	@age int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @name, @age
END
' 
END
GO
