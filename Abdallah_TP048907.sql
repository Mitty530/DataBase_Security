CREATE DATABASE Wellmeadows
GO

USE Wellmeadows
GO





-- Insrting Procedures
EXECUTE sp_addrole @rolename='Receptionist'
EXECUTE sp_addrole @rolename='Doctor'

EXECUTE sp_addlogin @loginame='Kai', @passwd='kai123'
EXECUTE sp_addlogin @loginame='', @passwd='123'

EXECUTE sp_adduser @loginame='Kai', @name_in_db='Kai'
EXECUTE sp_adduser @loginame='', @name_in_db=''


-- Role

--Assignment Part D (Role Authorization)
--Create user for HR
execute sp_addlogin @loginame = 'Abdallah', @passwd = 'Abdallah' 

--Create user for Head Nurse
execute sp_addlogin @loginame = 'Talib', @passwd = 'anang'

--Add the users to Wellmeadows
execute sp_adduser @loginame = 'Abdallah', @name_in_db = 'Dia'

execute sp_adduser @loginame = 'Talib', @name_in_db = 'Talibhani'




--Create roles on the database
execute sp_addrole @rolename = 'HR'
execute sp_addrole @rolename = 'HeadNurse'

--Grant the roles specific activities
--HR
Grant SELECT, INSERT, UPDATE, DELETE
on Nurse
to HR

Grant SELECT, INSERT, UPDATE, DELETE
on Doctor
to HR

Grant SELECT, INSERT, UPDATE, DELETE
on Specialty
to HR

--Head Nurse
Grant SELECT
on Nurse
to HeadNurse

Grant SELECT, INSERT, UPDATE, DELETE
on Ward
to HeadNurse

Grant SELECT, INSERT, UPDATE, DELETE
on Bed
to HeadNurse

Grant SELECT
on Patient
to HeadNurse

Grant SELECT
on InPatient
to HeadNurse

Grant SELECT
on OutPatient
to HeadNurse

Grant SELECT
on Kin
to HeadNurse

Grant SELECT, INSERT, UPDATE, DELETE
on Appointment
to HeadNurse

Grant SELECT
on Doctor
to HeadNurse

Grant SELECT
on Specialty
to HeadNurse

--Add members to these roles
execute sp_addrolemember @rolename = 'HR' , @membername = 'Dia'
execute sp_addrolemember @rolename = 'HeadNurse' , @membername = 'Talibhani'


--Assignment Part E (Logon Triggers)
CREATE TABLE Login_Tracks
    (
	 SPID int,
	 Login_Name VARCHAR(256),
     Host_Name  NVARCHAR(200),
	 Login_Time DATETIME,
    );
GO

CREATE TRIGGER Track_Logins ON ALL SERVER
FOR LOGON
AS
     BEGIN
           INSERT INTO Wellmeadows.dbo.Login_Tracks (SPID, Login_Name, Host_Name, Login_Time)
		   values (@@SPID, ORIGINAL_LOGIN(),
		   EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]', 'NVARCHAR(128)'),
		   GETDATE())
     END;



--Grant HR and Head Nurse INSERT to Login_Tracks for Logon Trigger
Grant INSERT
on Login_Tracks
to HeadNurse

Grant INSERT
on Login_Tracks
to HR



--Assignment Part F (DML Triggers)
CREATE TABLE Ward_Change_Logs(
	Change_ID			int identity(1,1),
	WardId				int,
	WardName			varchar(50),
	WardGender			varchar(10),
	NoOfBed				int,
	PhoneExtension		char(4),
	Host_Name			varchar(200),
	Time				datetime,
	Operation			varchar(10),
)
GO


--Trigger to track insert, update, and delete
CREATE TRIGGER Track_Ward_Changes
ON Ward
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	WITH progress1 AS (
		SELECT d.WardId as DeletedId, i.WardId as InsertedID, 
		d.WardName as DeletedWard, i.WardName as InsertedWard,
		d.WardGender as DeletedGender, i.WardGender as InsertedGender,
		d.NoOfBed as DeletedBeds, i.NoOfBed as InsertedBeds,
		d.PhoneExtension as DeletedPhone, i.PhoneExtension as InsertedPhone
		FROM deleted d
		FULL OUTER JOIN inserted i on i.WardId = d.WardId),

		progress2 AS (
		SELECT
			COALESCE(InsertedId, DeletedId) as WardId,
			COALESCE(InsertedWard, DeletedWard) as WardName,
			COALESCE(InsertedGender, DeletedGender) as WardGender,
			COALESCE(InsertedBeds, DeletedBeds) as NoOfBeds,
			COALESCE(InsertedPhone, DeletedPhone) as PhoneExtension,
			CASE
				WHEN InsertedId IS NOT NULL AND DeletedId IS NOT NULL THEN 'Update' 
				WHEN InsertedId IS NOT NULL AND DeletedId IS NULL THEN 'Insert'
				WHEN InsertedId IS NULL AND DeletedId IS NOT NULL THEN 'Delete'
				ELSE ''
			END AS Operation
		FROM progress1
		)

		INSERT INTO Ward_Change_Logs(WardId, WardName, WardGender, NoOfBed, PhoneExtension, Host_Name, Time, Operation)
		SELECT progress2.WardId, progress2.WardName, progress2.WardGender, progress2.NoOfBeds, progress2.PhoneExtension,
		ORIGINAL_LOGIN(), GETDATE(), progress2.Operation
		FROM progress2;
END
GO


--Trigger to check an appropriate name is given to a ward
CREATE TRIGGER Ward_Name_Validity
ON Ward
INSTEAD OF INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM inserted WHERE WardName NOT IN (SELECT Specialty FROM Specialty))
	BEGIN
		Print 'There is no such specialty in the hospital!'
		ROLLBACK
	END
GO


--Test inserting
Insert into Ward(WardId, WardName, WardGender, NoOfBed, PhoneExtension)
values(20, 'Mali', 'Male', 50, 2320)


select * from Ward
--Test deleting
Delete from Ward
where WardId = 20


--Test updating
Update Ward
Set WardName = 'Mamagila'
Where WardId = 19

--Assignment Part G (Encryption)
--Create Certificate
Create Certificate PatientCerticate
Encryption By Password = ''
With Subject = 'Patient Certificate' 


-- Assignment Part F
select * from sys.certificates

--Create Symmetry Key
-- Encryption for Patient Table
Create Symmetric Key PatientKeyCert With
Algorithm = AES_256
Encryption By Certificate PatientCerticate 

select * from sys.key_encryptions

--Open Symmetry Key
Open Symmetric Key PatientKeyCert
Decryption by Certificate PatientCerticate With Password = '' 

select * from sys.openkeys

--Create Encrypted Table
Create Table Encrypted_Patient(
	PatientId varbinary(max) NOT NULL,
	FirstName varbinary(1000) NOT NULL,
	LastName varbinary(1000),
	Address varbinary(1000),
	PhoneNumber varbinary(1000),
	Gender varchar(10) NOT NULL,
	DateOfBirth date NOT NULL,
	MaritalStatus varchar(15) NOT NULL,
	DateRegistered date NOT NULL
)


INSERT INTO Encrypted_Patient(PatientId, FirstName, LastName, Address, PhoneNumber, Gender, DateOfBirth, MaritalStatus, DateRegistered)
Select (ENCRYPTBYKEY(Key_GUID('PatientKey'), convert(varbinary,PatientId))),
(ENCRYPTBYKEY(Key_GUID('PatientKey'), convert(varbinary,FirstName))),
(ENCRYPTBYKEY(Key_GUID('PatientKey'), convert(varbinary,LastName))),
(ENCRYPTBYKEY(Key_GUID('PatientKey'), convert(varbinary,Address))),
(ENCRYPTBYKEY(Key_GUID('PatientKey'), convert(varbinary,PhoneNumber))),
Gender,
DateOfBirth,
MaritalStatus,
DateRegistered 
FROM Patient
GO

select * from Encrypted_Patient

--Close Symmetry Key
Close Symmetric Key PatientKey

--Decrypt Data
Select 
convert(int, DECRYPTBYKEY(PatientId)) as 'Patient ID', 
convert(varchar, DECRYPTBYKEY(FirstName)) as 'First Name', 
convert(varchar, DECRYPTBYKEY(LastName)) as 'Last Name',
convert(varchar, DECRYPTBYKEY(Address)) as 'Address',
convert(varchar, DECRYPTBYKEY(PhoneNumber)) as 'Phone Number',
Gender as 'Gender',
DateOfBirth as 'Date of Birth',
MaritalStatus as 'Marital Status',
DateRegistered as 'Date Registered'
From Encrypted_Patient


-- PART G ENCRYPTION

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Abdallah'

select * from sys.symmetric_keys
GO

CREATE ASYMMETRIC KEY AppointmentAssKey
WITH ALGORITHM = RSA_2048

SELECT * FROM sys.asymmetric_keys
GO

CREATE SYMMETRIC KEY SymAppointmentKey
WITH ALGORITHM = AES_256
ENCRYPTION BY ASYMMETRIC KEY AppointmentAssKey

SELECT * FROM sys.symmetric_keys
GO

OPEN SYMMETRIC KEY SymAppointmentKey
DECRYPTION BY ASYMMETRIC KEY AppointmentAssKey

SELECT * FROM sys.openkeys
GO


CREATE TABLE WardtEncryptedTable
(
	AppointmentId int,
	PatientId VARBINARY(max),
	WardId VARBINARY(max),
	DoctorId VARBINARY(max),
	AppointmentDate VARBINARY(max),
	AppointmentTime VARBINARY(max)
)

INSERT INTO WardtEncryptedTable
SELECT AppointmentId, ENCRYPTBYKEY(key_guid('SymAppointmentKey'), CONVERT(VARBINARY, PatientId)), ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, WardId)), 
		ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, DoctorId)), ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, AppointmentDate)), 
		ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, AppointmentTime))
FROM Appointment

SELECT * FROM WardtEncryptedTable

SELECT AppointmentId, CONVERT(int, DECRYPTBYKEY(PatientId)) AS PatientId, CONVERT(int, DECRYPTBYKEY(WardId)) AS WardId, CONVERT(int, DECRYPTBYKEY(DoctorId)) AS DoctorId,
		CONVERT(date, DECRYPTBYKEY(AppointmentDate)) AS AppointmentDate, CONVERT(time, DECRYPTBYKEY(AppointmentTime)) AS AppointmentTime
FROM WardtEncryptedTable

SELECT * FROM Appointment

