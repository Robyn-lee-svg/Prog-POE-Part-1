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
Description VARCHAR(500) NULL,
EventDate DATE NOT NULL,
Location VARCHAR(200) NOT NULL,
Distance DECIMAL(6,2) NOT NULL,
EventType VARCHAR(20) NOT NULL,
CONSTRAINT FK_Event_Organiser FOREIGN KEY (OrgainserID) REFERENCES Users(UserID),
CONSTRAINT CK_Event_Type CHECK (EventType IN('Run', 'Walk', 'Cycle')),
CONSTRAINT CK_Event_Distance CHECK (Distance >0)
);

Create table