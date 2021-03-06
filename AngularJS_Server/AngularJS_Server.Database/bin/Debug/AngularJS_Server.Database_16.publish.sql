﻿/*
Deployment script for AngularJS_Server.Database

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "AngularJS_Server.Database"
:setvar DefaultFilePrefix "AngularJS_Server.Database"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--DELETE FROM OauthProviders
GO

GO
PRINT N'Dropping FK_Threads_Categories...';


GO
ALTER TABLE [dbo].[Threads] DROP CONSTRAINT [FK_Threads_Categories];


GO
PRINT N'Dropping FK_Posts_OauthUsers...';


GO
ALTER TABLE [dbo].[Posts] DROP CONSTRAINT [FK_Posts_OauthUsers];


GO
PRINT N'Dropping FK_Posts_Threads...';


GO
ALTER TABLE [dbo].[Posts] DROP CONSTRAINT [FK_Posts_Threads];


GO
PRINT N'Starting rebuilding table [dbo].[Categories]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Categories] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Name]      NVARCHAR (150) NOT NULL,
    [IsEnabled] BIT            NOT NULL,
    [CreatedOn] DATETIME       NOT NULL,
    [CreatedBy] NVARCHAR (100) NOT NULL,
    [UpdatedOn] DATETIME       NULL,
    [UpdatedBy] NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Categories])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Categories] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Categories] ([Id], [Name], [IsEnabled], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy])
        SELECT   [Id],
                 [Name],
                 [IsEnabled],
                 [CreatedOn],
                 [CreatedBy],
                 [UpdatedOn],
                 [UpdatedBy]
        FROM     [dbo].[Categories]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Categories] OFF;
    END

DROP TABLE [dbo].[Categories];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Categories]', N'Categories';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Posts]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Posts] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [Content]     NVARCHAR (1500) NOT NULL,
    [OauthUserId] INT             NOT NULL,
    [ThreadId]    INT             NOT NULL,
    [IsEnabled]   BIT             NOT NULL,
    [CreatedOn]   DATETIME        NOT NULL,
    [CreatedBy]   NVARCHAR (100)  NOT NULL,
    [UpdatedOn]   DATETIME        NULL,
    [UpdatedBy]   NVARCHAR (100)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Posts])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Posts] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Posts] ([Id], [Content], [OauthUserId], [ThreadId], [IsEnabled], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy])
        SELECT   [Id],
                 [Content],
                 [OauthUserId],
                 [ThreadId],
                 [IsEnabled],
                 [CreatedOn],
                 [CreatedBy],
                 [UpdatedOn],
                 [UpdatedBy]
        FROM     [dbo].[Posts]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Posts] OFF;
    END

DROP TABLE [dbo].[Posts];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Posts]', N'Posts';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Threads]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Threads] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (150) NOT NULL,
    [CategoryId] INT            NOT NULL,
    [IsEnabled]  BIT            NOT NULL,
    [CreatedOn]  DATETIME       NOT NULL,
    [CreatedBy]  NVARCHAR (100) NOT NULL,
    [UpdatedOn]  DATETIME       NULL,
    [UpdatedBy]  NVARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Threads])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Threads] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Threads] ([Id], [Name], [CategoryId], [IsEnabled], [CreatedOn], [CreatedBy], [UpdatedOn], [UpdatedBy])
        SELECT   [Id],
                 [Name],
                 [CategoryId],
                 [IsEnabled],
                 [CreatedOn],
                 [CreatedBy],
                 [UpdatedOn],
                 [UpdatedBy]
        FROM     [dbo].[Threads]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Threads] OFF;
    END

DROP TABLE [dbo].[Threads];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Threads]', N'Threads';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating FK_Threads_Categories...';


GO
ALTER TABLE [dbo].[Threads] WITH NOCHECK
    ADD CONSTRAINT [FK_Threads_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([Id]);


GO
PRINT N'Creating FK_Posts_OauthUsers...';


GO
ALTER TABLE [dbo].[Posts] WITH NOCHECK
    ADD CONSTRAINT [FK_Posts_OauthUsers] FOREIGN KEY ([OauthUserId]) REFERENCES [dbo].[OauthUsers] ([Id]);


GO
PRINT N'Creating FK_Posts_Threads...';


GO
ALTER TABLE [dbo].[Posts] WITH NOCHECK
    ADD CONSTRAINT [FK_Posts_Threads] FOREIGN KEY ([ThreadId]) REFERENCES [dbo].[Threads] ([Id]);


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF NOT EXISTS ( SELECT 1 FROM OauthProviders WHERE OauthProviders.Name = 'Basic')
INSERT INTO OauthProviders VALUES ('Basic');

IF NOT EXISTS ( SELECT 1 FROM OauthProviders WHERE OauthProviders.Name = 'Facebook')
INSERT INTO OauthProviders VALUES ('Facebook');
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Threads] WITH CHECK CHECK CONSTRAINT [FK_Threads_Categories];

ALTER TABLE [dbo].[Posts] WITH CHECK CHECK CONSTRAINT [FK_Posts_OauthUsers];

ALTER TABLE [dbo].[Posts] WITH CHECK CHECK CONSTRAINT [FK_Posts_Threads];


GO
PRINT N'Update complete.';


GO
