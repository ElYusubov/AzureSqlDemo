
-- Set new editor window to instance
-- Creates a simple user for read/write access to the SQL instance
CREATE USER ApplicationUser WITH PASSWORD = 'YourSUPERPassword1';
GO

ALTER ROLE db_datareader ADD MEMBER ApplicationUser;
GO
ALTER ROLE db_datawriter ADD MEMBER ApplicationUser;
GO