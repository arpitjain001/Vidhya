IF Not EXISTS (SELECT name FROM master.sys.databases WHERE name = N'School')
	CREATE DATABASE School;


Set XACT_ABORT ON
GO
BEGIN TRAN
Use [School]

GO
CREATE SCHEMA [Config]
    AUTHORIZATION [dbo];
GO

CREATE SCHEMA [ND]
    AUTHORIZATION [dbo];
GO

CREATE SCHEMA [Acc]
    AUTHORIZATION [dbo];
GO

CREATE SCHEMA [Tea]
    AUTHORIZATION [dbo];
GO
CREATE SCHEMA [Audit]
    AUTHORIZATION [dbo];
GO

CREATE TABLE [Config].[GenderSet]
(
GenderCode varchar(5) CONSTRAINT PK_GenderSet_Code  NOT NULL PRIMARY KEY,
GenderDescription varchar(50),
);

GO

CREATE TABLE [Config].[MaritalStatus]
(
MaritalStatusCode varchar(5) CONSTRAINT PK_MaritalStatus_Code NOT NULL PRIMARY KEY,
MaritalStatusDescription varchar(50),
);


GO

CREATE TABLE [Config].[City]
(
CityCode varchar(10) CONSTRAINT PK_City_Code  NOT NULL PRIMARY KEY,
CityDescription varchar(50),
)

GO

CREATE TABLE [Config].[State]
(
StateCode varchar(10) CONSTRAINT PK_State_Code  NOT NULL PRIMARY KEY,
StateDescription varchar(50),
)

GO

CREATE TABLE [Config].[Country]
(
CountryCode varchar(10) CONSTRAINT PK_Country_Code NOT NULL PRIMARY KEY,
CountryDescription varchar(50),
)

GO

CREATE TABLE [Config].[Syllabus]
(
SyllabusID bigint CONSTRAINT PK_Syllabus_ID NOT NULL PRIMARY KEY,
SyllabusName varchar(250),
)

GO

CREATE TABLE [Config].[Religion]
(
ReligionCode varchar(10) CONSTRAINT PK_Religion_Code NOT NULL PRIMARY KEY,
ReligionDescription varchar(250),
)

GO

CREATE TABLE [Config].[Medium]
(
MediumCode varchar(10) CONSTRAINT PK_Medium_Code NOT NULL PRIMARY KEY,
MediumDescription varchar(250),
)

GO

CREATE TABLE [Config].[Category]
(
CategoryCode varchar(10) CONSTRAINT PK_Category_Code NOT NULL PRIMARY KEY,
CategoryDescription varchar(250),
)

GO

CREATE TABLE [Config].[Permission]
(
PermissionID bigint CONSTRAINT PK_Permission_ID NOT NULL PRIMARY KEY,
PermissionToken varchar(250),
)

GO

CREATE TABLE [Config].[Designation]
(
DesignationCode varchar(10) CONSTRAINT PK_Designation_Code NOT NULL PRIMARY KEY,
DesignationDescription varchar(250),
)

GO


CREATE TABLE [Config].[DesignationPermission]
(
DesignationPermissionID bigint CONSTRAINT PK_DesignationPermission_DesignationPermissionID NOT NULL PRIMARY KEY,
DesignationCode varchar(10) CONSTRAINT FK_DesignationPermission_Designation_DesignationCode FOREIGN KEY REFERENCES Config.Designation(DesignationCode),
PermissionID bigint CONSTRAINT FK_DesignationPermission_Permission_PermissionID FOREIGN KEY REFERENCES Config.Permission(PermissionID),
);

GO

CREATE TABLE [Config].[Class]
(
ClassID bigint CONSTRAINT PK_Class_ID NOT NULL PRIMARY KEY,
ClassName varchar(50),
ClassSection varchar(50),
SyllabusID bigint CONSTRAINT FK_Class_Syllabus_SyllabusID FOREIGN KEY REFERENCES Config.Syllabus(SyllabusID),
)

GO

CREATE TABLE [Acc].[Account]
(
AccountID bigint CONSTRAINT PK_Account_ID NOT NULL PRIMARY KEY,
BankName varchar(50),
IFSCCode varchar(50),
AccountNumber varchar(50),
)

GO

CREATE TABLE ND.[Address]
(
AddressID bigint CONSTRAINT PK_Address_ID NOT NULL PRIMARY KEY,
AddressLine01 varchar(max),
AddressLine02 varchar(max),
AddressLine03 varchar(max),
Village varchar(250),
CityCode varchar(10) CONSTRAINT FK_Address_City_CityCode FOREIGN KEY REFERENCES Config.City(CityCode),
StateCode varchar(10) CONSTRAINT FK_Address_State_StateCode FOREIGN KEY REFERENCES Config.State(StateCode),
CountryCode varchar(10) CONSTRAINT FK_Address_Country_CountryCode FOREIGN KEY REFERENCES Config.Country(CountryCode),
PostCode varchar(10),
FullAddress varchar(500),
CustomReference01 varchar(100),
CustomReference02 varchar(100),
CustomReference03 varchar(100),
CustomReference04 varchar(100),
CustomReference05 varchar(100),
CustomReference06 varchar(100),
CustomReference07 varchar(100),
CustomReference08 varchar(100),
CustomReference09 varchar(100),
CustomReference10 varchar(100),
);

GO

CREATE TABLE [ND].[Student]
(
StudentID bigint CONSTRAINT PK_Student_ID NOT NULL PRIMARY KEY,
AadharID varchar(12),
SamagraID varchar(12),
RollNumber varchar(50),
Forename varchar(100),
Surname varchar(100),
DateOfBirth datetime,
GenderCode varchar(5) CONSTRAINT FK_Student_Gender_CityCode FOREIGN KEY REFERENCES Config.GenderSet(GenderCode),
GuardianName varchar(50),
GuardianOccupation varchar(50),
GuardianAddressID  bigint CONSTRAINT FK_Student_GuardianAddress_AddressID FOREIGN KEY REFERENCES ND.Address(AddressID),
FatherName varchar(50),
FatherOccupation varchar(50),
FatherAddressID  bigint CONSTRAINT FK_Student_FatherAddress_AddressID FOREIGN KEY REFERENCES ND.Address(AddressID),
MotherName varchar(50),
MotherOccupation varchar(50),
MotherAddressID  bigint CONSTRAINT FK_Student_MotherAddress_AddressID FOREIGN KEY REFERENCES ND.Address(AddressID),
ReligionCode  varchar(10) CONSTRAINT FK_Student_Religion_ReligionCode FOREIGN KEY REFERENCES Config.Religion(ReligionCode),
MediumCode  varchar(10) CONSTRAINT FK_Student_Medium_MediumCode FOREIGN KEY REFERENCES Config.Medium(MediumCode),
CategoryCode  varchar(10) CONSTRAINT FK_Student_Category_CategoryCode FOREIGN KEY REFERENCES Config.Category(CategoryCode),
IsPhysicallyChallenged bit,
PreviousSchoolName varchar(100),
AdmissionDate Datetime,
IsLunchFacilityTaken bit,
IsBusFacilityTaken bit,
ClassID  bigint CONSTRAINT FK_Student_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
PreviousClassIDs varchar(50),
DesignationCode varchar(10) CONSTRAINT FK_Student_Designation_DesignationCode FOREIGN KEY REFERENCES Config.Designation(DesignationCode),
AddressID bigint CONSTRAINT FK_Student_Address_AddressID FOREIGN KEY REFERENCES ND.Address(AddressID),
ContactNumber01 varchar(10),
ContactNumber02 varchar(10),
ContactNumber03 varchar(10),
ContactNumber04 varchar(10),
ContactNumber05 varchar(10),
Email01 varchar(50),
Email02 varchar(50),
Email03 varchar(50),
Email04 varchar(50),
Email05 varchar(50),
CustomReference01 varchar(100),
CustomReference02 varchar(100),
CustomReference03 varchar(100),
CustomReference04 varchar(100),
CustomReference05 varchar(100),
CustomReference06 varchar(100),
CustomReference07 varchar(100),
CustomReference08 varchar(100),
CustomReference09 varchar(100),
CustomReference10 varchar(100),
)

GO

CREATE TABLE ND.[StaffSalary]
(
StaffSalaryID bigint CONSTRAINT PK_StaffSalary_ID NOT NULL PRIMARY KEY,
SalaryPerAnum decimal,
SalaryPerMonth decimal,
);

GO

CREATE TABLE [ND].[StaffDetail]
(
StaffDetailID bigint CONSTRAINT PK_StaffDetail_ID NOT NULL PRIMARY KEY,
AadharID varchar(12),
Forename varchar(100),
Surname varchar(100),
DateOfBirth datetime,
GenderCode varchar(5) CONSTRAINT FK_StaffDetail_Gender_CityCode FOREIGN KEY REFERENCES Config.GenderSet(GenderCode),
MaritalStatusCode varchar(5) CONSTRAINT FK_StaffDetail_MaritalStatus_MaritalStatusCode FOREIGN KEY REFERENCES Config.MaritalStatus(MaritalStatusCode),
Qualification varchar(100),
DesignationCode varchar(10) CONSTRAINT FK_StaffDetail_Designation_DesignationCode FOREIGN KEY REFERENCES Config.Designation(DesignationCode),
ReligionCode varchar(10) CONSTRAINT FK_StaffDetail_Religion_ReligionCode FOREIGN KEY REFERENCES Config.Religion(ReligionCode),
MediumCode varchar(10) CONSTRAINT FK_StaffDetail_Medium_MediumCode FOREIGN KEY REFERENCES Config.Medium(MediumCode),
CategoryCode  varchar(10) CONSTRAINT FK_StaffDetail_Category_CategoryCode FOREIGN KEY REFERENCES Config.Category(CategoryCode),
IsPhysicallyChallenged bit,
PreviousSchoolName varchar(100),
NumberOfYearsOfExperince bigint,
JoiningDate Datetime,
AdmissionClass varchar(50),
IsLunchFacilityTaken bit,
IsBusFacilityTaken bit,
AccountID bigint CONSTRAINT FK_StaffDetail_Account_AccountID FOREIGN KEY REFERENCES Acc.Account(AccountID),
StaffSalaryID bigint CONSTRAINT FK_StaffDetail_StaffSalary_StaffSalaryID FOREIGN KEY REFERENCES ND.StaffSalary(StaffSalaryID),
AddressID bigint CONSTRAINT FK_StaffDetail_Address_AddressID FOREIGN KEY REFERENCES ND.Address(AddressID),
ContactNumber01 varchar(10),
ContactNumber02 varchar(10),
ContactNumber03 varchar(10),
ContactNumber04 varchar(10),
ContactNumber05 varchar(10),
Email01 varchar(50),
Email02 varchar(50),
Email03 varchar(50),
Email04 varchar(50),
Email05 varchar(50),
CustomReference01 varchar(100),
CustomReference02 varchar(100),
CustomReference03 varchar(100),
CustomReference04 varchar(100),
CustomReference05 varchar(100),
CustomReference06 varchar(100),
CustomReference07 varchar(100),
CustomReference08 varchar(100),
CustomReference09 varchar(100),
CustomReference10 varchar(100),
);

GO


CREATE TABLE [Tea].[ClassKG1StudentAttendance]
(
ClassKG1StudentAttendanceID bigint CONSTRAINT PK_ClassKG1StudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassKG1StudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassKG1StudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassKG1StudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO

CREATE TABLE [Tea].[ClassKG2StudentAttendance]
(
ClassKG2StudentAttendanceID bigint CONSTRAINT PK_ClassKG2StudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassKG2StudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassKG2StudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassKG2StudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO

CREATE TABLE [Tea].[ClassFirstStudentAttendance]
(
ClassFirstStudentAttendanceID bigint CONSTRAINT PK_ClassFirstStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassFirstStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassFirstStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassFirstStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassSecondStudentAttendance]
(
ClassSecondStudentAttendanceID bigint CONSTRAINT PK_ClassSecondStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassSecondStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassSecondStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassSecondStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassThirdStudentAttendance]
(
ClassThirdStudentAttendanceID bigint CONSTRAINT PK_ClassThirdStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassThirdStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassThirdStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassThirdStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassFourthStudentAttendance]
(
ClassFourthStudentAttendanceID bigint CONSTRAINT PK_ClassFourthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassFourthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassFourthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassFourthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassFifthStudentAttendance]
(
ClassFifthStudentAttendanceID bigint CONSTRAINT PK_ClassFifthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassFifthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassFifthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassFifthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassSixthStudentAttendance]
(
ClassSixthStudentAttendanceID bigint CONSTRAINT PK_ClassSixthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassSixthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassSixthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassSixthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassSeventhStudentAttendance]
(
ClassSeventhStudentAttendanceID bigint CONSTRAINT PK_ClassSeventhStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassSeventhStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassSeventhStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassSeventhStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassEighthStudentAttendance]
(
ClassEighthStudentAttendanceID bigint CONSTRAINT PK_ClassEighthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassEighthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassEighthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassEighthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassNinthStudentAttendance]
(
ClassNinthStudentAttendanceID bigint CONSTRAINT PK_ClassNinthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassNinthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassNinthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassNinthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassTenthStudentAttendance]
(
ClassTenthStudentAttendanceID bigint CONSTRAINT PK_ClassTenthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassTenthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassTenthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassTenthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassEleventhStudentAttendance]
(
ClassEleventhStudentAttendanceID bigint CONSTRAINT PK_ClassEleventhStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassEleventhStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassEleventhStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassEleventhStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO 

CREATE TABLE [Tea].[ClassTwelthStudentAttendance]
(
ClassTwelthStudentAttendanceID bigint CONSTRAINT PK_ClassTwelthStudentAttendance_ID NOT NULL PRIMARY KEY,
AttendanceDate DateTime,
AttendanceTakerID  bigint CONSTRAINT FK_ClassTwelthStudentAttendance_StaffDetail_StaffDetailID FOREIGN KEY REFERENCES ND.StaffDetail(StaffDetailID),
ClassID  bigint CONSTRAINT FK_ClassTwelthStudentAttendance_Class_ClassID FOREIGN KEY REFERENCES Config.Class(ClassID),
StudentID  bigint CONSTRAINT FK_ClassTwelthStudentAttendance_Student_StudentID FOREIGN KEY REFERENCES ND.Student(StudentID),
IsPresent bit,
)

GO
Commit TRAN






