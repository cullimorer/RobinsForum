CREATE TABLE [dbo].[Threads]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	[Name]	NVARCHAR(150) NOT NULL,
	[CategoryId] INT NOT NULL,
	[IsEnabled]	BIT NOT NULL,
	[CreatedOn]	DATETIME NOT NULL,
	[CreatedBy]	NVARCHAR(100) NOT NULL,
	[UpdatedOn]	DATETIME NULL,
	[UpdatedBy]	NVARCHAR(100) NULL,
	CONSTRAINT [FK_Threads_Categories] FOREIGN KEY ([CategoryId]) REFERENCES [Categories]([Id])
)
