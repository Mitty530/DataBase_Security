/*

Title: Backup & Restore Database
Date: 12-7-2019

*/

-- 1) create a new database "BackupEncryption"
USE master
Go

CREATE DATABASE BackupEncryption;
GO

-- 2) create Database Master Key 
-- in case that Database Master Key exist. drop the key

-- Drop Master Key;

--USE BackupEncryption;

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '@dmin_1234';
GO


-- 3) view the Database Master Key

select * from sys.symmetric_keys 


-- 4) Create certificate "BackupEncryption"

-- DROP certificate BackupEncryption

CREATE CERTIFICATE BackupEncryption
    WITH SUBJECT = 'Backup Certificate';
GO

-- 5) backup "BackupEncryption" certificate

BACKUP CERTIFICATE BackupEncryption 
TO FILE = 'E:\backup\BackupEncryption.cert'
WITH PRIVATE KEY (
FILE = 'E:\backup\BackupEncryption.key',
ENCRYPTION BY PASSWORD = '@P@SS_WORD123')

-- 6) backup database with encryption
BACKUP DATABASE BackupEncryption
TO DISK = 'E:\backup\BackupEncryption.bak'
WITH COMPRESSION,
ENCRYPTION (ALGORITHM = AES_256, SERVER CERTIFICATE = BackupEncryption)



-- 7) Drop Database BackupEncryption and certificate BackupEncryption



Go
DROP DATABASE BackupEncryption;
GO
DROP CERTIFICATE BackupEncryption;
GO

-- 8) Try to restore "BackupEncryption" 
-- Note: you can't restore the database. Because certifcate is missing
RESTORE DATABASE BackupEncryption
FROM DISK = 'E:\backup\BackupEncryption.bak';
GO

-- 9) restore "BackupEncryption" certificate



CREATE CERTIFICATE BackupEncryption
FROM FILE = 'E:\backup\BackupEncryption.cert'
WITH PRIVATE KEY (FILE = 'E:\backup\BackupEncryption.key',
DECRYPTION BY PASSWORD = '@P@SS_WORD123');
GO

-- 10) attempt to restore "BackupEncryption" once again

RESTORE DATABASE BackupEncryption
FROM DISK = 'E:\backup\BackupEncryption.bak';
GO

