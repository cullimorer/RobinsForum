CREATE TABLE [dbo].[OauthUsers]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[Username] VARCHAR(max) NOT NULL, 
	[Email] VARCHAR(max) NULL, 
    [OauthId] VARCHAR(MAX) NOT NULL, 
    [OauthProviderId] INT NOT NULL,
	CONSTRAINT [FK_OauthUsers_OauthProviders] FOREIGN KEY ([OauthProviderId]) REFERENCES [OauthProviders]([Id])
)

GO
