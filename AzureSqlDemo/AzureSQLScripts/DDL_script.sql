-- create new sample database
CREATE DATABASE TestDB COLLATE SQL_Latin1_General_CP1_CI_AS 
	(
	  EDITION = 'Standard',
	  SERVICE_OBJECTIVE='S1',
	  MAXSIZE = 50 GB
	)

GO

-- Switching database instances ?
USE demoSql
GO


--- Creating a copy of a existing DB.
CREATE DATABASE nextDemoSql   
AS COPY OF demoSql;
GO  


-- Create new database in a pool
-- name should match the Elastic Pool which already exist on a logical server
CREATE DATABASE ElasticPoolDB1 ( SERVICE_OBJECTIVE = ELASTIC_POOL ( name = Change_Name ) ) ;