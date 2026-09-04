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
ProfileID INT IDENTITY(1,1) PRIMARY KEY
UserID INT NOT NULL UNIQUE,
Address VARCHAR(255) NULL,
ProfilePictureURL VARCHAR(500) NULL,
CONSTRAINT FK_Profile_User FOREIGN KEY (UserID) References Users(UserID)
);

Create table Events(
EventID INT IDENTITY(1,1) PRIMARY KEY,
OrganiserID INT NOT NULL,
Name VARCHAR(150) NOT NULL,

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

  
  
