-- MAJD
USE Wellmeadows
GO


EXECUTE sp_addrole @rolename='Receptionist'
EXECUTE sp_addrole @rolename='Doctor'

EXECUTE sp_addlogin @loginame='Majd', @passwd='Majd123'
EXECUTE sp_addlogin @loginame='Alhamad', @passwd='Alhamad123'

EXECUTE sp_adduser @loginame='Majd', @name_in_db='Majd'
EXECUTE sp_adduser @loginame='Alhamad', @name_in_db='Alhamad'

GRANT SELECT, INSERT, UPDATE, DELETE
ON Appointment
TO Receptionist

GRANT SELECT
ON Doctor
TO Receptionist

GRANT SELECT, INSERT
ON InPatient
TO Receptionist

GRANT SELECT, INSERT
ON Kin
TO Receptionist

GRANT SELECT, INSERT
ON OutPatient
TO Receptionist

GRANT SELECT, INSERT
ON Patient
TO Receptionist

GRANT SELECT
ON Specialty
TO Receptionist

GRANT SELECT
ON Ward
TO Receptionist

GRANT SELECT
ON Appointment
TO Doctor

GRANT SELECT
ON Doctor
TO Doctor

GRANT SELECT
ON Specialty
TO Doctor

EXECUTE sp_addrolemember @rolename='Receptionist', @membername='Majd'
EXECUTE sp_addrolemember @rolename='Doctor', @membername='Alhamad'

CREATE TABLE AppointmentAudit
(
	AppointmentId int NOT NULL,
	PatientFirstName varchar(20),
	PatientLastName varchar(20),
	WardName varchar(50),
	DoctorFirstName varchar(50),
	DoctorLastName varchar(20),
	AppointmentDate date,
	AppointmentTime time,
	CurrentUser varchar(50),
	InsDelDateTime datetime,
	Flag char(1)
)

CREATE TRIGGER Tr_AppointmentAudit
ON Appointment
AFTER INSERT, DELETE
AS
	INSERT INTO AppointmentAudit
	SELECT AppointmentId, Patient.FirstName, Patient.LastName, Ward.WardName, Doctor.FirstName, Doctor.LastName, AppointmentDate, AppointmentTime, CURRENT_USER, GETDATE(), 'I'
	FROM inserted
	INNER JOIN Patient
	ON Patient.PatientId = inserted.PatientId
	INNER JOIN Ward
	ON Ward.WardId = inserted.WardId
	INNER JOIN Doctor
	ON Doctor.DoctorId = inserted.DoctorId

	INSERT INTO AppointmentAudit
	SELECT deleted.AppointmentId, Patient.FirstName, Patient.LastName, Ward.WardName, Doctor.FirstName, Doctor.LastName, AppointmentDate, AppointmentTime, CURRENT_USER, GETDATE(), 'D'
	FROM deleted
	INNER JOIN Patient
	ON Patient.PatientId = deleted.PatientId
	INNER JOIN Ward
	ON Ward.WardId = deleted.WardId
	INNER JOIN Doctor
	ON Doctor.DoctorId = deleted.DoctorId

CREATE TRIGGER Tr_AppointmentAuditUpdate
ON Appointment
AFTER UPDATE
AS
	BEGIN
		IF
		(
			((SELECT AppointmentId FROM inserted) = (SELECT AppointmentId FROM deleted)) AND
			((SELECT PatientId FROM inserted) = (SELECT PatientId From deleted)) AND
			((SELECT WardId FROM inserted) = (SELECT WardId FROM deleted)) AND
			((SELECT DoctorId From inserted) = (SELECT DoctorId FROM deleted))
		)
			BEGIN
				INSERT INTO AppointmentAudit
				SELECT AppointmentId, Patient.FirstName, Patient.LastName, Ward.WardName, Doctor.FirstName, Doctor.LastName, AppointmentDate, AppointmentTime, CURRENT_USER, GETDATE(), 'U'
				FROM inserted
				INNER JOIN Patient
				ON Patient.PatientId = inserted.PatientId
				INNER JOIN Ward
				ON Ward.WardId = inserted.WardId
				INNER JOIN Doctor
				ON Doctor.DoctorId = inserted.DoctorId

				INSERT INTO AppointmentAudit
				SELECT deleted.AppointmentId, Patient.FirstName, Patient.LastName, Ward.WardName, Doctor.FirstName, Doctor.LastName, AppointmentDate, AppointmentTime, CURRENT_USER,  
						GETDATE(), 'U'
				FROM deleted
				INNER JOIN Patient
				ON Patient.PatientId = deleted.PatientId
				INNER JOIN Ward
				ON Ward.WardId = deleted.WardId
				INNER JOIN Doctor
				ON Doctor.DoctorId = deleted.DoctorId
			END
		ELSE
			BEGIN
				PRINT('Only appointment date and time are allowed to be modified')
				ROLLBACK
			END
	END

INSERT INTO Appointment
VALUES	(11, 1, 1, 1, '2021-6-24', '15:30:00')

UPDATE appointment
set AppointmentDate = '2021-7-24'
where appointmentid = 11


DELETE FROM Appointment WHERE AppointmentId = 11

SELECT * FROM AppointmentAudit

INSERT INTO Appointment
VALUES	(11, 1, 1, 1, '2021-6-24', '15:30:00')

UPDATE appointment
set doctorid = 5
where appointmentid = 11


-- PART G

--CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Majd123'

select * from sys.symmetric_keys
GO

CREATE ASYMMETRIC KEY Appsym
WITH ALGORITHM = RSA_2048

SELECT * FROM sys.asymmetric_keys
GO

CREATE SYMMETRIC KEY SymApp
WITH ALGORITHM = AES_256
ENCRYPTION BY ASYMMETRIC KEY Appsym

SELECT * FROM sys.symmetric_keys
GO

OPEN SYMMETRIC KEY SymApp
DECRYPTION BY ASYMMETRIC KEY Appsym

SELECT * FROM sys.openkeys
GO


CREATE TABLE AppointmentEncryptedTable
(
	AppointmentId int,
	PatientId VARBINARY(max),
	WardId VARBINARY(max),
	DoctorId VARBINARY(max),
	AppointmentDate VARBINARY(max),
	AppointmentTime VARBINARY(max)
)

INSERT INTO AppointmentEncryptedTable
SELECT AppointmentId, ENCRYPTBYKEY(key_guid('SymAppointmentKey'), CONVERT(VARBINARY, PatientId)), ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, WardId)), 
		ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, DoctorId)), ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, AppointmentDate)), 
		ENCRYPTBYKEY(KEY_GUID('SymAppointmentKey'), CONVERT(VARBINARY, AppointmentTime))
FROM Appointment

SELECT * FROM AppointmentEncryptedTable

SELECT AppointmentId, CONVERT(int, DECRYPTBYKEY(PatientId)) AS PatientId, CONVERT(int, DECRYPTBYKEY(WardId)) AS WardId, CONVERT(int, DECRYPTBYKEY(DoctorId)) AS DoctorId,
		CONVERT(date, DECRYPTBYKEY(AppointmentDate)) AS AppointmentDate, CONVERT(time, DECRYPTBYKEY(AppointmentTime)) AS AppointmentTime
FROM AppointmentEncryptedTable

SELECT * FROM Appointment

