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
PRINT N'Creating [dbo].[OauthUsers]...';


GO
CREATE TABLE [dbo].[OauthUsers] (
    [Id]              INT           NOT NULL,
    [Username]        VARCHAR (MAX) NOT NULL,
    [OauthId]         VARCHAR (MAX) NOT NULL,
    [OauthProviderId] INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating FK_OauthUsers_OauthProviders...';


GO
ALTER TABLE [dbo].[OauthUsers] WITH NOCHECK
    ADD CONSTRAINT [FK_OauthUsers_OauthProviders] FOREIGN KEY ([OauthProviderId]) REFERENCES [dbo].[OauthProviders] ([Id]);


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

INSERT INTO OauthProviders VALUES (1, 'Facebook');
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[OauthUsers] WITH CHECK CHECK CONSTRAINT [FK_OauthUsers_OauthProviders];


GO
PRINT N'Update complete.'
GO
