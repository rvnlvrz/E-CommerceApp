CREATE TABLE [dbo].[Products]
(
	[id] INT NOT NULL PRIMARY KEY IDENTITY(1,1), 
    [name] NVARCHAR(50) NOT NULL, 
    [description] NVARCHAR(MAX) NOT NULL, 
    [sku] NVARCHAR(50) NOT NULL, 
    [price] INT NOT NULL, 
    [qty] INT NULL, 
    [tags] NVARCHAR(50) NULL,
	[img_url] NVARCHAR(MAX) NULL, 
    [md_url] NCHAR(10) NULL
)
