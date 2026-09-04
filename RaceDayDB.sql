CREATE DATABASE RaceDayDB;
GO
USE RaceDayDB;
GO

Create table Users(
UserID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) NULL UNIQUE,
PasswordHash VARCHAR(255) NOT NULL,
Role VARCHAR(20) NOT NULL,
Phone VARCHAR(20) NULL,
CONSTRAINT CK_Uer_Role CHECK (Role IN('Organiser', 'Participant'))
);
Create table Profiles(
  ProfileID INT IDENTITY(1,1) PRIMARY KEY,
  UserID INT NOT NULL UNIQUE,
  Address VARCHAR(255) NULL,
  ProfilePictureURL VARCHAR(500) NULL,
  FOREIGN KEY (UserID) REFERENCES Users(UserID)
  );

Create table Events(
EventID INT IDENTITY(1,1) PRIMARY KEY,
OrganiserID INT NOT NULL,
Name VARCHAR(150) NOT NULL,
Description VARCHAR(500) NULL,
EventDate DATE NOT NULL,
Location VARCHAR(200) NOT NULL,
Distance DECIMAL(6,2) NOT NULL,
EventType VARCHAR(20) NOT NULL,
CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrgainserID) REFERENCES Users(UserID),
CONSTRAINT CK_Event_Type CHECK (EventType IN('Run', 'Walk', 'Cycle')),
CONSTRAINT CK_Event_Distance CHECK (Distance >0)
);



Create table Categories(
  CategoryID INT IDENTITY(1,1) PRIMARY KEY,
  EventID INT NOT NULL,
  CategoryName VARCHAR(100) NOT NULL,
  Description VARCHAR(255) NULL,
  CONSTRAINT FK_Category_Event FOREIGN KEY(EventID) REFERENCES Events(EventID) ON DELETE CASCADE
  );

Create table Enrolments(
  EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
  ParticipantID INT NOT NULL,
  EventID INT NOT NULL,
  CategoryID INT NOT NULL,
  EnrolmentDate DATE NOT NULL DEFAULT GETDATE(),
  Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
  CONSTRAINT FK_Enrolment_Participant FOREIGN KEY(ParticipantID REFERENCES Users(UserID),
  CONSTRAINT FK_Enrolment_Event FOREIGN KEY(EventID) REFERENCES Events(EventID),
  CONSTRAINT FK_Enrolment_Category FOREIGN KEY(CategoryID) REFERENCES Categories(CategoryID),
  CONSTRAINT CK_Enrolment_Status CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled')),
  CONSTRAINT UQ_Participant_Event UNIQUE (ParticipantID, EventID)
  );

Create table Results(
  ResultID INT IDENTITY(1,1) PRIMARY KEY,
  EnrolmentID INT NOT NULL UNIQUE,
  FinishTime TIME NOT NULL,
  FinishPosition INT NOT NULL,
  ResultDate DATE NOT NULL DEFAULT GETDATE(),
  CONSTRAINT FK_Result_Enrolment FOREIGN KEY(EnrolmentID) REFERENCES Enrolments(EnromentID),
  CONSTRAINT CK_Result_Position CHECK(FinishPosition >0)
  );

Create table EventBanners(
  BannerID INT IDENTITY(1,1) PRIMARY KEY,
  EventID INT NOT NULL UNIQUE,
  ImageURL VARCHAR(500) NOT NULL,
  UploadedDate DATE NOT NULL DEFAULT GETDATE(),
  CONSTRAINT FK_Banner_Event FOREIGN KEY(EventID) REFERENCES Events(EventID) ON DELETE CASCADE
  );

INSERT INTO Users(FirstName, LastName, Email, PasswordHash, Role, Phone)
VALUES
('Jamie', 'Smith', 'jamieSmittie@gmail.com','HASHED_PASSWORD_1', 'Organiser', ' 0823334589'),
('Sarah', 'Naidoo', 'SarahN@gmail.com', 'HASHED_PASSWORD_2', 'Organiser', ' 0765443028'),
('Lerato', 'Dlamini', 'LeratoDlamini@gmail.com', 'HASHED_PASSWORD_3', 'Organiser', '0720754276'),
(' Jonny', 'Lopez', 'JonLopez@gmail.com', 'HASHED_PASSWORD-4'), 'Organiser', ' 0812168042');

INSERT INTO Profiles(UserID, Address, ProfilePictureURL)
VALUES
(1, 'Johannesburg',' Gauteng', NULL),
(2,'Cape Town',' Western Cape', NULL),
(3, 'Pretoria',' Gauteng', NULL),
(4, 'Durban', 'Kwazulu-Natal', NULL);

INSERT INTO Events(OrganiserID, Name, Description, EventDate, Location, Distance, EventType)
VALUES
(1, 'Johannesburg Walk for charity', 'Community event for charity.', ' 2026-11-15', 'Johannesburg', 5.00, 'Walk'),
(1, ' Cape Town Spring Run', 'Annual road runnung event', '2026-10-14', ' Cape Town', 10.00, 'Run'),
(2, 'Durban Coastal Cycle', 'Road cycling event along the coast.', '2026-12-09', 'Durban', 21.00, 'Cycle');

INSERT INTO Categories(EventID, CategoryName, Description)
VALUES
(1, 'Under 18', 'Participants under 18 years old'),
(1, 'Senior', 'Senior Participants'),
(1, '10km', '10km Kilometere category'),

(2, 'Under 20',' Participants under 20 years old'),
(2, 'Senior', 'Senior Participants'),
(2, '5km', '5km Kilometere category'),

(3, 'Under 20',' Participants under 20 years old'),
(3, 'Senior', 'Senior Participants'),
(3, '21km', '21km Kilometere cycling category');

INSERT INTO Enrolments(ParticipantID, EventID, CategoryID, Status)
VALUES
(3,1,3, 'Confirmed'),
(4,1,2, 'Confirmed'),
(3,2,6, 'Confirmed'),
(4,3,9, 'Confirmed');

INSERT INTO Results(EnrolmentID, FinishTime, FinishPosition)
Values
(1, '00:50:35', 46),
(2, '00:57:12', 67);





  
  
