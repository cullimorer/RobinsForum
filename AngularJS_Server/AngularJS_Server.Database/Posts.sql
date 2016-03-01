CREATE TABLE [dbo].[Posts]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[Content]	NVARCHAR(1500) NOT NULL,
	[OauthUserId] INT NOT NULL,
	[ThreadId] INT NOT NULL,
	[IsEnabled]	BIT NOT NULL,
	[CreatedOn]	DATETIME NOT NULL,
	[CreatedBy]	NVARCHAR(100) NOT NULL,
	[UpdatedOn]	DATETIME NULL,
	[UpdatedBy]	NVARCHAR(100) NULL,
	CONSTRAINT [FK_Posts_OauthUsers] FOREIGN KEY ([OauthUserId]) REFERENCES [OauthUsers]([Id]),
	CONSTRAINT [FK_Posts_Threads] FOREIGN KEY ([ThreadId]) REFERENCES [Threads]([Id])
)
