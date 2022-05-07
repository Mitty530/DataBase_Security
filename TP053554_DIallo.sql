CREATE TABLE Nurse
(
	NurseId int NOT NULL, 
	WardId int,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20),
	Position varchar(20) NOT NULL, 
	Salary int NOT NULL,
	Gender varchar(10) NOT NULL,
	
);
GO

CREATE TABLE Ward
(
	WardId int NOT NULL,
	WardName varchar(50) NOT NULL,
	WardGender varchar(10) NOT NULL,
	NoOfBed int NOT NULL,
	PhoneExtension char(4) NOT NULL
);
GO

CREATE TABLE Bed
(
	BedId int NOT NULL,
	WardId int
);
GO

CREATE TABLE InPatient
(
	PatientId int,
	InPatientId int NOT NULL,
	BedId int,
	AppointmentId int,
	AdmittedDate date NOT NULL,
	ExpectedStayDuration int NOT NULL,
	ExpectedCheckoutDate date NOT NULL,
	ActualCheckoutDate date,
);
GO

CREATE TABLE Patient
(
	PatientId int NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20),
	Address varchar(150),
	PhoneNumber varchar(20),
	Gender varchar(10) NOT NULL,
	DateOfBirth date NOT NULL,
	MaritalStatus varchar(15) NOT NULL,
	DateRegistered date NOT NULL
);
GO

CREATE TABLE Kin 
(
	PatientId int,
	KinName varchar(50) NOT NULL,
	PhoneNumber varchar(20) NOT NULL,
	Relationship varchar(15) NOT NULL,
);
GO

CREATE TABLE OutPatient
(
	PatientId int,
	OutPatientId int NOT NULL,
	OutPatientAppointmentDate date NOT NULL,
	OutPatientAppointmentTime time NOT NULL,
	AppointmentId int,
);
GO

CREATE TABLE Appointment
(
	AppointmentId int NOT NULL,
	PatientId int,
	WardId int,
	DoctorId int,
	AppointmentDate date NOT NULL,
	AppointmentTime time NOT NULL,
);
GO

CREATE TABLE Doctor
(
	DoctorId int NOT NULL,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20),
	PhoneExtension char(4) NOT NULL
);
GO

CREATE TABLE Specialty
(
	DoctorId int,
	Specialty varchar(30),
	
);
GO



ALTER TABLE Nurse ADD PRIMARY KEY (NurseId);

ALTER TABLE Ward ADD PRIMARY KEY (WardId);

ALTER TABLE Bed ADD PRIMARY KEY (BedId);

ALTER TABLE InPatient ADD PRIMARY KEY (InPatientId);

ALTER TABLE Patient ADD PRIMARY KEY (PatientId);

ALTER TABLE OutPatient ADD PRIMARY KEY (OutPatientId);

ALTER TABLE Appointment ADD PRIMARY KEY (AppointmentId);

ALTER TABLE Doctor ADD PRIMARY KEY (DoctorId);

GO

ALTER TABLE Nurse ADD FOREIGN KEY (WardId) REFERENCES Ward(WardId);

ALTER TABLE Bed ADD FOREIGN KEY (WardId) REFERENCES Ward(WardId);

ALTER TABLE InPatient ADD FOREIGN KEY (BedId) REFERENCES Bed(BedId), FOREIGN KEY (PatientId) REFERENCES Patient(PatientId), 
FOREIGN KEY (AppointmentId) REFERENCES Appointment(AppointmentId);

ALTER TABLE OutPatient ADD FOREIGN KEY (PatientId) REFERENCES Patient(PatientId),
	FOREIGN KEY (AppointmentId) REFERENCES Appointment(AppointmentId);

ALTER TABLE Kin ADD FOREIGN KEY (PatientId) REFERENCES Patient(PatientId) ON DELETE CASCADE;

ALTER TABLE Appointment ADD FOREIGN KEY (PatientId) REFERENCES Patient(PatientId),
	FOREIGN KEY (WardId) REFERENCES Ward(WardId),
	FOREIGN KEY (DoctorId) REFERENCES Doctor(DoctorId);

ALTER TABLE Specialty ADD FOREIGN KEY (DoctorId) REFERENCES Doctor(DoctorId) ON DELETE CASCADE;

--INSERT TABLE WARD
INSERT INTO Ward (WardId, WardName, WardGender, NoOfBed, PhoneExtension)
VALUES	(1, 'Anestethics', 'Male', 15, '2301'),
		(2, 'Anestethics', 'Female', 15, '2302'),
		(3, 'Cardiology', 'Male', 15, '2303'),
		(4, 'Cardiology', 'Female', 15, '2304'),
		(5, 'Gastroenterology', 'Male', 15, '2305'),
		(6, 'Gastroenterology', 'Female', 15, '2306'),
		(7, 'Neurology', 'Male', 15, '2307'),
		(8, 'Neurology', 'Female', 15, '2308'),
		(9, 'Hematology', 'Male', 15, '2309'),
		(10, 'Hematology', 'Female', 15, '2310'),
		(11, 'Orthopedics', 'Male', 15, '2311'),
		(12, 'Orthopedics', 'Female', 15, '2312'),
		(13, 'Nutrition & Dietetics', 'Male', 15, '2313'),
		(14, 'Nutrition & Dietetics', 'Female', 15, '2314'),
		(15, 'Physiotherapy', 'Male', 15, '2315'),
		(16, 'Physiotherapy', 'Female', 15, '2316'),
		(17, 'General Practitioner', 'Both', 0, '2317');
GO

--INSERT NURSE TABLE
INSERT INTO Nurse (NurseId, WardId, FirstName, LastName, Position, Salary, Gender)
VALUES	(1, 1, 'Gjaj', 'Lukeson', 'Head Nurse', 5000, 'Male'),
		(2, 1, 'Borislav', 'Björk', 'General Nurse', 2500, 'Male'),
		(3, 1, 'Jayant', 'Vaughn', 'Trainee Nurse', 1000, 'Male'),
		(4, 2, 'Tadhg', 'Madaidhín', 'Head Nurse', 5000, 'Male'),
		(5, 2, 'Lavanya', 'Adams', 'General Nurse', 2500, 'Female'),
		(6, 2, 'Lawrence', 'Demirci', 'Trainee Nurse', 1000, 'Male'),
		(7, 3, 'Aruna', 'Popescu', 'Head Nurse', 5000, 'Female'),
		(8, 3, 'Devdas', 'Kauffmann', 'General Nurse', 2500, 'Male'),
		(9, 3, 'Odilo', 'Giffard', 'Trainee Nurse', 1000, 'Male'),
		(10, 4, 'Julieta', 'Fiscella', 'Head Nurse', 5000, 'Female'),
		(11, 4, 'Bertók', 'Lehmann', 'General Nurse', 2500, 'Male'),
		(12, 4, 'Boro', 'Shah', 'Trainee Nurse', 1000, 'Male'),
		(13, 5, 'Célestine', 'Ignatov', 'Head Nurse', 5000, 'Female'),
		(14, 5, 'Ion', 'Haber', 'General Nurse', 2500, 'Male'),
		(15, 5, 'Reuben', 'Lukeson', 'Trainee Nurse', 1000, 'Male'),
		(16, 6, 'Kane', 'House', 'Head Nurse', 5000, 'Female'),
		(17, 6, 'Elma', 'Stacy', 'General Nurse', 2500, 'Female'),
		(18, 6, 'Petal', 'Reeves', 'Trainee Nurse', 1000, 'Male'),
		(19, 7, 'Harmonie', 'Sharp', 'Head Nurse', 5000, 'Female'),
		(20, 7, 'Marlin', 'Elwes', 'General Nurse', 2500, 'Male'),
		(21, 7, 'Alaya', 'Erickson', 'Trainee Nurse', 1000, 'Female'),
		(22, 8, 'Darion', 'Gully', 'Head Nurse', 5000, 'Male'),
		(23, 8, 'Kamryn', 'Crouch', 'General Nurse', 2500, 'Male'),
		(24, 8, 'Harrison', 'Nicholson', 'Trainee Nurse', 1000, 'Male'),
		(25, 9, 'Sid', 'Outlaw', 'Head Nurse', 5000, 'Female'),
		(26, 9, 'Wilda', 'Rowland', 'General Nurse', 2500, 'Female'),
		(27, 9, 'Douglas', 'Tupper', 'Trainee Nurse', 1000, 'Male'),
		(28, 10, 'Lacey', 'Cannon', 'Head Nurse', 5000, 'Female'),
		(29, 10, 'Abraham', 'John', 'General Nurse', 2500, 'Male'),
		(30, 10, 'Zayden', 'Robson', 'Trainee Nurse', 1000, 'Male'),
		(31, 11, 'Emery', 'Parkins', 'Head Nurse', 5000, 'Female'),
		(32, 11, 'Gaylord', 'Durand', 'General Nurse', 2500, 'Male'),
		(33, 11, 'Spring', 'Potter', 'Trainee Nurse', 1000, 'Male'),
		(34, 12, 'Wilf', 'Rowe', 'Head Nurse', 5000, 'Male'),
		(35, 12, 'Marva', 'Sims', 'General Nurse', 2500, 'Female'),
		(36, 12, 'Adam', 'Dorsey', 'Trainee Nurse', 1000, 'Male'),
		(37, 13, 'Shaye', 'Comstock', 'Head Nurse', 5000, 'Female'),
		(38, 13, 'Johnnie', 'Boone', 'General Nurse', 2500, 'Male'),
		(39, 13, 'Neil', 'Mondy', 'Trainee Nurse', 1000, 'Male'),
		(40, 14, 'Raine', 'Harley', 'Head Nurse', 5000, 'Male'),
		(41, 14, 'Amelia', 'Gardiner', 'General Nurse', 2500, 'Female'),
		(42, 14, 'Balfour', 'Ingham', 'Trainee Nurse', 1000, 'Male'),
		(43, 15, 'Elliana', 'Harden', 'Head Nurse', 5000, 'Female'),
		(44, 15, 'Webster', 'Brand', 'General Nurse', 2500, 'Male'),
		(45, 15, 'Marni', 'Elvis', 'Trainee Nurse', 1000, 'Female'),
		(46, 16, 'Nova', 'Jeanes', 'Head Nurse', 5000, 'Female'),
		(47, 16, 'Wendi', 'Wootton', 'General Nurse', 2500, 'Female'),
		(48, 16, 'Adrianna', 'Lucas', 'Trainee Nurse', 1000, 'Male'),
		(49, 17, 'Ness', 'Donalds', 'Head Nurse', 5000, 'Male'),
		(50, 17, 'Hollis', 'Pitts', 'General Nurse', 2500, 'Male'),
		(51, 17, 'Ulysses', 'Paul', 'Trainee Nurse', 1000, 'Male');

--INSERT INTO BED
INSERT INTO Bed(BedId, WardId)
VALUES	(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1),
		(10, 1), (11, 1), (12, 1), (13, 1), (14, 1), (15, 1), (16, 2), (17, 2), (18, 2), (19, 2),
		(20, 2), (21, 2), (22, 2), (23, 2), (24, 2), (25, 2), (26, 2), (27, 2), (28, 2), (29, 2),
		(30, 2), (31, 3), (32, 3), (33, 3), (34, 3), (35, 3), (36, 3), (37, 3), (38, 3), (39, 3),
		(40, 3), (41, 3), (42, 3), (43, 3), (44, 3), (45, 3), (46, 4), (47, 4), (48, 4), (49, 4),
		(50, 4), (51, 4), (52, 4), (53, 4), (54, 4), (55, 4), (56, 4), (57, 4), (58, 4), (59, 4),
		(60, 4), (61, 5), (62, 5), (63, 5), (64, 5), (65, 5), (66, 5), (67, 5), (68, 5), (69, 5),
		(70, 5), (71, 5), (72, 5), (73, 5), (74, 5), (75, 5), (76, 6), (77, 6), (78, 6), (79, 6),
		(80, 6), (81, 6), (82, 6), (83, 6), (84, 6), (85, 6), (86, 6), (87, 6), (88, 6), (89, 6),
		(90, 6), (91, 7), (92, 7), (93, 7), (94, 7), (95, 7), (96, 7), (97, 7), (98, 7), (99, 7),
		(100, 7), (101, 7), (102, 7), (103, 7), (104, 7), (105, 7), (106, 8), (107, 8), (108, 8), (109, 8),
		(110, 8), (111, 8), (112, 8), (113, 8), (114, 8), (115, 8), (116, 8), (117, 8), (118, 8), (119, 8),
		(120, 8), (121, 9), (122, 9), (123, 9), (124, 9), (125, 9), (126, 9), (127, 9), (128, 9), (129, 9),
		(130, 9), (131, 9), (132, 9), (133, 9), (134, 9), (135, 9), (136, 10), (137, 10), (138, 10), (139, 10),
		(140, 10), (141, 10), (142, 10), (143, 10), (144, 10), (145, 10), (146, 10), (147, 10), (148, 10), (149, 10),
		(150, 10), (151, 11), (152, 11), (153, 11), (154, 11), (155, 11), (156, 11), (157, 11), (158, 11), (159, 11),
		(160, 11), (161, 11), (162, 11), (163, 11), (164, 11), (165, 11), (166, 12), (167, 12), (168, 12), (169, 12),
		(170, 12), (171, 12), (172, 12), (173, 12), (174, 12), (175, 12), (176, 12), (177, 12), (178, 12), (179, 12),
		(180, 12), (181, 13), (182, 13), (183, 13), (184, 13), (185, 13), (186, 13), (187, 13), (188, 13), (189, 13),
		(190, 13), (191, 13), (192, 13), (193, 13), (194, 13), (195, 13), (196, 14), (197, 14), (198, 14), (199, 14),
		(200, 14), (201, 14), (202, 14), (203, 14), (204, 14), (205, 14), (206, 14), (207, 14), (208, 14), (209, 14),
		(210, 14), (211, 15), (212, 15), (213, 15), (214, 15), (215, 15), (216, 15), (217, 15), (218, 15), (219, 15),
		(220, 15), (221, 15), (222, 15), (223, 15), (224, 15), (225, 15), (226, 16), (227, 16), (228, 16), (229, 16),
		(230, 16), (231, 16), (232, 16), (233, 16), (234, 16), (235, 16), (236, 16), (237, 16), (238, 16), (239, 16),
		(240, 16);
GO

--INSERT TABLE PATIENT
INSERT INTO Patient
VALUES	(1, 'Orville', 'Day', 'Endah Promenade', '0142256237', 'Male', '1999-5-20', 'Single', '2021-6-24'),
	(2, 'Shannen', 'Simmons', 'Endah Promenade', '0112852123', 'Female', '1995-4-15', 'Married', '2021-5-18'),
	(3, 'Ryley', 'Brassington', 'Endah Promenade', '0142123215', 'Male', '1992-6-17', 'Divorce', '2020-12-29'),
	(4, 'Sunday', 'Joyner', 'Endah Promenade', '0171232141', 'Female', '2000-8-25', 'Single', '2021-7-17'),
	(5, 'Jayden', 'Kingston', 'Endah Promenade', '0191248500', 'Male', '1986-3-29', 'Maried', '2021-7-9');
GO

--INSERT TABLE DOCTOR
INSERT INTO Doctor
VALUES	(1, 'Coleman', 'Horn', '4001'),
		(2, 'Ariel', 'Rollins', '4002'),
		(3, 'Harve', 'Ott', '4003'),
		(4, 'Scottie', 'Warwick', '4004'),
		(5, 'Celinda', 'Peter', '4005'),
		(6, 'Keith', 'Pettigrew', '4006'),
		(7, 'Stan', 'Wilkinson', '4007'),
		(8, 'Shad', 'Welch', '4008'),
		(9, 'Kevin', 'Warren', '4009'),
		(10, 'Shawnda', 'Leonardson', '4010'),
		(11, 'Lucinda', 'Garland', '4011'),
		(12, 'Ashleigh', 'Bannerman', '4012'),
		(13, 'Darius', 'Abney', '4013'),
		(14, 'Rastus', 'Hogarth', '4014'),
		(15, 'Floella', 'Watts', '4015'),
		(16, 'Ali', 'Johnson', '4016'),
		(17, 'Brandee', 'Cartwright', '4017'),
		(18, 'Eulalia', 'Hicks', '4018');
GO

--INSER TABLE SPECIALTY
INSERT INTO Specialty
VALUES	(1, 'Anestethics'),
		(2, 'Anestethics'),
		(3, 'Cardiology'),
		(4, 'Cardiology'),
		(5, 'Gastroenterology'),
		(6, 'Gastroenterology'),
		(7, 'Neurology'),
		(8, 'Neurology'),
		(9, 'Hematology'),
		(10, 'Hematology'),
		(11, 'Orthopedics'),
		(12, 'Orthopedics'),
		(13, 'Nutrition & Dietetics'),
		(14, 'Nutrition & Dietetics'),
		(15, 'Physiotherapy'),
		(16, 'Physiotherapy'),
		(17, 'General Practitioner'),
		(18, 'General Practitioner');
GO

--INSERT TABLE APPOINTMENT
INSERT INTO Appointment
VALUES	(1, 1, 1, 1, '2021-6-24', '15:30:00'),
		(2, 2, 3, 3, '2021-5-18', '12:15:00'),
		(3, 3, 5, 5, '2020-12-29', '17:45:00'),
		(4, 4, 17, 17, '2021-7-17', '11:00:00'),
		(5, 5, 7, 7, '2021-7-9', '09:00:00'),
		(6, 1, 1, 1, '2021-6-13', '14:25:00'),
		(7, 2, 3, 3, '2021-7-1', '12:55:00'),
		(8, 3, 5, 5, '2021-1-6', '13:00:00');
GO

--INSERT TABLE IN PATIENT
INSERT INTO InPatient
VALUES	(1, 1, 1, 1, '2021-6-24', 3,'2021-6-27', '2021-6-28'),
		(2, 2, 31, 2, '2021-5-18', 4,'2021-5-22', '2021-5-23'),
		(3, 3, 61, 3, '2020-12-29', 5,'2021-1-3', '2021-1-5'),
		(5, 4, 91, 5, '2021-7-9', 6,'2021-7-15', '2021-7-18'),
		(1, 5, 1, 6, '2021-6-13', 3,'2021-6-16', '2021-6-21'),
		(2, 6, 31, 7, '2021-7-1', 4,'2021-7-5', '2021-7-6'),
		(3, 7, 61, 8, '2021-1-6', 5,'2021-6-11', '2021-6-13');
GO

--INSERT TABLE OUT PATIENT
INSERT INTO OutPatient
VALUES	(4, 1, '2021-7-24', '11:00:00', 4)

--INSERT TABLE KIN
INSERT INTO Kin
VALUES	(1, 'Georgie Cantrell', '0152123467', 'Father'),
		(2, 'Shonda Harris', '0186124215', 'Husband'),
		(3, 'Sonnie Paris', '0173115131', 'Sister'),
		(4, 'Rolf Tyson', '0817151241', 'Father'),
		(5, 'Alita Beck', '0189873756', 'Wife');
GO

--SELECT * FROM Appointment
--SELECT * FROM BED
--SELECT * FROM Doctor
--SELECT * FROM InPatient
--SELECT * FROM Kin
--SELECT * FROM Nurse
--SELECT * FROM OutPatient
--SELECT * FROM Specialty
--SELECT * FROM Ward














-- PART D AUTHORIZATION ROLES
--CREATEUSER FOR INTERNAL AUDITOR
execute sp_addlogin @loginame = 'Mitty', @passwd = 'Mitty123' 
GO

--CREATE USER FOR HOSPITAL ADMINISTRATOR
execute sp_addlogin @loginame = 'Diallo', @passwd = 'Diallo@'
GO

--ADD USER TO THE DATABASE
execute sp_adduser @loginame = 'Mitty', @name_in_db = 'Mitty@'
execute sp_adduser @loginame = 'Diallo', @name_in_db = 'DialloAl'
GO

--CREATE ROLES ON THE DATABASE
execute sp_addrole @rolename = 'HeadInternalAuditor'
execute sp_addrole @rolename = 'HospitalAdministrator'
GO


--GRANT PRIVILEGES FOR THE ROLES HEAD INTERNAL AUDITOR
GRANT ALL
ON Nurse
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Appointment
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Bed
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Doctor
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON InPatient
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Kin
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON OutPatient
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Patient
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Specialty
TO HeadInternalAuditor
WITH GRANT OPTION
GO

GRANT ALL
ON Ward
TO HeadInternalAuditor
WITH GRANT OPTION
GO

--GRANT PRIVILEGE FOR ROLE HOSPITAL ADMINISTRATOR
GRANT SELECT
ON Nurse
TO HospitalAdministrator
GO

GRANT SELECT
ON Appointment
TO HospitalAdministrator
GO

GRANT SELECT
ON Bed
TO HospitalAdministrator
GO

GRANT SELECT
ON Doctor
TO HospitalAdministrator
GO

GRANT SELECT
ON InPatient
TO HospitalAdministrator
GO

GRANT SELECT
ON Kin
TO HospitalAdministrator
WITH GRANT OPTION
GO

GRANT SELECT
ON OutPatient
TO HospitalAdministrator
GO

GRANT SELECT
ON Patient
TO HospitalAdministrator
GO

GRANT SELECT
ON Specialty
TO HospitalAdministrator
GO

GRANT SELECT
ON Ward
TO HospitalAdministrator
GO

--PUT THE MEMBER TO THE ROLES
execute sp_addrolemember @rolename = 'HeadInternalAuditor' , @membername = 'Mitty@'
execute sp_addrolemember @rolename = 'HospitalAdministrator' , @membername = 'DialloAl'
GO


--PART E LOGON TRIGGER
--GIVE VIEW SERVER STATE PERMISSION TO DURHADB
GRANT VIEW SERVER STATE TO Diallo
GO

--CREATE TRIGGER LOGON FOR USER DURHAD BENJAMIN TO LIMIT ACCESS OUTSIDE OFFICE HOUR
CREATE TRIGGER LIMIT
ON ALL SERVER FOR LOGON AS 
BEGIN
	IF((ORIGINAL_LOGIN() = 'Diallo') AND
	((DATEPART(HOUR, GETDATE()) BETWEEN 1 AND 8) OR
	(DATEPART(HOUR, GETDATE()) BETWEEN 16 AND 17)))
	BEGIN
		PRINT 'DATABASE IS OFF DURING OUT OF OFFICE HOUR'
		ROLLBACK
	END
END
BEGIN
	IF ORIGINAL_LOGIN() = 'Diallo' AND
	(SELECT COUNT(*) FROM sys.dm_exec_sessions
	WHERE  Is_User_Process = 1 AND Original_Login_Name = 'Diallo') > 10
	BEGIN
		PRINT 'YOU ARE LIMITED TO 10 SESSIONS AT A TIME'
		ROLLBACK
	END
END
GO

SELECT session_id
FROM sys.dm_exec_sessions
WHERE login_name = 'Diallo'


--PART F DML TRIGGER
--CREATE AUDIT TRAIL FOR NURSE
CREATE TABLE Nurse_Audit
(
	AuditID int not null identity(1,1),
	NurseId int NOT NULL, 
	WardId int,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20),
	Position varchar(20) NOT NULL, 
	Salary float NOT NULL,
	Gender varchar(10) NOT NULL,
	ModifiedBy varchar (150),
	ModifiedDate datetime, 
	Operation char (1)
	PRIMARY KEY CLUSTERED ( AuditID )
);
GO

--CREATE AUDIT TRIGGER FOR INSERT, DELETE, AND UPDATE
CREATE TRIGGER Nurse_Audit_Trigger ON Nurse
AFTER INSERT, DELETE, UPDATE
AS 
	DECLARE @login_name varchar(150)
	SELECT @login_name = login_name
	FROM sys.dm_exec_sessions
	WHERE session_id = @@SPID
	IF EXISTS (SELECT 0 FROM Deleted)
		BEGIN
			IF EXISTS(SELECT 0 FROM Inserted)
				BEGIN 
					INSERT INTO Nurse_Audit
					SELECT D.NurseId, D.WardId, D.FirstName, D.LastName, D.Position, D.Salary, D.Gender, @login_name, GETDATE(), 'U'
					FROM Deleted D
				END
			ELSE 
				BEGIN 
					INSERT INTO Nurse_Audit
					SELECT D.NurseId, D.WardId, D.FirstName, D.LastName, D.Position, D.Salary, D.Gender, @login_name, GETDATE(), 'D'
					FROM Deleted D
				END
		END
	ELSE
		BEGIN
			INSERT INTO Nurse_Audit
			SELECT I.NurseId, I.WardId, I.FirstName, I.LastName, I.Position, I.Salary, I.Gender, @login_name, GETDATE(), 'I'
			FROM Inserted I
		END
GO

--CHECK Nuser and Nuser Audit Table
SELECT * FROM Nurse
SELECT * FROM Nurse_Audit
GO
--INSERT NEW DATA
INSERT INTO Nurse (NurseId, WardId, FirstName, LastName, Salary, Position, Gender)
VALUES	(53, 1, 'Olaf', 'Jakckson', 2500,  'General Nurse', 'Male')
GO
--UPDATE DATA
UPDATE Nurse
SET WardId = 2, Position  = 'Head Nurse'
WHERE NurseId = 53
GO
--DELETE DATA
DELETE FROM Nurse WHERE NurseId = 53
GO
--DELETE All Nurse Audit Data
DELETE FROM Nurse_Audit
GO

--CREATE AUDIT TRIGGER FOR UPDATE
CREATE TRIGGER Nurse_Update ON Nurse
AFTER UPDATE AS 
	IF EXISTS(SELECT Position FROM Inserted WHERE Position NOT IN ('Head Nurse', 'General Nurse', 'Trainee Nurse'))
	BEGIN
		PRINT ('Position Must be either Head Nurse, General Nurse, or Trainee Nurse')
		ROLLBACK
	END
	IF EXISTS (SELECT * FROM Inserted WHERE Position = 'Head Nurse' AND (Salary NOT BETWEEN 5000 AND 10000))
	BEGIN
		PRINT ('Head Nurse Salary Must not below 5000 and above 10000')
		ROLLBACK
	END
	IF EXISTS (SELECT * FROM Inserted WHERE Position = 'General Nurse' AND (Salary NOT BETWEEN 2500 AND 5000))
		BEGIN
			PRINT ('General Nurse Salary Must not below 2500 and above 5000')
			ROLLBACK
		END
	IF EXISTS (SELECT * FROM Inserted WHERE Position = 'Trainee Nurse' AND (Salary NOT BETWEEN 1000 AND 2500))
		BEGIN
			PRINT ('Trainee Nurse Salary Must not below 1000 and above 2500')
			ROLLBACK
		END
GO

--UPDATE NURSE POSITION
UPDATE Nurse
SET Position  = 'Ups Nurse'
WHERE NurseId = 52

--CHECK Nuser and Nuser Audit Table
SELECT * FROM Nurse
SELECT * FROM Nurse_Audit
GO

--UPDATE NURSE SALARY
UPDATE Nurse
SET Salary = 5000
WHERE NurseId = 52

--UPDATE NURSE SALARY AND POSITION
UPDATE Nurse
SET Position = 'General Nurse', Salary = 20000
WHERE NurseId = 52



-- PART G ENCRYPTION
--HIERARCHY LEVEL = DMK > CERTIFICATE > SYMMETRIC KEY > ENCRYPT DATA
--CREATE DATA MASTER KEY
--CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Mitty'
--GO

--CREATE CERTIFICATE KEY PROTECTED BY DATA MASTER KEY
CREATE CERTIFICATE Certificate_Encrypt WITH SUBJECT = 'Wellmeadows'
GO

--CREATE SYMMETRIC KEY
CREATE SYMMETRIC KEY Symetric_Encrypt WITH 
	ALGORITHM = AES_256 
	ENCRYPTION BY CERTIFICATE Certificate_Encrypt
GO

--OPEN THE SYMMETRIC KEY
OPEN SYMMETRIC KEY Symetric_Encrypt  
    DECRYPTION BY CERTIFICATE Certificate_Encrypt;   
GO   

--ADD COLUMN ENCRYPTING SALARY
ALTER TABLE Nurse
ADD Salary_Encrypt varbinary(MAX)
GO

--UPDATE THE NURSE TABLE TO ENCRYPT THE SALARY
UPDATE Nurse
SET Salary_Encrypt = EncryptByKey (Key_GUID('Symetric_Encrypt'), convert(varbinary,Salary))
FROM Nurse
GO

--CLOSE THE SYMMETRIC KEY
CLOSE SYMMETRIC KEY Symetric_Encrypt 
GO

--IN CASE IF WANT TO DECRYPT THE SALARY
SELECT NurseId, WardId,FirstName,LastName,Position, Salary, CONVERT(int, DECRYPTBYKEY(Salary_Encrypt)) AS 'Salary Encrypt', Gender
FROM Nurse 
GO 

select * from Nurse
select * from sys.symmetric_keys 
select * from sys.key_encryptions
select * from sys.certificates 
SELECT * from sys.openkeys 

DROP Symmetric Key Symetric_Encrypt
DROP certificate Certificate_Encrypt




--Part H Backup
--Use Master
USE master


--NORMAL BACKUP 
BACKUP DATABASE Wellmeadows 

TO DISK = 'D:\DBS_Assignment\Backup\Wellmeadows.bak'
GO



--CREATE MASTER KEY IN MASTER
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Diallo';
GO

--CREATE CERTIFICATE FOR BACKUP
CREATE CERTIFICATE WellmeadowCert
WITH SUBJECT = 'Wellmeadow Certificate'
GO

--BACKUP CERTIFICATE
BACKUP CERTIFICATE WellmeadowCert 
TO FILE = 'D:\DBS_Assignment\Backup\WellmeadowsCert.cert'
WITH PRIVATE KEY (
FILE = 'D:\DBS_Assignment\Backup\WellmeadowsCert.key',
ENCRYPTION BY PASSWORD = 'Mitty123')

--BACKUP DATABASE with compression
BACKUP DATABASE Wellmeadows
TO DISK = 'D:\DBS_Assignment\Backup\WellmeadowsWithCert.bak'
WITH COMPRESSION,
ENCRYPTION (ALGORITHM = AES_256, SERVER CERTIFICATE = WellmeadowCert)

--DROP CERTIFICATE AND DATABASE FOR TESTING
DROP CERTIFICATE WellmeadowCert
DROP DATABASE Wellmeadows

--RESTORE CERTIFICATE
CREATE CERTIFICATE WellmeadowCert
FROM FILE = 'D:\DBS_Assignment\Backup\WellmeadowsCert.cert'
WITH PRIVATE KEY (FILE = 'D:\DBS_Assignment\Backup\WellmeadowsCert.key',
DECRYPTION BY PASSWORD = 'Mitty123');
GO

--RESTORE DATABASE
RESTORE DATABASE Wellmeadows
FROM DISK = 'D:\DBS_Assignment\Backup\Wellmeadows.bak'
GO

RESTORE DATABASE WellmeadowsWithCert
FROM DISK = 'D:\DBS_Assignment\Backup\WellmeadowsWithCert.bak'
GO

